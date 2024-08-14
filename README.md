# ⚡QUICK-FILES

## Fast, no-nonsense access to your most frequented files.

I made this plugin because I love harpoon, but it scopes files down to project directories. So I couldn't share the same file list between different projects.

Using this plugin, I can quickly edit my neovim config on the fly, get to my repos directory ASAP, etc. no matter where I am in neovim. It's rough around the edges and nowhere near as polished as harpoon, but it was a good way to learn some lua and hack around in neovim. Also lots of fun!

## How to use

`<leader-J>` adds the current file to the file list. You will be prompted for a label to easily identify it.
`<leader-j>` pulls up the file window, and `<CR>` loads the file under your cursor.
You can remove entries with `dd`.

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
  	  	add_entry = "<leader>J",
  	  	navigate = "<CR>",
  	  	remove_entry = "dd",
  	  },
  	})
  end,
}

```

Open up a couple of files, add them as entries, and you should have a populated window when you toggle the plugin:

![screenshot of window](https://i.imgur.com/o99h6Vm.png)

#### HAPPY EDITING 🎉
