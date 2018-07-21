" To load the defaults, following two lines are necessary in vim.
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set mouse=a " To enable scrolling with mouse.
set clipboard=unnamedplus " All yanked stuff is pasted to clipboard too. This works on Ubuntu and not on mac.
" set clipboard=unnamed " Same as previous. This works on Mac and not ubuntu

" Navigate panes.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

