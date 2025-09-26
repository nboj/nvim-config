return {
  "nvimtools/none-ls.nvim",
  config = function()
    local nls = require("null-ls") -- module name is still "null-ls" for backwards compat
    nls.setup({
      sources = {
        nls.builtins.formatting.alejandra,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.black,
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.shfmt,
      },
    })
  end,
}
