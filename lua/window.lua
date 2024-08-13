local M = {}

local my_buf = vim.api.nvim_create_buf(false, true)
local window_id = nil

M.open_floating_window = function()
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

	local keys = {}
	for k, _ in pairs(files) do
		table.insert(keys, k)
	end

	vim.api.nvim_buf_set_lines(my_buf, 0, -1, true, keys)

	window_id = vim.api.nvim_open_win(my_buf, true, opts)
end

M.close_window = function()
	vim.api.nvim_win_close(window_id, false)
	window_id = nil
end

M.toggle_window = function()
	if window_id then
		M.close_window()
	else
		M.open_floating_window()
	end
end

return M
