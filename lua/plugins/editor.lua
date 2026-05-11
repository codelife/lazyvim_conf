return {
  {
    "smoka7/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      local hop = require("hop")
      local direction = require("hop.hint").HintDirection

      vim.keymap.set("", "f", function()
        hop.hint_char1({ direction = direction.AFTER_CURSOR, current_line_only = true })
      end)
      vim.keymap.set("", "F", function()
        hop.hint_char1({ direction = direction.BEFORE_CURSOR, current_line_only = true })
      end)
      vim.keymap.set("", "w", function()
        hop.hint_words({ direction = direction.AFTER_CURSOR })
      end)
      vim.keymap.set("", "b", function()
        hop.hint_words({ direction = direction.BEFORE_CURSOR })
      end)
    end,
  },

  -- surround 环绕编辑
  { "tpope/vim-surround", event = "BufRead" },
  { "tpope/vim-repeat", event = "BufRead" },

  -- 括号匹配增强
  { "andymass/vim-matchup", event = "BufReadPost" },

  -- 彩虹括号
  { "HiPhish/rainbow-delimiters.nvim" },

  -- 搜索高亮
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufRead",
    config = function()
      require("hlslens").setup({ calm_down = true })
    end,
  },

  -- 数字/布尔值/日期递增递减
  {
    "monaqa/dial.nvim",
    keys = { "<C-a>", "<C-x>" },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.new({ elements = { "True", "False" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
          augend.constant.new({ elements = { "asc", "desc" }, word = true, cyclic = true }),
        },
      })
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal())
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal())
    end,
  },

  -- 编辑历史来回跳转
  {
    "bloznelis/before.nvim",
    event = "BufRead",
    config = function()
      require("before").setup()
    end,
  },

  -- 翻译插件
  {
    "voldikss/vim-translator",
    cmd = "TranslateW",
    config = function()
      vim.g.translator_default_engines = { "youdao", "haici" }
    end,
  },
}
