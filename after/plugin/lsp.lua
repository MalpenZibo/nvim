local lsp_zero = require("lsp-zero")

local builtin = require("telescope.builtin")
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
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next()
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

	-- lsp.buffer_autoformat()
end)

local lsp_config = require("lspconfig")

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"rust_analyzer",
	},
	handlers = {
		lsp_zero.default_setup,
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
	},
})

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
	severity_sort = true,
	float = {
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()
local cmp_format = lsp_zero.cmp_format()

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
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
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = cmp.mapping.preset.insert({
		-- confirm completion item
		["<CR>"] = cmp.mapping.confirm(),

		-- toggle completion menu
		["<C-e>"] = cmp_action.toggle_completion(),

		-- tab complete
		["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
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

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd.with({
			filetypes = {
				"javascript",
				"typescript",
				"css",
				"scss",
				"html",
				"htmldjango",
				"yaml",
				"markdown",
				"graphql",
				"md",
				"txt",
			},
		}),
	},
})

require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = false,
	handlers = {},
})
