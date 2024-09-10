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
      vim.cmd([[colorscheme tokyonight-storm]])
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
        ensure_installed = { "ruby", "javascript", "typescript", "tsx", "vue", "html", "css", "scss", "lua", "c", "rust", "vim", "regex", "markdown", "markdown_inline", "json", "yaml", "vimdoc" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
        },
        context = {
          enable = false,
          max_lines = 5,
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
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope.nvim"},
    },
    event = "LspAttach",
    config = function()
      require('tiny-code-action').setup()
    end
  },
  -- {
  --   "zeioth/garbage-day.nvim", -- GC for LSP
  --   dependencies = "neovim/nvim-lspconfig",
  --   event = "VeryLazy",
  --   opts = {
  --     -- your options here
  --   }
  -- },
  -- Editing support
  {
    'mfussenegger/nvim-lint' -- Linter
  },
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        format_after_save = {
          timeout_ms = 500,
          lsp_format = "first"
        },
        formatters_by_ft = {
          ruby = function(bufnr)
            if vim.fn.filereadable(".standard.yml") == 1 then
              return { "standardrb" }
            elseif vim.fn.filereadable(".rubocop.yml") == 1 then
              return { "rubocop" }
            else
              return { }
            end
          end,
        }
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
    event = { "InsertEnter", "CmdlineEnter" },
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
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<C-k>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" })
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
  {
    'kevinhwang91/nvim-ufo', -- Folding
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      -- Copied from its README
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
      end
      require('ufo').setup{
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end,
        fold_virt_text_handler = handler,
        close_fold_kinds_for_ft = {
          default = { 'comment', 'imports' }
        }
      }
    end
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
      local telescope = require('telescope')
      telescope.setup{
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
            find_command = function()
              return {"rg", "--files", "--hidden", "--glob", "!.git"}
            end
          }
        },
      }
      telescope.load_extension("undo")
      telescope.load_extension('fzf')
    end
  },
  -- UI section
  {
    'stevearc/dressing.nvim', -- UI enhancement
    opts = {},
  },
  {
    "nvim-tree/nvim-tree.lua", -- Tree UI
    event = "VeryLazy",
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
    },
    opts = {
      theme = 'tokyonight',
    },
  },
  {
    'nvim-lualine/lualine.nvim', -- statusline
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional dependency
      "okuramasafumi/rspec-current.vim",
      'AndreM222/copilot-lualine',
    },
    config = function()
      require("lualine").setup{
        sections = {
          lualine_c = {'RSpecCurrentSubject'},
          lualine_x = { { 'copilot', show_colors = true } , 'filetype' },
        },
        options = {
          theme = 'tokyonight',
        }
      }
    end
  },
  {
    "luukvbaal/statuscol.nvim", -- statuscolumn
    config = function()
      require("statuscol").setup({})
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  {
    "nvim-zh/colorful-winsep.nvim", -- Colorful window separator
    config = true,
    event = { "WinNew" },
  },
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        default_mappings = true
      }
    end
  },
  {
    'nvim-pack/nvim-spectre', -- Search and replace
    config = function()
      require('spectre').setup()
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = { "qf" },
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
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
      'zidhuss/neotest-minitest',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require("neotest-rspec"),
          require('neotest-minitest'),
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
  {
    'weizheheng/ror.nvim', -- Rails development support
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'rcarriga/nvim-notify',
      'stevearc/dressing.nvim'
    },
  },
  "hallison/vim-rdoc", -- RDoc syntax highlighting
  -- JavaScript/TypeScript
  "MaxMEllon/vim-jsx-pretty",
  { 'dmmulroy/ts-error-translator.nvim' }, -- Better TypeScript error message
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
  {
    "lewis6991/gitsigns.nvim", -- Sign with Git status
    config = function()
      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    'akinsho/git-conflict.nvim', -- Fancy conflict viewer
    version = "*",
    config = true
  },
  {
    'ruifm/gitlinker.nvim', -- Permalink to GitHub and others
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require("gitlinker").setup()
    end
  },
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end
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
      wk.add({
        { "<C-h>", ss.move_cursor_left, desc = "Move cursor left" },
        { "<C-j>", ss.move_cursor_down, desc = "Move cursor down" },
        { "<C-k>", ss.move_cursor_up, desc = "Move cursor up" },
        { "<C-l>", ss.move_cursor_right, desc = "Move cursor right" },
      })
    end
  },
  {
    "zbirenbaum/copilot.lua", -- copilot
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>"
          }
        }
      })
    end,
  },
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
  {
    'stevearc/overseer.nvim', -- Task management
    config = function()
      require('overseer').setup()
    end
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'} }
  },
  {
    "m4xshen/hardtime.nvim", -- Good habits
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    'stevearc/oil.nvim', -- File explorer
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  "direnv/direnv.vim", -- direnv integration
  {
    "uga-rosa/ccc.nvim", -- Color utility
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    }
  },
  {
    'Sam-programs/cmdline-hl.nvim', -- Highlight cmdline
    event = 'VimEnter',
    opts = {}
  },
  {
    "CRAG666/code_runner.nvim",
    config = true
  },
  {
    "mistricky/codesnap.nvim", -- Take screenshots
    build = "make",
    opts = {
      bg_x_padding = 64,
      bg_y_padding = 32,
      save_path = "~/codesnap/"
    }
  },
})

