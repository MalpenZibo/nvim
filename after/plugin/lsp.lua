local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"rust_analyzer",
})

lsp.configure("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})

lsp.configure("html", {
	filetypes = { "html", "htmldjango" },
})

--lsp.configure("metals", { force_setup = true })

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

local builtin = require("telescope.builtin")

lsp.on_attach(function(bufnr)
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

	lsp.buffer_autoformat()
end)

lsp.setup()

vim.diagnostic.config({
	update_in_insert = true,
	virtual_text = false,
	underline = true,
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
