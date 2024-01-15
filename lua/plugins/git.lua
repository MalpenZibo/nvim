return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', '<leader>gb', gs.toggle_current_line_blame)
        end
      })
    end
  },
  {
    "kdheepak/lazygit.nvim",
    config = function() vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit) end
  }
}
