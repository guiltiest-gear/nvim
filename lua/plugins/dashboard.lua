return {
    'glepnir/dashboard-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    event = 'VimEnter',
    config = function()
        require('dashboard').setup({
            theme = 'doom',
            config = {
                header = {
                    '                                   ',
                    '                                   ',
                    '                                   ',
                    '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ',
                    '    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
                    '          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
                    '           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
                    '          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
                    '   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
                    '  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
                    ' ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
                    ' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
                    '      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
                    '       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
                    '                                   ',
                },
                center = {
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Find file',
                        desc_hl = 'String',
                        key = 'f',
                        key_hl = 'Number',
                        action = ':Telescope find_files'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'New file',
                        desc_hl = 'String',
                        key = 'e',
                        key_hl = 'Number',
                        action = ':ene | startinsert'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Recently used files',
                        desc_hl = 'String',
                        key = 'r',
                        key_hl = 'Number',
                        action = ':Telescope oldfiles'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Find text',
                        desc_hl = 'String',
                        key = 't',
                        key_hl = 'Number',
                        action = ':Telescope live_grep'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Configuration',
                        desc_hl = 'String',
                        key = 'c',
                        key_hl = 'Number',
                        action = ':cd ~/.config/nvim | e ~/.config/nvim/init.lua'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Update plugins',
                        desc_hl = 'String',
                        key = 'u',
                        key_hl = 'Number',
                        action = ':Lazy update'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Mason',
                        desc_hl = 'String',
                        key = 'm',
                        key_hl = 'Number',
                        action = ':Mason'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'NeoGit',
                        desc_hl = 'String',
                        key = 'g',
                        key_hl = 'Number',
                        action = ':Neogit'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Quit Neovim',
                        desc_hl = 'String',
                        key = 'q',
                        key_hl = 'Number',
                        action = ':qa'
                    }
                },
                footer = {}
            }
        })
    end
}
