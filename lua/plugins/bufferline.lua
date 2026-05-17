return {
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
  keys = {
    -- 前后切换
    { "<C-p>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<C-n>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    -- 关闭当前 buffer
    { ";q", "<cmd>BufferKill<cr>", desc = "Kill Current Buffer" },
    -- Space + 0 固定/取消固定
    { "<leader>0", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Buffer Pin" },
    -- Space + 1~9 跳转对应序号buffer
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Goto Buffer 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Goto Buffer 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Goto Buffer 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Goto Buffer 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Goto Buffer 5" },
    { "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Goto Buffer 6" },
    { "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Goto Buffer 7" },
    { "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Goto Buffer 8" },
    { "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Goto Buffer 9" },

    -- 新增你之前要的：删除左侧/右侧所有 buffer
    { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Left Buffers" },
    { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Right Buffers" },
  },
}
