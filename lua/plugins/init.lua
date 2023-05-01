return {
    -- nvim-surround
    {
        'kylechui/nvim-surround',
        event = {
            'BufReadPost',
            'BufNewFile'
        },
        config = true
    },

    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        event = {
            'BufReadPost',
            'BufNewFile'
        },
        config = true
    },

    -- bufdelete.nvim
    {
        'famiu/bufdelete.nvim',
        cmd = 'Bdelete'
    },

    -- hlargs.nvim
    {
        'm-demare/hlargs.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        ft = {
            'c',
            'cpp',
            'cs',
            'go',
            'java',
            'js',
            'jsx',
            'ts',
            'tsx',
            'jl',
            'lua',
            'nix',
            'php',
            'py',
            'r',
            'R',
            'rb',
            'vim',
            'zig',
            'rs'
        },
        config = true
    },

    -- nvim-hlslens
    {
        'kevinhwang91/nvim-hlslens',
        keys = {
            'n',
            'N',
            '*',
            '#'
        },
        dependencies = 'romainl/vim-cool',
        config = true
    },

    -- colorful-winsep.nvim
    {
        'nvim-zh/colorful-winsep.nvim',
        event = 'WinNew',
        config = true
    },

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
        config = true
    },

    -- relative-toggle.nvim
    {
        'cpea2506/relative-toggle.nvim',
        event = 'InsertEnter',
        config = true
    },

    -- trouble.nvim
    {
        'folke/trouble.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'LspAttach',
        config = true
    },
}
