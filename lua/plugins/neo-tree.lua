return {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    branch = 'v2.x',
    init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
    end,
    keys = {
        {
            '<leader>e',
            '<cmd>Neotree toggle<CR>',
            desc = 'Open neo-tree.nvim',
        },
    },
    opts = {
        default_component_configs = {
            icon = {
                folder_empty = '󰜌',
                folder_empty_open = '󰜌',
            },
            git_status = {
                symbols = {
                    renamed = '󰁕',
                    unstaged = '󰄱',
                },
            },
        },
        document_symbols = {
            kinds = {
                File = { icon = '󰈙', hl = 'Tag' },
                Namespace = { icon = '󰌗', hl = 'Include' },
                Package = { icon = '󰏖', hl = 'Label' },
                Class = { icon = '󰌗', hl = 'Include' },
                Property = { icon = '󰆧', hl = '@property' },
                Enum = { icon = '󰒻', hl = '@number' },
                Function = { icon = '󰊕', hl = 'Function' },
                String = { icon = '󰀬', hl = 'String' },
                Number = { icon = '󰎠', hl = 'Number' },
                Array = { icon = '󰅪', hl = 'Type' },
                Object = { icon = '󰅩', hl = 'Type' },
                Key = { icon = '󰌋', hl = '' },
                Struct = { icon = '󰌗', hl = 'Type' },
                Operator = { icon = '󰆕', hl = 'Operator' },
                TypeParameter = { icon = '󰊄', hl = 'Type' },
                StaticMethod = { icon = '󰠄 ', hl = 'Function' },
            },
        },
        source_selector = {
            winbar = true,
            statusline = true,
            sources = {
                { source = 'filesystem', display_name = ' 󰉓 Files ' },
                -- { source = 'git_status', display_name = ' 󰊢 Git ' },
            },
        },
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_by_name = {
                    '.git',
                },
            },
            follow_current_file = true,
        },
    },
}
