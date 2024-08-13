local window = require("quick-files.window")
local init = require("quick-files.init")
local M = {}

M.navigate_to_file = function()
	local line = vim.fn.getline(".")
	local path = init.files[line]
	if path then
		window.toggle_window()
		vim.api.nvim_command("edit " .. path)
	else
		print("No path associated with this line")
	end
end

return M
