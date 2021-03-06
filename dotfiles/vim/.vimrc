" To load the defaults, following two lines are necessary in vim.
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set mouse=a " To enable scrolling with mouse.
set clipboard=unnamedplus " All yanked stuff is pasted to clipboard too. This works on Ubuntu and not on mac.
" set clipboard=unnamed " Same as previous. This works on Mac and not ubuntu

" So clipboard is not cleared on vim exit
" autocmd VimLeave * call system("xsel -ib", getreg('+')) 
" autocmd VimLeave * call system("xclip -o | xclip -selection c")

" #################### Vundle ###########################
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'python-mode/python-mode'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" #################### Vundle end ######################

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" " when indenting with '>', use 4 spaces width
set shiftwidth=2
" " On pressing tab, insert 4 spaces
set expandtab

