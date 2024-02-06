return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "cljoly/telescope-repo.nvim",
    },
    config = function()
        require("telescope").load_extension("live_grep_args")
        require("telescope").load_extension("noice")
        require("telescope").load_extension("ui-select")

        local builtin = require("telescope.builtin")
        local extensions = require("telescope").extensions

        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find git files" })
        vim.keymap.set("n", "<leader>ps", extensions.live_grep_args.live_grep_args, { desc = "[S]earch by [G]rep" })
    end
}
