local file = require("quick-files.file")
local utils = require("quick-files.utils")
local init = require("quick-files.init")

local M = {}
local window_id = nil
M.my_buf = vim.api.nvim_create_buf(false, true)

local open_window = function()
	init.files = file.load_state()

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
	}

	local string_array = utils.format_keys(init.files)
	vim.api.nvim_buf_set_lines(M.my_buf, 0, -1, true, string_array)
	window_id = vim.api.nvim_open_win(M.my_buf, true, opts)
end

M.close_window = function()
	vim.api.nvim_win_close(window_id, false)
	window_id = nil
end

M.toggle_window = function()
	if window_id then
		M.close_window()
	else
		open_window()
	end
end

return M
