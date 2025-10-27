-- Load Options
require('options')
-- Load keymap
require('keymap')
if vim.g.vscode then
    require('vscode_config')
    return
end
-- Load Plugins
require('plugins')
-- Set LSP
require('lsp')
-- Set colorscheme
require('colorscheme')
require("notify").setup({
    background_colour = "#000000",
})
