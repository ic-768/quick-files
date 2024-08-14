local init = require("quick-files.init")
local M = {}

M.my_buf = vim.api.nvim_create_buf(false, true)
M.window_id = nil

M.open_floating_window = function()
	init.files = { vim = "test" }
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
	vim.api.nvim_echo({ { "files are: " .. vim.inspect(init.files), "Normal" } }, false, {})
	for k, _ in pairs(init.files) do
		vim.api.nvim_echo({ { "item is: " .. k } }, false, {})
		table.insert(keys, k)
	end

	vim.api.nvim_buf_set_lines(M.my_buf, 0, -1, true, keys)

	M.window_id = vim.api.nvim_open_win(M.my_buf, true, opts)
end

M.close_window = function()
	vim.api.nvim_win_close(M.window_id, false)
	M.window_id = nil
end

M.toggle_window = function()
	if M.window_id then
		M.close_window()
	else
		M.open_floating_window()
	end
end

return M
