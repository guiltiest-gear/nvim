-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so there aren't any errors on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end
    }
}

-- Plugin section
return packer.startup(function(use)
    -- impatient.nvim
    use 'lewis6991/impatient.nvim'

    -- Have packer manage itself
    use 'wbthomason/packer.nvim'

    -- nvim-lualine and nvim-web-devicons
    use {
        'nvim-lualine/lualine.nvim',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    -- neogit
    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        cmd = 'Neogit'
    }

    -- gitsigns.nvim
    use 'lewis6991/gitsigns.nvim'

    -- Tokyonight.nvim colorscheme
    use 'folke/tokyonight.nvim'

    -- nvim-autopairs
    use 'windwp/nvim-autopairs'

    -- nvim-surround
    use 'kylechui/nvim-surround'

    -- Comment.nvim
    use 'numToStr/Comment.nvim'

    -- indent-blankline.nvim
    use 'lukas-reineke/indent-blankline.nvim'

    -- telescope.nvim
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        branch = '0.1.x',
        cmd = 'Telescope'
    }

    -- telescope-fzf-native.nvim
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    -- bufferline.nvim
    use {
        'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        tag = 'v3.*'
    }

    -- bufdelete.nvim
    use {
        'famiu/bufdelete.nvim',
        cmd = {
            'Bdelete',
            'Bwipeout',
            'Bdelete!',
            'Bwipeout!'
        }
    }

    -- nvim-tree.lua
    use {
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    -- which-key.nvim
    use 'folke/which-key.nvim'

    -- alpha-nvim
    use {
        'goolord/alpha-nvim',
        requires = {
            'nvim-tree/nvim-web-devicons',
            'BlakeJC94/alpha-nvim-fortune'
        }
    }

    -- nvim-treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- toggleterm.nvim
    use {
        'akinsho/toggleterm.nvim',
        tag = '*'
    }

    -- cmp plugins
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua'
        }
    }

    -- Snippets
    use {
        'L3MON4D3/LuaSnip',
        after = 'friendly-snippets',
        run = 'make install_jsregexp',
        tag = "v1.*"
    }

    use 'rafamadriz/friendly-snippets'

    -- LSP
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig'
    }

    -- null-ls.nvim
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    -- Twilight
    use {
        'folke/twilight.nvim',
        cmd = 'Twilight'
    }

    -- vim-illuminate
    use 'RRethy/vim-illuminate'

    -- vim-cool
    use 'romainl/vim-cool'

    -- Automatically set up all my config after cloning packer.nvim
    -- This always needs to be at the bottom of the function
    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
