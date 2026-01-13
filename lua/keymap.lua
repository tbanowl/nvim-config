vim.g.mapleader = " "

local keymap = vim.keymap

-- kyemap.set(模式, 修改后的键, 原来的键)
-- 模式：i 插入模式
-- ------------- 插入模式 -------------
keymap.set("i", "jj", "<ESC>")
keymap.set("i", "j;", "<ESC>A;<ENTER>")
keymap.set("i", "j<ENTER>", "<ESC>A<ENTER>")
keymap.set("i", "ju", "<ESC>ui")
keymap.set("i", "jw", "<ESC>wi")
keymap.set("i", "je", "<ESC>ei")
keymap.set("i", "jb", "<ESC>bi")

-- ------------- 视觉模式 -------------
-- 模式：v 视觉模式
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ------------- Normal -------------
-- 模式：n Normal模式
-- keymap.set("n", "<key>", "<motion>")

