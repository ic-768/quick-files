local window = require("quick-files.window")
local file = require("quick-files.file")
local M = {}

M.navigate_to_file = function()
	local line = vim.fn.getline(".")
	local path = file.files[line]
	if path then
		window.toggle_window()
		vim.api.nvim_command("edit " .. path)
	else
		print("No path associated with this line")
	end
end

return M
