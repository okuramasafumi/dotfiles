local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Install lazy.nvim
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	"nvim-lua/plenary.nvim", -- Utility
	"MunifTanjim/nui.nvim", -- UI
  'b0o/schemastore.nvim', -- JSON schema access
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- TreeSitter section
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding xor succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            include_surrounding_whitespace = true,
          },
        },
        textsubjects = {
          enable = true,
          prev_selection = ',', -- (Optional) keymap to select the previous selection
          keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
          },
        },
        ensure_installed = { "ruby", "javascript", "typescript", "tsx", "vue", "html", "css", "scss", "lua", "c", "rust", "vim", "regex", "markdown", "markdown_inline", "json", "yaml" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        ignore_install = {}, -- List of parsers to ignore installing
        highlight = {
          enable = true,              -- false will disable the whole extension
          disable = { "c", "rust" },  -- list of language that will be disabled
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = { "ruby", "vim" },
        },
        refactor = {
          highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
          },
          highlight_current_scope = { enable = true },
        },
        endwise = {
          enable = true,
        },
        matchup = {
          enable = true,              -- mandatory, false will disable the whole extension
        },
        autotag = {
          enable = true,
        }
      }
    end,
    dependencies = {
      "andymass/vim-matchup", -- matchit replacement
      'nvim-treesitter/nvim-treesitter-textobjects', -- Syntax aware text objects
      'nvim-treesitter/nvim-treesitter-context', -- Code context
      'nvim-treesitter/nvim-treesitter-refactor', -- Refactoring support
      'RRethy/nvim-treesitter-endwise', -- Complete end
      'windwp/nvim-ts-autotag', -- Auto close tags
      'HiPhish/rainbow-delimiters.nvim' -- Rainbow delimiters
    }
  },
  -- LSP section
  "neovim/nvim-lspconfig",
  'lukas-reineke/lsp-format.nvim', -- Async formatting
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    keys = {
      { "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Jump to next diagnostic with Lspsaga" }
    },
    dependenices = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    }
  },
  -- Editing support
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.diagnostics.rubocop.with{
            prefer_local = "bin"
          },
          null_ls.builtins.formatting.rubocop.with{
            prefer_local = "bin"
          },
          null_ls.builtins.diagnostics.tsc,
        },
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- LSP completaion
      'hrsh7th/cmp-buffer', -- Buffer completion
      'hrsh7th/cmp-path', -- Path completion
      'hrsh7th/cmp-cmdline', -- Command line completion
      'hrsh7th/cmp-nvim-lsp-signature-help', --  Function signatures
      'petertriho/cmp-git', -- Git completion
      "L3MON4D3/LuaSnip", -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- Snippets completion
      'ray-x/cmp-treesitter', -- TreeSitter completion
      'quangnguyen30192/cmp-nvim-tags', -- ctags completion
      'onsails/lspkind-nvim', -- Show pictograms
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For ultisnips users.
        }, {
          { name = 'treesitter' },
        }, {
          {
            name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          },
          { name = 'tags' }
        })
      })
      cmp.setup.filetype('ruby', {
        sources = cmp.config.sources({
          {
            name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          },
          { name = 'nvim_lsp' },
          { name = 'ultisnips' },
        }, {
          { name = 'treesitter' },
        }, {
          { name = 'tags' }
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
          { name = 'cmdline_history' },
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' },
          { name = 'cmdline_history' },
        })
      })

      local lspkind = require('lspkind')
      cmp.setup {
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
              return vim_item
            end
          })
        }
      }
    end
  },
  {
    "L3MON4D3/LuaSnip",
    version = "1.*",
    event = "InsertEnter",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require('luasnip').filetype_extend("ruby", {"rails"})
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  -- Telescope
  {
    'nvim-telescope/telescope-fzf-native.nvim', -- Faster sort
    build = 'make'
  },
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'LukasPietzschmann/telescope-tabs',
      "debugloop/telescope-undo.nvim"
    },
    config = function()
      require('telescope').setup{
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          undo = {
            -- Configurations here
          }
        },
        pickers = {
          find_files = {
            hidden = true
          }
        },
      }
      require("telescope").load_extension("undo")
      local builtin = require('telescope.builtin')
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          f = {
            name = "+file",
            f = { builtin.find_files, "Find File" },
            o = { builtin.oldfiles, "Find File from history" },
          },
          r = { builtin.grep_string, "Grep string" },
          l = { builtin.live_grep, "Live grep" },
          g = {
            name = "git",
            c = { builtin.git_commits, "Git commits" },
            b = { builtin.git_branches, "Git branches" },
            s = { builtin.git_status, "Git status" },
          },
          tb = { builtin.builtin, "List builtin commands" },
          u = { "<cmd>Telescope undo<cr>", "List undos"}
        },
      })
      require('telescope').load_extension('fzf')
    end
  },
  -- UI section
  {
    'stevearc/dressing.nvim', -- UI enhancement
    opts = {},
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {
    "utilyre/barbecue.nvim", -- VSCode like winbar
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    }
  },
  {
    'nvim-lualine/lualine.nvim', -- statusline
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional dependency
    }
  },
  {
    "luukvbaal/statuscol.nvim", -- statuscolumn
    config = function()
      require("statuscol").setup({})
    end,
  },
  {
    'romgrk/barbar.nvim', -- tabline
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    "nvim-zh/colorful-winsep.nvim", -- Colorful window separator
    config = true,
    event = { "WinNew" },
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dapui").setup()
    end,
    ft = { "ruby", "javascript", "typescript" },
    dependencies = {
      "suketa/nvim-dap-ruby",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  -- Testing
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
      'zidhuss/neotest-minitest',
    },
    config = function()
      local neotest = require('neotest').setup({
        adapters = {
          require("neotest-rspec"),
          require('neotest-minitest'),
        }
      })
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          t = { neotest.run.run(), "Run nearest test" },
          T = { neotest.run.run(vim.fn.expand("%")), "Run file test" },
        }
      })
    end
  },
  -- Ruby
  {
    "okuramasafumi/rspec-current.vim",
    ft = "ruby"
  },
  "pocke/rbs.vim", -- Including filetype detector
  "slim-template/vim-slim", -- Slim template
  -- JavaScript/TypeScript
  -- Git
  {
    'NeogitOrg/neogit', -- Git interface
    dependencies = {
      'nvim-lua/plenary.nvim',
      "sindrets/diffview.nvim"
    },
    opts = {
      integration = {
        diffview = true
      }
    }
  },
  "lewis6991/gitsigns.nvim", -- Sign with Git status
  {
    'akinsho/git-conflict.nvim', -- Fancy conflict viewer
    version = "*",
    config = true
  },
  {
    'ruifm/gitlinker.nvim', -- Permalink to GitHub and others
    dependencies = 'nvim-lua/plenary.nvim',
  },
  -- Misc section
  {
    "folke/which-key.nvim", -- Key bindings
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    'mrjones2014/smart-splits.nvim',
    version = '>=1.0.0',
    config = function()
      local ss = require("smart-splits")
      local wk = require("which-key")
      wk.register({
        ["<C-h>"] = { ss.move_cursor_left, "Move cursor left" },
        ["<C-j>"] = { ss.move_cursor_down, "Move cursor down" },
        ["<C-k>"] = { ss.move_cursor_up, "Move cursor up" },
        ["<C-l>"] = { ss.move_cursor_right, "Move cursor right" },
      })
    end
  },
  "github/copilot.vim", -- Copilot
  "wsdjeg/vim-fetch", -- Line number and column number
  "gpanders/editorconfig.nvim", -- Editorconfig
  'jghauser/mkdir.nvim', -- Create directory when it's missing
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  },
  {
    "ethanholz/nvim-lastplace", -- Restore last cursor position
    config = function()
      require("nvim-lastplace").setup{}
    end
  },
  "direnv/direnv.vim" -- direnv integration
})

