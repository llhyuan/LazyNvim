return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      columns = {
        "icon",
        "size",
        --"permissions",
        --"mtime",
      },
    },
    keys = {
      { "<leader>d", "actions.open_cwd", desc = "Open current directroy" },
    },

    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
