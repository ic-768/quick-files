# ⚡QUICKFILES

## Fast, no-nonsense access to your most frequented files.

Use `<leader-J>` to add a file. You will be prompted for a label to easily identify it.
Press `<leader-j>` to pull up the file window, and `<CR>` to load the file under your cursor.
Remove entries with `dd`.

### Installation (lazy.nvim shown)

Install as you would normally. The setup function accepts an optional table called `keys` for remapping. The values shown are the defaults and can be omitted - feel free to change them as you wish:

```
return {
  "ic-768/quick-files",
  name = "quick-files",
  config = function()
  	require("quick-files").setup({
  	  keys = {
  	  	toggle = "<leader>j",
  	  	navigate = "<CR>",
  	  	add_entry = "<leader>J",
  	  	remove_entry = "dd",
  	  },
  	})
  end,
}

```

Open up a couple of files, add them as entries, and you should have a populated window when you toggle the plugin:

![screenshot of window](https://i.imgur.com/phyJgjX.png)

#### HAPPY EDITING 🎉
