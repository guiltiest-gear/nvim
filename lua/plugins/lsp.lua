return {
  -- mason.nvim
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
      log_level = vim.log.levels.OFF,
    },
  },

  -- mason-tool-installer.nvim
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    --[[ cmd = {
      "MasonToolsInstall",
      "MasonToolsInstallSync",
      "MasonToolsUpdate",
      "MasonToolsUpdateSync",
      "MasonToolsClean",
    }, ]]
    opts = {
      ensure_installed = {
        -- Language serverss
        "lua-language-server",
        -- "clangd",
        "marksman",
        "bash-language-server",
        "taplo",
        --[[ "html-lsp",
        "eslint-lsp",
        "typescript-language-server",
        "css-lsp", ]]
        -- Linters and formatters
        "stylua",
        "markdownlint",
        "selene",
        --[[ "shellcheck",
        "clang-format",
        "cpplint", ]]
        "shfmt",
        -- "markuplint",
        "prettierd",
        -- "stylelint",
        "codespell",
        -- Debuggers
        --[[ "codelldb",
        "bash-debug-adapter",
        "firefox-debug-adapter", ]]
      },
      run_on_start = true,
    },
  },

  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "Saghen/blink.cmp" },
    keys = {
      { "gd", "<cmd>Telescope lsp_definitions<CR>", desc = "Goto Definition" },
      {
        "gi",
        "<cmd>Telescope lsp_implementations<CR>",
        desc = "Goto Implementation",
      },
      {
        "gy",
        "<cmd>Telescope lsp_type_definitions<CR>",
        desc = "Goto T[y]pe Definition",
      },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = {
          spacing = 4,
          source = "if_many",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H",
          },
        },
      },
      servers = {
        clangd = {
          -- Fix clangd offset encoding
          capabilities = { offsetEncoding = { "utf-16" } },
          cmd = {
            "clangd",
            "--clang-tidy",
            "--fallback-style=Google",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--header-insertion=iwyu",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        lua_ls = {
          log_level = 0,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                arrrayIndex = "Disable",
              },
            },
          },
        },
        marksman = {},
        bashls = { filetypes = { "sh", "zsh", "bash" } },
        taplo = {},
        --[[ html = {},
        eslint = {},
        ts_ls = {
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
        },
        cssls = {}, ]]
      },
    },
    config = function(_, opts)
      for server, config in pairs(opts.servers) do
        config.capabilities =
          require("blink.cmp").get_lsp_capabilities(config.capabilities)
        vim.lsp.enable(server)
        vim.lsp.config(server, config)
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
    end,
  },

  -- lazydev.nvim
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        "nvim-dap-ui",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },

  -- luvit-meta
  { "Bilal2453/luvit-meta", lazy = true },

  -- conform.nvim
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    init = function()
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        markdown = { "prettierd" },
        --[[ html = { "prettierd" },
        javascript = { "prettierd" },
        css = { "prettierd" }, ]]
        json = { "prettierd" },
        toml = { "taplo" },
        cpp = { "clang-format" },
        c = { "clang-format" },
        ["*"] = {
          "trim_whitespace",
          "squeeze_blanks",
        },
        -- ["_"] = {},
      },
      -- Default options
      default_format_opts = {
        lsp_format = "fallback",
      },
      -- Set up format-on-save
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          lsp_format = "fallback",
          timeout_ms = 500,
        }
      end,
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci", "-bn" },
        },
        --[[ clang_format = {
          prepend_args = { "--style=Google" },
        }, ]]
      },
    },
  },

  -- nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        lua = { "luac", "selene" },
        bash = {
          "bash",
          -- "shellcheck",
        },
        zsh = { "zsh" },
        markdown = { "markdownlint" },
        --[[ html = { "markuplint" },
        css = { "stylelint" }, ]]
        cpp = { "clang-tidy" },
        c = { "clang-tidy" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          -- Attempt to lint the document
          lint.try_lint()

          -- Use codespell on all filetypes
          lint.try_lint("codespell")
        end,
      })
    end,
  },

  -- nvim-navic
  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    opts = {
      highlight = true,
      lsp = { auto_attach = true },
      lazy_update_context = true,
      icons = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Copilot = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = " ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
      },
    },
  },

  -- fidget.nvim
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    version = "*",
    opts = {
      notification = { window = { winblend = 0 } },
      logger = { level = vim.log.levels.OFF },
      progress = { suppress_on_insert = true, display = { render_limit = 3 } },
    },
  },

  -- actions-preview.nvim
  {
    "aznhe21/actions-preview.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = function()
      local hl = require("actions-preview.highlight")
      return {
        telescope = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
        highlight_command = { hl.delta("delta --side-by-side") },
      }
    end,
    keys = {
      {
        "gf",
        function()
          return require("actions-preview").code_actions()
        end,
        mode = { "n", "v" },
        desc = "Open actions-preview.nvim",
      },
    },
  },

  -- nvim-lightbulb
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      autocmd = {
        enabled = true,
      },
    },
  },

  -- nvim-dap
  {
    "mfussenegger/nvim-dap",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- nvim-dap-virtual-text
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = { highlight_new_as_changed = true },
      },

      -- goto-breakpoints.nvim
      {
        "ofirgall/goto-breakpoints.nvim",
        keys = {
          {
            "]b",
            function()
              return require("goto-breakpoints").next()
            end,
            desc = "Next breakpoint",
          },
          {
            "[b",
            function()
              return require("goto-breakpoints").prev()
            end,
            desc = "Previous breakpoint",
          },
        },
      },

      -- nvim-dap-ui
      {
        "rcarriga/nvim-dap-ui",
        dependencies = "nvim-neotest/nvim-nio",
        keys = {
          {
            "<leader>du",
            function()
              return require("dapui").toggle()
            end,
            desc = "Dap UI",
          },
          {
            "<leader>de",
            function()
              return require("dapui").eval()
            end,
            desc = "Eval",
            mode = { "n", "v" },
          },
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup()
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
    },
    keys = {
      {
        "<leader>dB",
        function()
          return require("dap").set_breakpoint(
            vim.fn.input("Breakpoint condition: ")
          )
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>db",
        function()
          return require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          return require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>dC",
        function()
          return require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          return require("dap").goto_()
        end,
        desc = "Go to line (no execute)",
      },
      {
        "<leader>di",
        function()
          return require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          return require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          return require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          return require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>dO",
        function()
          return require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>do",
        function()
          return require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dp",
        function()
          return require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          return require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          return require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          return require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function()
          return require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
    },
    opts = {
      adapters = {
        bashdb = {
          type = "executable",
          command = vim.fn.stdpath("data")
            .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
          name = "bashdb",
        },
        gdb = {
          type = "executable",
          command = "gdb",
          args = {
            "--interpreter=dap",
            "--eval-command",
            "set pretty print on",
          },
        },
      },
      configurations = {
        sh = {
          {
            type = "bashdb",
            request = "launch",
            name = "Launch file",
            showDebugOutput = true,
            pathBashdb = vim.fn.stdpath("data")
              .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
            pathBashdbLib = vim.fn.stdpath("data")
              .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
            trace = true,
            file = "${file}",
            program = "${file}",
            cwd = "${workspaceFolder}",
            pathCat = "cat",
            pathBash = "/bin/bash",
            pathMkfifo = "mkfifo",
            pathPkill = "pkill",
            args = {},
            env = {},
            terminalKind = "integrated",
          },
        },
        c = {
          {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
              return vim.fn.input(
                "Path to executable: ",
                vim.fn.getcwd() .. "/",
                "file"
              )
            end,
            args = {}, -- provide arguments if needed
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
          },
          {
            name = "Select and attach to process",
            type = "gdb",
            request = "attach",
            program = function()
              return vim.fn.input(
                "Path to executable: ",
                vim.fn.getcwd() .. "/",
                "file"
              )
            end,
            pid = function()
              local name = vim.fn.input("Executable name (filter): ")
              return require("dap.utils").pick_process({ filter = name })
            end,
            cwd = "${workspaceFolder}",
          },
          {
            name = "Attach to gdbserver :1234",
            type = "gdb",
            request = "attach",
            target = "localhost:1234",
            program = function()
              return vim.fn.input(
                "Path to executable: ",
                vim.fn.getcwd() .. "/",
                "file"
              )
            end,
            cwd = "${workspaceFolder}",
          },
        },
        --[[ javascript = {
          {
            name = "Debug with Firefox",
            type = "firefox",
            request = "launch",
            reAttach = true,
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            firefoxExecutable = "/usr/bin/firefox",
          },
        }, ]]
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      for debugger, config in pairs(opts.adapters) do
        dap.adapters[debugger] = config
      end
      for ft, config in pairs(opts.configurations) do
        dap.configurations[ft] = config
      end
      -- Reuse c config for cpp
      opts.configurations.cpp = opts.configurations.c

      vim.api.nvim_set_hl(
        0,
        "DapStoppedLine",
        { default = true, link = "Visual" }
      )
    end,
  },
}
