return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt", "dioxus" },
        ["_"] = { "trim_whitespace" },
      },
      formatters = {
        sqlfluff = {
          args = { "format", "-" },
        },
      },
    },
  },
}
