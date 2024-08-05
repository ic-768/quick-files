# ⚡QUICKFILES

## Fast, no-nonsense access to your most frequented files.

Simply press the keybinding (`<leader-q>` by default) to select a file, and hit `<CR>` to load it.
The file list is defined during setup, as per the example below.

### Installation (lazy.nvim)

Install as you would normally. The setup function accepts two parameters:

- files : a table with `{label you want to show = file path of the file}`:
- toggleMap: which keybinding you want to toggle the window.

```
return {
	dir = "~/Code/quick-files",
	name = "quick-files",
	config = function()
		require("quick-files").setup({
			files = {
				term = "~/DotFiles/termShortcuts.md",
				vim = "~/DotFiles/vimShortcuts.md",
			},
			toggleMap = "<leader>q",
		})
	end,
}

```

This configuration for example lets me pick any of the two files for editing:

![screenshot of window](https://i.imgur.com/SonP6vS.png)
