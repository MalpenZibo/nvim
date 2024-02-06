return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        preview_config = {
          border = 'rounded'
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = "Toggle git blame" })
          map('n', '<leader>gtd', gs.toggle_deleted, { desc = "Toggle git removed" })

          map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = "Git blame" })
          map('n', '<leader>gd', gs.diffthis, { desc = "Git local diff" })
          map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = "git remote diff" })
          map('n', '<leader>gh', gs.preview_hunk, { desc = "Preview git hunk" })

          map('n', '<leader>gs', gs.stage_hunk, { desc = "Stage git hunk" })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Undo stage git hunk" })
          map('n', '<leader>gr', gs.reset_hunk, { desc = "Reset git hunk" })
          map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Stage git hunk" })
          map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Reset git hunk" })

          map('n', '<leader>gS', gs.stage_buffer, { desc = "Stage buffer" })
          map('n', '<leader>gU', gs.reset_buffer_index, { desc = "Unstage buffer" })
          map('n', '<leader>gR', gs.reset_buffer, { desc = "Reset buffer" })
        end
      })
    end
  },
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
      "tommcdo/vim-fubitive"
    },
    config = function()
      vim.keymap.set("n", "<leader>go", "<cmd>GBrowse<CR>")
    end
  },
  {
    "kdheepak/lazygit.nvim",
    config = function() vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit) end
  }
}
