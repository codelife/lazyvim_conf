return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = false,
        ---@type table<'accept'|'next'|'prev'|'dismiss', false|string>
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<c-k>",
        },
        layout = {
          position = "bottom",
          ratio = 0.5,
        },
      },
      suggestion = {
        enabled = false,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-l>",
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-j>",
          prev = "<C-->",
          dismiss = "<C-c>",
        },
      },
      filetypes = {
        ["*"] = true,
      },
    },
  },
}
