-- -- Example of settings
-- metals_config.settings = {
-- 	showImplicitArguments = true,
-- 	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
-- }
--
-- -- *READ THIS*
-- -- I *highly* recommend setting statusBarProvider to true, however if you do,
-- -- you *have* to have a setting to display this in your statusline or else
-- -- you'll not see any messages from metals. There is more info in the help
-- -- docs about this
-- metals_config.init_options.statusBarProvider = "on"
--
-- -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
-- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- -- Autocmd that will actually be in charging of starting the whole thing
-- local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	-- NOTE: You may or may not want java included here. You will need it if you
-- 	-- want basic Java support but it may also conflict if you are using
-- 	-- something like nvim-jdtls which also works on a java filetype autocmd.
-- 	pattern = { "scala", "sbt" },
-- 	callback = function()
-- 		require("metals").initialize_or_attach(metals_config)
-- 	end,
-- 	group = nvim_metals_group,
-- })
--
-- -- LSP mappings
-- vim.keymap.set("n", "gd", vim.lsp.buf.definition)
-- vim.keymap.set("n", "K", vim.lsp.buf.hover)
-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
-- vim.keymap.set("n", "gr", vim.lsp.buf.references)
-- vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
-- vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
-- vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run)
-- vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
