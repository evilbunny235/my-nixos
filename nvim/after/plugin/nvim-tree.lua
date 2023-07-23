require('nvim-tree').setup({
    view = {
        width = 35
    }
})
vim.keymap.set('n', '<leader>tn', ':NvimTreeToggle<CR>')

