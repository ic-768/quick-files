local M = {}
M.files = {}

M.config_file = vim.fn.stdpath("data") .. "/quick-files.json"

M.load_state = function()
	local file = io.open(M.config_file, "r")
	if file then
		local content = file:read("*a")
		file:close()
		local state, err = vim.fn.json_decode(content)
		if state then
			return state
		else
			error("Failed to decode JSON: " .. err)
		end
	else
		file = io.open(M.config_file, "w")
		if file then
			file:close()
			return {} -- Return an empty table if the file is newly created
		else
			error("Could not create file: " .. M.config_file)
		end
	end
end

M.save_state = function()
	local state = { test = 1 }
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
	vim.keymap.set("n", "<CR>", M.save_state, { buffer = window.my_buf, noremap = true, silent = true })
end

return M
