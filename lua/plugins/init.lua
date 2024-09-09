return {
  "folke/neodev.nvim",
  {
    "folke/which-key.nvim",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    }
  },
  { "folke/neoconf.nvim", cmd = "Neoconf" },
}