-- Misc
vim.opt.termguicolors = true -- True color
vim.opt.relativenumber = true -- Setting relativenumber is slow but Apple Sillicon make it work!
vim.opt.number = true -- Current line has 0 relative number so showing absolute number
vim.opt.foldenable = true
vim.opt.foldmethod = "syntax" -- Fold with syntax
vim.opt.expandtab = true -- Insert whitespaces with tabb key
vim.opt.tabstop = 2 -- Tab is 2 whitespaces
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.spelllang = "en,cjk" -- Spellcheck language
vim.opt.undofile = true -- Persistent undo

-- Key mappings
local wk = require("which-key")
wk.register({
  ["]<space>"] = {":<C-u>call append(expand('.'), '')<Cr>j", "Add one empty line to below"},
  ["<leader>g"] = { -- Git related
    name = "+git",
    a = {":<C-u>!git add %<Cr>", "Add current file"},
    c = {":<C-u>Neogit commit<Cr>", "Git commit"},
    g = {":Neogit<Cr>", "Open Neogit"},
  }
})

local diagnostic_hover_augroup_name = "lspconfig-diagnostic"
local function on_cursor_hold()
  if vim.lsp.buf.server_ready() then
    vim.diagnostic.open_float()
  end
end
vim.api.nvim_set_option('updatetime', 500)
vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })

-- LSP
-- Setup lspconfig.
local lspconfig = require'lspconfig'

lspconfig.tsserver.setup {}

lspconfig.yamlls.setup {
  settings = {
    yaml = {
      schemas = require('schemastore').json.schemas(),
      -- schemas = {
        -- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      -- },
    },
  }
}

local jsonls_capabilities = vim.lsp.protocol.make_client_capabilities()
jsonls_capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.jsonls.setup {
  capabilities = jsonls_capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
}

lspconfig.typeprof.setup {
  cmd = { 'bundle', 'exec', 'typeprof', '--lsp', '--stdio' },
}

lspconfig.steep.setup {
  cmd = { 'bundle', 'exec', 'steep', 'langserver' },
}

lspconfig.ruby_ls.setup {}
