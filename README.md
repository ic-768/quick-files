# ⚡QUICKFILES

## Fast, no-nonsense access to your most frequented files.

Simply press the keybinding (`<leader-q>` by default) to select a file, and hit `<CR>` to load it.
The file list is defined during setup, as per the example below.

### Installation (lazy.nvim)

Install as you would normally, and in the setup function provide a table with `{label = file path}`:

```
return {
	"ic-768/quick-files",
	name = "quick-files",
	config = function()
		require("quick-files").setup({
			term = "~/DotFiles/termShortcuts.md",
			vim = "~/DotFiles/vimShortcuts.md",
		})
	end,
}

```

This configuration for example lets me pick any of the two files for editing:

![screenshot of window](https://i.imgur.com/SonP6vS.png)
