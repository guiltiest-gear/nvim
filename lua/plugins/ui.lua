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
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
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
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = {
        override = function(conf)
          conf.col = -1
          conf.row = 0
          return conf
        end,
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

  -- nvim-origami
  { 'chrisgrieser/nvim-origami', event = { 'BufReadPost', 'BufNewFile' }, config = true },

  -- windows.nvim
  {
    'anuvyklack/windows.nvim',
    dependencies = { 'anuvyklack/animation.nvim', 'anuvyklack/middleclass' },
    event = 'WinNew',
    config = true,
    keys = {
      { '<C-w>z', '<cmd>WindowsMaximize<CR>', desc = 'Max out current window' },
      { '<C-w>_', '<cmd>WindowsMaximizeVertically<CR>', desc = 'Max out window height' },
      { '<C-w>|', '<cmd>WindowsMaximizeHorizontally<CR>', desc = 'Max out window width' },
      { '<C-w>=', '<cmd>WindowsEqualize<CR>', desc = 'Equalize windows' },
    },
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
          { 'diagnostics', sources = { 'nvim_lsp', 'nvim_diagnostic' } },
          {
            function()
              local ok, m = pcall(require, 'better_escape')
              return ok and m.waiting and '✺' or ''
            end,
          },
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
            color_correction = 'static',
          },
        },
        lualine_x = { 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = {
        'man',
        'quickfix',
        'mason',
        'toggleterm',
        'neo-tree',
        'trouble',
        'lazy',
        'nvim-dap-ui',
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
    keys = { '<leader>', '"', "'", '`', 'c', 'y', 'd', 'z', 'g' },
    opts = {
      operators = { gc = 'Comments', gb = 'Block comments', ys = 'Add surroundings' },
      defaults = {
        mode = { 'n', 'v' },
        ['g'] = { name = '+goto' },
        ['gc'] = { name = '+comments' },
        ['gb'] = { name = '+block comments' },
        [']'] = { name = '+next' },
        ['['] = { name = '+prev' },
        ['<leader>q'] = { name = '+quit/session' },
        ['<leader>f'] = { name = '+find' },
        ['<leader>b'] = { name = '+buffers' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>x'] = { name = '+diagnostics/quickfix' },
        ['<leader>d'] = { name = '+debugger' },
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  -- bufferline.nvim
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    event = 'UIEnter',
    keys = {
      { '<S-h>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Go to next buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<CR>', desc = 'Go to previous buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<CR>', desc = 'Go to next buffer' },
      { ']b', '<cmd>BufferLineCycleNext<CR>', desc = 'Go to previous buffer' },
      { '<Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Go to next buffer' },
      { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Go to previous buffer' },
      {
        '<leader>b1',
        function()
          return require('bufferline').go_to(1, true)
        end,
        desc = 'Jump to first buffer',
      },
      {
        '<leader>b2',
        function()
          return require('bufferline').go_to(2, true)
        end,
        desc = 'Jump to second buffer',
      },
      {
        '<leader>b3',
        function()
          return require('bufferline').go_to(3, true)
        end,
        desc = 'Jump to third buffer',
      },
      {
        '<leader>b4',
        function()
          return require('bufferline').go_to(4, true)
        end,
        desc = 'Jump to fourth buffer',
      },
      {
        '<leader>b5',
        function()
          return require('bufferline').go_to(5, true)
        end,
        desc = 'Jump to fifth buffer',
      },
      {
        '<leader>b6',
        function()
          return require('bufferline').go_to(6, true)
        end,
        desc = 'Jump to sixth buffer',
      },
      {
        '<leader>b7',
        function()
          return require('bufferline').go_to(7, true)
        end,
        desc = 'Jump to seventh buffer',
      },
      {
        '<leader>b8',
        function()
          return require('bufferline').go_to(8, true)
        end,
        desc = 'Jump to eighth buffer',
      },
      {
        '<leader>b9',
        function()
          return require('bufferline').go_to(9, true)
        end,
        desc = 'Jump to ninth buffer',
      },
      {
        '<leader>b$',
        function()
          return require('bufferline').go_to(-1, true)
        end,
        desc = 'Jump to last buffer',
      },
    },
    opts = {
      options = {
        numbers = function(opts)
          return string.format('%s', opts.ordinal)
        end,
        mode = 'buffers',
        diagnostics = 'nvim_lsp',
        ---@diagnostic disable-next-line: unused-local
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = ' '
          for e, n in pairs(diagnostics_dict) do
            local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
            s = s .. n .. sym
          end
          return s
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
  },

  -- mini.animate
  {
    'echasnovski/mini.animate',
    event = 'CursorMoved',
    opts = function()
      local animate = require('mini.animate')
      return {
        -- This is already handled by windows.nvim
        resize = { enable = false },
        open = { enable = false },
        close = { enable = false },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              return total_scroll > 1
            end,
          }),
        },
      }
    end,
  },
}
