return {
  -- Comment.nvim
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Toggle comments" },
      { "gb", mode = { "n", "v" }, desc = "Toggle block comments" },
    },
    config = true,
  },

  -- dial.nvim
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<C-a>",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
        desc = "Increment",
      },
      {
        "<C-x>",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
        desc = "Decrement",
      },
      {
        "g<C-a>",
        function()
          return require("dial.map").inc_gnormal()
        end,
        expr = true,
        desc = "Multiline increment",
      },
      {
        "g<C-x>",
        function()
          return require("dial.map").dec_gnormal()
        end,
        expr = true,
        desc = "Multiline decrement",
      },
      {
        "<C-a>",
        function()
          return require("dial.map").inc_visual()
        end,
        mode = "v",
        expr = true,
        desc = "Increment",
      },
      {
        "<C-x>",
        function()
          return require("dial.map").dec_visual()
        end,
        mode = "v",
        expr = true,
        desc = "Decrement",
      },
      {
        "g<C-a>",
        function()
          return require("dial.map").inc_gvisual()
        end,
        mode = "v",
        expr = true,
        desc = "Multiline increment",
      },
      {
        "g<C-x>",
        function()
          return require("dial.map").dec_gvisual()
        end,
        mode = "v",
        expr = true,
        desc = "Multiline decrement",
      },
    },
    opts = function()
      local augend = require("dial.augend")

      local ordinal_numbers = augend.constant.new({
        elements = {
          "first",
          "second",
          "third",
          "fourth",
          "fifth",
          "sixth",
          "seventh",
          "eighth",
          "ninth",
          "tenth",
        },
        word = false,
        cyclic = true,
      })

      local weekdays = augend.constant.new({
        elements = {
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday",
        },
        word = true,
        cyclic = true,
      })

      local months = augend.constant.new({
        elements = {
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        },
        word = true,
        cyclic = true,
      })

      local captialized_boolean = augend.constant.new({
        elements = {
          "True",
          "False",
        },
        word = true,
        cyclic = true,
      })

      return {
        default = {
          augend.integer.alias.decimal_int,
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.integer.alias.hex,
          augend.date.alias["%m/%d/%Y"],
          augend.constant.alias.bool,
          augend.misc.alias.markdown_header,
          ordinal_numbers,
          weekdays,
          months,
          captialized_boolean,
          augend.constant.new({
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "and", "or" },
            word = true,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "let", "const" },
            cyclic = true,
            word = true,
          }),
          augend.constant.new({
            elements = { "yes", "no" },
            word = true,
            cyclic = true,
          }),
          augend.hexcolor.new({
            case = "lower",
          }),
          augend.hexcolor.new({
            case = "upper",
          }),
        },
      }
    end,
    config = function(_, opts)
      require("dial.config").augends:register_group(opts)
    end,
  },

  -- blink.cmp
  {
    "Saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<C-b>"] = { "scroll_documentation_up" },
        ["<C-f>"] = { "scroll_documentation_down" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          "snippet_backward",
          "fallback",
        },
        ["<C-Space>"] = {
          "show",
          "show_documentation",
          "hide_documentation",
        },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      trigger = {
        signature_help = { enabled = true },
      },
      windows = {
        autocomplete = {
          selection = "auto_insert",
          draw = "reversed",
        },
        documentation = {
          auto_show = true,
        },
      },
      sources = {
        completion = {
          enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
        },
        providers = {
          lsp = { fallback_for = { "lazydev" } },
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        },
      },
    },
  },
}
