local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.ensure_installed({
    'rust_analyzer'
})

lsp.configure('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = 'clippy'
            },
        },
    },
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr }

    vim.keymap.set('n', '<leader>gq', function()
        vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end, opts)

    lsp.buffer_autoformat()
end)

lsp.setup()
