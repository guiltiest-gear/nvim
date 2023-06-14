return {
    'kylechui/nvim-surround',
    keys = {
        { 'cs', mode = 'n', desc = 'Change surroundings' },
        { 'ys', mode = 'n', desc = 'Add surroundings' },
        { 'ds', mode = 'n', desc = 'Delete surroundings' },
    },
    opts = {
        check_ts = true,
    },
}
