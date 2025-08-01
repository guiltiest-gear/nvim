return {
  -- nvim-treesitter
  --[[ {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    config = function()
      -- Parsers to install
      local parsers = {
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "git_config",
        "git_rebase",
        "gitignore",
        "gitcommit",
        "diff",
        "vim",
        "vimdoc",
        "bash",
        "toml",
        "ssh_config",
        "zathurarc",
        "ini",
        "xresources",
      }

      -- Install the parsers
      require("nvim-treesitter").install(parsers)

      -- Enable treesitter highlighting
      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function()
          -- Syntax highlighting
          vim.treesitter.start()

          -- Folds provided by neovim
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

          -- Indentation provided by nvim-treesitter
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Use bash ts parser for zsh
      vim.treesitter.language.register("bash", "zsh")
    end,
  }, ]]

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = vim.fn.argc(-1) == 0, -- Treesitter should load early if a file is being opened from the cmdline
    event = "VeryLazy",
    build = ":TSUpdate",
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      matchup = { enable = true, include_match_words = true },
      ensure_installed = {
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "git_config",
        "git_rebase",
        "gitignore",
        "gitcommit",
        "diff",
        "vim",
        "vimdoc",
        "bash",
        "toml",
        "ssh_config",
        "zathurarc",
        "ini",
        "xresources",
        "json",
        "jsonc",
        "xml",
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Use bash ts parser for zsh
      vim.treesitter.language.register("bash", "zsh")
    end,
  },

  -- nvim-treesitter-context
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    opts = { max_lines = 3 },
  },

  -- vim-matchup
  {
    "andymass/vim-matchup",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
      vim.g.matchup_matchparen_deferred = 1
    end,
  },

  -- treesj
  {
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = { max_join_length = 150 },
    -- TODO: Think of better keys for this plugin
    keys = {
      {
        "<leader>m",
        function()
          return require("treesj").toggle()
        end,
        desc = "Toggle node under cursor",
      },
      {
        "<leader>j",
        function()
          return require("treesj").join()
        end,
        desc = "Join node under cursor",
      },
      {
        "<leader>s",
        function()
          return require("treesj").split()
        end,
        desc = "Split node under cursor",
      },
    },
  },

  -- rainbow-delimiters.nvim
  {
    "hiphish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
  },
}
