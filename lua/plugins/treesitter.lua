return {
  -- nvim-treesitter
  {
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
      }

      -- Install the parsers
      require("nvim-treesitter").install(parsers)

      -- Enable treesitter highlighting
      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
        end,
      })

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

  -- helpview.nvim
  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
}
