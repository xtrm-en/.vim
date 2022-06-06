"" Install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" Auto-update plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"" Plugins block
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Themes
Plug 'joshdick/onedark.vim'
Plug 'everblush/everblush.vim'

" UI
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'

Plug 'christoomey/vim-tmux-navigator'
Plug 'voldikss/vim-floaterm'

" Code
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'weirongxu/coc-kotlin'
Plug 'udalov/kotlin-vim'

" Other
Plug 'vbe0201/vimdiscord'
Plug 'wakatime/vim-wakatime'

call plug#end()

"" Floaterm configuration
nmap <C-t> :FloatermToggle<CR>

"" COC configuration
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-java',
  \ 'coc-git',
  \ 'coc-markdownlint',
  \ 'coc-markdown-preview-enhanced',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-tailwindcss',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"" NERDTree configuration

" Let cwd follow
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore = ['^node_modules$']

nmap <C-n> :NERDTreeToggle<CR>

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

"" Global configuration

" Get syntax files from config folder
set runtimepath+=~/.config/nvim/syntax

" Theme
colorscheme everblush

" Syntax highlighting
syntax on

" TextEdit might fail if hidden is not set.
set hidden

" Position in code
set number relativenumber
set ruler

" Don't make noise
set visualbell

" default file encoding
set encoding=utf-8

" Enable autocompletion:
set wildmode=longest,list,full

" Line wrap
set nowrap

" Highlight search results
set hlsearch
set incsearch

" Indent
filetype plugin indent on
set smarttab
set tabstop=4
set shiftwidth=4

" always uses spaces instead of tab characters
set expandtab

" Mouse support
set mouse=a

" disable backup files
set nobackup
set nowritebackup

" no delays!
set updatetime=300

set shortmess+=c

set signcolumn=no

" Give more space for displaying messages.
set cmdheight=2
