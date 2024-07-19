-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  'AstroNvim/astrocommunity',
  -- { import = "astrocommunity.pack.lua" },
  { import = 'astrocommunity.diagnostics.lsp_lines-nvim'},
  { import = 'astrocommunity.pack.gleam'},
  { import = 'astrocommunity.file-explorer.oil-nvim'},
  { import = 'astrocommunity.keybinding.nvcheatsheet-nvim'},
  { import = 'astrocommunity.workflow.hardtime-nvim'},
  { import = 'astrocommunity.syntax.vim-sandwich'},
  -- import/override with your plugins folder
}
