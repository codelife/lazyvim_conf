-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.foldmethod = "manual"
  end,
})

-- markdown 保存后执行 PanguAll
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  callback = function()
    vim.cmd("silent! PanguAll")
  end,
})

require("tokyonight").setup({
  transparent = true,
})

require("dracula").setup({
  transparent_bg = true,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "BufferLineBufferSelected", {
      fg = "#ffcc00",
      bg = "#282c34",
      bold = true,
    })
  end,
})

vim.cmd.colorscheme("dracula")

vim.api.nvim_set_hl(0, "BufferLineBufferSelected", {
  fg = "#ffcc00",
  bg = "#282c34",
  bold = true,
})
