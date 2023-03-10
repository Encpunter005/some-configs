local status_ok, browse = pcall(require, "browse")
if not status_ok then
  return
end

browse.setup {
  provider = "bing",
}

local bookmarks = {
  "https://www.chrisatmachine.com/",
  "https://github.com/christianchiarulli",
  "https://github.com/rockerBOO/awesome-neovim",
  "https://doc.rust-lang.org/book/",
  "https://aur.archlinux.org/packages/",
  "https://www.bilibili.com",
  "https://www.google.com",
  "https://www.youtube.com",
  "https://www.bing.com",
  "https://markdown.com.cn/basic-syntax/",
  "https://atcode.jp",
  "https://blog,csdn.net",
  "https://leetcode.cn",
  "https://www.acwing.com",
  "https://luogu.com.cn",
  "https://zh.cppreference.com/w/cpp",
  -- "https://github.com/neovim/neovim",
  -- "https://neovim.discourse.group/",
}

local function command(name, rhs, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(name, rhs, opts)
end

command("BrowseInputSearch", function()
  browse.input_search()
end, {})

command("Browse", function()
  browse.browse { bookmarks = bookmarks }
end, {})

command("BrowseBookmarks", function()
  browse.open_bookmarks { bookmarks = bookmarks }
end, {})

command("BrowseDevdocsSearch", function()
  browse.devdocs.search()
end, {})

command("BrowseDevdocsFiletypeSearch", function()
  browse.devdocs.search_with_filetype()
end, {})

command("BrowseMdnSearch", function()
  browse.mdn.search()
end, {})

local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

