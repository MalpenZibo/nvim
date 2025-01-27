local get_root_dir = function(fname)
  local util = require("lspconfig.util")
  return util.root_pattern(".git")(fname) or util.root_pattern("package.json", "tsconfig.json")(fname)
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        eslint = {
          root_dir = get_root_dir,
        },
        vtsls = {
          root_dir = get_root_dir,
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ui = { border = "rounded" } },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          border = "rounded",
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },
}
