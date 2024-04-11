-- Johans Super Cool Neovim Config --
-- vim: ts=2 sts=2 sw=2 et
--
-- This is roughly based upon kickstart and then changed to be more
-- fitting to my preferences.

-- [[ Leader Mapping ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Plugin Manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyversion = "stable"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blobl:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=" .. lazyversion,
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require("lazy").setup({
	-- Theme
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},

	-- Statusbar
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				theme = "kanagawa",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
			},
			inactive_sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
			},
		},
	},

	-- Keymap Visualiser
	{ "folke/which-key.nvim", opts = {} },

	-- Git plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true,
		},
	},

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			"folke/neodev.nvim",
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},

	-- Autocomplete
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine and its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},

	-- Navigation
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("file_browser")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("harpoon")
		end,
	},

	-- Code manipulation and helpers
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{ "numToStr/Comment.nvim", opts = {} },
	"tpope/vim-surround",

	{
		"stevearc/conform.nvim",

		enabled = true,

		keys = {
			{
				-- Customize or remove this keymap to your liking
				"ff",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},

		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Use a sub-list to run only the first available formatter
					javascript = { { "prettier" } },
					typescript = { { "prettier" } },
					html = { { "prettier" } },
					handlebars = { { "prettier" } },
					ruby = { { "standardrb" } },
				},

				notify_on_error = true,

				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})

			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_fallback = true, range = range })
			end, { range = true })
		end,
	},
}, {})

-- Settings

-- Disable highlight on search
vim.o.hlsearch = false

-- Enable line numbers
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Enable a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Enable terminal color support
vim.o.termguicolors = true

-- [[ Keymaps ]]

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Configure Telescope
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

-- Enable telescope fzf native if installed
pcall(require("telescope").load_extension, "fzf")

-- [[ Find Keymap ]]
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find Existing Buffers" })
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind Files" })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fs", require("telescope.builtin").git_status, { desc = "[F]ind by Git [S]tatus" })
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<cr>", { desc = "[F]ind in [B]rowser" })
vim.keymap.set(
	"n",
	"<leader>fB",
	":Telescope file_browser path=%:p:h select_buffer=true<cr>",
	{ desc = "[F]ind in [B]rowser (relative)" }
)
vim.keymap.set("n", "<leader>fm", ":Telescope harpoon marks<cr>", { desc = "[F]ind [M]arks" })

-- [[ Harpoon Keymap ]]
vim.keymap.set("n", "<leader>ma", require("harpoon.mark").add_file, { desc = "[A]dd mark" })
vim.keymap.set("n", "<leader>mr", require("harpoon.mark").rm_file, { desc = "[R]emove mark" })
vim.keymap.set("n", "<leader>mc", require("harpoon.mark").clear_all, { desc = "[C]lear all marks" })
vim.keymap.set("n", "<leader>mn", require("harpoon.ui").nav_next, { desc = "[N]ext mark" })
vim.keymap.set("n", "<leader>mp", require("harpoon.ui").nav_prev, { desc = "[P]revious mark" })
vim.keymap.set("n", "<leader>ml", require("harpoon.ui").toggle_quick_menu, { desc = "[L]ist all marks" })

-- [[ Git Keymap ]]
vim.keymap.set("n", "<leader>gg", ":Neogit<cr>", { desc = "[G]it" })

-- [[ Configure Treesitter }]]
vim.defer_fn(function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"c",
			"cpp",
			"go",
			"lua",
			"python",
			"rust",
			"tsx",
			"javascript",
			"typescript",
			"vimdoc",
			"vim",
			"bash",
		},

		auto_install = false,
		sync_install = false,
		ignore_install = {},
		modules = {},
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_increment = "<c-s>",
				node_decrement = "<M-space>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
		},
	})
end, 0)

-- [[ Configure LSP ]]
local on_attach = function(_, bufnr) end

require("which-key").register({
	["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
	["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
	["<leader>m"] = { name = "[M]ark", _ = "which_key_ignore" },
})

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup()

local servers = {
	html = { filetypes = { "html", "twig", "hbs", "handlebars", "html.handlebars" } },

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
}

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- Configure nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = cmp.mapping.preset.insert({
		["C-Space"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
})
