local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
    null_ls.builtins.formatting.gofmt,
    -- If using gofumpt ober gofmt, be sure to `go get` the latest version.
    --null_ls.builtins.formatting.gofumpt,

    null_ls.builtins.formatting.goimports,
    -- If using goimports_reviser instead of goimports, be sure to `go get` it.
    --null_ls.builtins.formatting.goimports_reviser,

    -- golines shortens long lines where possible.
    null_ls.builtins.formatting.golines,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}
return opts

