local get_root_dir = function(fname)
  local util = require("lspconfig.util")
  return util.root_pattern(".git")(fname) or util.root_pattern("package.json", "tsconfig.json")(fname)
end

local test = function(bufnr, on_dir)
  local nvim_lsp = require("lspconfig")
  on_dir(nvim_lsp.util.root_pattern("tsconfig.json", "package.json", ".git")(vim.api.nvim_buf_get_name(bufnr)))
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = true,
        virtual_lines = false,
      },
      inlay_hints = { enabled = false },
      servers = {
        -- eslint = {
        --   root_dir = test,
        -- },
        -- vtsls = {
        --   root_dir = test,
        -- },
        zls = {
          settings = {
            zls = {
              enable_build_on_save = true,
              semantic_tokens = "partial",
            },
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = false,
          },
        },
      },
    },
  },
}
