local M = {}

M.files = {}
M.config_file = vim.fn.stdpath("data") .. "/quick-files.json"

M.load_state = function()
	local file = io.open(M.config_file, "r")
	if file then
		local content = file:read("*a")
		file:close()
		local state, err = vim.fn.json_decode(content or {})
		if state then
			return state
		else
			error("Failed to decode JSON: " .. err)
		end
	else
		file = io.open(M.config_file, "w")
		if file then
			file:write(vim.fn.json_encode({}))
			file:close()
			return {} -- Return an empty table if the file is newly created
		else
			error("Could not create file: " .. M.config_file)
		end
	end
end

M.add_entry = function()
	-- Prompt the user for a file label
	local label = vim.fn.input("Enter file label: ")
	if label == "" then
		print("Label cannot be empty")
		return
	end

	local current_file_path = vim.api.nvim_buf_get_name(0)

	-- Fallback to working directory if buffer name is empty
	if current_file_path == "" then
		current_file_path = vim.fn.getcwd()
	end

	-- Load the existing state or initialize it
	local state = M.load_state()

	-- Add the new entry
	state[label] = current_file_path

	-- Save the updated state
	local file = io.open(M.config_file, "w+")
	if file then
		file:write(vim.fn.json_encode(state))
		file:close()
	else
		error("Could not open file: " .. M.config_file)
	end
end

M.remove_entry = function()
	local line = vim.api.nvim_get_current_line()

	-- Extract key from the line
	local key = line:match("^(%S+):")
	if not key then
		print("No valid key found on the current line")
		return
	end

	-- Load existing state
	local state = M.load_state()

	-- Remove the entry
	if state[key] then
		state[key] = nil

		-- Save updated state
		local file = io.open(M.config_file, "w+")
		if file then
			file:write(vim.fn.json_encode(state))
			file:close()
		else
			error("Could not open file: " .. M.config_file)
		end

		-- Remove the line from the buffer
		local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
		vim.api.nvim_buf_set_lines(0, cursor_line - 1, cursor_line, false, {})
		print("Entry removed")
	else
		print("Key not found in JSON state")
	end
end

M.navigate_to_file = function()
	local window = require("quick-files.window")
	local line = vim.api.nvim_get_current_line()
	local path = line:match("%S+$") -- Extract the last non-whitespace sequence (file path)

	if path then
		-- Check if the path exists before opening
		if vim.fn.filereadable(path) then
			window.close_window()
			vim.cmd("edit " .. path)
		else
			print("File does not exist: " .. path)
		end
	else
		print("No file path found on the current line")
	end
end

return M
