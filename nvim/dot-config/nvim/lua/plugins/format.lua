return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        gitcommit = { "commitmsgfmt" },
        rust = { "rustfmt", "dioxus" },
        proto = { "buf" },
        python = { "ruff_format", "ruff_organize_imports" },
        ["_"] = { "trim_whitespace" },
      },
      formatters = {
        sqlfluff = {
          args = { "format", "-" },
        },
      },
    },
  },
  {
    "mkjeldsen/commitmsgfmt",
    url = "https://gitlab.com/mkjeldsen/commitmsgfmt.git",
    tag = "v1.7.0",
    build = "cargo build --release",
    ft = "gitcommit",
    config = function()
      -- Locate where Lazy.nvim cloned the repository.
      local plugin_dir = require("lazy.core.config").plugins["commitmsgfmt"].dir
      local bin_path = plugin_dir .. "/target/release"
      -- Add the compiled binary into Neovim's internal PATH.
      vim.env.PATH = bin_path .. ":" .. vim.env.PATH
    end,
  },
}
