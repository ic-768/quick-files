local file = require("quick-files.file")

local M = {}

M.setup = function(opts)
	local window = require("quick-files.window")

	local keys = opts and opts.keys or {}

	vim.keymap.set("n", keys.toggle or "<leader>j", window.toggle_window, { noremap = true, silent = true })
	vim.keymap.set("n", keys.add_entry or "<leader>J", file.add_entry, { noremap = true, silent = true })

	vim.keymap.set(
		"n",
		keys.navigate or "<CR>",
		file.navigate_to_file,
		{ buffer = window.my_buf, noremap = true, silent = true }
	)
	vim.keymap.set("n", "<Esc>", window.close_window, { buffer = window.my_buf, noremap = true, silent = true })
	vim.keymap.set(
		"n",
		keys.remove_entry or "dd",
		file.remove_entry,
		{ buffer = window.my_buf, noremap = true, silent = true }
	)
end

return M