-- Misc
vim.opt.termguicolors = true -- True color
vim.opt.relativenumber = true -- Setting relativenumber is slow but Apple Sillicon make it work!
vim.opt.number = true -- Current line has 0 relative number so showing absolute number
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- For ufo
vim.opt.foldlevelstart = 99 -- For ufo
vim.opt.expandtab = true -- Insert whitespaces with tabb key
vim.opt.tabstop = 2 -- Tab is 2 whitespaces
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.spelllang = "en,cjk" -- Spellcheck language
vim.opt.undofile = true -- Persistent undo
vim.opt.laststatus = 3 -- always and ONLY the last window
vim.opt.grepprg = "rg --vimgrep" -- Use ripgrep for grep
vim.opt.grepformat = "%f:%l:%c:%m"

-- autocmd
local spell_group = vim.api.nvim_create_augroup('spell', {clear = false})
vim.api.nvim_create_autocmd({'BufEnter'}, {
  pattern = {'*.txt','*.md','*.markdown','NeogitCommitMessage'},
  group = spell_group,
  command = 'setlocal spell',
  desc = 'Set spell for text files'
})

-- Key mappings
local wk = require("which-key")
local builtin = require('telescope.builtin')
wk.add({
  {
    {"]<space>", ":<C-u>call append(expand('.'), '')<Cr>j", desc = "Add one empty line to below"},
    { "<leader>g", group = "git" },
    { "<leader>ga", ":<C-u>!git add %<Cr>", desc = "Add current file" },
    { "<leader>gcc", ":<C-u>Neogit commit<Cr>", desc = "Git commit" },
    { "<leader>gg", ":Neogit<Cr>", desc = "Open Neogit" },
    { "]<space>", ":<C-u>call append(expand('.'), '')<Cr>j", desc = "Add one empty line to below" },
    { "<leader>f", group = "+file" },
    { "<leader>ff", builtin.find_files, desc = "Find Files" },
    { "<leader>fo", builtin.oldfiles, desc = "Find File from history" },
    { "<leader>fh", builtin.help_tags, desc = "Help items" },
    { "<leader>r", group = "+grep" },
    { "<leader>rr", builtin.grep_string, desc = "Grep string under cursor" },
    { "<leader>rl", builtin.live_grep, desc = "Live grep" },
    { "<leader>glc", builtin.git_commits, desc = "Git commits" },
    { "<leader>gb", builtin.git_branches, desc = "Git branches" },
    { "<leader>gs", builtin.git_status, desc = "Git status" },
    { "<leader>tb", builtin.builtin, desc = "List builtin commands" },
    { "<leader>qf", builtin.quickfix, desc = "Quickfix" },
    { "<leader>ts", builtin.treesitter, desc = "treesitter" },
    { "<leader>u", "<cmd>Telescope undo<cr>", desc = "Undos" },
  }
})

-- LSP
-- Setup lspconfig.
local lspconfig = require'lspconfig'
local json_schemas = require('schemastore').json.schemas()

lspconfig.tsserver.setup {}

lspconfig.yamlls.setup {
  settings = {
    yaml = {
      schemas = json_schemas,
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
      schemas = json_schemas,
    },
  },
}

-- lspconfig.typeprof.setup {}

-- lspconfig.steep.setup {}

lspconfig.ruby_lsp.setup {}

lspconfig.jdtls.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
wk.add({
  { "<leader>T", "<cmd>Neotest run file<cr>", desc = "Run file test" },
  { "<leader>t", "<cmd>Neotest run<cr>", desc = "Run nearest test" },
  { "<space>e", vim.diagnostic.open_float, desc = "Open diagnostic float" },
  { "<space>q", vim.diagnostic.setloclist, desc = "Set loclist" },
  { "[d", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
  { "]d", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
})
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    wk.add({
      { { "gD", vim.lsp.buf.declaration, desc = 'Go to declaration' }, opts },
      { { "gd", vim.lsp.buf.definition, desc = 'Go to definition' }, opts },
      { { "K", vim.lsp.buf.hover, desc = 'Hover' }, opts },
      { { "gi", vim.lsp.buf.implementation, desc = 'Go to implementation' }, opts },
      { { "<leader>k", vim.lsp.buf.signature_help, desc = 'Show signature help' }, opts },
      -- ['<space>wa'] = { vim.lsp.buf.add_workspace_folder, opts },
      -- ['<space>wr'] = { vim.lsp.buf.remove_workspace_folder, opts },
      -- ['<space>wl'] = { function()
      --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- end, opts },
      { { "TD", vim.lsp.buf.type_definition, desc = 'Go to type definition' }, opts },
      { { "rn", vim.lsp.buf.rename, desc = 'Rename' }, opts },
      { { "<leader>ca", vim.lsp.buf.code_action, desc = 'Code action', mode = { 'n', 'v' } }, opts },
      { { "gr", vim.lsp.buf.references, desc = 'Go to references' }, opts },
      -- ['<space>f'] = { { function()
      --   vim.lsp.buf.format { async = true }
      -- end, 'Format' }, opts },
    })
  end,
})

-- Editing support

local ruby_linter = nil
if vim.fn.filereadable(".standard.yml") == 1 then
  ruby_linter = "standardrb"
elseif vim.fn.filereadable(".rubocop.yml") == 1 then
  ruby_linter = "rubocop"
end
local lint = require('lint')
lint.linters_by_ft = {
  ruby = {ruby_linter},
  javascript = {"eslint"},
  typescript = {"eslint"},
  typescriptreact = {"eslint"},
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
