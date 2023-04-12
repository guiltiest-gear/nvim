return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        local npairs = require('nvim-autopairs')
        npairs.setup({
            check_ts = true,
            disable_filetype = { 'TelescopePrompt', 'text' },
        })

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp_status_ok, cmp = pcall(require, 'cmp')
        if not cmp_status_ok then
            return
        end
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({}))
    end,
}
