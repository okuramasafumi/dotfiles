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
  "MunifTanjim/nui.nvim",  -- UI
  'b0o/schemastore.nvim',  -- JSON schema access
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      image = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = false,
        timeout = 3000,
      },
      notify = { enabled = true },
      picker = { enabled = false },
      profiler = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      terminal = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      },
    },
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
              ['@function.outer'] = 'V',  -- linewise
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
        ignore_install = {},                                                                                                                                                                         -- List of parsers to ignore installing
        highlight = {
          enable = true,                                                                                                                                                                             -- false will disable the whole extension
          disable = { "c", "rust" },                                                                                                                                                                 -- list of language that will be disabled
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
          enable = true, -- mandatory, false will disable the whole extension
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
      "andymass/vim-matchup",                        -- matchit replacement
      'nvim-treesitter/nvim-treesitter-textobjects', -- Syntax aware text objects
      'nvim-treesitter/nvim-treesitter-context',     -- Code context
      'nvim-treesitter/nvim-treesitter-refactor',    -- Refactoring support
      'RRethy/nvim-treesitter-endwise',              -- Complete end
      'windwp/nvim-ts-autotag',                      -- Auto close tags
    }
  },
  -- LSP section
  "neovim/nvim-lspconfig",
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    event = "LspAttach",
    config = function()
      require('tiny-code-action').setup()
    end
  },
  -- Editing support
  {
    'mfussenegger/nvim-lint' -- Linter
  },
  {
    'stevearc/conform.nvim',
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
    'echasnovski/mini.ai',
    version = false,
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = { "InsertEnter", "CmdlineEnter" },
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',                -- LSP completaion
      'hrsh7th/cmp-buffer',                  -- Buffer completion
      'hrsh7th/cmp-path',                    -- Path completion
      'hrsh7th/cmp-cmdline',                 -- Command line completion
      'hrsh7th/cmp-nvim-lsp-signature-help', --  Function signatures
      'petertriho/cmp-git',                  -- Git completion
      "L3MON4D3/LuaSnip",                    -- Snippet engine
      'saadparwaiz1/cmp_luasnip',            -- Snippets completion
      'ray-x/cmp-treesitter',                -- TreeSitter completion
      'quangnguyen30192/cmp-nvim-tags',      -- ctags completion
      'onsails/lspkind.nvim',                -- Show pictograms
      "xzbdmw/colorful-menu.nvim",           -- Colorful menu
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
          { name = 'nvim_lsp_signature_help' },
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
          { name = 'tags' },
          { name = 'lazydev', group_index = 0 }
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
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' },
        })
      })

      cmp.setup {
        formatting = {
          fields = { "kind", "abbr", "menu" },

          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
              mode = "symbol_text",
            })(entry, vim.deepcopy(vim_item))
            local highlights_info = require("colorful-menu").cmp_highlights(entry)

            -- if highlight_info==nil, which means missing ts parser, let's fallback to use default `vim_item.abbr`.
            -- What this plugin offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
            if highlights_info ~= nil then
              vim_item.abbr_hl_group = highlights_info.highlights
              vim_item.abbr = highlights_info.text
            end
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            vim_item.kind = " " .. (strings[1] or "") .. " "
            vim_item.menu = ""

            return vim_item
          end,
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
      require('luasnip').filetype_extend("ruby", { "rails" })
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
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
        fold_virt_text_handler = handler,
        close_fold_kinds_for_ft = {
          default = { 'comment', 'imports' }
        }
      }
    end
  },
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-3.7-sonnet",
              },
              max_tokens = {
                default = 65536,
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
      },
    },
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<up>",
        function() mc.lineAddCursor(-1) end)
      set({ "n", "x" }, "<down>",
        function() mc.lineAddCursor(1) end)
      set({ "n", "x" }, "<leader><up>",
        function() mc.lineSkipCursor(-1) end)
      set({ "n", "x" }, "<leader><down>",
        function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<leader>n",
        function() mc.matchAddCursor(1) end)
      set({ "n", "x" }, "<leader>s",
        function() mc.matchSkipCursor(1) end)
      set({ "n", "x" }, "<leader>N",
        function() mc.matchAddCursor(-1) end)
      set({ "n", "x" }, "<leader>S",
        function() mc.matchSkipCursor(-1) end)

      -- In normal/visual mode, press `mwap` will create a cursor in every match of
      -- the word captured by `iw` (or visually selected range) inside the bigger
      -- range specified by `ap`. Useful to replace a word inside a function, e.g. mwif.
      set({ "n", "x" }, "mw", function()
        mc.operator({ motion = "iw", visual = true })
        -- Or you can pass a pattern, press `mwi{` will select every \w,
        -- basically every char in a `{ a, b, c, d }`.
        -- mc.operator({ pattern = [[\<\w]] })
      end)

      -- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
      set("n", "mW", mc.operator)

      -- Add all matches in the document
      set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

      -- You can also add cursors with any motion you prefer:
      -- set("n", "<right>", function()
      --     mc.addCursor("w")
      -- end)
      -- set("n", "<leader><right>", function()
      --     mc.skipCursor("w")
      -- end)

      -- Rotate the main cursor.
      set({ "n", "x" }, "<left>", mc.nextCursor)
      set({ "n", "x" }, "<right>", mc.prevCursor)

      -- Delete the main cursor.
      set({ "n", "x" }, "<leader>x", mc.deleteCursor)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)

      -- Easy way to add and remove cursors using the main cursor.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Clone every cursor and disable the originals.
      set({ "n", "x" }, "<leader><c-q>", mc.duplicateCursors)

      set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- bring back cursors if you accidentally clear them
      set("n", "<leader>gv", mc.restoreCursors)

      -- Align cursor columns.
      set("n", "<leader>a", mc.alignCursors)

      -- Split visual selections by regex.
      set("x", "S", mc.splitCursors)

      -- Append/insert for each line of visual selections.
      set("x", "I", mc.insertVisual)
      set("x", "A", mc.appendVisual)

      -- match new cursors within visual selections by regex.
      set("x", "M", mc.matchCursors)

      -- Rotate visual selection contents.
      set("x", "<leader>t",
        function() mc.transposeCursors(1) end)
      set("x", "<leader>T",
        function() mc.transposeCursors(-1) end)

      -- Jumplist support
      set({ "x", "n" }, "<c-i>", mc.jumpForward)
      set({ "x", "n" }, "<c-o>", mc.jumpBackward)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { link = "Cursor" })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end
  },
  -- Telescope
  {
    'nvim-telescope/telescope-fzf-native.nvim', -- Faster sort
    build = 'make'
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'LukasPietzschmann/telescope-tabs',
      "debugloop/telescope-undo.nvim",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup {
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          undo = {
            -- Configurations here
          }
        },
        pickers = {
          find_files = {
            find_command = function()
              return { "rg", "--files", "--hidden", "--glob", "!.git" }
            end
          }
        },
      }
      telescope.load_extension("undo")
      telescope.load_extension('fzf')
      telescope.load_extension("live_grep_args")
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
    'nvim-lualine/lualine.nvim',     -- statusline
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional dependency
      "okuramasafumi/rspec-current.vim",
      'AndreM222/copilot-lualine',
    },
    config = function()
      require("lualine").setup {
        sections = {
          lualine_c = { 'RSpecCurrentSubject' },
          lualine_x = { { 'copilot', show_colors = true }, 'filetype' },
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
    build = "build.sh",
    lazy = true,
    cmd = "Spectre",
    config = function()
      require('spectre').setup({
        default = {
          replace = {
            cmd = "oxi"
          }
        }
      })
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
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    "andrewferrier/debugprint.nvim",
    opts = {},
    version = "*", -- Remove if you DON'T want to use the stable version
  },
  -- Testing
  {
    'nvim-neotest/neotest',
    lazy = true,
    event = "VeryLazy",
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
  "pocke/rbs.vim",          -- Including filetype detector
  "slim-template/vim-slim", -- Slim template
  {
    'weizheheng/ror.nvim',  -- Rails development support
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
    lazy = true,
    event = "VeryLazy",
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
    "FabijanZulj/blame.nvim", -- Git blame, sidebar style
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
        { "<C-h>", ss.move_cursor_left,  desc = "Move cursor left" },
        { "<C-j>", ss.move_cursor_down,  desc = "Move cursor down" },
        { "<C-k>", ss.move_cursor_up,    desc = "Move cursor up" },
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
  "wsdjeg/vim-fetch",           -- Line number and column number
  "gpanders/editorconfig.nvim", -- Editorconfig
  'jghauser/mkdir.nvim',        -- Create directory when it's missing
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
    "ethanholz/nvim-lastplace", -- Restore last cursor position
    config = function()
      require("nvim-lastplace").setup {}
    end
  },
  {
    'stevearc/overseer.nvim', -- Task management
    lazy = true,
    event = "VeryLazy",
    config = function()
      require('overseer').setup()
    end
  },
  {
    "m4xshen/hardtime.nvim", -- Good habits
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    'stevearc/oil.nvim', -- File explorer
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  "direnv/direnv.vim",   -- direnv integration
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
    config = function()
      require("code_runner").setup {}
      local wk = require("which-key")
      wk.add({
        { '<leader>rr', ':RunCode<CR>', desc = "Runs based on file type, first checking if belongs to project, then if filetype mapping exists" },
        { '<leader>rf', ':RunFile<CR>', desc = "Run the current file (optionally you can select an opening mode)." },
      })
    end
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
  {
    "folke/lazydev.nvim", -- Lua development
    ft = "lua",           -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "OXY2DEV/helpview.nvim", -- Nicer help
    lazy = false
  },
})

-- Misc
vim.opt.termguicolors = true  -- True color
vim.opt.relativenumber = true -- Setting relativenumber is slow but Apple Sillicon make it work!
vim.opt.number = true         -- Current line has 0 relative number so showing absolute number
vim.opt.foldenable = true
vim.opt.foldlevel = 99        -- For ufo
vim.opt.foldlevelstart = 99   -- For ufo
vim.opt.expandtab = true      -- Insert whitespaces with tabb key
vim.opt.tabstop = 2           -- Tab is 2 whitespaces
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.spelllang = "en,cjk"     -- Spellcheck language
vim.opt.undofile = true          -- Persistent undo
vim.opt.laststatus = 3           -- always and ONLY the last window
vim.opt.grepprg = "rg --vimgrep" -- Use ripgrep for grep
vim.opt.grepformat = "%f:%l:%c:%m"

-- autocmd
local spell_group = vim.api.nvim_create_augroup('spell', { clear = false })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { '*.txt', '*.md', '*.markdown', 'NeogitCommitMessage' },
  group = spell_group,
  command = 'setlocal spell',
  desc = 'Set spell for text files'
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*rdoc_options",
  command = "set filetype=yaml",
  desc    = ".rdoc_options is YAML"
})

