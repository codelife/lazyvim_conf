return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  },

  -- 透明窗口
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      extra_groups = { "NormalFloat", "NvimTreeNormal" },
    },
  },

  -- lualine 配置对齐你的样式
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.theme = "dracula"
      opts.sections.lualine_c = {
        { "diff", separator = "" },
        { "python_env", separator = "" },
        { "filename", path = 2 },
      }
    end,
  },

  -- bufferline 配置
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
        sort_by = "relative_directory",
        numbers = "ordinal",
        diagnostics = true,
        show_tab_indicators = false,
        tab_size = 0,
      },
    },
  },
}
