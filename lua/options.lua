local opt = vim.opt
-- 启用鼠标
opt.mouse:append("a") -- allow the mouse to be used in Nvim

-- 缩进配置
opt.tabstop = 4 -- number of visual spaces per TAB
opt.softtabstop = 4 -- number of spacesin tab when editing
opt.shiftwidth = 4 -- insert 4 spaces on a tab
opt.expandtab = true -- tabs are spaces, mainly because of python

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- UI config
opt.number = true -- show absolute line number
opt.showmode = true -- show mode
opt.relativenumber = true -- add numbers to each line on the left side
opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
opt.splitbelow = true -- open new vertical split bottom
opt.splitright = true -- open new horizontal splits right
opt.showmode = false -- show current mode, example as "-- INSERT --" mode hint in bottom
opt.termguicolors = true -- enable 24-bit RGB color in the TUI
opt.signcolumn = "yes"

-- 搜索
opt.incsearch = true -- search as characters are entered
opt.hlsearch = false -- do not highlight matches
opt.ignorecase = true -- ignore case in searches by default
opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
