set nocompatible					"Always use vim instead of vi.
syntax enable
set autowriteall					"Always save files when switching buffers.

"-----General Settings------"
set backspace=indent,eol,start  			"Make backspaces work.
let mapleader = ','					"Change the default leader to a comma.
set number                                              "Activate line-numbers.
set encoding=utf-8                                      "Standard encoding

"Tabsettings
set tabstop=8
set expandtab                                           "Use spaces
set softtabstop=4
set shiftwidth=4

"-----Visuals-----"
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'soft'

set t_CO=256 						"Use 256 colors. Good for terminal vim.
set guifont=Fira_Code:h12
set macligatures
set linespace=13					"Macvim specific line-height.

set guioptions-=l					"Set of options to remove scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=e 					"Disable gui tabs

set showtabline=2 					"Always show tabs.

"------Search---------"
set hlsearch
set incsearch

"-----Mappings--------"
"Vimrc shortcode, you will live here
nmap <Leader>ev :e $MYVIMRC<cr>

"stop search highlight
nmap <Leader><space> :nohlsearch<cr>

"Remap split moving windows
nmap <C-J> <C-W><C-J>					
nmap <C-J> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"go to defination
nmap <Leader>f :tag<cr>

"-----Auto-Commands------"

"Automatically source the vimrc file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"Trigger php-cs-fixer on save.
augroup phpfixing
	autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
augroup END

"------Plugins-----"
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'stephpy/vim-php-cs-fixer'

call plug#end()

"--------Plugin-settings-------"

"CtrlP
set wildignore+=*/tmp/*,*.so,*.swp     " Linux/MacOSX
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'

nmap <D-p> :CtrlP<cr>
"Search based on the tag inside a file
nmap <C-r> :CtrlPBufTag<cr>
"Most recently used files.
nmap <D-e> :CtrlPMRUFiles<cr>

"" The Silver Searcher
if executable('ag')
	
  let g:ackprg = 'ag --vimgrep'      
" Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"NerdTree
let NERDTreeHijackNetrw = 0
"Toggle sidebar
nmap <Leader>1 :NERDTreeToggle<cr>

"Php-cs fixer
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
let g:php_cs_fixer_config_file = '.php_cs' " options: --config
let g:php_cs_fixer_php_path = '~/.composer/vendor/bin/php-cs-fixer'