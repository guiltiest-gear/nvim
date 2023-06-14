return {
    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gc', mode = 'n', desc = 'Toggle comments (normal mode)' },
            { 'gc', mode = 'v', desc = 'Toggle comments (visual mode)' },
            { 'gb', mode = 'n', desc = 'Toggle block comments (normal mode)' },
            { 'gb', mode = 'v', desc = 'Toggle block comments (visual mode)' },
        },
        config = true,
    },

    -- nvim-autopairs
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {
            disable_filetype = {
                'TelescopePrompt',
                'text',
            },
        },
        config = function(_, opts)
            local npairs = require('nvim-autopairs')
            npairs.setup(opts)
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done {})
        end,
    },

    -- nvim-surround
    {
        'kylechui/nvim-surround',
        keys = {
            { 'cs', mode = 'n', desc = 'Change surroundings' },
            { 'ys', mode = 'n', desc = 'Add surroundings' },
            { 'ds', mode = 'n', desc = 'Delete surroundings' },
        },
        opts = {
            check_ts = true,
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
        },
        config = function()
            local augend = require('dial.augend')
            require('dial.config').augends:register_group {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                },
            }
        end,
    },

    -- treesj
    {
        'Wansmer/treesj',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        keys = {
            {
                '<leader>m',
                function()
                    return require('treesj').toggle()
                end,
                desc = 'Toggle node under cursor',
            },
            {
                '<leader>j',
                function()
                    return require('treesj').join()
                end,
                desc = 'Join node under cursor',
            },
            {
                '<leader>s',
                function()
                    return require('treesj').split()
                end,
                desc = 'Split node under cursor',
            },
        },
        opts = {
            max_join_length = 150,
        },
    },

    -- nvim-cmp
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'FelipeLema/cmp-async-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            {
                'L3MON4D3/LuaSnip',
                build = 'make install_jsregexp',
                version = 'v1.*',
            },
        },
        init = function()
            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
        end,
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            require('luasnip.loaders.from_vscode').lazy_load()

            local check_backspace = function()
                local col = vim.fn.col('.') - 1
                return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
            end

            local kind_icons = {
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

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
                    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                    ['<C-e>'] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end, {
                        'i',
                        's',
                    }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {
                        'i',
                        's',
                    }),
                },
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(entry, vim_item)
                        vim_item.kind = kind_icons[vim_item.kind]
                        vim_item.menu = ({
                            nvim_lsp = '',
                            nvim_lua = '',
                            luasnip = '',
                            buffer = '',
                            path = '',
                            emoji = '',
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'async_path' },
                    { name = 'calc' },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                -- NOTE: Keep sorting disabled for now, the behavior isn't super desirable
                --[[ sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            }, ]]
                experimental = {
                    ghost_text = true,
                },
                enabled = function()
                    -- Disable nvim-cmp in a telescope prompt
                    local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
                    if buftype == 'prompt' then
                        return false
                    end
                    -- Disable completion in comments
                    local context = require('cmp.config.context')
                    -- Keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return true
                    else
                        return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
                    end
                end,
            }

            -- cmp-cmdline setup
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' },
                        },
                    },
                }),
            })
        end,
    },
}
