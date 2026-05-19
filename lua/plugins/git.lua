return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
      })
    end,
    keys = {
      { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
      { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
      { "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Buffer" },
      { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
      { "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
      {
        "<leader>hb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "Blame Line",
      },
      {
        "<leader>gd",
        function()
          require("gitsigns").diffthis("~")
        end,
        desc = "Diff This (vs HEAD)",
      },
    },
  },
}
