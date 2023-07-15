return {
  -- mason.nvim
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {
      ui = {
        icons = {
          package_installed = '',
          package_pending = '',
          package_uninstalled = '',
        },
      },
    },
  },

  -- nvim-lspconfig
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      {
        'williamboman/mason-lspconfig.nvim',
        cmd = { 'LspInstall', 'LspUninstall' },
        opts = {
          ensure_installed = {
            'lua_ls',
            'clangd',
            'marksman',
          },
        },
      },
      {
        'jay-babu/mason-null-ls.nvim',
        opts = {
          ensure_installed = {
            'stylua',
            'markdownlint',
            'luacheck',
            'cpplint',
            'clang_format',
          },
        },
      },
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = 'mason.nvim',
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {
            'codelldb',
          },
        },
      },
      {
        'folke/neodev.nvim',
        config = true,
        lazy = true,
      },
    },
    keys = {
      {
        'gd',
        function()
          return require('telescope.builtin').lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gr',
        function()
          return require('telescope.builtin').lsp_references()
        end,
        desc = 'References',
      },
      {
        'gD',
        vim.lsp.buf.declaration,
        desc = 'Goto Declaration',
      },
      {
        'gI',
        function()
          return require('telescope.builtin').lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          return require('telescope.builtin').lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        'K',
        vim.lsp.buf.hover,
        desc = 'Hover',
      },
      {
        'gK',
        vim.lsp.buf.signature_help,
        desc = 'Signature Help',
      },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local navic = require('nvim-navic')
      local lspconfig = require('lspconfig')
      -- Load neodev.nvim before loading everything else
      require('neodev').setup()
      lspconfig.clangd.setup {
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end,
        -- Fix clangd offset encoding
        capabilities = { offsetEncoding = { 'utf-16' } },
      }
      lspconfig.lua_ls.setup {
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.stdpath('config') .. '/lua'] = true,
              },
            },
            telemetry = { enable = false },
          },
        },
      }
      lspconfig.marksman.setup {
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end,
      }
    end,
  },

  -- null-ls.nvim
  -- WARNING: null-ls.nvim will be archived on August 11, 2023
  -- Find a suitable replacement soon
  -- Related: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = 'williamboman/mason.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local nls = require('null-ls')
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      return {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.markdownlint,
          nls.builtins.formatting.clang_format,
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.diagnostics.luacheck,
          nls.builtins.diagnostics.cpplint,
        },
        on_attach = function(client, bufnr)
          -- Autoformat on save if supported
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds {
              group = augroup,
              buffer = bufnr,
            }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end,
      }
    end,
  },

  -- fidget.nvim
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    -- NOTE: Keep branch option until further notice
    -- Related: https://github.com/j-hui/fidget.nvim/commit/a6c51e2
    branch = 'legacy',
    opts = { window = { blend = 0 } },
  },

  -- lsp_lines.nvim
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'LspAttach',
    init = function()
      vim.diagnostic.config {
        virtual_text = false,
        virtual_lines = { highlight_whole_line = false },
      }
    end,
    config = true,
  },

  -- symbols-outline.nvim
  {
    'simrat39/symbols-outline.nvim',
    keys = { { '<leader>o', '<cmd>SymbolsOutline<CR>', desc = 'Open symbols-outline' } },
    opts = {
      symbols = {
        File = { icon = ' ' },
        Module = { icon = ' ' },
        Namespace = { icon = ' ' },
        Package = { icon = ' ' },
        Class = { icon = ' ' },
        Method = { icon = ' ' },
        Property = { icon = ' ' },
        Field = { icon = ' ' },
        Constructor = { icon = ' ' },
        Enum = { icon = ' ' },
        Interface = { icon = ' ' },
        Function = { icon = ' ' },
        Variable = { icon = ' ' },
        Constant = { icon = ' ' },
        String = { icon = ' ' },
        Number = { icon = ' ' },
        Boolean = { icon = ' ' },
        Array = { icon = ' ' },
        Object = { icon = ' ' },
        Key = { icon = ' ' },
        Null = { icon = ' ' },
        EnumMember = { icon = ' ' },
        Struct = { icon = ' ' },
        Event = { icon = ' ' },
        Operator = { icon = ' ' },
        TypeParameter = { icon = ' ' },
      },
    },
  },

  -- nvim-navic
  {
    'SmiteshP/nvim-navic',
    event = 'LspAttach',
    opts = {
      icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = ' ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
      },
    },
  },

  -- nvim-dap
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- UI for nvim-dap
      {
        'rcarriga/nvim-dap-ui',
        keys = {
          {
            '<leader>du',
            function()
              require('dapui').toggle()
            end,
            desc = 'Dap UI',
          },
          {
            '<leader>de',
            function()
              require('dapui').eval()
            end,
            desc = 'Eval',
            mode = { 'n', 'v' },
          },
        },
        config = function()
          local dap = require('dap')
          local dapui = require('dapui')
          dapui.setup()
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
          end
        end,
      },
      -- Virtual text for nvim-dap
      {
        'theHamsta/nvim-dap-virtual-text',
        config = true,
      },
    },
    keys = {
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'Breakpoint Condition',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to Cursor',
      },
      {
        '<leader>dg',
        function()
          require('dap').goto_()
        end,
        desc = 'Go to line (no execute)',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = 'Down',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = 'Up',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>do',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dp',
        function()
          require('dap').pause()
        end,
        desc = 'Pause',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.toggle()
        end,
        desc = 'Toggle REPL',
      },
      {
        '<leader>ds',
        function()
          require('dap').session()
        end,
        desc = 'Session',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Widgets',
      },
    },
    config = function()
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
    end,
  },
}
