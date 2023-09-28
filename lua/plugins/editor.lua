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

  -- trouble.nvim
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = true,
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle<CR>', desc = 'Toggle trouble.nvim' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Open workspace diagnostics' },
      { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Open document diagnostics' },
      { '<leader>xq', '<cmd>TroubleToggle quickfix<CR>', desc = 'Open quickfix' },
      { '<leader>xl', '<cmd>TroubleToggle loclist<CR>', desc = 'Open location list' },
      { '<leader>xr', '<cmd>TroubleToggle lsp_references<CR>', desc = 'Open lsp references' },
    },
  },

  -- vim-illuminate
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      providers = { 'lsp', 'treesitter', 'regex' },
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

  -- nvim-hlslens
  {
    'kevinhwang91/nvim-hlslens',
    config = true,
    keys = {
      { 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { '*', [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { '#', [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    },
  },

  -- neo-tree.nvim
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
    -- Load neo-tree.nvim if we provide a directory as an argument
    init = function()
      if vim.fn.argc() == 1 then
        ---@diagnostic disable-next-line: param-type-mismatch
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end
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
        filtered_items = { hide_dotfiles = false, hide_by_name = { '.git' } },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ['h'] = function(state)
            local node = state.tree:get_node()
            if node.type == 'directory' and node:is_expanded() then
              require('neo-tree.sources.filesystem').toggle_directory(state, node)
            else
              require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
            end
          end,
          ['l'] = function(state)
            local node = state.tree:get_node()
            if node.type == 'directory' then
              if not node:is_expanded() then
                require('neo-tree.sources.filesystem').toggle_directory(state, node)
              elseif node:has_children() then
                require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
              end
            end
          end,
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

  -- zen-mode.nvim
  {
    'folke/zen-mode.nvim',
    dependencies = {
      {
        'folke/twilight.nvim',
        keys = { { '<leader>t', '<cmd>Twilight<CR>', desc = 'Toggle twilight.nvim' } },
        config = true,
      },
    },
    opts = { plugins = { kitty = { enabled = true, font = '+4' } } },
    keys = {
      {
        '<leader>z',
        function()
          return require('zen-mode').toggle()
        end,
        desc = 'Toggle zen-mode.nvim',
      },
    },
  },

  -- neogit
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    keys = {
      {
        '<leader>gg',
        function()
          return require('neogit').open()
        end,
        desc = 'Open neogit',
      },
      {
        '<leader>gC',
        function()
          return require('neogit').open({ 'commit' })
        end,
        desc = 'Open neogit commit popup',
      },
    },
    opts = {
      disable_insert_on_commit = 'auto',
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
      vim.api.nvim_create_autocmd({ 'BufRead' }, {
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
        '<leader>gj',
        function()
          return require('gitsigns').next_hunk()
        end,
        desc = 'Next hunk',
      },
      {
        '<leader>gk',
        function()
          return require('gitsigns').prev_hunk()
        end,
        desc = 'Previous hunk',
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
      {
        '<leader>gl',
        function()
          return require('gitsigns').blame_line()
        end,
        desc = 'Open git blame',
      },
      {
        '<leader>gp',
        function()
          return require('gitsigns').preview_hunk()
        end,
        desc = 'Preview the hunk',
      },
      {
        '<leader>gr',
        function()
          return require('gitsigns').reset_hunk()
        end,
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
    },
    opts = {
      signs = {
        add = {
          hl = 'GitSignsAdd',
          text = '+',
          numhl = 'GitSignsAddNr',
          linehl = 'GitSignsAddLn',
        },
        change = {
          hl = 'GitSignsChange',
          text = '~',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
        delete = {
          hl = 'GitSignsDelete',
          text = '-',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        topdelete = {
          hl = 'GitSignsDelete',
          text = '-',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        changedelete = {
          hl = 'GitSignsChange',
          text = '~',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
      },
      signcolumn = true, -- Toggle with `:GitSigns toggle_signs`
      watch_gitdir = { interval = 1000, follow_files = true },
      attach_to_untracked = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
    },
  },

  -- toggleterm.nvim
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = [[<C-\>]],
    opts = {
      open_mapping = [[<C-\>]],
      size = 20,
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

  -- bufdelete.nvim
  {
    'famiu/bufdelete.nvim',
    keys = {
      {
        '<leader>bk',
        function()
          return require('bufdelete').bufdelete(0, false)
        end,
        desc = 'Delete the current buffer',
      },
      {
        '<leader>bK',
        function()
          return require('bufdelete').bufdelete(0, true)
        end,
        desc = 'Delete the current buffer forcefully',
      },
    },
  },

  -- BufOnly.nvim
  { 'numToStr/BufOnly.nvim', keys = { { '<leader>bo', '<cmd>BufOnly<CR>', desc = 'Delete all other buffers' } } },

  -- highlight-undo.nvim
  { 'tzachar/highlight-undo.nvim', keys = { 'u', '<C-r>' }, config = true },

  -- undotree
  { 'mbbill/undotree', keys = { { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Open undo tree' } } },

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

  -- better-escape.nvim
  {
    'max397574/better-escape.nvim',
    event = 'InsertCharPre',
    opts = {
      mapping = { 'jj', 'jk' },
      keys = function()
        return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
      end,
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
        '<leader>go',
        function()
          return require('telescope.builtin').git_status()
        end,
        desc = 'Seach through changed files',
      },
      {
        '<leader>gb',
        function()
          return require('telescope.builtin').git_branches()
        end,
        desc = 'Search through git branches',
      },
      {
        '<leader>gc',
        function()
          return require('telescope.builtin').git_commits()
        end,
        desc = 'Search and checkout git commits',
      },
      { '<leader>ft', '<cmd>TodoTelescope<CR>', desc = 'Todo comments' },
    },
    opts = function()
      -- File and text search in hidden files and directories
      local telescopeConfig = require('telescope.config')

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, '--hidden')
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, '--glob')
      table.insert(vimgrep_arguments, '!**/.git/*')

      return {
        defaults = {
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

  -- nvim-gomove
  {
    'booperlv/nvim-gomove',
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

  -- vim-kitty
  { 'fladson/vim-kitty', ft = 'kitty' },
}
