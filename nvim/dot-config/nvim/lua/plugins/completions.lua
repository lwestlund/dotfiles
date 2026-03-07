return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      cmdline = {
        keymap = { preset = "inherit" },
      },
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        menu = {
          draw = {
            align_to = "label",
            columns = {
              { "kind_icon" },
              { "label", "detail", gap = 2 },
            },
            components = {
              detail = {
                -- A component that displays details of an item, for example
                -- a vairable will be detailed with its type, or a function
                -- by its signature.
                text = function(item)
                  return item.item.detail or ""
                end,
                -- highlight = "Comment",
              },
            },
          },
        },
      },
    },
  },
}
