-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    print('Installing packer close and reopen Neovim...')
    vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so there aren't any errors on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end
    }
}

-- Plugin section
return packer.startup(function(use)
    -- impatient.nvim
    use 'lewis6991/impatient.nvim'

    -- Have packer manage itself
    use 'wbthomason/packer.nvim'

    -- nvim-lualine
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

    -- tokyonight.nvim colorscheme
    use 'folke/tokyonight.nvim'

    -- nvim-autopairs
    use 'windwp/nvim-autopairs'

    -- nvim-surround
    use 'kylechui/nvim-surround'

    -- Comment.nvim
    use 'numToStr/Comment.nvim'

    -- indent-blankline.nvim
    use {
        'lukas-reineke/indent-blankline.nvim',
        after = 'nvim-treesitter'
    }

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

    -- hlargs.nvim
    use 'm-demare/hlargs.nvim'

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
            'FelipeLema/cmp-async-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-omni'
        }
    }

    -- Snippets
    use {
        'L3MON4D3/LuaSnip',
        run = 'make install_jsregexp',
        tag = 'v1.*',
        requires = 'rafamadriz/friendly-snippets'
    }

    -- nvim-lspconfig
    use 'neovim/nvim-lspconfig'

    -- mason.nvim
    use {
        'williamboman/mason.nvim',
        requires = 'williamboman/mason-lspconfig.nvim',
        run = ':MasonUpdate'
    }

    -- null-ls.nvim
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    -- Twilight
    use {
        'folke/twilight.nvim',
        cmd = 'Twilight',
        after = 'nvim-treesitter'
    }

    -- vim-illuminate
    use 'RRethy/vim-illuminate'

    -- nvim-scrollbar
    use 'petertriho/nvim-scrollbar'

    -- hop.nvim
    use 'phaazon/hop.nvim'

    -- fidget.nvim
    use 'j-hui/fidget.nvim'

    -- nvim-ufo
    use {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async'
    }

    -- nvim-hlslens
    use 'kevinhwang91/nvim-hlslens'

    -- neodim
    use {
        'zbirenbaum/neodim',
        event = 'LspAttach'
    }

    -- colorful-winsep.nvim
    use 'nvim-zh/colorful-winsep.nvim'

    -- numb.nvim
    use 'nacro90/numb.nvim'

    -- windows.nvim
    use {
        'anuvyklack/windows.nvim',
        requires = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim'
        }
    }

    -- lsp_lines.nvim
    use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

    -- nvim-genghis
    use {
        'chrisgrieser/nvim-genghis',
        requires = 'stevearc/dressing.nvim'
    }

    -- relative-toggle.nvim
    use 'cpea2506/relative-toggle.nvim'

    -- nvim-spider
    use 'chrisgrieser/nvim-spider'

    -- vim-cool
    use 'romainl/vim-cool'

    -- Automatically set up all my config after cloning packer.nvim
    -- This always needs to be at the bottom of the function
    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
