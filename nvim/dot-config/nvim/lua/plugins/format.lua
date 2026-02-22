return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt", "dioxus" },
      },
      formatters = {
        sqlfluff = {
          args = { "format", "-" },
        },
      },
    },
  },
}
