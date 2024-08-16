local file = require("quick-files.file")

local M = {}

M.setup = function(opts)
	local ui = require("quick-files.ui")
	local keys = opts and opts.keys or {}

	vim.keymap.set("n", keys.toggle or "<leader>j", ui.toggle_window, { noremap = true, silent = true })
	vim.keymap.set("n", keys.add_entry or "<leader>J", file.add_entry, { noremap = true, silent = true })

	vim.keymap.set(
		"n",
		keys.navigate or "<CR>",
		file.navigate_to_file,
		{ buffer = ui.my_buf, noremap = true, silent = true }
	)
	vim.keymap.set("n", "<Esc>", ui.close_window, { buffer = ui.my_buf, noremap = true, silent = true })
	vim.keymap.set(
		"n",
		keys.remove_entry or "dd",
		file.remove_entry,
		{ buffer = ui.my_buf, noremap = true, silent = true }
	)

	-- to change working directory
	vim.cmd([[
  augroup ChangeDirectory
    autocmd!
    autocmd BufEnter * cd %:p:h
  augroup END
]])
end

return M
