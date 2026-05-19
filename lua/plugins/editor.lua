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
  { "mason-org/mason-lspconfig.nvim", config = function() end },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        -- core languages
        "lua-language-server",
        "typescript-language-server",
        "gopls",
        "pyright",

        -- infra / cloud
        "yaml-language-server",
        "dockerfile-language-server",
        "bash-language-server",

        -- config / data
        "json-lsp",
        "ansible-language-server",
        "terraform-ls",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
      local lspconfig = require("lspconfig")

      -- Lua (Neovim dev)
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      -- TypeScript
      lspconfig.ts_ls.setup({})

      -- Go (SRE core)
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            staticcheck = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })

      -- Python automation
      lspconfig.pyright.setup({})

      -- YAML / Kubernetes
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            kubernetes = true,
            schemaStore = { enable = true },
            validate = true,
          },
        },
      })

      -- Docker
      lspconfig.dockerls.setup({})

      -- Bash / Shell
      lspconfig.bashls.setup({})

      -- SQL
      lspconfig.sqlls.setup({})

      -- Ansible
      lspconfig.ansiblels.setup({})
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports", "golines" },
        lua = { "stylua" },
        python = { "ruff" },

        typescript = { "prettierd" },
        javascript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },

        json = { "fixjson" },
        yaml = { "yamlfmt" },
        terraform = { "terraform" },
        dockerfile = { "hadolint" }, -- lint only, format optional
        sql = { "sqlfmt" },
        markdown = { "prettierd" },
      },

      formatters = {
        golines = {
          prepend_args = { "-m", "120" },
        },

        stylua = {
          prepend_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
            "--column-width",
            "120",
          },
        },
      },

      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d", "trivy" },
        typescript = { "eslint_d", "trivy" },
        javascriptreact = { "eslint_d", "trivy" },
        typescriptreact = { "eslint_d", "trivy" },
        python = { "ruff", "trivy" },
        go = { "golangci-lint", "trivy" },
        dockerfile = { "hadolint", "trivy" },
        sql = { "sqlfluff" },
        proto = { "buf" },
        ansible = { "ansible-lint" },
        groovy = { "npm-groovy-lint" },
        markdown = { "markdownlint-cli2" },
        terraform = { "tflint" },
        bash = { "shellcheck" },
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
    "rmagatti/goto-preview",
    opts = {
      width = 120,
      height = 25,
      border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
    },
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
  {
    "gbprod/yanky.nvim",
    keys = {
      { "gp", false },
      { "gP", false },
    },
  },
}
