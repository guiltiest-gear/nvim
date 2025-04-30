return {
  -- tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      lualine_bold = true,
      terminal_colors = true,
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
        hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopePromptNormal = { bg = prompt }
        hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
        hl.TelescopePromptTitle = { bg = prompt, fg = prompt }
        hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
      end,
    },
    config = function(_, opts)
      local tokyonight = require("tokyonight")
      tokyonight.setup(opts)
      tokyonight.load()
    end,
  },

  -- nvim-notify
  {
    "rcarriga/nvim-notify",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },

  -- nvim-origami
  {
    "chrisgrieser/nvim-origami",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },

  -- windows.nvim
  {
    "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/animation.nvim", "anuvyklack/middleclass" },
    config = true,
    keys = {
      { "<C-w>z", "<cmd>WindowsMaximize<CR>", desc = "Max out current window" },
      {
        "<C-w>_",
        "<cmd>WindowsMaximizeVertically<CR>",
        desc = "Max out window height",
      },
      {
        "<C-w>|",
        "<cmd>WindowsMaximizeHorizontally<CR>",
        desc = "Max out window width",
      },
      { "<C-w>=", "<cmd>WindowsEqualize<CR>", desc = "Equalize windows" },
      { "<C-w>v" },
      { "<C-w>s" },
    },
  },

  -- lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          "dashboard",
          "NeogitStatus",
          "NeogitCommitView",
          "NeogitPopup",
          "NeogitConsole",
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          { "diagnostics", sources = { "nvim_lsp", "nvim_diagnostic" } },
          --[[ {
            function()
              local ok, m = pcall(require, 'better_escape')
              return ok and m.waiting and '✺' or ''
            end,
          }, ]]
        },
        lualine_c = {
          "filename",
          {
            function()
              return require("nvim-navic").get_location()
            end,
            cond = function()
              return package.loaded["nvim-navic"]
                and require("nvim-navic").is_available()
            end,
            color_correction = "static",
          },
        },
        lualine_x = {
          "fileformat",
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1 },
          },
          {
            function()
              return require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = {
        "man",
        "quickfix",
        "mason",
        "toggleterm",
        "neo-tree",
        "trouble",
        "lazy",
        "nvim-dap-ui",
      },
    },
  },

  -- which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = { rules = false },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>q", group = "quit/session" },
          { "<leader>f", group = "find" },
          { "<leader>b", group = "buffers" },
          { "<leader>g", group = "git" },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "<leader>d", group = "debugger" },
          { "<leader>t", group = "terminal" },
          { "<leader>p", group = "precognition" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gz", group = "surround" },
          { "z", group = "fold" },
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add(opts.spec)
    end,
  },

  -- bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    version = "*",
    event = "UIEnter",
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Go to next buffer" },
      {
        "<S-Tab>",
        "<cmd>BufferLineCyclePrev<CR>",
        desc = "Go to previous buffer",
      },
      {
        "<S-l>",
        "<cmd>BufferLineMoveNext<CR>",
        desc = "Move current buffer forwards",
      },
      {
        "<S-h>",
        "<cmd>BufferLineMovePrev<CR>",
        desc = "Move current buffer backwards",
      },
      {
        "<leader>bf",
        function()
          return require("bufferline").move_to(1)
        end,
        desc = "Move buffer to beginning",
      },
      {
        "<leader>bl",
        function()
          return require("bufferline").move_to(-1)
        end,
        desc = "Move buffer to end",
      },
      {
        "<leader>b1",
        function()
          return require("bufferline").go_to(1, true)
        end,
        desc = "Jump to first buffer",
      },
      {
        "<leader>b2",
        function()
          return require("bufferline").go_to(2, true)
        end,
        desc = "Jump to second buffer",
      },
      {
        "<leader>b3",
        function()
          return require("bufferline").go_to(3, true)
        end,
        desc = "Jump to third buffer",
      },
      {
        "<leader>b4",
        function()
          return require("bufferline").go_to(4, true)
        end,
        desc = "Jump to fourth buffer",
      },
      {
        "<leader>b5",
        function()
          return require("bufferline").go_to(5, true)
        end,
        desc = "Jump to fifth buffer",
      },
      {
        "<leader>b6",
        function()
          return require("bufferline").go_to(6, true)
        end,
        desc = "Jump to sixth buffer",
      },
      {
        "<leader>b7",
        function()
          return require("bufferline").go_to(7, true)
        end,
        desc = "Jump to seventh buffer",
      },
      {
        "<leader>b8",
        function()
          return require("bufferline").go_to(8, true)
        end,
        desc = "Jump to eighth buffer",
      },
      {
        "<leader>b9",
        function()
          return require("bufferline").go_to(9, true)
        end,
        desc = "Jump to ninth buffer",
      },
      {
        "<leader>b$",
        function()
          return require("bufferline").go_to(-1, true)
        end,
        desc = "Jump to last buffer",
      },
    },
    opts = {
      options = {
        numbers = function(opts)
          return string.format("%s", opts.ordinal)
        end,
        mode = "buffers",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local ret = (diag.error and " " .. diag.error .. " " or "")
            .. (diag.warning and " " .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
