return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      -- "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
      -- "nvim-mini/mini.pick",           -- optional
      "folke/snacks.nvim", -- optional
      "https://github.com/isakbm/gitgraph.nvim",
    },
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
        desc = "Neogit status",
      },
    },
    opts = {
      graph_style = "kitty",
      remember_settings = false,
      kind = "replace",
      commit_editor = {
        kind = "auto",
      },
      mappings = {
        popup = {
          ["p"] = "PushPopup",
          ["P"] = false,
          ["F"] = "PullPopup",
        },
        status = {
          ["["] = "GoToPreviousHunkHeader",
          ["]"] = "GoToNextHunkHeader",
        },
        commit_editor = {
          ["gk"] = "PrevMessage",
          ["gj"] = "NextMessage",
        },
      },
    },
  },
}