-- Easy quittng
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf', 'healthcheck', 'help', 'crunner' },
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>bd<cr>', { silent = true, buffer = true })
  end,
})

-- Key mappings
local wk = require("which-key")
local builtin = require('telescope.builtin')
wk.add({
  {
    { "]<space>",    ":<C-u>call append(expand('.'), '')<Cr>j",                            desc = "Add one empty line to below" },
    { "<leader>g",   group = "git" },
    { "<leader>ga",  ":<C-u>!git add %<Cr>",                                               desc = "Add current file" },
    { "<leader>gcc", ":<C-u>Neogit commit<Cr>",                                            desc = "Git commit" },
    { "<leader>gg",  ":Neogit<Cr>",                                                        desc = "Open Neogit" },
    { "]<space>",    ":<C-u>call append(expand('.'), '')<Cr>j",                            desc = "Add one empty line to below" },
    { "<leader>f",   group = "+file" },
    { "<leader>ff",  builtin.find_files,                                                   desc = "Find Files" },
    { "<leader>fo",  builtin.oldfiles,                                                     desc = "Find File from history" },
    { "<leader>fh",  builtin.help_tags,                                                    desc = "Help items" },
    { "<leader>r",   group = "+grep" },
    { "<leader>rr",  require("telescope-live-grep-args.shortcuts").grep_word_under_cursor, desc = "Grep string under cursor",          mode = "n" },
    { "<leader>rr",  require("telescope-live-grep-args.shortcuts").grep_visual_selection,  desc = "Grep string with visual selection", mode = "v" },
    { "<leader>rl",  require('telescope').extensions.live_grep_args.live_grep_args,        desc = "Live grep" },
    { "<leader>glc", builtin.git_commits,                                                  desc = "Git commits" },
    { "<leader>gb",  builtin.git_branches,                                                 desc = "Git branches" },
    { "<leader>gs",  builtin.git_status,                                                   desc = "Git status" },
    { "<leader>tb",  builtin.builtin,                                                      desc = "List builtin commands" },
    { "<leader>qf",  builtin.quickfix,                                                     desc = "Quickfix" },
    { "<leader>ts",  builtin.treesitter,                                                   desc = "treesitter" },
    { "<leader>u",   "<cmd>Telescope undo<cr>",                                            desc = "Undos" },
  }
})

