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

	-- Get the current file path (adjust as needed if this is not the desired file path)
	local currentFilePath = vim.api.nvim_buf_get_name(0)

	-- Load the existing state or initialize it
	local state = M.load_state()

	-- Add the new entry
	state[label] = currentFilePath

	-- Save the updated state
	local file = io.open(M.config_file, "w+")
	if file then
		file:write(vim.fn.json_encode(state))
		file:close()
	else
		error("Could not open file: " .. M.config_file)
	end
end

M.setup = function(opts)
	local window = require("quick-files.window")

	vim.keymap.set("n", opts.toggle_map or "<leader>q", window.toggle_window, { noremap = true, silent = true })
	--vim.keymap.set("n", "<CR>", navigation.navigate_to_file, { buffer = window.my_buf, noremap = true, silent = true })
	vim.keymap.set("n", "<Esc>", window.close_window, { buffer = window.my_buf, noremap = true, silent = true })
	vim.keymap.set("n", "<leader>G", M.add_entry, { noremap = true, silent = true })
end

return M
