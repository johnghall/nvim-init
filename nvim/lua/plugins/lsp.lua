return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v1.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
		{ "williamboman/mason.nvim" }, -- Optional
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional
		{ "glepnir/lspsaga.nvim", branch = "main" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "hrsh7th/cmp-buffer" }, -- Optional
		{ "hrsh7th/cmp-path" }, -- Optional
		{ "saadparwaiz1/cmp_luasnip" }, -- Optional
		{ "hrsh7th/cmp-nvim-lua" }, -- Optional
		{ "onsails/lspkind.nvim" },
		{ "simrat39/rust-tools.nvim" },

		-- Snippets
		{ "L3MON4D3/LuaSnip" }, -- Required
		{ "rafamadriz/friendly-snippets" }, -- Optional

		-- Formatting
		{ "jose-elias-alvarez/null-ls.nvim" },
		{ "jose-elias-alvarez/typescript.nvim" },
		{ "jayp0521/mason-null-ls.nvim" },
		{ "MunifTanjim/prettier.nvim" },

		-- Debugging
		{ "mfussenegger/nvim-dap" },
	},
}
