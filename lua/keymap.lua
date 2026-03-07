vim.g.mapleader = " "

local keymap = vim.keymap

-- kyemap.set(模式, 修改后的键, 原来的键)
-- 模式：i 插入模式
-- ------------- 插入模式 -------------
keymap.set("i", "jj", "<ESC>")
keymap.set("i", "j;", "<ESC>A;<ENTER>")
keymap.set("i", "ja", "<ESC>a")
keymap.set("i", "jA", "<ESC>A")
keymap.set("i", "jo", "<ESC>o")
keymap.set("i", "jO", "<ESC>O")
keymap.set("i", "ju", "<ESC>ui")
keymap.set("i", "jw", "<ESC>wi")
keymap.set("i", "j:q", "<ESC>:q<ENTER>")
keymap.set("i", "j:wq", "<ESC>:wq<ENTER>")
keymap.set("i", "je", "<ESC>ea")
keymap.set("i", "jb", "<ESC>bi")

-- ------------- 视觉模式 -------------
-- 模式：v 视觉模式
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ------------- Normal -------------
-- 模式：n Normal模式
-- keymap.set("n", "<key>", "<motion>")

