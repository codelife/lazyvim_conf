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

      local on_attach = function(client, bufnr)
        -- disable lsp formatting
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end

      -- Lua (Neovim dev)
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      -- TypeScript
      lspconfig.ts_ls.setup({ on_attach = on_attach })

      -- Go (SRE core)
      lspconfig.gopls.setup({
        on_attach = on_attach,
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
      lspconfig.pyright.setup({ on_attach = on_attach })

      -- YAML / Kubernetes
      lspconfig.yamlls.setup({
        on_attach = on_attach,
        settings = {
          yaml = {
            kubernetes = true,
            schemaStore = { enable = true },
            validate = true,
          },
        },
      })

      -- Docker
      lspconfig.dockerls.setup({ on_attach = on_attach })

      -- Bash / Shell
      lspconfig.bashls.setup({ on_attach = on_attach })

      -- SQL
      lspconfig.sqlls.setup({ on_attach = on_attach })

      -- Ansible
      lspconfig.ansiblels.setup({ on_attach = on_attach })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports" },
        lua = { "stylua" },
        python = { "ruff" },

        typescript = { "prettierd" },
        javascript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },

        json = { "fixjson" },
        yaml = { "yamlfmt" },
        terraform = { "terraform" },
        sql = { "sqlfmt" },
        markdown = { "prettierd" },
      },

      formatters = {
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
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        javascript = { "eslint_d", "trivy" },
        typescript = { "eslint_d", "trivy" },
        javascriptreact = { "eslint_d", "trivy" },
        typescriptreact = { "eslint_d", "trivy" },
        python = { "ruff", "trivy" },
        go = { "golangcilint", "trivy" },
        dockerfile = { "hadolint", "trivy" },
        sql = { "sqlfluff" },
        proto = { "buf" },
        ansible = { "ansible-lint" },
        groovy = { "npm-groovy-lint" },
        markdown = { "markdownlint-cli2" },
        terraform = { "tflint" },
        bash = { "shellcheck" },
      },
    },
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
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {},
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
  },
  {
    "mzlogin/vim-markdown-toc",
    ft = "markdown",
  },
  { "hotoo/pangu.vim", ft = { "markdown", "vimwiki", "text" } },
}
