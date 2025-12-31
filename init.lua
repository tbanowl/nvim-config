-- Load Options
require('options')
-- Load keymap
require('keymap')
-- Load Plugins
require('plugins')
require("notify").setup({
    background_colour = "#000000",
})
if vim.g.vscode then
    require('vsc.config')
    return
end
-- Set LSP
require('lsp')
-- Set colorscheme
require('colorscheme')
