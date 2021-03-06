" Intro {{{

" This file will be a lot prettier and easier to read if you have the
" following lines in your vim config:
"
" ```
" set modeline
" set modelines=1
" ```
"
" `modelines` doesn't actually have to be 1 but it needs to be at least 1.
"
" I've only tested this in neovim so some of this may not work in vim.
" There are also probably quite a few options not explicitly set in here that
" most people would want that are enabled by default in neovim but not in vim.
" Basically, this config was made with neovim in mind only.
"
" vim-plug is used for installing plugins - https://github.com/junegunn/vim-plug
"
" A few plugins listed below have dependancies that must be installed separately:
"
" neoclide/coc.nvim
" * node - https://nodejs.org/en
"
" junegunn/fzf
" junegunn/fzf.vim
" * fzf - https://github.com/junegunn/fzf
"
" There's also support for some neovim 0.5 features. For example, neovim's
" native LSP will be used instead of coc.nvim is you're using neovim 0.5 or
" later.

" }}}
" Vim-Plug {{{

call plug#begin("~/.local/share/nvim/plugged")

" Colorschemes:

Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'ronny/birds-of-paradise.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'skbolton/embark'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'srcery-colors/srcery-vim'
Plug 'chuling/equinusocio-material.vim'
Plug 'nightsense/strawberry'
Plug 'nightsense/vimspectr'
Plug 'addisonbean/amber'
Plug 'metalelf0/base16-black-metal-scheme'
Plug 'co1ncidence/bliss', { 'rtp': 'vim' }
Plug 'logico/typewriter-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'arzg/vim-colors-xcode'
Plug '~/code/projects/srcery-basic'
Plug 'pineapplegiant/spaceduck'
Plug 'kyazdani42/blue-moon'
Plug 'danishprakash/vim-yami'

" Language Specific:

