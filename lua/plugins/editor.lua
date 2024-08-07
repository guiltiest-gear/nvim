return {
  -- todo-comments.nvim
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
    keys = {
      {
        ']t',
        function()
          return require('todo-comments').jump_next()
        end,
        desc = 'Jump to next todo comment',
      },
      {
        '[t',
        function()
          return require('todo-comments').jump_prev()
        end,
        desc = 'Jump to previous todo comment',
      },
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

  -- trouble.nvim
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = { use_diagnostic_signs = true, focus = true },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Toggle trouble.nvim' },
      { '<leader>xw', '<cmd>Trouble diagnostics<cr>', desc = 'Open workspace diagnostics' },
      { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Open document diagnostics' },
      { 'gR', '<cmd>Trouble lsp toggle<cr>', desc = 'References' },
      { '<leader>xt', '<cmd>TodoTrouble<CR>', desc = 'Todo (Trouble)' },
      { '<leader>xT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<CR>', desc = 'Todo/Fix/Fixme (Trouble)' },
    },
  },

  -- vim-illuminate
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      -- providers = { 'lsp', 'treesitter', 'regex' },
      large_file_cuttoff = 2000,
      large_file_overrides = { providers = { 'lsp' } },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end
      map(']]', 'next')
      map('[[', 'prev')
      -- Set it after loading ftplugins
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
    keys = { { ']]', desc = 'Next Reference' }, { '[[', desc = 'Prev Reference' } },
  },

  -- vim-cool
  { 'romainl/vim-cool', keys = { '/', '?', '*', '#', 'g*', 'g#', 'n', 'N' } },
  -- HACK: There doesn't seem to be an autocommand event to detect when you start
  -- searching, so this will have to do until I can find an event for that or until neovim creates that event
  -- Related: https://github.com/neovim/neovim/issues/18879

  -- neo-tree.nvim
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
    -- Load neo-tree.nvim if we provide a directory as an argument
    init = function()
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
        desc = 'Start neo-tree with directory',
        once = true,
        callback = function()
          if package.loaded['neo-tree'] then
            return
          else
            ---@diagnostic disable-next-line: param-type-mismatch
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == 'directory' then
              require('lazy').load({ plugins = { 'neo-tree.nvim' } })
            end
          end
        end,
      })
    end,
    branch = 'v3.x',
    keys = { { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Open neo-tree.nvim' } },
    opts = {
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            -- auto close
            require('neo-tree.command').execute({ action = 'close' })
          end,
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = { '.git' },
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = '',
          expander_expanded = '',
        },
      },
      window = {
        mappings = {
          ['<space>'] = 'none',
          ['h'] = {
            function(state)
              local node = state.tree:get_node()
              if node.type == 'directory' and node:is_expanded() then
                require('neo-tree.sources.filesystem').toggle_directory(state, node)
              else
                require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
              end
            end,
            desc = 'Open directory',
          },
          ['l'] = {
            function(state)
              local node = state.tree:get_node()
              if node.type == 'directory' then
                if not node:is_expanded() then
                  require('neo-tree.sources.filesystem').toggle_directory(state, node)
                elseif node:has_children() then
                  require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
                end
              end
            end,
            desc = 'Close directory',
          },
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c')
            end,
            desc = 'Copy path to clipboard',
          },
          ['P'] = { 'toggle_preview', config = { use_float = false } },
        },
      },
    },
  },

  -- leap.nvim
  {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat', keys = { '.' } },
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
      { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
      { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
    },
    config = function(_, opts)
      local leap = require('leap')
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
    end,
  },

  -- flit.nvim
  {
    'ggandor/flit.nvim',
    dependencies = 'ggandor/leap.nvim',
    opts = { labeled_modes = 'nx' },
    keys = function()
      local ret = {}
      for _, key in ipairs({ 'f', 'F', 't', 'T' }) do
        ret[#ret + 1] = { key, mode = { 'n', 'x', 'o' }, desc = key }
      end
      return ret
    end,
  },

  -- neogit
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    cmd = 'Neogit',
    keys = {
      {
        '<leader>gg',
        function()
          return require('neogit').open()
        end,
        desc = 'Open neogit',
      },
    },
    opts = {
      kind = 'replace',
      status = { recent_commit_count = 25 },
      integrations = { telescope = true },
      auto_show_console = false,
      telescope_sorter = function()
        return require('telescope').extensions.fzf.native_fzf_sorter()
      end,
    },
  },

  -- gitsigns.nvim
  {
    'lewis6991/gitsigns.nvim',
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd('BufRead', {
        group = vim.api.nvim_create_augroup('GitSignsLazyLoad', { clear = true }),
        callback = function()
          vim.fn.system('git -C ' .. '"' .. vim.fn.expand('%:p:h') .. '"' .. ' rev-parse')
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name('GitSignsLazyLoad')
            vim.schedule(function()
              require('lazy').load({ plugins = { 'gitsigns.nvim' } })
            end)
          end
        end,
      })
    end,
    ft = 'gitcommit',
    keys = {
      {
        '<leader>gB',
        function()
          return require('gitsigns').blame_line()
        end,
        desc = 'Open git blame',
      },
      {
        '<leader>gp',
        function()
          return require('gitsigns').preview_hunk_inline()
        end,
        desc = 'Preview the hunk',
      },
      {
        '<leader>gr',
        function()
          return require('gitsigns').reset_hunk()
        end,
        mode = { 'n', 'v' },
        desc = 'Reset the hunk',
      },
      {
        '<leader>gR',
        function()
          return require('gitsigns').reset_buffer()
        end,
        desc = 'Reset the buffer',
      },
      {
        '<leader>gs',
        function()
          return require('gitsigns').stage_hunk()
        end,
        mode = { 'n', 'v' },
        desc = 'Stage the hunk',
      },
      {
        '<leader>gS',
        function()
          return require('gitsigns').stage_buffer()
        end,
        desc = 'Stage the buffer',
      },
      {
        '<leader>gu',
        function()
          return require('gitsigns').undo_stage_hunk()
        end,
        desc = 'Unstage the hunk',
      },
      {
        '<leader>gd',
        function()
          return require('gitsigns').diffthis()
        end,
        desc = 'Open a diff',
      },
      {
        '<leader>gq',
        function()
          return require('gitsigns').setqflist()
        end,
        desc = 'Open quickfix list with hunks',
      },
      {
        '<leader>gl',
        function()
          return require('gitsigns').setloclist()
        end,
        desc = 'Open location list with hunks',
      },
      {
        '<leader>gL',
        function()
          return require('gitsigns').toggle_current_line_blame()
        end,
        desc = 'Toggle line blame',
      },
      {
        ']g',
        function()
          return require('gitsigns').next_hunk()
        end,
        desc = 'Next hunk',
      },
      {
        '[g',
        function()
          return require('gitsigns').prev_hunk()
        end,
        desc = 'Previous hunk',
      },
    },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '-' },
        topdelete = { text = '-' },
        changedelete = { text = '~' },
      },
      attach_to_untracked = true,
      numhl = true,
      -- word_diff = true,
    },
  },

  -- toggleterm.nvim
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', desc = 'Open a vertial terminal' },
      { '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', desc = 'Open a horizontal terminal' },
      { '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', desc = 'Open a floating terminal' },
    },
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
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
      direction = 'float',
      close_on_exit = true,
      float_opts = { border = 'curved' },
    },
  },

  -- mini.bufremove
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>bk',
        function()
          local bd = require('mini.bufremove').delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\nCancel')
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>bK',
        function()
          require('mini.bufremove').delete(0, true)
        end,
        desc = 'Delete buffer forcefully',
      },
    },
  },

  -- highlight-undo.nvim
  { 'tzachar/highlight-undo.nvim', keys = { 'u', '<C-r>' }, config = true },

  -- undotree
  {
    'mbbill/undotree',
    keys = { { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Open undotree' } },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
    end,
  },

  -- better-escape.nvim
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
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
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
    },
    branch = '0.1.x',
    cmd = 'Telescope',
    keys = {
      {
        '<leader>ff',
        function()
          return require('telescope.builtin').find_files()
        end,
        desc = 'Files',
      },
      {
        '<leader>fw',
        function()
          return require('telescope.builtin').live_grep()
        end,
        desc = 'Words',
      },
      {
        '<leader>fb',
        function()
          return require('telescope.builtin').buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>fh',
        function()
          return require('telescope.builtin').help_tags()
        end,
        desc = 'Help',
      },
      {
        '<leader>fm',
        function()
          return require('telescope.builtin').man_pages()
        end,
        desc = 'Man pages',
      },
      {
        '<leader>fr',
        function()
          return require('telescope.builtin').oldfiles()
        end,
        desc = 'Recently opened',
      },
      {
        '<leader>fR',
        function()
          return require('telescope.builtin').registers()
        end,
        desc = 'Registers',
      },
      {
        '<leader>fk',
        function()
          return require('telescope.builtin').keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>fc',
        function()
          return require('telescope.builtin').commands()
        end,
        desc = 'Commands',
      },
      {
        '<leader>fC',
        function()
          return require('telescope.builtin').command_history()
        end,
        desc = 'Command history',
      },
      {
        '<leader>fl',
        function()
          return require('telescope.builtin').resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>fd',
        function()
          return require('telescope.builtin').diagnostics({ bufnr = 0 })
        end,
        desc = 'Document diagnostics',
      },
      {
        '<leader>fD',
        function()
          return require('telescope.builtin').diagnostics()
        end,
        desc = 'Workspace diagnostics',
      },
      {
        '<leader>fs',
        function()
          return require('telescope.builtin').lsp_document_symbols()
        end,
        desc = 'Document symbols',
      },
      {
        '<leader>fg',
        function()
          return require('telescope.builtin').git_files()
        end,
        desc = 'Git files',
      },
      {
        '<leader>fo',
        function()
          return require('telescope.builtin').vim_options()
        end,
        desc = 'Options',
      },
      { '<leader>ft', '<cmd>TodoTelescope<CR>', desc = 'Todo' },
      { '<leader>fT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>', desc = 'Todo/Fix/Fixme' },
      {
        '<leader>gc',
        function()
          return require('telescope.builtin').git_status()
        end,
        desc = 'Search through changed files',
      },
      {
        '<leader>gb',
        function()
          return require('telescope.builtin').git_branches()
        end,
        desc = 'Search through git branches',
      },
      {
        '<leader>gC',
        function()
          return require('telescope.builtin').git_commits()
        end,
        desc = 'Search and checkout git commits',
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
      local telescopeConfig = require('telescope.config')
      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      local actions = require('telescope.actions')
      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, '--hidden')
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, '--glob')
      table.insert(vimgrep_arguments, '!**/.git/*')

      return {
        defaults = {
          prompt_prefix = ' ',
          selection_caret = ' ',
          mappings = { n = { ['q'] = actions.close } },
          vimgrep_arguments = vimgrep_arguments,
          theme = 'tokyonight',
          path_display = { 'smart' },
          file_ignore_patterns = { '.git/' },
          layout_strategy = 'horizontal',
          layout_config = { prompt_position = 'top' },
          sorting_strategy = 'ascending',
        },
        pickers = { find_files = { find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' } } },
      }
    end,
  },

  -- mini.move
  {
    'echasnovski/mini.move',
    config = true,
    keys = {
      { '<A-h>', mode = { 'n', 'v' }, desc = 'Block left' },
      { '<A-j>', mode = { 'n', 'v' }, desc = 'Block down' },
      { '<A-k>', mode = { 'n', 'v' }, desc = 'Block up' },
      { '<A-l>', mode = { 'n', 'v' }, desc = 'Block right' },
    },
  },

  -- persistence.nvim
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    config = true,
    keys = {
      {
        '<leader>qs',
        function()
          return require('persistence').load()
        end,
        desc = 'Restore the session for the current dir',
      },
      {
        '<leader>ql',
        function()
          return require('persistence').load({ last = true })
        end,
        desc = 'Restore the last session',
      },
      {
        '<leader>qd',
        function()
          return require('persistence').stop()
        end,
        desc = 'Stop persistence',
      },
    },
  },

  -- mini.surround
  {
    'echasnovski/mini.surround',
    keys = {
      { 'gza', mode = { 'n', 'v' }, desc = 'Add surrounding' },
      { 'gzd', desc = 'Delete surrounding' },
      { 'gzf', desc = 'Find right surrounding' },
      { 'gzF', desc = 'Find left surrounding' },
      { 'gzh', desc = 'Highlight surrounding' },
      { 'gzr', desc = 'Replace surrounding' },
      { 'gzn', desc = 'Updated n_lines' },
    },
    opts = {
      mappings = {
        add = 'gza',
        delete = 'gzd',
        find = 'gzf',
        find_left = 'gzF',
        highlight = 'gzh',
        replace = 'gzr',
        update_n_lines = 'gzn',
      },
    },
  },

  -- precognition.nvim
  {
    'tris203/precognition.nvim',
    keys = {
      {
        '<leader>pP',
        function()
          return require('precognition').toggle()
        end,
        desc = 'Toggle precognition.nvim',
      },
      {
        '<leader>pp',
        function()
          return require('precognition').peek()
        end,
        desc = 'Peek precognition.nvim',
      },
    },
    opts = { startVisible = false },
  },

  -- vim-kitty
  { 'fladson/vim-kitty', ft = 'kitty' },

  -- zathurarc.vim
  { 'Freed-Wu/zathurarc.vim', ft = 'zathurarc' },
}
