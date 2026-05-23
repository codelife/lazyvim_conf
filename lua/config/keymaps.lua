-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local opts = { silent = true }

-- 插入模式 Home/End
map("i", "<c-a>", "<Home>", opts)
map("i", "<c-e>", "<End>", opts)

vim.api.nvim_set_hl(0, "BlinkCmpGhostText", {
  fg = "#8ea0ff",
  italic = true,
})

vim.api.nvim_set_hl(0, "CopilotSuggestion", {
  fg = "#8ea0ff",
})

vim.api.nvim_set_hl(0, "PmenuSel", {
  bg = "#4c566a",
  fg = "#fffff2",
  bold = true,
})
-- LSP 诊断跳转
map("n", "gj", vim.diagnostic.goto_next, opts)
map("n", "gk", vim.diagnostic.goto_prev, opts)

-- B1/B2: Hunk 导航（lvim 习惯 <leader>j/k；LazyVim 默认 ]h/[h 仍可用）
map("n", "<leader>j", "<cmd>Gitsigns next_hunk<cr>", { silent = true, desc = "Next Hunk" })
map("n", "<leader>k", "<cmd>Gitsigns prev_hunk<cr>", { silent = true, desc = "Prev Hunk" })

map("n", "<leader>gd", "<cmd>Git diffthis<cr>", { silent = true, desc = "Git Diff This" })

map("n", "<leader>bs", "<cmd>BufferLineSortByDirectory<cr>", { silent = true, desc = "sort buffer by directory" })

map("n", "<leader>\\", "<cmd>terminal<cr>", { silent = true, desc = "Toggle comment (visual)" })

vim.keymap.set({ "n", "v" }, "<leader>/", "gc", { remap = true, desc = "Toggle comment" })

map("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { silent = true, desc = "Markdown Preview " })
map("n", "<leader>mg", "<cmd>GenTocMarked<cr>", { silent = true, desc = "Markdown GenTocMarked " })
map("n", "<leader>mf", "<cmd>PanguAll<cr>", { silent = true, desc = "Markdown Text format" })

vim.keymap.set("n", "<leader>tf", function()
  require("lazyvim.util").format.toggle()
end, { desc = "Toggle format on save" })

-- 重命名
map("n", "gn", vim.lsp.buf.rename, opts)
map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP definition" })
map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP references" })

-- 快速保存/关闭Buffer
map("n", ";w", "<cmd>w<cr>", opts)
map("n", ";q", "<cmd>bd<cr>", opts)

-- Buffer 切换
map("n", "<c-p>", "<cmd>BufferLineCyclePrev<cr>", opts)
map("n", "<c-n>", "<cmd>BufferLineCycleNext<cr>", opts)

-- 编辑历史来回跳（你用的 before.nvim）
map("n", "<c-h>", function()
  require("before").jump_to_last_edit()
end, opts)
map("n", "<c-l>", function()
  require("before").jump_to_next_edit()
end, opts)

map("v", "<leader>ts", ":TranslateW<CR>", { noremap = true, silent = true })
map("n", "<leader>ts", ":TranslateW<CR>", { noremap = true, silent = true })

map("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })

map("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })

map("n", "<leader>gr", ":Gitsigns reset_buffer<CR>", { noremap = true, silent = true })

map("n", "<leader>ge", "<c-w>h<cmd>q<cr>", { noremap = true, silent = true })
