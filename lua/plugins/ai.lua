return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        keymap = {
          accept = "<M-CR>",
        },
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      LazyVim.cmp.actions.ai_accept = nil
    end,
  },
  { "zbirenbaum/copilot-cmp", enabled = false },
}