Plug 'mattn/emmet-vim', { 'for': ['html', 'eruby', 'php', 'xml', 'vue', 'js', 'typescript', 'typescriptreact'] }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'rudes/vim-java', { 'for': 'java' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'js' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'edwinb/idris2-vim', { 'for': 'idr' }
Plug 'pangloss/vim-javascript', { 'for': 'js' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'lervag/vimtex', { 'for': 'latex' }

" General:

Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sleuth'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'mjbrownie/swapit'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lifepillar/vim-colortemplate'
Plug 'vimwiki/vimwiki'
Plug 'ms-jpq/chadtree'
Plug 'skywind3000/asyncrun.vim'
if has('nvim-0.5')
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
else
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
end

call plug#end()

" }}}
" "set"-ings {{{

" Enable syntax highlighting
syntax enable

filetype plugin indent on

" Don't unload buffers after closing the window
set hidden

" Display tabs, trailing spaces, and non-breaking spaces when `list` is set
set listchars=tab:\|\ ,trail:.,nbsp:-

" Write swap files to disk and a trigger cursor hold after idling for 500ms
set updatetime=500

" Show the sign column even when no signs are present
set signcolumn=yes

" Use tilde as an operator, which can be preceded by a motion
" Ex. ~w to change the case of a word
set tildeop

" Zsh style autocomplete in command mode
set wildmenu

" Detect when a file is changed from outside vim
" and update the buffer accordingly
set autoread

" Display the cursor position in the status line
set ruler

" Show line numbers
set number

" Display tabs as 4 spaces
set tabstop=4

" Insert 4 spaces when using expandtab
set shiftwidth=4

" Use tabs instead of spaces
set noexpandtab

" Only redraw when necessary
set lazyredraw

" Don't show the current mode, as the
" lightline plugin takes care of this
set noshowmode

" Enable folds
set foldenable

" Open folds by default when opening buffers
set foldlevelstart=99

" Determines where folds start/end using indention
set foldmethod=indent

set modeline
set modelines=1

set backspace=2

" Ignore case in searches
" Can be disabled temporarily by using \C in the search
set ignorecase

if has('termguicolors')
	set termguicolors
endif

" Use spaces instead of ~ at the end of the buffer
set fcs=eob:\ 

let g:python_recommended_style = 0

" }}}
" Custom mappings and commands {{{

" opens something like {} up to a multiline kinda thing then puts the cursor
" in the middle
nnoremap <C-l> i<cr><cr><esc>k"_S
inoremap <C-l> <cr><cr><esc>k"_S
" nnoremap <C-k> a<cr><cr><esc>k"_S
" inoremap <C-k> <right><cr><cr><esc>k"_S

" Toggle `spell`
nnoremap <silent> <c-s><c-s> :set spell!<cr>

" Open ~/.vimrc in a new verical buffer
" nnoremap <silent> <leader>ev :vnew ~/.vimrc<cr>
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>

" Reload ~/.config/nvim/init.vim
nnoremap <silent> <leader>rv :source $MYVIMRC <bar> doautocmd BufRead<cr>
" nnoremap <silent> <leader>rv :source $MYVIMRC<cr>

" TODO: revise this, add Y and D and crap?
" Let <leader> + paste/cut/copy use the system clipboard
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" TODO: is there a more general way to do this?
" Remap <C-a> since that's my tmux prefix and <C-c> is useless by default
nnoremap <C-c> <C-a>
vnoremap <C-c> <C-a>
vnoremap g<C-c> g<C-a>

" Unhighlight all text
nnoremap <silent> <C-h> :noh<cr>

" Toggle relative line numbers (current line will always remain absolute)
nnoremap <silent> <C-q> :set relativenumber!<cr>

" Use ctrl-j and ctrl-k to navigate completion menus
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use ctrl-_ and ctrl-\ to split a window horizontally/vertically
nnoremap <silent> <C-_> :new<cr>
nnoremap <silent> <C-\> :vnew<cr>

" Use [<space> and ]<space> to add a new line above/below the current line
" (Thanks to https://vi.stackexchange.com/a/3891/8749 for extracting this
" from the tpope/vim-unimpaired plugin)
nnoremap <silent> [<space> :<C-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space> :<C-u>put =repeat([''],v:count)<bar>'[-1<cr>

" When multiple lines are selected in visual mode,
" use @ to apply a macro to each individual line
" Thanks to https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
xnoremap <silent> @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Use <space> to toggle a fold
nnoremap <space> za

" Use ctrl-j and ctrl-k to navigate command mode history
cnoremap <C-j> <down>
cnoremap <C-k> <up>

" Add a markdown/reST heading
nnoremap <leader>h ^v$hyo<esc>p==^v$hr

" Surround words with various things {{{

" I know vim-surround can probably do this but I didn't feel like
" figuring out how to get it to use these mappings

" Surround the current word with backticks
nnoremap <c-s>` wbi`<esc>ea`<esc>
inoremap <c-s>` <esc>wbi`<esc>ea`

" Surround the current word with brackets
nnoremap <c-s>[ wbi[<esc>ea]<esc>
inoremap <c-s>[ <esc>wbi[<esc>ea]
nnoremap <c-s>] wbi[<esc>ea]<esc>
inoremap <c-s>] <esc>wbi[<esc>ea]

" Surround the current word with parenthesis
nnoremap <c-s>( wbi(<esc>ea)<esc>
inoremap <c-s>( <esc>wbi(<esc>ea)
nnoremap <c-s>) wbi(<esc>ea)<esc>
inoremap <c-s>) <esc>wbi(<esc>ea)

" Surround the current word with angle brackets
nnoremap <c-s><lt> wbi<lt><esc>ea><esc>
inoremap <c-s><lt> <esc>wbi<lt><esc>ea>
nnoremap <c-s>> wbi<lt><esc>ea><esc>
inoremap <c-s>> <esc>wbi<lt><esc>ea>

" }}}

" Stop s, x, d, and c from copying {{{

nnoremap s "_s
nnoremap S "_S

nnoremap d "_d
nnoremap D "_D

nnoremap c "_c
nnoremap C "_C

nnoremap x "_x
nnoremap X "_X

" Prefix the old s, x, d, and c with <leader>

nnoremap <leader>s s
nnoremap <leader>S S

nnoremap <leader>d d
nnoremap <leader>D D

nnoremap <leader>c c
nnoremap <leader>C C

nnoremap <leader>x x
nnoremap <leader>X X

" }}}

" Allow saving and quiting when I'm still accidentally holding shift
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! X x

" View the current buffer as a hexdump
command! Hexdump %!xxd
command! NoHexdump %!xxd -r

" Open the current 
" TODO: use `open` when on macOS
command! Open !xdg-open %

" Thanks to https://stackoverflow.com/a/4293538/1525759
function WriteCreatingDirs()
	execute ':silent !mkdir -p %:h'
	write
endfunction
command! WD call WriteCreatingDirs()

function PdfView()
	let l:fname = system("echo -n $RANDOM")
	execute '!pandoc -s % -o /tmp/' . l:fname . '.pdf && xdg-open /tmp/' . l:fname . '.pdf && rm /tmp/' . l:fname . '.pdf'
endfunction

command! Pdf call PdfView()

" }}}
" Plugin setup {{{

" tomtom/tcomment_vim {{{

" Comment/uncomment the current line
nnoremap <silent> <leader>\ :TComment<cr>
xnoremap <silent> <leader>\ :TComment<cr>

""" }}}
" junegunn/fzf.vim {{{

function! SearchFiles()
	" If in a git repo and there is at least one commit use `GFiles`, otherwise use `Files`
	if system('[ "$(git rev-parse --is-inside-work-tree)" = "true" ] && [ "$(git count-objects | head -c 1)" -ne 0 ] && echo -n true') == "true"
		GFiles --exclude-standard -c -o
	else
		Files
	endif
endfunc

" Open a file using a fzf file search window
nnoremap <silent> <C-p> :call SearchFiles()<cr>
nnoremap <silent> <leader>nf :call SearchFiles()<cr>

" Pick an open buffer to open
nnoremap <silent> <leader>nb :Buffers<cr>

" Fuzzy search a project for a matching string using `ripgrep`
nnoremap <silent> <leader>nr :Rg<cr>

" }}}
" posva/vim-vue {{{

" Rather than loading syntax files for all preprocessors and
" trying each one, attempt to detect which need to be loaded
let g:vue_pre_processors = 'detect_on_enter'

" }}}
" junegunn/goyo.vim {{{

let g:goyo_width = 100
" let g:goyo_linenr = 1

" https://github.com/junegunn/goyo.vim/wiki/Customization#ensure-q-to-quit-even-when-goyo-is-active

function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
	" Quit Vim if this is the only remaining buffer
	if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" }}}
" mattn/emmet-vim {{{

" let g:user_emmet_leader_key = '<leader>e'

" }}}
" neoclide/coc.nvim {{{

if !has('nvim-0.5')
	let g:coc_global_extensions = [
	\'coc-rust-analyzer',
	\'coc-tsserver',
	\'coc-vetur',
	\'coc-json',
	\'coc-java',
	\]

	autocmd FileType rust,vue,typescript,json,java,typescriptreact call s:coc_settings()

	function! s:coc_settings()
		" Navigation to the definition for the symbol under the cursor
		nmap <silent><buffer> gd <Plug>(coc-definition)
		nmap <silent><buffer> <c-]> <Plug>(coc-definition)

		" Navigation to the type definition for the symbol under the cursor
		nmap <silent><buffer> gy <Plug>(coc-type-definition)

		" Navigation to the implementation(s) for the symbol under the cursor
		nmap <silent><buffer> gi <Plug>(coc-implementation)

		" Navigation to references to the symbol under the cursor
		nmap <silent><buffer> gr <Plug>(coc-references)

		" Rename the symbol under the cursor, including all it's other usages
		" (This can act surprising sometimes. For example, if renaming
		" a property or method in an interface implementation, it won't rename
		" the corresponding name in the interface definition nor in other
		" implementations. Updating the symbol from the interface will update
		" the implementations though.)
		nmap <buffer> <leader>rn <Plug>(coc-rename)

		" Display documentation for the symbol under the cursor
		nnoremap <silent><buffer> K :call CocAction('doHover')<cr>

		" Get a type-aware list of possible completions/suggestions
		inoremap <silent><buffer><expr> <C-n> coc#refresh()

		" Navigate between error diagnostics
		nmap <silent><buffer> [e <Plug>(coc-diagnostic-prev)
		nmap <silent><buffer> ]e <Plug>(coc-diagnostic-next)

		" Open up the code action menu for the a selection or motion
		xmap <buffer> <leader>a <Plug>(coc-codeaction-selected)
		nmap <buffer> <leader>a <Plug>(coc-codeaction-selected)

		" Apply a "quick fix" for the current line
		nmap <buffer> <leader>qf <Plug>(coc-fix-current)

		" Function and class text objects
		" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
		xmap if <Plug>(coc-funcobj-i)
		omap if <Plug>(coc-funcobj-i)
		xmap af <Plug>(coc-funcobj-a)
		omap af <Plug>(coc-funcobj-a)
	endfunc
end

" }}}
" junegunn/vim-easy-align {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}
" itchyny/lightline.vim {{{

let g:lightline = {
	\ 'colorscheme': 'ayu_dark',
	\ 'active': {
	\   'right': [ [ 'lineinfo' ],
	\              [ 'filetype' ] ],
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'inactive': {
	\   'left': [ [ ],
	\             [ 'filename', 'modified' ] ],
	\   'right': [ [ 'filetype' ] ]
	\ },
	\ 'enable': {
	\   'tabline': 0,
	\ },
	\ }

" }}}
" christoomey/vim-tmux-navigator {{{

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-a><C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-a><C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-a><C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-a><C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-a><C-w> :TmuxNavigatePrevious<cr>

" }}}
" vimwiki/vimwiki {{{

let g:vimwiki_list = [
	\ { 'path': '~/.local/share/vimwiki/default/', 'syntax': 'markdown' }
	\ ]

let g:vimwiki_folding = 'expr'

function! g:VimwikiRefreshIndex()
	if expand('%:t') == 'index.wiki'
		VimwikiRebuildTags
		VimwikiGenerateTagLinks
		VimwikiTOC
	endif
endfunc

autocmd BufEnter,BufWritePre * if &ft ==# 'vimwiki' | :call g:VimwikiRefreshIndex() | endif

" }}}
" nvim-telescope/telescope.nvim {{{

nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <c-p> <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fv <cmd>Telescope git_status<cr>

" }}}

" }}}
" Auto Commands {{{

autocmd BufRead,BufNewFile *.jbuilder setlocal filetype=ruby
autocmd BufRead,BufNewFile *.rasi setlocal filetype=css

autocmd FileType gitcommit setlocal spell
autocmd FileType elm,haskell setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType html,css,vue setlocal iskeyword+=-
" autocmd FileType html syntax sync fromstart

" autocmd FileType markdown Goyo
autocmd FileType markdown,rst,text,vimwiki
	\ setlocal tabstop=2 shiftwidth=2 expandtab linebreak |
	\ inoremap <buffer> <C-l> <esc>o-<space><esc>O<esc>jo<esc>kA |
	\ nnoremap <buffer> <C-l> o-<space><esc>O<esc>jo<esc>kA

" }}}
" LSP {{{

if has('nvim-0.5')
lua << EOF

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	-- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	-- I use telescope.nvim for references via. `gr` instead of this
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
	buf_set_keymap('n', '<leader>ge', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('i', '<c-n>', '<c-x><c-o>', opts)


	-- telescope.nvim mappings
	buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
end

local servers = { 'ccls', 'cssls', 'ghcide', 'html', 'pyls', 'rust_analyzer', 'vimls', 'tsserver' }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup { on_attach = on_attach }
end

EOF
end

" }}}
" Tree Sitter {{{

if has('nvim-0.5')
lua <<EOF
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		disable = { "rust" },
	},
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.typescript.used_by = "typescriptreact"

EOF
end

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" }}}
" Colorschemes {{{

" The colorscheme is set in ~/.config/nvim/custom.vim

let g:seoul256_background = 233
let g:gruvbox_contrast_dark = 'hard'
let ayucolor = 'dark'
let g:equinusocio_material_style = 'pure'
let g:srcery_inverse = 0
set background=dark

if has('nvim-0.5')
	hi EndOfBuffer guibg=NONE guifg=NONE cterm=NONE
endif

" Colorscheme list {{{

" This is outdated btw

" Favs
"   ayu
"   srcery
"   embark
"   shades_of_purple (looks bad in a lot of languages...)
"   equinusocio_material (style = 'pure' or 'darker')

" dark/chill
"   gruvbox
"   base16-darktooth
"   base16-atelier-dune (almost brown)
"   base16-codeschool
"   base16-railscasts
"   quantum (when `let g:quantum_black = 1`)
" dark/bold/high contrast
"   ayu (let ayucolor="dark")
"   base16-london-tube
"   base16-pop
"   base16-summerfruit
"   base16-molokai
" blue
"   ayu (let ayucolor="mirage")
"   base16-stelier-sulphurpool
"   base16-bespin
"   base16-flat
"   base16-materia
"   base16-solar-flare
"   base16-solarized-dark
"   mod8
"   wwdc16
"   oceanicnext
"   deep-space
"   quantum
" brown/tan
"   base16-mocha
"   base16-monokai
"   base16-eighties
"   birds-of-paradise (almost purple?)
"   peacock (folds look weird)
"   base16-unikitty-dark
" deep purple/magenta
"   base16-hopscotch
"   base16-paraiso
"   wild-cherry
"   embark
" light
"   base16-default-light
"   base16-solarized-light
"   bclear
"   hybrid
"   summerfruit256
"   xcode

" }}}

" }}}
" TODO for this file {{{

" - More helpful comments, act like this file is for someone else
" - Can I use .vimrc instead of CocConfig to set "suggestions.autoTrigger"
" - Document what isn't automated in this file (like CocInstall)
" - Anything else labeled "TODO"
" - Get a markdown viewer in vim (idk if this exists without using a browser)
"   - Zathura will update when the underlying document updates so I
"     could just regenerate it
" - Use different bindings for copying to clipboard (\ gets annoying)
" - Check this out: https://learnvimscriptthehardway.stevelosh.com/chapters/49.html
" - Can I try to fold by syntax but fallback on indent?
" - Make a snippet/shortcut for `{\n|\n},` where `|` is the cursor (and get
"   the cursor indention right. Also a version for `({ ... })`
"   - NO WAIT: change <C-l> to expand the `{}` pair anywhere on the line (or
"   find the last occurrence of `}`?
" - Only case-insensitive autocomplete in txt/md/rst???

" }}}

" Load custom config that I don't want on all machines
" TIP: use `gf` while over this path to edit it if it exists
if filereadable(expand('~/.config/nvim/custom.vim'))
	source ~/.config/nvim/custom.vim
endif

" vim:foldmethod=marker:foldlevel=0
