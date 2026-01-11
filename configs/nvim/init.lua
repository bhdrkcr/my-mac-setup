-- Neovim Configuration
-- Basic setup for a pleasant editing experience

-- ============================================================================
-- Options
-- ============================================================================

vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true   -- Relative line numbers
vim.opt.mouse = 'a'             -- Enable mouse support
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.breakindent = true      -- Preserve indentation in wrapped lines
vim.opt.undofile = true         -- Persistent undo
vim.opt.ignorecase = true       -- Case insensitive search
vim.opt.smartcase = true        -- Unless capital letters used
vim.opt.signcolumn = 'yes'      -- Always show sign column
vim.opt.updatetime = 250        -- Faster update time
vim.opt.timeoutlen = 300        -- Faster key sequence completion
vim.opt.splitright = true       -- Vertical split to the right
vim.opt.splitbelow = true       -- Horizontal split below
vim.opt.cursorline = true       -- Highlight current line
vim.opt.scrolloff = 8           -- Keep 8 lines above/below cursor
vim.opt.termguicolors = true    -- True color support

-- Indentation
vim.opt.tabstop = 4             -- Tab width
vim.opt.shiftwidth = 4          -- Indentation width
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.smartindent = true      -- Smart auto-indentation

-- ============================================================================
-- Keymaps
-- ============================================================================

vim.g.mapleader = ' '           -- Space as leader key
vim.g.maplocalleader = ' '

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Clear search highlighting
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { silent = true })

-- Better indentation in visual mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Move lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Quick save
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })

-- ============================================================================
-- Autocommands
-- ============================================================================

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

-- ============================================================================
-- Plugin Manager (lazy.nvim bootstrap)
-- ============================================================================

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Plugins
-- ============================================================================

require('lazy').setup({
    -- Colorscheme
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('catppuccin-mocha')
        end,
    },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = { theme = 'catppuccin' },
            })
        end,
    },

    -- File explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('nvim-tree').setup()
            vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
        end,
    },

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
        end,
    },

    -- Syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'lua', 'python', 'javascript', 'typescript', 'json', 'yaml', 'markdown', 'bash' },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- Git signs
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },

    -- Auto pairs
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },

    -- Comment toggling
    {
        'numToStr/Comment.nvim',
        config = true,
    },

    -- Which key (keybinding hints)
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = true,
    },
})
