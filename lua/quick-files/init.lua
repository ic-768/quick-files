local file = require("quick-files.file")

local M = {}

M.setup = function(opts)
	local window = require("quick-files.window")

	vim.keymap.set("n", opts.toggle_map or "<leader>q", window.toggle_window, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>Q", file.add_entry, { noremap = true, silent = true })

	vim.keymap.set("n", "<CR>", file.navigate_to_file, { buffer = window.my_buf, noremap = true, silent = true })
	vim.keymap.set("n", "<Esc>", window.close_window, { buffer = window.my_buf, noremap = true, silent = true })
	vim.keymap.set("n", "dd", file.remove_entry, { buffer = window.my_buf, noremap = true, silent = true })
end

return M
