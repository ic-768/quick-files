local myBuf = vim.api.nvim_create_buf(false, true)
local isOpen = false
local windowId = nil

local function open_floating_window()
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

	windowId = vim.api.nvim_open_win(myBuf, true, opts)
	isOpen = true
end

local function close_floating_window()
	vim.api.nvim_win_close(windowId, false)
end

local function read_to_buffer()
	vim.api.nvim_buf_set_lines(myBuf, 0, -1, true, { "abc", "def" })
end

local function append_to_buffer()
	vim.api.nvim_buf_set_lines(myBuf, -1, -1, true, { "abc", "def" })
end

vim.keymap.set("n", "<leader>f", open_floating_window, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>g", close_floating_window, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>x", read_to_buffer, { buffer = myBuf, noremap = true, silent = true })
vim.keymap.set("n", "<leader>c", append_to_buffer, { buffer = myBuf, noremap = true, silent = true })
