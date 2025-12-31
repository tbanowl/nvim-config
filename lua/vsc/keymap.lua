if not vim.g.vscode then
    return
end

print('vscode keymap init')

local keymap = vim.keymap
local code = require('vscode')

local function code_action(cmd)
    return function()
        print('code action:', cmd)
        code.action(cmd)
    end
end

-- Insert 模式 ---------------------
keymap.set('i', 'jj', code_action('vscode-neovim.escape'))

-- Normal 模式 ---------------------
keymap.set('n', '<Leader>f', code_action('editor.action.formatDocument'))

-- Visual 模式 ---------------------
