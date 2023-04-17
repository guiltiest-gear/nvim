return {
    'folke/which-key.nvim',
    keys = {
        "<leader>",
        '"',
        "'",
        "`",
    },
    config = function()
        local wk = require('which-key')
        local setup = {
            ignore_missing = true,
            hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
        }

        local mappings = {
            ['d'] = 'Open dashboard',
            ['e'] = 'Explorer',
            ['t'] = 'Toggle twilight',
            ['l'] = 'Toggle lsp_lines',
            ['q'] = 'Quit the current file',
            ['Q'] = 'Quit neovim',
            ['w'] = 'Save the current file',
            ['m'] = 'Toggle the node under cursor (split if one line, join if multiline)',
            ['s'] = 'Split node under the cursor',
            ['j'] = 'Join node under the cursor',
            f = {
                name = 'Find',
                f = 'Find files',
                w = 'Find text',
                b = 'Find buffers',
                h = 'Find help pages',
                m = 'Find man pages',
                r = 'Find recent files',
                R = 'Find registers',
                k = 'Find keymaps',
                c = 'Find commands',
            },
            i = {
                name = 'Illuminate',
                t = 'Toggle vim-illuminate globally',
                b = 'Toggle vim-illuminate per buffer',
            },
            b = {
                name = 'Buffer',
                k = 'Kill the current buffer',
                K = 'Kill the current buffer forcefully',
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
                d = 'Toggle document_diagnostics',
                q = 'Open up quickfix',
                l = 'Open up location list',
                r = 'Open up lsp references',
            },
            L = {
                name = 'Lazy.nvim',
                l = 'Open lazy.nvim',
                u = 'Update plugins',
                s = 'Sync plugins',
                L = 'Open the log',
                c = 'Clean plugins',
                p = 'Profiler'
            },
            r = {
                name = 'Search and replace',
                s = 'Within a single buffer selection',
                o = 'Within a single open buffer',
                w = 'Within a single word',
                W = 'Within an entire line',
                e = 'Within a C expression',
                f = 'Within a C file path',
                b = {
                    name = 'Multiple buffers',
                    s = 'Within multiple buffer selections',
                    o = 'Within multiple open buffers',
                    w = 'Within multiple words',
                    W = 'Within multiple lines',
                    e = 'Within multiple c expressions',
                    f = 'Within multiple file paths'
                }
            }
        }

        local opts = {
            mode = 'n',
            prefix = '<leader>',
            buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
        }

        wk.setup(setup)
        wk.register(mappings, opts)
    end,
}
