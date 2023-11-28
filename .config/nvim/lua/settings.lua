-- Don't unload buffers after closing the window
vim.o.hidden = true

-- Display tabs, trailing spaces, and non-breaking spaces when `list` is set
-- vim.o.listchars = { tab = '| ', trail = ':', nbsp = '-' }
vim.o.listchars = [[tab:| ,trail:.,nbsp:-]]

-- Write swap files to disk and a trigger cursor hold after idling for this many milliseconds
vim.o.updatetime = 500

-- Show the sign column even when no signs are present
vim.o.signcolumn = 'yes'

-- Use tilde as an operator, which can be preceded by a motion
-- Ex. ~w to change the case of a word
vim.o.tildeop = true

-- Display tabs as 4 spaces
vim.o.tabstop = 4

-- Insert 4 spaces when using expandtab
vim.o.shiftwidth = 4

-- Use tabs instead of spaces
vim.o.expandtab = false

-- Only redraw when necessary
vim.o.lazyredraw = true

-- Don't show the current mode, as the
-- lightline plugin takes care of this
vim.o.showmode = false

-- Open folds by default when opening buffers
vim.o.foldlevelstart = 99

-- Determines where folds start/end using indention
vim.o.foldmethod = 'indent'
vim.o.modelines = 1

-- Ignore case in searches
-- Can be disabled temporarily by using \C in the search
vim.o.ignorecase = true

-- Only open menu when there's more than one option
-- Don't auto-select an option from the menu
-- vim.o.completeopt = { 'menuone', 'noselect' }
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

-- TODO: describe... (see `:h ft-python-plugin`)
vim.g.python_recommended_style = 0

-- Support embedded lua in init.vim
vim.g.vimsyn_embed = 'l'

-- Jump to the previously used window when jumping to errors with quickfix commands
-- vim.o.switchbuf = 'uselast'

vim.o.smartcase = true

-- Use the case of the typed text when inserting autocompleted text
vim.o.infercase = true
