local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    -- List of parser names
    ensure_installed = "all",

    -- List of parsers to ingnore installing
    ignore_install = {""},

    -- Autoinstall missing parsers when enering buffer
    auto_install = true
}
