return {
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        border = "rounded",
      })
    end,
    cmd = "Glow"
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = false,
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {

        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
    },
    config = function()
      require("spider").setup {
        skipInsignificantPunctuation = false,
        consistentOperatorPending = true, -- see "Consistent Operator-pending Mode" in the README
        subwordMovement = true,
        customPatterns = {},        -- check "Custom Movement Patterns" in the README for details
      }
    end
  },
  {
    "numTostr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },
  {
    'nmac427/guess-indent.nvim',
    config = function()
      require("guess-indent").setup({})
    end
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",

        cwd_change_handling = {
          restore_upcoming_session = true,   -- already the default, no need to specify like this, only here as an example
          pre_cwd_changed_hook = nil,        -- already the default, no need to specify like this, only here as an example
          post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
            require("lualine").refresh()     -- refresh lualine so the new session name is displayed in the status bar
          end,
        },
      });
    end
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }
}
