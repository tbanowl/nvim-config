-- Load Options
require('options')
if vim.g.vscode then
    print("gui is vscode")
    return
end
-- Load keymap
require('keymap')
-- Load Packervim
require('plugins')
-- Set colorscheme
require('colorscheme')
-- Set LSP
require('lsp')
require("notify").setup({
    background_colour = "#000000",
})
