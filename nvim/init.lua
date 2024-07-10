-- PLUGIN MANAGER
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- Theme
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
	use 'rebelot/kanagawa.nvim'

	-- Mason
	use {
		'williamboman/mason.nvim',
		requires = {
			'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig',
		}
	}

	use {
		'SmiteshP/nvim-navic',
		requires = 'neovim/nvim-lspconfig',
	}

	use {
		'hrsh7th/nvim-cmp',
		requires = {
		  'hrsh7th/cmp-nvim-lsp',
		}
	}

	use {
		'hrsh7th/vim-vsnip',
	}

	use {
		"nvimtools/none-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		}
	}

	-- FZF
	use { 'ibhagwan/fzf-lua',
		-- optional for icon support
		requires = { 'kyazdani42/nvim-web-devicons' }
	}

	-- Move
	use 'unblevable/quick-scope'

	-- HTML
	use 'mattn/emmet-vim'

	-- Utility
	use 'simeji/winresizer'
	use 'bronson/vim-trailing-whitespace'
	use 'luochen1990/rainbow'

	-- Git
	use 'airblade/vim-gitgutter'
	use {
		'lewis6991/gitsigns.nvim',
		-- tag = 'release',
}

	-- File explorer
	use 'lambdalisue/fern.vim'

	-- Tab
	use 'nvim-tree/nvim-web-devicons'
	use {
		'romgrk/barbar.nvim',
	}

	-- Icon
	use 'lambdalisue/nerdfont.vim'
	use 'lambdalisue/fern-renderer-nerdfont.vim'

	-- EditorConfig
	use 'editorconfig/editorconfig-vim'

	-- Git
	use 'tpope/vim-fugitive'

	use 'github/copilot.vim'
end)

-- Mason
require('mason').setup {
	ui = {
		check_outdated_packages_on_open = false,
		border = 'single',
	},
}

-- Mason LSP Config
require('mason-lspconfig').setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			apabilities = require('cmp_nvim_lsp').default_capabilities(),
		}
	end,
}

local null_ls = require "null-ls"
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettier.with {
      prefer_local = "node_modules/.bin",
    },
  },
}

local cmp = require 'cmp'
local map = cmp.mapping
cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
  },
	mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<ESC>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
	sources = cmp.config.sources {
	  { name = 'nvim_lsp' },
	},
}

require('nvim-navic').setup {
  lsp = {
    auto_attach = true,
  },
  highlight = true,
}

-- Status Bar
require('lualine').setup()

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

-- Color Scheme
vim.cmd [[colorscheme kanagawa]]

-- ====================
-- Options
-- ====================
vim.opt.title = true

vim.opt.number = true

vim.opt.cursorline = true

vim.opt.wrap = true
vim.opt.whichwrap = 'b,s,h,l,<,>,~,[,]'

vim.opt.visualbell = true

vim.opt.list = true

vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.helplang = 'ja,en'
vim.opt.showtabline = 2

-- indent
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = false
vim.opt.smarttab = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- replacement
vim.opt.gdefault = true


-- input
vim.opt.wildmode = 'longest,full'
vim.opt.showcmd = true

vim.opt.display = 'lastline'

-- Buffer切替時に保存確認が表示されなくなる
vim.opt.hidden = true

-- format
vim.opt.fileformats = 'unix,mac,dos'

-- use mouse
vim.opt.mouse = 'a'

-- ====================
-- keymaps
-- ====================

vim.g.mapleader = " "

-- move
vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })
vim.keymap.set('n', '<down>', 'gj', { noremap = true })
vim.keymap.set('n', '<up>', 'gk', { noremap = true })

-- edit
vim.keymap.set('i', 'jj', '<ESC>', { silent = true })
vim.keymap.set('n', '<leader>w', ':<C-u>w<CR>', { noremap = true })
vim.keymap.set('n', '<leader>q', ':<C-u>bd<CR>', { noremap = true })
vim.keymap.set('n', 'Yy', '"*yy', { noremap = true })
vim.keymap.set('v', 'Yy', '"*yy', { noremap = true })
vim.keymap.set('n', 'Dd', '"*dd', { noremap = true })
vim.keymap.set('v', 'Dd', '"*dd', { noremap = true })

-- buffer
vim.keymap.set('n', '<C-l>', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '<C-h>', ':bprev<CR>', { silent = true })

-- window
vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true })

-- remove hilights
vim.keymap.set('n', '<ESC><ESC>', ':<C-u>set nohlsearch!<CR>', { silent = true })


-- TODO: Split files

-- Fern
vim.keymap.set('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>')

-- Status Bar
vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern#default_hidden'] = 1

-- ====================
-- LSP Settings
-- ====================
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }

		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'g.', '<cmd>lua vim.lsp.buf.code_action()<CR>')
		vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
		vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
		vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wl', function()
		--	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
-- vim.cmd [[
-- set updatetime=500
-- highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- augroup lsp_document_highlight
--   autocmd!
--   autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
--   autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
-- augroup END
-- ]]

-- ====================
-- FZF Settings
-- ====================
require'fzf-lua'.setup({
	winopts = {
		height		 = 0.85,			-- window height
		width			 = 0.80,			-- window width
		row				 = 0.35,			-- window row position (0=top, 1=bottom)
		col				 = 0.50,			-- window col position (0=left, 1=right)
		border		 = 'rounded', -- 'none', 'single', 'double', 'thicc' or 'rounded'
		fullscreen = false,			-- start fullscreen?
	},
})

vim.cmd [[
highlight FzfLuaNormal guibg=#383850
highlight FzfLuaBorder guibg=#383850
]]

vim.opt.winblend = 5
vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>p', "<cmd>lua require('fzf-lua').files()<CR>")
vim.keymap.set('n', '<leader>gs', "<cmd>lua require('fzf-lua').git_status()<CR>")
vim.keymap.set('n', '<leader>gb', "<cmd>lua require('fzf-lua').git_branches()<CR>")
vim.keymap.set('n', '<leader>r', "<cmd>lua require('fzf-lua').grep()<CR>")
vim.keymap.set('n', '<leader>b', "<cmd>lua require('fzf-lua').blines()<CR>")

-- vim.keymap.set('n', '<leader>r', "<cmd>lua require('fzf-lua').lsp_references()<CR>")
-- vim.keymap.set('n', '<leader>d', "<cmd>lua require('fzf-lua').lsp_definitions()<CR>")
-- vim.keymap.set('n', '<leader>D', "<cmd>lua require('fzf-lua').lsp_declarations()<CR>")
-- vim.keymap.set('n', '<leader>i', "<cmd>lua require('fzf-lua').lsp_implementations()<CR>")
-- vim.keymap.set('n', '<leader>s', "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>")
-- vim.keymap.set('n', '<leader>t', "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>")
-- vim.keymap.set('n', '<leader>l', "<cmd>lua require('fzf-lua').diagnostics_document()<CR>")
