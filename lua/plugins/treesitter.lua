return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      ensure_installed = {
        'lua',
        'luadoc',
        'luap',
        'cpp',
        'markdown',
        'markdown_inline',
        'git_config',
        'git_rebase',
        'gitcommit',
        -- 'gitignore',
        -- 'gitattributes',
        'diff',
        -- 'vim',
        'vimdoc',
        -- 'regex',
        'bash',
        'toml',
        'ssh_config',
      },
      highlight = { enable = true },
      indent = { enable = true },
      ignore_install = { '' },
      auto_install = true,
      -- vim-matchup config
      -- NOTE: I'm not sure about the quote matching feature for vim-matchup
      -- May remove this in the future
      matchup = { enable = true, include_match_words = true, enable_quotes = true },
    },
  },

  -- nvim-treesitter-context
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },

  -- vim-matchup
  { 'andymass/vim-matchup', dependencies = 'nvim-treesitter/nvim-treesitter', event = { 'BufReadPost', 'BufNewFile' } },

  -- treesj
  {
    'Wansmer/treesj',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = { max_join_length = 150 },
    keys = {
      {
        '<leader>m',
        function()
          return require('treesj').toggle()
        end,
        desc = 'Toggle node under cursor',
      },
      {
        '<leader>j',
        function()
          return require('treesj').join()
        end,
        desc = 'Join node under cursor',
      },
      {
        '<leader>s',
        function()
          return require('treesj').split()
        end,
        desc = 'Split node under cursor',
      },
    },
  },

  -- rainbow-delimiters.nvim
  {
    'hiphish/rainbow-delimiters.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
  },

  -- indent-blankline.nvim
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      indent = { char = '▏' },
      scope = { char = '▏' },
      exclude = { filetypes = { 'lazy', 'dashboard', 'mason' } },
    },
  },
}
