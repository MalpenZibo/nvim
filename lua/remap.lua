vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeOpen<CR>", { noremap = true, silent = true, desc = "Open file explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

vim.keymap.set("n", "J", "mzJ`z", { silent = true, desc = "Join lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Scroll page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Scroll page up" })
vim.keymap.set("n", "n", "nzzzv", { silent = true, desc = "Move to next search match" })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, desc = "Move to previous search match" })

-- greaest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selection" })

-- next gretest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole register" })

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { silent = true, desc = "Next quickfix" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { silent = true, desc = "Previous quickfix" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { silent = true, desc = "Next location" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { silent = true, desc = "Previous location" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace" })

vim.keymap.set("n", "<C-s>", "<cmd>update<CR>", { desc = "Save file" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
