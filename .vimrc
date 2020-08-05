" Vim-Plug {{{

call plug#begin("~/.vim/plugged")

" Colorschemes:

Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'ronny/birds-of-paradise.vim'
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'ayu-theme/ayu-vim'
Plug 'skbolton/embark'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'srcery-colors/srcery-vim'
Plug 'chuling/equinusocio-material.vim'

" Language Specific:

Plug 'mattn/emmet-vim', { 'for': ['html', 'eruby', 'php', 'xml', 'vue', 'js'] }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'rudes/vim-java', { 'for': 'java' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': 'js' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'edwinb/idris2-vim', { 'for': 'idr' }
Plug 'pangloss/vim-javascript', { 'for': 'js' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" General:

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-sleuth'
Plug 'tomtom/tcomment_vim'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'mjbrownie/swapit'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'

call plug#end()

" }}}
" "set"-ings {{{

" Enable syntax highlighting
syntax enable

filetype plugin indent on

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

" Highlight search results
set hlsearch

" Show line numbers
set number

" Display tabs as 4 spaces
set tabstop=4

" Only redraw when necessary
set lazyredraw

" Enable folds
set foldenable

" Open folds by default when opening buffers
set foldlevelstart=99

" Determines where folds start/end using indention
set foldmethod=indent

set modeline
set modelines=1

set backspace=2

if has('termguicolors')
	set termguicolors
endif

if !has('nvim')
	try
		set cryptmethod=blowfish2
	catch
		set cryptmethod=blowfish
	endtry
endif

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
nnoremap <silent> <C-s> :set spell!<cr>

" Open ~/.vimrc in a new verical buffer
nnoremap <silent> <leader>ev :vnew ~/.vimrc<cr>

" Reload ~/.config/nvim/init.vim
nnoremap <silent> <leader>rv :source $MYVIMRC <bar> doautocmd BufRead<cr>
" nnoremap <silent> <leader>rv :source $MYVIMRC<cr>

" TODO: revise this, add Y and D and crap?
" Let <leader> + paste/cut/copy use the system clipboard
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" Remap <C-a> since that's my tmux prefix and <C-c> is useless by default
nnoremap <C-c> <C-a>

" Unhighlight all text
nnoremap <silent> <C-h> :noh<cr>

" Toggle relative line numbers (current line will always remain absolute)
nnoremap <silent> <C-q> :set relativenumber!<cr>

" Use ctrl-j and ctrl-k to navigate completion menus
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "j"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "k"

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
command! Open !xdg-open %:t

" Update my .vimrc on gist.github.com
" TODO: add a nice error msg if `gist` isn't found
command! PushVimrc !gist -u 0eceeb962ac315fc6166f0ab0cb081d0 ~/.vimrc

" Thanks to https://stackoverflow.com/a/4293538/1525759
function WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
command! WD call WriteCreatingDirs()

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

" }}}
" posva/vim-vue {{{

" Rather than loading syntax files for all preprocessors and
" trying each one, attempt to detect which need to be loaded
let g:vue_pre_processors = 'detect_on_enter'

" }}}
" preservim/nerdtree {{{

" Toggle the nerd tree view viewer
nnoremap <silent> <leader>n :NERDTreeToggle<cr>

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

 let g:coc_global_extensions = [
    \'coc-rust-analyzer',
    \'coc-tsserver',
    \'coc-vetur',
    \'coc-json',
    \'coc-java',
    \]

autocmd FileType rust,vue,typescript,json,java call s:coc_settings()

function! s:coc_settings()
	" Navigation to the definition for the symbol under the cursor
	nmap <silent><buffer> gd <Plug>(coc-definition)

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

" }}}
" junegunn/vim-easy-align {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}

" }}}
" Auto Commands {{{

autocmd BufRead,BufNewFile *.jbuilder setlocal filetype=ruby
autocmd BufRead,BufNewFile *.rasi setlocal filetype=css

autocmd FileType gitcommit setlocal spell
autocmd FileType elm,haskell setlocal tabstop=2
autocmd FileType text setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType markdown setlocal tabstop=2
autocmd FileType markdown Goyo
autocmd FileType html,css,vue setlocal iskeyword+=-
autocmd FileType html syntax sync fromstart

" }}}
" Colorschemes {{{

let g:seoul256_background = 233
let g:gruvbox_contrast_dark = 'hard'
let ayucolor = 'dark'
let g:equinusocio_material_style = 'pure'

set background=dark

color ayu

hi clear SignColumn
hi LineNr guifg=grey ctermfg=grey
hi Normal guibg=NONE ctermbg=NONE

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
" TODO for this file {{{

" - Find a way to load/source some other file for platform/computer specific stuff
"   - This may help: https://vi.stackexchange.com/a/3817/8749
" - More helpful comments, act like this file is for someone else
" - Can I use .vimrc instead of CocConfig to set "suggestions.autoTrigger"
" - Also how to automate CocInstall
" - Document what isn't automated in this file (like CocInstall)
" - Set up the ale linter for Rust, and maybe other languages too
" - Anything else labeled "TODO"
" - Get a markdown viewer in vim (idk if this exists without using a browser)
" - NERDTree open directory w/ space
" - Use different bindings for copying to clipboard (\ gets annoying)
" - Check this out: https://learnvimscriptthehardway.stevelosh.com/chapters/49.html
" - Can I try to fold by syntax but fallback on indent?
" - Something to download newest vimrc and replace the old one if there are no
"   differences between the 2nd oldest and this one? Or something at least to
"   automate that process...
" - Make a snippet/shortcut for `{\n|\n},` where `|` is the cursor (and get
"   the cursor indention right. Also a version for `({ ... })`
" - Get a haskell language server for coc.nvim

" }}}

" vim:foldmethod=marker:foldlevel=0
