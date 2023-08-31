require("telescope").load_extension("live_grep_args")
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", extensions.live_grep_args.live_grep_args, { desc = "[S]earch by [G]rep" })
