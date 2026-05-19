return {
  {
    "smoka7/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      local hop = require("hop")
      local direction = require("hop.hint").HintDirection
      vim.keymap.set("n", "f", function()
        hop.hint_char1({ direction = direction.AFTER_CURSOR, current_line_only = true })
      end)
      vim.keymap.set("n", "F", function()
        hop.hint_char1({ direction = direction.BEFORE_CURSOR, current_line_only = true })
      end)
      vim.keymap.set("n", "w", function()
        hop.hint_words({ direction = direction.AFTER_CURSOR })
      end)
      vim.keymap.set("n", "b", function()
        hop.hint_words({ direction = direction.BEFORE_CURSOR })
      end)
    end,
  },

  { "tpope/vim-surround", event = "BufRead" },
  { "tpope/vim-repeat", event = "BufRead" },
  { "andymass/vim-matchup", event = "BufReadPost" },
  { "HiPhish/rainbow-delimiters.nvim" },

  {
    "kevinhwang91/nvim-hlslens",
    event = "BufRead",
    config = function()
      require("hlslens").setup({ calm_down = true })
    end,
  },

  {
    "monaqa/dial.nvim",
    opts = function(_, opts)
      local augend = require("dial.augend")
      table.insert(
        opts.groups.default,
        augend.constant.new({
          elements = { "asc", "desc" },
          word = true,
          cyclic = true,
        })
      )
    end,
  },

  {
    "bloznelis/before.nvim",
    event = "BufRead",
    config = function()
      require("before").setup()
    end,
  },

  {
    "voldikss/vim-translator",
    cmd = "TranslateW",
    config = function()
      vim.g.translator_default_engines = { "youdao", "haici" }
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports", "golines" },
        sql = { "sqlfmt" },
        lua = { "stylua" },
        json = { "fixjson" },
        groovy = { "npm-groovy-lint" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        markdown = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        yaml = { "prettierd" },
      },
      formatters = {
        golines = { prepend_args = { "-m", "120" } },
        stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2", "--column-width", "120" } },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "ruff" },
        dockerfile = { "hadolint" },
        sql = { "sqruff" },
        proto = { "buf" },
        ansible = { "ansible-lint" },
        groovy = { "npm-groovy-lint" },
        markdown = { "markdownlint" },
        go = { "golangci-lint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      completion = {
        trigger = { show_on_trigger_character = true, show_on_keyword = true },
        menu = { winblend = 0, border = "rounded", scrolloff = 2, draw = { treesitter = { "lsp" } } },
        documentation = { auto_show = true, window = { border = "rounded" } },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { "copilot", "lsp", "path", "snippets", "buffer" },
        providers = {
          copilot = { score_offset = 100 },
          lsp = { score_offset = 90 },
          snippets = { score_offset = 80 },
          buffer = { score_offset = 20 },
        },
      },
      appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = "mono" },
    },
  },
  {
    {
      "rmagatti/goto-preview",
      event = "VeryLazy",
      keys = {
        {
          "gp",
          function()
            require("goto-preview").goto_preview_definition()
          end,
          desc = "Goto Preview Definition",
        },
        {
          "gi",
          function()
            require("goto-preview").goto_preview_implementation()
          end,
          desc = "Goto Preview Implementation",
        },
        {
          "gq",
          function()
            require("goto-preview").close_all_win()
          end,
          desc = "Close Preview Windows",
        },
      },
    },
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          win = {
            input = {
              keys = {
                ["<C-j>"] = { "history_forward", mode = { "i", "n" } },
                ["<C-k>"] = { "history_back", mode = { "i", "n" } },
              },
            },
          },
        },
      },
    },
  },
}
