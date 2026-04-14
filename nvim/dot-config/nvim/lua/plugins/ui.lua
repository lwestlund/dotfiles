return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = {
        globalstatus = false,
      }
      opts.theme = "doom-one"
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(s)
            return string.sub(s, 1, 1)
          end,
        },
      }
      opts.sections.lualine_z = {}

      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols_plus",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      opts.winbar = { lualine_c = { symbols.get, cond = symbols.has() } }
    end,
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        -- Use non-greedy matching up to the first keyword of the line, and an optional match of a
        -- parenthesis after the keyword, with a non-greedy matching of the closing parenthesis.
        -- Inspired from https://github.com/folke/todo-comments.nvim/pull/255.
        pattern = [[.{-}<((KEYWORDS)%(\(.{-1,}\))?):]],
      },
      search = {
        pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
      },
    },
  },
}
