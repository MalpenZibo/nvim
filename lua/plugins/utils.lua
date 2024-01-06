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
        vim.keymap.set({ "t", "n" }, "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set({ "t", "n" }, "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
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
  }
}
