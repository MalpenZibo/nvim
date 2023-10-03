vim.opt.termguicolors = true
require("bufferline").setup({
	options = {
		color_icons = true,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = true,
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		get_element_icon = function(element)
			local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
			return icon, hl
		end,
	},
})

vim.keymap.set("n", "<C-]>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<C-[>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<C-q>", ":bdelete<CR>")
vim.keymap.set("n", "<C-Q>", ":%bd | e#<CR>")
