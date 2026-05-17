local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  defaults = { timeout = 600, lazy = false, version = false },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      paths = { vim.fn.stdpath("data") .. "/site" },
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})

-- <leader>/ → gc（mini.comment toggle），用 vim.keymap.set 直接绕开 snacks lazy-handler
vim.keymap.set("n", "<leader>/", "gc", { silent = true, desc = "Toggle comment" })
vim.keymap.set("x", "<leader>/", "gc", { silent = true, desc = "Toggle comment (visual)" })

-- <leader>gr → Gread 别名（叠加在 gitsigns <leader>ghR 上，并补上 staged 部分）
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    vim.keymap.set("n", "<leader>gr", function()
      local gs = require("gitsigns")
      gs.reset_buffer()
      vim.schedule(function() gs.reset_buffer_index() end)
    end, { desc = "Git read (Gread)", silent = true })
  end,
})

return {
  {
    "smoka7/hop.nvim",
    event = "BufRead",
    config = function()
      local hop = require("hop")
      local direction = require("hop.hint").HintDirection
      vim.keymap.set("n", "f", function() hop.hint_char1({ direction = direction.AFTER_CURSOR, current_line_only = true }) end)
      vim.keymap.set("n", "F", function() hop.hint_char1({ direction = direction.BEFORE_CURSOR, current_line_only = true }) end)
      vim.keymap.set("n", "w", function() hop.hint_words({ direction = direction.AFTER_CURSOR }) end)
      vim.keymap.set("n", "b", function() hop.hint_words({ direction = direction.BEFORE_CURSOR }) end)
    end,
  },

  { "tpope/vim-surround", event = "BufRead" },
  { "tpope/vim-repeat",   event = "BufRead" },
  { "andymass/vim-matchup", event = "BufReadPost" },
  { "HiPhish/rainbow-delimiters.nvim" },

  {
    "kevinhwang91/nvim-hlslens",
    event = "BufRead",
    config = function() require("hlslens").setup({ calm_down = true }) end,
  },

  {
    "monaqa/dial.nvim",
    opts = function(_, opts)
      local augend = require("dial.augend")
      table.insert(opts.groups.default, augend.constant.new({
        elements = { "asc", "desc" }, word = true, cyclic = true,
      }))
    end,
  },

  {
    "bloznelis/before.nvim",
    event = "BufRead",
    config = function() require("before").setup() end,
  },

  {
    "voldikss/vim-translator",
    cmd = "TranslateW",
    config = function() vim.g.translator_default_engines = { "youdao", "haici" } end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports", "golines" },
        sql = { "sqlfmt" }, lua = { "stylua" }, json = { "fixjson" },
        groovy = { "npm-groovy-lint" },
        javascript = { "prettierd" }, typescript = { "prettierd" },
        javascriptreact = { "prettierd" }, typescriptreact = { "prettierd" },
        markdown = { "prettierd" }, css = { "prettierd" },
        html = { "prettierd" }, yaml = { "prettierd" },
      },
      format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
      formatters = { golines = { prepend_args = { "-m", "120" } } },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" }, typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" }, typescriptreact = { "eslint_d" },
        python = { "ruff" }, dockerfile = { "hadolint" }, sql = { "sqruff" },
        proto = { "buf" }, ansible = { "ansible-lint" },
        groovy = { "npm-groovy-lint" }, markdown = { "markdownlint" }, go = { "golangci-lint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, { callback = function() lint.try_lint() end })
    end,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" } },
      completion = {
        trigger = { show_on_trigger_character = true, show_on_keyword = true },
        menu = { winblend = 0, border = "rounded", scrolloff = 2, draw = { treesitter = { "lsp" } } },
        documentation = { auto_show = true, window = { border = "rounded" } },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { "copilot", "lsp", "path", "snippets", "buffer" },
        providers = { copilot = { score_offset = 100 }, lsp = { score_offset = 90 },
          snippets = { score_offset = 80 }, buffer = { score_offset = 20 } },
      },
      appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = "mono" },
    },
  },

}
