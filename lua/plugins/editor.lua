return {
  -- todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      {
        "]t",
        function()
          return require("todo-comments").jump_next()
        end,
        desc = "Jump to next todo comment",
      },
      {
        "[t",
        function()
          return require("todo-comments").jump_prev()
        end,
        desc = "Jump to previous todo comment",
      },
    },
  },

  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = { "TelescopePrompt", "text" },
      disable_in_macro = false,
      check_ts = true,
    },
  },

  -- trouble.nvim
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = { use_diagnostic_signs = true, focus = true },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle trouble.nvim",
      },
      {
        "<leader>xw",
        "<cmd>Trouble diagnostics<cr>",
        desc = "Open workspace diagnostics",
      },
      {
        "<leader>xd",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Open document diagnostics",
      },
      { "gR", "<cmd>Trouble lsp toggle<cr>", desc = "References" },
      { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Todo (Trouble)" },
      {
        "<leader>xT",
        "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<CR>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
    },
  },

  -- vim-cool
  { "romainl/vim-cool", event = "VeryLazy" },

  -- neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    -- Load neo-tree.nvim if we provide a directory as an argument
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup(
          "Neotree_start_directory",
          { clear = true }
        ),
        desc = "Start neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            ---@diagnostic disable-next-line: param-type-mismatch
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("lazy").load({ plugins = { "neo-tree.nvim" } })
            end
          end
        end,
      })
    end,
    branch = "v3.x",
    keys = {
      {
        "<leader>e",
        function()
          return require("neo-tree.command").execute({
            toggle = true,
            dir = vim.uv.cwd(),
          })
        end,
        desc = "Open neo-tree.nvim",
      },
      {
        "<leader>ge",
        function()
          return require("neo-tree.command").execute({
            source = "git_status",
            toggle = true,
          })
        end,
        desc = "Git explorer",
      },
      {
        "<leader>be",
        function()
          return require("neo-tree.command").execute({
            source = "buffers",
            toggle = true,
          })
        end,
        desc = "Buffer explorer",
      },
    },
    cmd = "Neotree",
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            -- auto close
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = { ".git" },
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["h"] = {
            function(state)
              local node = state.tree:get_node()
              if node.type == "directory" and node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(
                  state,
                  node
                )
              else
                require("neo-tree.ui.renderer").focus_node(
                  state,
                  node:get_parent_id()
                )
              end
            end,
            desc = "Open directory",
          },
          ["l"] = {
            function(state)
              local node = state.tree:get_node()
              if node.type == "directory" then
                if not node:is_expanded() then
                  require("neo-tree.sources.filesystem").toggle_directory(
                    state,
                    node
                  )
                elseif node:has_children() then
                  require("neo-tree.ui.renderer").focus_node(
                    state,
                    node:get_child_ids()[1]
                  )
                end
              end
            end,
            desc = "Close directory",
          },
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy path to clipboard",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
    },
  },

  -- leap.nvim
  {
    "https://codeberg.org/andyg/leap.nvim.git",
    event = "VeryLazy",
    dependencies = { "tpope/vim-repeat", keys = { "." } },
    keys = {
      {
        "s",
        "<Plug>(leap-forward)",
        mode = { "n", "x", "o" },
        desc = "Leap forward",
      },
      {
        "S",
        "<Plug>(leap-backward)",
        mode = { "n", "x", "o" },
        desc = "Leap backward",
      },
      {
        "gs",
        "<Plug>(leap-from-window)",
        mode = { "n", "x", "o" },
        desc = "Leap from windows",
      },
    },
    opts = {
      -- Disable auto-jumping to first match
      safe_labels = "",

      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group:
      equivalence_classes = {
        " \t\r\n",
        "([{",
        "}])",
        "\"'`",
      },

      -- Define a preview filter (skip the middle of alphanumeric words):
      preview_filter = function(ch0, ch1, ch2)
        return not (
          ch1:match("%s")
          or ch0:match("%a") and ch1:match("%a") and ch2:match("%a")
        )
      end,
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
    end,
  },

  -- leap.nvim enhanced f/t motions
  {
    "https://codeberg.org/andyg/leap.nvim.git",
    config = function()
      do
        -- Return an argument table for `leap()`, tailored for f/t-motions.
        local function as_ft(key_specific_args)
          local common_args = {
            inputlen = 1,
            inclusive = true,
            -- To limit search scope to the current line:
            -- pattern = function (pat) return '\\%.l'..pat end,
            opts = {
              labels = "", -- force autojump
              safe_labels = vim.fn.mode(1):match("[no]") and "" or nil, -- [1]
            },
          }
          return vim.tbl_deep_extend("keep", common_args, key_specific_args)
        end

        local clever = require("leap.user").with_traversal_keys -- [2]
        local clever_f = clever("f", "F")
        local clever_t = clever("t", "T")

        for key, key_specific_args in pairs({
          f = { opts = clever_f },
          F = { backward = true, opts = clever_f },
          t = { offset = -1, opts = clever_t },
          T = { backward = true, offset = 1, opts = clever_t },
        }) do
          vim.keymap.set({ "n", "x", "o" }, key, function()
            require("leap").leap(as_ft(key_specific_args))
          end)
        end
      end

      ------------------------------------------------------------------------
      -- [1] Match the modes here for which you don't want to use labels
      --     (`:h mode()`, `:h lua-pattern`).
      -- [2] This helper function makes it easier to set "clever-f"-like
      --     functionality (https://github.com/rhysd/clever-f.vim), returning
      --     an `opts` table derived from the defaults, where the given keys
      --     are added to `keys.next_target` and `keys.prev_target`
    end,
  },

  -- Jump to lines with leap.nvim
  {
    "https://codeberg.org/andyg/leap.nvim.git",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "|", function()
        local line = vim.fn.line(".")
        -- Skip 3-3 lines around the cursor.
        local top, bot = unpack({ math.max(1, line - 3), line + 3 })
        require("leap").leap({
          pattern = "\\v(%<" .. top .. "l|%>" .. bot .. "l)$",
          windows = { vim.fn.win_getid() },
          opts = { safe_labels = "" },
        })
      end)
    end,
  },

  -- neogit
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    cmd = "Neogit",
    keys = { { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open neogit" } },
    opts = {
      kind = "replace",
      status = { recent_commit_count = 25 },
      integrations = { telescope = true },
      auto_show_console = false,
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
    },
  },

  -- gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup(
          "GitSignsLazyLoad",
          { clear = true }
        ),
        callback = function()
          vim.fn.system(
            "git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse"
          )
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
            vim.schedule(function()
              require("lazy").load({ plugins = { "gitsigns.nvim" } })
            end)
          end
        end,
      })
    end,
    cmd = "Gitsigns",
    ft = "gitcommit",
    keys = {
      { "<leader>gB", "<cmd>Gitsigns blame_line<CR>", desc = "Open git blame" },
      {
        "<leader>gp",
        "<cmd>Gitsigns preview_hunk_inline<CR>",
        desc = "Preview the hunk",
      },
      {
        "<leader>gr",
        "<cmd>Gitsigns reset_hunk<CR>",
        mode = { "n", "v" },
        desc = "Reset the hunk",
      },
      {
        "<leader>gR",
        "<cmd>Gitsigns reset_buffer<CR>",
        desc = "Reset the buffer",
      },
      {
        "<leader>gs",
        "<cmd>Gitsigns stage_hunk<CR>",
        mode = { "n", "v" },
        desc = "Stage the hunk",
      },
      {
        "<leader>gS",
        "<cmd>Gitsigns stage_buffer<CR>",
        desc = "Stage the buffer",
      },
      { "<leader>gd", "<cmd>Gitsigns diffthis<CR>", desc = "Open a diff" },
      {
        "<leader>gq",
        "<cmd>Gitsigns setqflist<CR>",
        desc = "Open quickfix list with hunks",
      },
      {
        "<leader>gl",
        "<cmd>Gitsigns setloclist<CR>",
        desc = "Open location list with hunks",
      },
      {
        "<leader>gL",
        "<cmd>Gitsigns toggle_current_line_blame<CR>",
        desc = "Toggle line blame",
      },
      {
        "]g",
        function()
          return require("gitsigns").nav_hunk("next", { wrap = false })
        end,
        desc = "Next hunk",
      },
      {
        "[g",
        function()
          return require("gitsigns").nav_hunk("prev", { wrap = false })
        end,
        desc = "Previous hunk",
      },
    },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
      },
      attach_to_untracked = true,
      numhl = true,
      -- word_diff = true,
    },
  },

  -- toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    enabled = false,
    version = "*",
    keys = {
      {
        "<leader>tv",
        "<cmd>ToggleTerm direction=vertical<CR>",
        desc = "Open a vertical terminal",
      },
      {
        "<leader>th",
        "<cmd>ToggleTerm direction=horizontal<CR>",
        desc = "Open a horizontal terminal",
      },
      {
        "<leader>tf",
        "<cmd>ToggleTerm direction=float<CR>",
        desc = "Open a floating terminal",
      },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.ceil(vim.o.columns * 0.4)
        else
          return 20
        end
      end,
      hide_numbers = true,
      shell = vim.o.shell,
      shade_terminals = true,
      shading_factor = 2,
      persist_size = true,
      start_in_insert = true,
      direction = "float",
      close_on_exit = true,
      float_opts = { border = "curved" },
    },
  },

  -- snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      quickfile = { enabled = true },
      bigfile = { enabled = true },
      image = { enabled = true },
      indent = { enabled = true },
      scope = { enabled = true },
      words = {
        enabled = true,
        debounce = 100,
      },
      input = { enabled = true },
      statuscolumn = {
        enabled = false,
        left = { "fold", "git" },
        right = { "mark", "sign" },
        folds = {
          open = true,
          git_hl = false,
        },
        git = {
          patterns = { "GitSign" },
        },
      },
      scroll = {
        animate = {
          duration = {
            total = 150,
          },
        },
      },
      dashboard = {
        enabled = true,
        preset = {
          pick = "telescope.nvim",
          keys = {
            {
              icon = "󰈞",
              key = "f",
              desc = "Find file",
              action = ":Telescope find_files",
            },
            {
              icon = "",
              key = "e",
              desc = "New file",
              action = ":ene | startinsert",
            },
            {
              icon = "󰄉",
              key = "r",
              desc = "Recent files",
              action = ":Telescope oldfiles",
            },
            {
              icon = "󰊄",
              key = "w",
              desc = "Find text",
              action = ":Telescope live_grep",
            },
            {
              icon = "",
              key = "c",
              desc = "Configuration",
              action = ":cd ~/.config/nvim | e ~/.config/nvim/init.lua",
            },
            {
              icon = "",
              key = "u",
              desc = "Update plugins",
              action = ":Lazy update",
            },
            { icon = "", key = "m", desc = "Mason", action = ":Mason" },
            { icon = "", key = "g", desc = "NeoGit", action = ":Neogit" },
            {
              icon = "󰦛",
              key = "l",
              desc = "Restore last session",
              action = ":lua require('persistence').load({ last = true })",
            },
            { icon = "", key = "q", desc = "Quit Neovim", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    keys = {
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Previous Reference",
        mode = { "n", "t" },
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bD",
        function()
          Snacks.bufdelete.other()
        end,
        desc = "Delete Other Buffers",
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end,
  },

  -- highlight-undo.nvim
  {
    "tzachar/highlight-undo.nvim",
    keys = { "u", "<C-r>" },
    config = true,
  },

  -- undotree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Open undotree" },
    },
    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
    end,
  },

  -- better-escape.nvim
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      i = {
        j = {
          j = false,
        },
      },
      c = {
        j = {
          j = false,
        },
      },
      t = {
        j = {
          j = false,
        },
      },
    },
  },

  -- telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    version = "v0.1.*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").load_extension("ui-select")
        end,
      },
    },
    event = "VeryLazy",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Files" },
      { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Words" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
      { "<leader>fm", "<cmd>Telescope man_pages<CR>", desc = "Man pages" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recently opened" },
      { "<leader>fR", "<cmd>Telescope registers<CR>", desc = "Registers" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Commands" },
      {
        "<leader>fC",
        "<cmd>Telescope command_history<CR>",
        desc = "Command history",
      },
      { "<leader>fl", "<cmd>Telescope resume<CR>", desc = "Resume" },
      {
        "<leader>fd",
        "<cmd>Telescope diagnostics bufnr=0<CR>",
        desc = "Document diagnostics",
      },
      {
        "<leader>fD",
        "<cmd>Telescope diagnostics<CR>",
        desc = "Workspace diagnostics",
      },
      {
        "<leader>fs",
        "<cmd>Telescope lsp_document_symbols<CR>",
        desc = "Document symbols",
      },
      { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Git files" },
      { "<leader>fo", "<cmd>Telescope vim_options<CR>", desc = "Options" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Todo" },
      {
        "<leader>fT",
        "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>",
        desc = "Todo/Fix/Fixme",
      },
      {
        "<leader>gc",
        "<cmd>Telescope git_status<CR>",
        desc = "Search through changed files",
      },
      {
        "<leader>gb",
        "<cmd>Telescope git_branches<CR>",
        desc = "Search through git branches",
      },
      {
        "<leader>gC",
        "<cmd>Telescope git_commits<CR>",
        desc = "Search and checkout git commits",
      },
      --[[ {
        '<leader>gO',
        function()
          return require('telescope.builtin').git_stash()
        end,
        desc = 'Search through stash',
      }, ]]
    },
    opts = function()
      -- File and text search in hidden files and directories
      local telescopeConfig = require("telescope.config")
      -- Clone the default Telescope configuration
      local vimgrep_arguments =
        { unpack(telescopeConfig.values.vimgrep_arguments) }
      local actions = require("telescope.actions")
      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = { n = { ["q"] = actions.close } },
          vimgrep_arguments = vimgrep_arguments,
          theme = "tokyonight",
          path_display = { "smart" },
          file_ignore_patterns = { ".git/" },
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
        },
        pickers = {
          find_files = {
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!**/.git/*",
            },
          },
        },
      }
    end,
  },

  -- nvim-gomove
  {
    "booperlv/nvim-gomove",
    config = true,
    keys = {
      { "<A-h>", mode = { "n", "v" }, desc = "Block left" },
      { "<A-j>", mode = { "n", "v" }, desc = "Block down" },
      { "<A-k>", mode = { "n", "v" }, desc = "Block up" },
      { "<A-l>", mode = { "n", "v" }, desc = "Block right" },
    },
  },

  -- persistence.nvim
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = true,
    keys = {
      {
        "<leader>qs",
        function()
          return require("persistence").load()
        end,
        desc = "Restore the session for the current dir",
      },
      {
        "<leader>ql",
        function()
          return require("persistence").load({ last = true })
        end,
        desc = "Restore the last session",
      },
      {
        "<leader>qS",
        function()
          return require("persistence").select()
        end,
        desc = "Select session",
      },
      {
        "<leader>qd",
        function()
          return require("persistence").stop()
        end,
        desc = "Stop persistence",
      },
    },
  },

  -- mini.surround
  {
    "nvim-mini/mini.surround",
    keys = {
      { "gza", mode = { "n", "v" }, desc = "Add surrounding" },
      { "gzd", desc = "Delete surrounding" },
      { "gzf", desc = "Find right surrounding" },
      { "gzF", desc = "Find left surrounding" },
      { "gzh", desc = "Highlight surrounding" },
      { "gzr", desc = "Replace surrounding" },
      { "gzn", desc = "Updated n_lines" },
    },
    opts = {
      mappings = {
        add = "gza",
        delete = "gzd",
        find = "gzf",
        find_left = "gzF",
        highlight = "gzh",
        replace = "gzr",
        update_n_lines = "gzn",
      },
    },
  },

  -- precognition.nvim
  {
    "tris203/precognition.nvim",
    keys = {
      {
        "<leader>pP",
        "<cmd>Precognition toggle<CR>",
        desc = "Toggle precognition.nvim",
      },
      {
        "<leader>pp",
        "<cmd>Precognition peek<CR>",
        desc = "Peek precognition.nvim",
      },
    },
    opts = { startVisible = false },
  },

  -- in-and-out.nvim
  {
    "ysmb-wtsg/in-and-out.nvim",
    keys = {
      {
        "<C-CR>",
        function()
          return require("in-and-out").in_and_out()
        end,
        mode = "i",
      },
    },
  },

  -- vim-lastplace
  {
    "farmergreg/vim-lastplace",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.g.lastplace_open_folds = 0
    end,
  },

  -- vim-kitty
  -- NOTE: Plugin will be depreciated with neovim v0.12+
  -- Related: https://github.com/fladson/vim-kitty/commit/cd72f2d9cfee8d6aba5a180a5ac3ca265b5d3a46
  -- Related: https://github.com/neovim/neovim/pull/35809
  {
    "fladson/vim-kitty",
    enabled = function()
      return vim.fn.has("nvim-0.12") == 0
    end,
    ft = "kitty",
  },

  -- oil.nvim
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = { { "-", "<cmd>Oil<CR>", desc = "Open parent directory" } },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
        case_insensitive = true,
      },
    },
  },
}
