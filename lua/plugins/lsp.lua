return {
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      local lsp_config = require("lspconfig")
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "html",
          "rust_analyzer",
          "ts_ls",
          "eslint"
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            lsp_config.lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,
          rust_analyzer = function()
            lsp_config.rust_analyzer.setup({
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = {
                    command = "clippy",
                  },
                },
              },
            })
          end,
          html = function()
            lsp_config.html.setup({
              filetypes = { "html", "htmldjango" },
            })
          end,
          ts_ls = function()
            lsp_config.ts_ls.setup({
              on_init = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentFormattingRangeProvider = false
              end
            })
          end,
        },
      })
    end
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      local lsp_zero = require("lsp-zero")

      local builtin = require("telescope.builtin")

      local function goto_highest_severity(direction)
        local current_buf = vim.api.nvim_get_current_buf()
        local diagnostics = vim.diagnostic.get(current_buf)
        if #diagnostics == 0 then
          return
        end

        -- Sort diagnostics by severity (ascending, so highest severity is first)
        table.sort(diagnostics, function(a, b)
          return a.severity < b.severity
        end)

        -- Set the severity filter to start from the highest severity present
        local severity_filter = { severity = { min = diagnostics[1].severity } }

        -- Use goto_next to jump to the first diagnostic in the sorted list
        if direction == "prev" then
          vim.diagnostic.goto_prev(severity_filter)
        else
          vim.diagnostic.goto_next(severity_filter)
        end
      end

      lsp_zero.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        vim.keymap.set("n", "gd", function()
          builtin.lsp_definitions()
        end, opts)
        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>vd", function()
          vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "[d", function()
          goto_highest_severity("prev")
        end, opts)
        vim.keymap.set("n", "]d", function()
          goto_highest_severity("next")
        end, opts)
        vim.keymap.set("n", "<leader>vca", function()
          vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>vrr", function()
          builtin.lsp_references()
        end, opts)
        vim.keymap.set("n", "<leader>vrn", function()
          vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
          vim.lsp.buf.signature_help()
        end, opts)

        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end, opts)
      end)

      lsp_zero.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "",
      })

      vim.diagnostic.config({
        update_in_insert = true,
        virtual_text = false,
        underline = true,
        severity_sort = false,
        float = {
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end
  },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local lsp_zero = require("lsp-zero")

      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()
      local cmp_format = lsp_zero.cmp_format()

      cmp.setup({
        formatting = cmp_format,
        preselect = "item",
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = "copilot" },
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "buffer",  keyword_length = 3 },
          { name = "luasnip", keyword_length = 2 },
        },
        mapping = cmp.mapping.preset.insert({
          -- confirm completion item
          ["<CR>"] = cmp.mapping.confirm(),

          -- toggle completion menu
          ["<C-e>"] = cmp_action.toggle_completion(),

          -- tab complete
          ["<Tab>"] = cmp.mapping.select_next_item(),
          -- ["<Tab>"] = cmp_action.tab_complete(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          -- ["<C-p>"] = cmp.mapping.select_prev_item(),
          -- ["<C-n>"] = cmp.mapping.select_next_item(),

          -- navigate between snippet placeholder
          ["<C-d>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),

          -- scroll documentation window
          ["<C-f>"] = cmp.mapping.scroll_docs(5),
          ["<C-u>"] = cmp.mapping.scroll_docs(-5),
        }),
      })
    end
  },
  { 'L3MON4D3/LuaSnip' },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd.with({
            filetypes = {
              "javascript",
              "typescript",
              "typescriptreact",
              "css",
              "scss",
              "html",
              "htmldjango",
              "yaml",
              "markdown",
              "graphql",
              "md",
              "txt",
              "json"
            },
          }),
        },
      })
    end
  },
  {
    "jay-babu/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettierd",
        },
        automatic_installation = false,
        handlers = {},
      })
    end
  },
  {
    "scalameta/nvim-metals",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      local metals_config = require("metals").bare_config()

      -- -- Example of settings
      metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      }

      -- *READ THIS*
      -- I *highly* recommend setting statusBarProvider to true, however if you do,
      -- you *have* to have a setting to display this in your statusline or else
      -- you'll not see any messages from metals. There is more info in the help
      -- docs about this
      metals_config.init_options.statusBarProvider = "on"

      -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Autocmd that will actually be in charging of starting the whole thing
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })

      local builtin = require("telescope.builtin")

      metals_config.on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "gd", function()
          builtin.lsp_definitions()
        end, opts)
        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>vd", function()
          vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "[d", function()
          vim.diagnostic.goto_prev()
        end, opts)
        vim.keymap.set("n", "]d", function()
          vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "<leader>vca", function()
          vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>vrr", function()
          require("telescope.builtin").lsp_references()
        end, opts)
        vim.keymap.set("n", "<leader>vrn", function()
          vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
          vim.lsp.buf.signature_help()
        end, opts)

        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end, opts)
      end
    end
  }
}
