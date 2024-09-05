local file = require("quick-files.file")
local utils = require("quick-files.utils")

local M = {}
local window_id = nil
M.my_buf = vim.api.nvim_create_buf(false, true)

local open_window = function()
	file.files = file.load_state()

	local width = utils.max(math.floor(vim.o.columns * 0.3), 80)
	local height = utils.max(math.floor(vim.o.lines * 0.2), 20)

	local opts = {
		title = "quick-files",
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	}

	local string_array = utils.format_keys(file.files)
	vim.api.nvim_buf_set_lines(M.my_buf, 0, -1, true, string_array)
	window_id = vim.api.nvim_open_win(M.my_buf, true, opts)

	vim.api.nvim_set_option_value("wrap", false, { win = window_id })

	-- Highlight the first word in each line
	local ns_id = vim.api.nvim_create_namespace("QuickFileLabel")
	for i, line in ipairs(string_array) do
		local col_end = line:find(":") or #line
		vim.api.nvim_buf_add_highlight(M.my_buf, ns_id, "Aqua", i - 1, 0, col_end)
	end
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