-- LSP
-- Setup lspconfig.
local lspconfig = require 'lspconfig'
local json_schemas = require('schemastore').json.schemas()

lspconfig.ts_ls.setup {}

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

local ruby_lsp_type = ""
if vim.fn.filereadable(".standard.yml") == 1 then
  ruby_lsp_type = "standard"
elseif vim.fn.filereadable(".rubocop.yml") == 1 then
  ruby_lsp_type = "rubocop"
end
if ruby_lsp_type ~= "" then
  lspconfig.ruby_lsp.setup({
    before_init = function(params, config)
      -- TODO: Move params confiiguration here
    end,
    init_options = {
      formatter = ruby_lsp_type,
      linters = { ruby_lsp_type },
    }
  })
end

lspconfig.jdtls.setup {}

lspconfig.lua_ls.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
wk.add({
  { "<leader>T", "<cmd>Neotest run file<cr>",                                      desc = "Run file test" },
  { "<leader>t", "<cmd>Neotest run<cr>",                                           desc = "Run nearest test" },
  { "<leader>e", vim.diagnostic.open_float,                                        desc = "Open diagnostic float" },
  { "<leader>q", vim.diagnostic.setloclist,                                        desc = "Set loclist" },
  { "[d",        function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Go to previous diagnostic" },
  { "]d",        function() vim.diagnostic.jump({ count = 1, float = true }) end,  desc = "Go to next diagnostic" },
})
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    wk.add({
      { { "gD", vim.lsp.buf.declaration, desc = 'Go to declaration' },                        opts },
      { { "gd", vim.lsp.buf.definition, desc = 'Go to definition' },                          opts },
      { { "K", vim.lsp.buf.hover, desc = 'Hover' },                                           opts },
      { { "gi", vim.lsp.buf.implementation, desc = 'Go to implementation' },                  opts },
      { { "<leader>k", vim.lsp.buf.signature_help, desc = 'Show signature help' },            opts },
      -- ['<space>wa'] = { vim.lsp.buf.add_workspace_folder, opts },
      -- ['<space>wr'] = { vim.lsp.buf.remove_workspace_folder, opts },
      -- ['<space>wl'] = { function()
      --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- end, opts },
      { { "TD", vim.lsp.buf.type_definition, desc = 'Go to type definition' },                opts },
      { { "rn", vim.lsp.buf.rename, desc = 'Rename' },                                        opts },
      { { "<leader>ca", vim.lsp.buf.code_action, desc = 'Code action', mode = { 'n', 'v' } }, opts },
      { { "gr", vim.lsp.buf.references, desc = 'Go to references' },                          opts },
      -- ['<space>f'] = { { function()
      --   vim.lsp.buf.format { async = true }
      -- end, 'Format' }, opts },
    })

    -- Auto formatting with LSP
    if client and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd("BufWritePre", {
        -- pattern = "*.rb",
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
})

-- Rails specific settings

local function is_rails_project()
  local current_dir = vim.fn.expand('%:p:h')
  while current_dir ~= "/" do
    if vim.fn.filereadable(current_dir .. "/config/application.rb") == 1 then
      return true
    end
    current_dir = vim.fn.fnamemodify(current_dir, ":h")
  end
  return false
end


local rails_group = vim.api.nvim_create_augroup('rails', { clear = false })

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.rb",
  callback = function()
    if is_rails_project() then
      vim.opt.path:append("app/models")
      vim.opt.suffixesadd:append(".rb")
    end
  end,
  group = rails_group,
})
