local function filter_pyright_diagnostics(err, result, ctx, config)
  if not result or not result.diagnostics then
    return vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
  end

  local function filter(diagnostic)
    if diagnostic.data and type(diagnostic.data.actions) == "table" then
      for _, action in pairs(diagnostic.data.actions) do
        if action.action == "pyright.unusedImport" then
          return nil
        end
      end
    end
    return diagnostic
  end

  local filtered_diagnostics = {}
  for _, diag in ipairs(result.diagnostics) do
    local filtered_diag = filter(diag)
    if filtered_diag ~= nil then
      table.insert(filtered_diagnostics, filtered_diag)
    end
  end

  -- Overwrite the original diagnostics with the filtered list and
  -- pass it back to the default diagnostic handler.
  result.diagnostics = filtered_diagnostics
  vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnusedClass = "none",
                -- reportUnusedFunction = true,
              },
            },
          },
        },
        handlers = {
          ["textDocument/publishDiagnostics"] = filter_pyright_diagnostics,
        },
      },
    },
  },
}
