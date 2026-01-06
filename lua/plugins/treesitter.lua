return {
  -- nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      -- Parsers to install
      local parsers = {
        "bash",
        "c",
        "cpp",
        "desktop",
        "diff",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "ini",
        "json",
        "kitty",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "ssh_config",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "xresources",
        "yaml",
        "zathurarc",
        "zsh",
      }

      -- Install the parsers
      require("nvim-treesitter").install(parsers)

      -- HACK: Monkey patch in jsonc and sh strings into the parsers table, so
      -- the autocommand works correctly
      table.insert(parsers, "jsonc")
      table.insert(parsers, "sh")

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
    init = function()
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
