return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
      server = {
        settings = {
          ["rust-analyzer"] = {
            procMacro = { enable = true },
            checkOnSave = { command = "clippy" },
          },
        },
      },
    },
  },
}
