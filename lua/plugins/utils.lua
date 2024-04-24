return {
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = "vertical",
        shade_terminals = true,
        size = 60,
      })

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
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
          restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
          pre_cwd_changed_hook = nil,  -- already the default, no need to specify like this, only here as an example
          post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
            require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
          end,
        },
      });
    end
  }
}
