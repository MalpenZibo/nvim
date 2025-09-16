local get_root_dir = function(fname)
  local util = require("lspconfig.util")
  return util.root_pattern(".git")(fname) or util.root_pattern("package.json", "tsconfig.json")(fname)
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        virtual_lines = true,
      },
      inlay_hints = { enabled = false },
      servers = {
        eslint = {
          root_dir = get_root_dir,
        },
        vtsls = {
          root_dir = get_root_dir,
        },
        zls = {
          settings = {
            zls = {
              -- enable_build_on_save = true,
              -- build_on_save_step = "check", -- make sure this matches your step name
              -- semantic_tokens = "none",
              -- retain_build_on_save_results = true,
              enable_build_on_save = true,
              semantic_tokens = "partial",
            },
          },
        },
      },
    },
  },
}
