local ui = require("quick-files.ui")
local file = require("quick-files.file")
local M = {}

M.navigate_to_file = function()
	local line = vim.fn.getline(".")
	local path = file.files[line]
	if path then
		ui.toggle_window()
		vim.api.nvim_command("edit " .. path)
	else
		print("No path associated with this line")
	end
end

return M
