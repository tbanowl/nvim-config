local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Theme onedark
    {
        "navarasu/onedark.nvim",
        config = function()
            require('config.onedark')
        end,
    },
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for the icons
        },
        config = function()
            require("config.nvim-tree")
        end,
    },
    -- Vscode-like pictograms
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},
	-- Auto-completion engine
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},
	-- Code snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},
    -- LSP manager
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
    -- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.lualine")
		end,
	},
    -- Autopairs: [], (), "", '', etc
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("config.nvim-autopairs")
		end,
	},
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        -- event = { "LazyFile", "VeryLazy"},
        lazy = vim.fn.argc(-1) == 0,
        init = function(plugin)
           require("lazy.core.loader").add_to_rtp(plugin)
           require("nvim-treesitter.query_predicates")

        end,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall"},
        config = function()
            require("config.nvim-treesitter")
        end,
    },
    -- Show indentation and blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("config.indent-blankline")
		end,
	},
    -- Better UI
	-- Run `:checkhealth noice` to check for common issues
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- Add any options here
		},
		dependencies = {
			-- If you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
        -- config = function()
        --     require("config.nvim-notify")
        -- end,
	},
    -- Git integration
	"tpope/vim-fugitive",
    -- Git decorations
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.gitsigns")
		end,
	},
    -- im-select
    {
        "keaising/im-select.nvim",
        config = function()
            require("config.im-select")
        end,
    },
    -- Telescope 列表模糊查找器
    "nvim-lua/plenary.nvim",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim"}
    }


})
