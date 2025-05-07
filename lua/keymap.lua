vim.g.mapleader = " "

local keymap = vim.keymap

-- kyemap.set(模式, 修改后的键, 原来的键)
-- 模式：i 插入模式,
-- ------------- 插入模式 -------------
keymap.set("i", "jk", "<ESC")

-- ------------- 视觉模式 -------------
-- 模式：v 插入模式,
-- keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ------------- Normal -------------
-- 模式：n 插入模式,

-- 窗口
if vim.g.vscode then
    require('keymap.vscode')
    return
end
