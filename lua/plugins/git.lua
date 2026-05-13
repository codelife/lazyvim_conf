return {
  -- A1/A2: Diffview — 多文件双窗口 diff
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewRefresh" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>ge", "<c-w>h<cmd>q<cr>", desc = "Close left diff pane" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
    },
  },

  -- A3: 文件历史放到 <leader>fl（与 lvim 一致）
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>fl", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
      { "<leader>fL", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
    },
  },

  -- C1: gitsigns hunk 操作 — lvim 风格 <leader>h* 别名（LazyVim 默认的 <leader>gh* 保留不动）
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
      { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
      { "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Buffer" },
      { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
      { "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
      { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame Line" },
      { "<leader>hd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff This (vs index)" },
      { "<leader>hD", function() require("gitsigns").diffthis("~") end, desc = "Diff This (vs HEAD)" },
    },
  },
}
