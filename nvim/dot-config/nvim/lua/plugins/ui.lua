return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        globalstatus = false,
      },
      theme = "doom-one",
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(s)
              return string.sub(s, 1, 1)
            end,
          },
        },
        lualine_z = {},
      },
    },
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
