
call plug#begin()
Plug 'https://github.com/enml/nord-vim.git'
Plug 'https://github.com/itchyny/vim-cursorword.git'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/vim-slash'
Plug 'Tsuzat/NeoSolarized.nvim', { 'branch': 'master' }
Plug 'majutsushi/tagbar'
Plug 'mzlogin/vim-markdown-toc'
Plug 'iamcco/markdown-preview.nvim'
Plug 'SirVer/ultisnips'
Plug '907th/vim-auto-save'
call plug#end()


colorscheme default

set clipboard^=unnamed,unnamedplus
set number
set noerrorbells
set nocompatible
syntax on
set showcmd
set mouse=a
set t_Co=256
filetype indent on
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set cursorline
set linebreak
set wrapmargin=2
set scrolloff=10
set laststatus=2
set ruler
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoread
set wildmenu
set wildmode=longest:list,full
let mapleader = " "  
map <leader>e :NERDTreeToggle<CR>
map <C-s> :w<CR>



let g:vim_markdown_math = 1

"激活tagbar扩展
let g:airline#extensions#tagbar#enabled = 1

"设置tagber对于markdown的支持
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Chapter',
        \ 'i:Section',
        \ 'k:Paragraph',
        \ 'j:Subparagraph'
    \ ]
\ }




"设置tab键为触发键
let g:UltiSnipsExpandTrigger = '<tab>'
"设置向后跳转键
let g:UltiSnipsJumpForwardTrigger = '<tab>' 
"设置向前跳转键
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>' 
"设置文件目录
let g:UltiSnipsSnippetDirectories=["path/of/snippetDirectories"]
"设置打开配置文件时为垂直打开
let g:UltiSnipsEditSplit="vertical"


let g:auto_save_events = ["InsertLeave", "TextChanged"]



