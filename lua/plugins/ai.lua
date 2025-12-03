return {
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      LazyVim.cmp.actions.ai_accept = nil

      return {
        panel = {
          keymap = {
            open = "<M-o>",
          },
        },
        suggestion = {
          enabled = true,
          keymap = {
            accept = "<M-CR>",
          },
        },
      }
    end,
  },
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          local Snacks = require("snacks")
          local copilot_exists = pcall(require, "copilot")

          if copilot_exists then
            Snacks.toggle({
              name = "Copilot Completion",
              color = {
                enabled = "azure",
                disabled = "orange",
              },
              get = function()
                return not require("copilot.client").is_disabled()
              end,
              set = function(state)
                if state then
                  require("copilot.command").enable()
                else
                  require("copilot.command").disable()
                end
              end,
            }):map("<leader>at")
          end
        end,
      })
    end,
  },
}
