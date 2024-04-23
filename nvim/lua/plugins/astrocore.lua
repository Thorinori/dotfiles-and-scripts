-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

-- Courtesy of https://github.com/Axlefublr/dotfiles/blob/main/astro/lua/plugins/astrocore.lua
local function copy_full_path()
	local full_path = vim.api.nvim_buf_get_name(0)
	local home = os.getenv('HOME')
	if not home then return end
	local friendly_path = string.gsub(full_path, home, '~')
	vim.fn.setreg('+', friendly_path)
	print('full path: ' .. friendly_path)
end

local function copy_file_name()
	local file_name = vim.fn.expand('%:t')
	vim.fn.setreg('+', file_name)
	print('name: ' .. file_name)
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        cursorline = false,
        smarttab = true,
        expandtab = true,
        shiftwidth = 4,
        tabstop = 4,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        -- L = {
        --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- H = {
        --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        ['<Leader>dq'] = { copy_full_path },
	      ['<Leader>dw'] = { copy_file_name },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
    autocmds = {
     --  everthing = {
     --    {
				 --  event = 'CursorMoved',
				 --  command = 'normal! zz',
			  -- },
     --  },
        center_cursorline = {
          {
            event = { "BufNewFile", "BufReadPost", "BufWritePost" },
            desc = "Keeps the cursorline at the center of the screen [1]",
            callback = function(args)
              -- add virtual lines at the top
              local win_height = vim.api.nvim_win_get_height(0) - 1 -- 1 is added by the breadcrumbs
              local win_offset = math.floor(win_height / 2)
              local extmark_ns = vim.api.nvim_create_namespace "always_center"

              local virt_lines = {}
              for _ = 1, win_offset do
                table.insert(virt_lines, { { "", "" } })
              end
              vim.api.nvim_buf_set_extmark(0, extmark_ns, 0, 0, {
                id = 1,
                virt_lines = virt_lines,
                virt_lines_above = true,
              })

              -- add autocmd to trigger on movement
              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
                desc = "Keeps the cursorline at the center of the screen [2]",
                callback = function(args_lcl)
                  local current_line = vim.api.nvim_win_get_cursor(0)[1]

                  -- if the event is CursorMoved or CursorMovedI (~BufEnter), only trigger if the cursorline has changed
                  if args_lcl.event ~= "BufEnter" and current_line == vim.b[args.buf].center_cursorline_last_line then
                    return
                  end
                  vim.b[args.buf].center_cursorline_last_line = current_line

                  local win_view = vim.fn.winsaveview()
                  win_view.topline = math.max(current_line - win_offset, 1)
                  win_view.topfill = math.max(win_offset - current_line + 1, 0)
                  vim.fn.winrestview(win_view)
                end,
                buffer = args.buf,
                group = vim.api.nvim_create_augroup("center_cursorline" .. args.buf, { clear = true }),
              })
            end,
          },
        },
    },
  },
}
