local my_buf = vim.api.nvim_create_buf(false, true)
local window_id = nil

local files = {}

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

	local keys = {}
	for k, _ in pairs(files) do
		table.insert(keys, k)
	end

	vim.api.nvim_buf_set_lines(my_buf, 0, -1, true, keys)

	window_id = vim.api.nvim_open_win(my_buf, true, opts)
end

local function close_window()
	vim.api.nvim_win_close(window_id, false)
	window_id = nil
end

local function toggle_window()
	if window_id then
		close_window()
	else
		open_floating_window()
	end
end

local function navigate_to_file()
	local line = vim.fn.getline(".")
	local path = files[line]
	if path then
		toggle_window()
		vim.api.nvim_command("edit " .. path)
	else
		print("No path associated with this line")
	end
end

local function setup(opts)
	files = opts.files

	vim.keymap.set("n", opts.toggle_map or "<leader>q", toggle_window, { noremap = true, silent = true })
	vim.keymap.set("n", "<CR>", navigate_to_file, { buffer = my_buf, noremap = true, silent = true })
	vim.keymap.set("n", "<Esc>", close_window, { buffer = my_buf, noremap = true, silent = true })
end

return { setup = setup }
