return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "codelldb",
        "flake8",
        "js-debug-adapter",
      },
    },
  },
}
