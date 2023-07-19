return {
  -- tokyonight.nvim
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night',
      transparent = true,
      lualine_bold = true,
      terminal_colors = true,
      on_highlights = function(hl, c)
        local prompt = '#2d3149'
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
      end,
    },
    config = function(_, opts)
      local tokyonight = require('tokyonight')
      tokyonight.setup(opts)
      tokyonight.load()
    end,
  },

  -- nvim-notify
  {
    'rcarriga/nvim-notify',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      local notify = require('notify')
      notify.setup(opts)
      vim.notify = notify
    end,
  },

  -- dressing.nvim
  {
    'stevearc/dressing.nvim',
    init = function()
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
    lazy = true,
  },

  -- indent-blankline.nvim
  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char = '▏',
      context_char = '▏',
      use_treesitter = true,
      show_first_indent_level = true,
      show_trailing_blankline_indent = false,
      show_current_context = true,
      show_current_context_start = true,
      filetype_exclude = {
        'help',
        'dashboard',
        'Trouble',
        'neogitstatus',
        'mason',
        'toggleterm',
        'lazy',
        'neo-tree',
      },
    },
  },

  -- nvim-ufo
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        'zR',
        function()
          return require('ufo').openAllFolds()
        end,
        desc = 'Open all folds',
      },
      {
        'zM',
        function()
          return require('ufo').closeAllFolds()
        end,
        desc = 'Close all folds',
      },
    },
    opts = {
      provider_selector = function(_, filetype, buftype)
        return (filetype == '' or buftype == 'nofile') and 'indent' or { 'treesitter', 'indent' }
      end,
    },
  },

  -- windows.nvim
  {
    'anuvyklack/windows.nvim',
    dependencies = { 'anuvyklack/animation.nvim', 'anuvyklack/middleclass' },
    event = 'WinNew',
    keys = {
      { '<C-w>z', '<cmd>WindowsMaximize<CR>' },
      { '<C-w>_', '<cmd>WindowsMaximizeVertically<CR>' },
      { '<C-w>|', '<cmd>WindowsMaximizeHorizontally<CR>' },
      { '<C-w>=', '<cmd>WindowsEqualize<CR>' },
    },
    config = true,
  },

  -- lualine.nvim
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      options = {
        theme = 'tokyonight',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          'mason',
          'dashboard',
          'NeogitStatus',
          'NeogitCommitView',
          'NeogitPopup',
          'NeogitConsole',
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          'diff',
          {
            'diagnostics',
            sources = { 'nvim_lsp', 'nvim_diagnostic' },
          },
          function()
            local ok, m = pcall(require, 'better_escape')
            return ok and m.waiting and '✺' or ''
          end,
        },
        lualine_c = {
          'filename',
          {
            function()
              return require('nvim-navic').get_location()
            end,
            cond = function()
              return require('nvim-navic').is_available()
            end,
          },
        },
        lualine_x = { 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = {
        'man',
        'toggleterm',
        'neo-tree',
        'symbols-outline',
        'trouble',
        'lazy',
      },
    },
  },

  -- dashboard-nvim
  {
    'nvimdev/dashboard-nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VimEnter',
    opts = {
      theme = 'doom',
      config = {
        header = {
          '                                   ',
          '                                   ',
          '                                   ',
          '                                   ',
          '                                   ',
          '                                   ',
          '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ',
          '    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
          '          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
          '           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
          '          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
          '   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
          '  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
          ' ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
          ' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
          '      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
          '       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
          '                                   ',
          '                                   ',
          '                                   ',
          '                                   ',
          '                                   ',
          '                                   ',
        },
        center = {
          {
            icon = '󰈞 ',
            icon_hl = 'Title',
            desc = 'Find file',
            desc_hl = 'String',
            key = 'f',
            key_hl = 'Number',
            action = ':lua require("telescope.builtin").find_files()',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'New file',
            desc_hl = 'String',
            key = 'e',
            key_hl = 'Number',
            action = ':ene | startinsert',
          },
          {
            icon = '󰄉 ',
            icon_hl = 'Title',
            desc = 'Recently used files                        ',
            desc_hl = 'String',
            key = 'r',
            key_hl = 'Number',
            action = ':lua require("telescope.builtin").oldfiles()',
          },
          {
            icon = '󰊄 ',
            icon_hl = 'Title',
            desc = 'Find text',
            desc_hl = 'String',
            key = 'w',
            key_hl = 'Number',
            action = ':lua require("telescope.builtin").live_grep()',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Configuration',
            desc_hl = 'String',
            key = 'c',
            key_hl = 'Number',
            action = ':cd ~/.config/nvim | e ~/.config/nvim/init.lua',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Update plugins',
            desc_hl = 'String',
            key = 'u',
            key_hl = 'Number',
            action = ':lua require("lazy").update()',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Mason',
            desc_hl = 'String',
            key = 'm',
            key_hl = 'Number',
            action = ':Mason',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'NeoGit',
            desc_hl = 'String',
            key = 'g',
            key_hl = 'Number',
            action = ':lua require("neogit").open()',
          },
          {
            icon = '󰦛 ',
            icon_hl = 'Title',
            desc = 'Restore last session',
            desc_hl = 'String',
            key = 'l',
            key_hl = 'Number',
            action = ':lua require("persistence").load({ last = true })',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Quit Neovim',
            desc_hl = 'String',
            key = 'q',
            key_hl = 'Number',
            action = ':qa',
          },
        },
        footer = {},
      },
    },
  },

  -- which-key.nvim
  {
    'folke/which-key.nvim',
    keys = {
      '<leader>',
      '"',
      "'",
      '`',
      'c',
      'y',
      'd',
      'z',
    },
    config = function()
      local wk = require('which-key')
      local setup = {
        ignore_missing = true,
        hidden = {
          '<silent>',
          '<cmd>',
          '<Cmd>',
          '<CR>',
          'call',
          'lua',
          '^:',
          '^ ',
        },
      }

      local opts = {
        mode = 'n',
        prefix = '<leader>',
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      }

      local mappings = {
        ['e'] = 'Explorer',
        ['w'] = 'Save the current file',
        ['m'] = 'Toggle the node under cursor',
        ['s'] = 'Split node under the cursor',
        ['j'] = 'Join node under the cursor',
        ['l'] = 'Open lazy.nvim',
        t = {
          name = 'Toggle',
          t = 'twilight.nvim',
          z = 'zen-mode.nvim',
          o = 'symbols-outline.nvim',
        },
        q = {
          name = 'Session',
          q = 'Quit current file',
          Q = 'Quit neovim',
          s = 'Restore the session for the current dir',
          l = 'Restore the last session',
          d = 'Stop persistence.nvim',
        },
        f = {
          name = 'Find',
          f = 'Files',
          w = 'Words',
          b = 'Buffers',
          h = 'Help pages',
          m = 'Man pages',
          r = 'Recent files',
          R = 'Registers',
          k = 'Keymaps',
          c = 'Commands',
          t = 'Todos',
        },
        b = {
          name = 'Buffer',
          k = 'Kill the current buffer',
          K = 'Kill the current buffer forcefully',
          ['1'] = 'Jump to buffer 1',
          ['2'] = 'Jump to buffer 2',
          ['3'] = 'Jump to buffer 3',
          ['4'] = 'Jump to buffer 4',
          ['5'] = 'Jump to buffer 5',
          ['6'] = 'Jump to buffer 6',
          ['7'] = 'Jump to buffer 7',
          ['8'] = 'Jump to buffer 8',
          ['9'] = 'Jump to buffer 9',
          ['$'] = 'Jump to last buffer',
        },
        g = {
          name = 'Git',
          g = 'Open neogit',
          j = 'Next hunk',
          k = 'Prev hunk',
          l = 'Blame',
          p = 'Preview hunk',
          r = 'Reset hunk',
          R = 'Reset buffer',
          s = 'Stage hunk',
          S = 'Stage buffer',
          u = 'Undo stage hunk',
          o = 'Open changed file',
          b = 'Checkout branch',
          c = 'Checkout commit',
          d = 'Diff',
        },
        x = {
          name = 'Trouble',
          x = 'Toggle trouble',
          w = 'Toggle workspace diagnostics',
          d = 'Toggle document diagnostics',
          q = 'Open up quickfix',
          l = 'Open up location list',
          r = 'Open up lsp references',
        },
        d = {
          name = 'Debugger',
          u = 'Open Dap UI',
          e = 'Eval',
          B = 'Set breakpoint condition',
          b = 'Toggle breakpoint',
          c = 'Continue',
          C = 'Run to cursor',
          g = 'Go to line (without executing)',
          i = 'Step into',
          j = 'Down',
          k = 'Up',
          l = 'Run last',
          o = 'Step out',
          O = 'Step over',
          p = 'Pause',
          r = 'Toggle REPL',
          s = 'Session',
          t = 'Terminate',
          w = 'Widgets',
        },
      }

      wk.setup(setup)
      wk.register(mappings, opts)
    end,
  },
}
