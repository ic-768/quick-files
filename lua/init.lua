local window = require("window")
local navigation = require("navigation")

local M = {}
M.files = {}

M.get_config_file = function()
	return vim.fn.stdpath("data") .. "/quick-files.json"
end

M.save_state = function(state)
	local file_path = M.get_config_file()
	local file = io.open(file_path, "w+")
	if file then
		file:write(vim.fn.json_encode(state))
		file:close()
	else
		error("Could not open file: " .. file_path)
	end
end

M.setup = function(opts)
	M.files = opts.files

	vim.keymap.set("n", opts.toggle_map or "<leader>q", window.toggle_window, { noremap = true, silent = true })
	vim.keymap.set("n", "<CR>", navigation.navigate_to_file, { buffer = window.my_buf, noremap = true, silent = true })
	vim.keymap.set("n", "<Esc>", window.close_window, { buffer = window.my_buf, noremap = true, silent = true })
end

return M
