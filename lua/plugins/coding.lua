return {
  -- Comment.nvim
  {
    'numToStr/Comment.nvim',
    config = true,
    keys = {
      { 'gc', mode = { 'n', 'v' }, desc = 'Toggle comments' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Toggle block comments' },
    },
  },

  -- nvim-autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      disable_filetype = { 'TelescopePrompt', 'text' },
      disable_in_macro = false,
      check_ts = true,
    },
  },

  -- nvim-surround
  {
    'kylechui/nvim-surround',
    config = true,
    keys = {
      { 'cs', mode = 'n', desc = 'Change surroundings' },
      { 'ys', mode = 'n', desc = 'Add surroundings' },
      { 'ds', mode = 'n', desc = 'Delete surroundings' },
    },
  },

  -- dial.nvim
  {
    'monaqa/dial.nvim',
    keys = {
      {
        '<C-a>',
        function()
          return require('dial.map').inc_normal()
        end,
        expr = true,
        desc = 'Increment',
      },
      {
        '<C-x>',
        function()
          return require('dial.map').dec_normal()
        end,
        expr = true,
        desc = 'Decrement',
      },
      {
        'g<C-a>',
        function()
          return require('dial.map').inc_gnormal()
        end,
        expr = true,
        desc = 'Multiline increment',
      },
      {
        'g<C-x>',
        function()
          return require('dial.map').dec_gnormal()
        end,
        expr = true,
        desc = 'Multiline decrement',
      },
      {
        '<C-a>',
        function()
          return require('dial.map').inc_visual()
        end,
        mode = 'v',
        expr = true,
        desc = 'Increment',
      },
      {
        '<C-x>',
        function()
          return require('dial.map').dec_visual()
        end,
        mode = 'v',
        expr = true,
        desc = 'Decrement',
      },
      {
        'g<C-a>',
        function()
          return require('dial.map').inc_gvisual()
        end,
        mode = 'v',
        expr = true,
        desc = 'Multiline increment',
      },
      {
        'g<C-x>',
        function()
          return require('dial.map').dec_gvisual()
        end,
        mode = 'v',
        expr = true,
        desc = 'Multiline decrement',
      },
    },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.integer.alias.octal,
          augend.integer.alias.binary,
          augend.constant.alias.bool,
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
        },
      })
    end,
  },

  -- nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'windwp/nvim-autopairs',
      'FelipeLema/cmp-async-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'saadparwaiz1/cmp_luasnip',
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
      {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        version = 'v2.*',
        config = true,
        keys = {
          {
            '<tab>',
            function()
              return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
            end,
            expr = true,
            silent = true,
            mode = 'i',
          },
          {
            '<tab>',
            function()
              return require('luasnip').jump(1)
            end,
            mode = 's',
          },
          {
            '<S-tab>',
            function()
              return require('luasnip').jump(-1)
            end,
            mode = { 'i', 's' },
          },
        },
      },
    },
    event = 'InsertEnter',
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      local cmp = require('cmp')
      local defaults = require('cmp.config.default')()
      return {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<S-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'async_path' },
          { name = 'calc' },
          { name = 'nvim_lsp_signature_help' },
        }),
        formatting = {
          format = function(_, item)
            local icons = {
              Array = ' ',
              Boolean = ' ',
              Class = ' ',
              Color = ' ',
              Constant = ' ',
              Constructor = ' ',
              Copilot = ' ',
              Enum = ' ',
              EnumMember = ' ',
              Event = ' ',
              Field = ' ',
              File = ' ',
              Folder = ' ',
              Function = ' ',
              Interface = ' ',
              Key = ' ',
              Keyword = ' ',
              Method = ' ',
              Module = ' ',
              Namespace = ' ',
              Null = ' ',
              Number = ' ',
              Object = ' ',
              Operator = ' ',
              Package = ' ',
              Property = ' ',
              Reference = ' ',
              Snippet = ' ',
              String = ' ',
              Struct = ' ',
              Text = ' ',
              TypeParameter = ' ',
              Unit = ' ',
              Value = ' ',
              Variable = ' ',
            }
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = { ghost_text = { hl_group = 'CmpGhostText' } },
        sorting = defaults.sorting,
        window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
      }
    end,
    config = function(_, opts)
      local cmp = require('cmp')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.setup(opts)
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' }, { name = 'cmdline' } }),
      })
      -- nvim-autopairs integration
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
}
