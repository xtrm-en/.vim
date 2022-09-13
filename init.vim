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
Plug 'everblush/everblush.vim'
Plug 'joshdick/onedark.vim'

" UI
Plug 'vim-utils/vim-man'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree' | 
           \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'

Plug 'vim-syntastic/syntastic'

" Plug 'christoomey/vim-tmux-navigator'
Plug 'voldikss/vim-floaterm'

call plug#end()

"" Floaterm configuration
let g:floaterm_wintype='split'
nmap <C-t> :FloatermToggle<CR>

"" NERDTree configuration

" Let cwd follow
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore = ['^node_modules$']

" Toggle
nmap <C-n> :NERDTreeToggle<CR>

" Show hidden files
let NERDTreeShowHidden=1

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

""

" Enable gcc
let g:syntastic_c_checkers = ['gcc']

let g:syntastic_python_checkers = ['pyflakes', 'pycodestyle', 'mypy']
function Py2()
  let g:syntastic_python_python_exec = '/usr/bin/python'
endfunction
function Py3()
  let g:syntastic_python_python_exec = '/usr/bin/python3'
endfunction
call Py3()   " default to Python3

let g:syntastic_aggregate_errors = 1
let g:syntastic_c_gcc_args = '-Werror -Wextra -Wall'

" Support headers (.h)
let g:c_syntax_for_h = 1
let g:syntastic_c_include_dirs = ['include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include']

" Check errors when opening a file (disable to speed up startup time)
let g:syntastic_check_on_open = 1

" Enable error list
let g:syntastic_always_populate_loc_list = 1

" Automatically open error list
let g:syntastic_auto_loc_list = 1

" Skip check when closing
let g:syntastic_check_on_wq = 0

"" Global configuration

" Theme
colorscheme everblush

" Syntax highlighting
syntax on

" TextEdit might fail if hidden is not set.
set hidden

" Position in code
set number

" Don't make noise
set visualbell

" default file encoding
if !&readonly
  set fileencoding=utf-8
endif

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
"" set expandtab NO DONT FUCKING DO THAT 

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
