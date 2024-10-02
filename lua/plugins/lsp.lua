return {
  -- mason.nvim
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        icons = {
          package_installed = '',
          package_pending = '',
          package_uninstalled = '',
        },
      },
      log_level = vim.log.levels.OFF,
    },
  },

  -- mason-lspconfig.nvim
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'LspInstall', 'LspUninstall' },
    opts = {
      ensure_installed = {
        'lua_ls',
        -- 'clangd',
        'marksman',
        'bashls',
        'taplo',
        'html',
        'eslint',
        'ts_ls',
        'cssls',
      },
    },
  },

  -- mason-null-ls.nvim
  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = { 'williamboman/mason.nvim', 'nvimtools/none-ls.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'NullLsInstall', 'NullLsUninstall', 'NoneLsInstall', 'NoneLsUninstall' },
    opts = {
      ensure_installed = {
        'stylua',
        'markdownlint',
        'selene',
        -- 'clang_format',
        'shfmt',
        'markuplint',
        'prettierd',
        'stylelint',
        'codespell',
      },
      handlers = {},
    },
  },

  -- nvim-lspconfig
  {
    'neovim/nvim-lspconfig',
    dependencies = 'williamboman/mason.nvim',
    keys = {
      { 'gd', '<cmd>Telescope lsp_definitions<CR>', desc = 'Goto Definition' },
      { 'gi', '<cmd>Telescope lsp_implementations<CR>', desc = 'Goto Implementation' },
      { 'gy', '<cmd>Telescope lsp_type_definitions<CR>', desc = 'Goto T[y]pe Definition' },
      { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
      { 'K', vim.lsp.buf.hover, desc = 'Hover' },
      { 'gK', vim.lsp.buf.signature_help, desc = 'Signature Help' },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lspconfig = require('lspconfig')
      --[[ lspconfig.clangd.setup({
        -- Fix clangd offset encoding
        capabilities = { offsetEncoding = { 'utf-16' } },
        cmd = {
          'clangd',
          '--clang-tidy',
          '--fallback-style=Google',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--header-insertion=iwyu',
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      }) ]]
      lspconfig.lua_ls.setup({
        log_level = 0,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            completion = { callSnippet = 'Replace' },
          },
        },
      })
      lspconfig.marksman.setup({})
      lspconfig.bashls.setup({ filetypes = { 'sh', 'zsh', 'bash' } })
      lspconfig.taplo.setup({})
      lspconfig.html.setup({})
      lspconfig.eslint.setup({})
      lspconfig.ts_ls.setup({
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      })
      lspconfig.cssls.setup({})
    end,
  },

  -- lazydev.nvim
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        {
          path = 'luvit-meta/library',
          words = { 'vim%.uv' },
        },
      },
    },
  },

  -- luvit-meta
  { 'Bilal2453/luvit-meta', lazy = true },

  -- none-ls.nvim
  -- NOTE: Keep only the code actions, designate linters and formatters to
  -- nvim-lint and conform.nvim respectively
  {
    'nvimtools/none-ls.nvim',
    lazy = true,
    main = 'null-ls',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = function()
      local nls = require('null-ls')
      return {
        log_level = 'off',
        sources = {
          nls.builtins.code_actions.gitrebase,
        },
      }
    end,
  },

  -- conform.nvim
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        markdown = { 'prettierd' },
        html = { 'prettierd' },
        javascript = { 'prettierd' },
        css = { 'prettierd' },
        json = { 'prettierd' },
        toml = { 'taplo' },
        -- cpp = { 'clang-format' },
        -- ['*'] = {},
        ['_'] = {
          'trim_whitespace',
          'squeeze_blanks',
        },
      },
      -- Default options
      default_format_opts = {
        lsp_format = 'fallback',
      },
      -- Set up format-on-save
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 500,
      },
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { '-i', '2', '-ci', '-bn' },
        },
      },
    },
  },

  -- nvim-lint
  {
    'mfussenegger/nvim-lint',
    event = 'BufWritePost',
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        lua = { 'selene' },
        bash = { 'bash' },
        zsh = { 'zsh' },
        markdown = { 'markdownlint' },
        html = { 'markuplint' },
        css = { 'stylelint' },
        -- cpp = { 'clang-tidy' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = function()
          -- Attempt to lint the document
          lint.try_lint()

          -- Use codespell on all filetypes
          lint.try_lint('codespell')
        end,
      })
    end,
  },

  -- inc-rename.nvim
  {
    'smjonas/inc-rename.nvim',
    keys = {
      {
        'gr',
        function()
          return ':IncRename ' .. vim.fn.expand('<cword>')
        end,
        expr = true,
        desc = 'Rename',
      },
    },
    opts = { input_buffer_type = 'dressing' },
  },

  -- nvim-navic
  {
    'SmiteshP/nvim-navic',
    event = 'LspAttach',
    opts = {
      highlight = true,
      lsp = { auto_attach = true },
      lazy_update_context = true,
      icons = {
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
      },
    },
  },

  -- fidget.nvim
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      notification = { window = { winblend = 0 } },
      logger = { level = vim.log.levels.OFF },
      progress = { suppress_on_insert = true, display = { render_limit = 3 } },
    },
  },

  -- actions-preview.nvim
  {
    'aznhe21/actions-preview.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    opts = function()
      local hl = require('actions-preview.highlight')
      return {
        telescope = {
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = 'top',
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
        highlight_command = { hl.delta('delta --side-by-side') },
      }
    end,
    keys = {
      {
        'gf',
        function()
          return require('actions-preview').code_actions()
        end,
        mode = { 'n', 'v' },
        desc = 'Open actions-preview.nvim',
      },
    },
  },

  -- nvim-lightbulb
  {
    'kosayoda/nvim-lightbulb',
    event = 'LspAttach',
    opts = {
      autocmd = {
        enabled = true,
      },
    },
  },

  -- nvim-dap
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- nvim-dap-virtual-text
      { 'theHamsta/nvim-dap-virtual-text', opts = { highlight_new_as_changed = true } },

      -- mason-nvim-dap.nvim
      {
        'jay-babu/mason-nvim-dap.nvim',
        cmd = { 'DapInstall', 'DapUninstall' },
        dependencies = 'williamboman/mason.nvim',
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {
            -- 'codelldb',
          },
        },
      },

      -- goto-breakpoints.nvim
      {
        'ofirgall/goto-breakpoints.nvim',
        keys = {
          {
            ']b',
            function()
              return require('goto-breakpoints').next()
            end,
            desc = 'Next breakpoint',
          },
          {
            '[b',
            function()
              return require('goto-breakpoints').prev()
            end,
            desc = 'Previous breakpoint',
          },
        },
      },

      -- nvim-dap-ui
      {
        'rcarriga/nvim-dap-ui',
        dependencies = 'nvim-neotest/nvim-nio',
        keys = {
          {
            '<leader>du',
            function()
              return require('dapui').toggle()
            end,
            desc = 'Dap UI',
          },
          {
            '<leader>de',
            function()
              return require('dapui').eval()
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
    },
    keys = {
      {
        '<leader>dB',
        function()
          return require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'Breakpoint Condition',
      },
      {
        '<leader>db',
        function()
          return require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        function()
          return require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>dC',
        function()
          return require('dap').run_to_cursor()
        end,
        desc = 'Run to Cursor',
      },
      {
        '<leader>dg',
        function()
          return require('dap').goto_()
        end,
        desc = 'Go to line (no execute)',
      },
      {
        '<leader>di',
        function()
          return require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>dj',
        function()
          return require('dap').down()
        end,
        desc = 'Down',
      },
      {
        '<leader>dk',
        function()
          return require('dap').up()
        end,
        desc = 'Up',
      },
      {
        '<leader>dl',
        function()
          return require('dap').run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>dO',
        function()
          return require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>do',
        function()
          return require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dp',
        function()
          return require('dap').pause()
        end,
        desc = 'Pause',
      },
      {
        '<leader>dr',
        function()
          return require('dap').repl.toggle()
        end,
        desc = 'Toggle REPL',
      },
      {
        '<leader>ds',
        function()
          return require('dap').session()
        end,
        desc = 'Session',
      },
      {
        '<leader>dt',
        function()
          return require('dap').terminate()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>dw',
        function()
          return require('dap.ui.widgets').hover()
        end,
        desc = 'Widgets',
      },
    },
    config = function()
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
    end,
  },
}
