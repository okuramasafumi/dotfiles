"***************************************************
" NeoBundle configuration
"***************************************************

filetype off " This is necessary

if has('vim_starting')
  set runtimepath&
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build': {
      \ 'windows': 'make -f make_mingw32.mak',
      \ 'mac': 'make -f make_mac.mak',
      \ 'unix': 'make -f make_unix.mak' } }

NeoBundle 'Shougo/neocomplete', { 'rev': 'ver.1.2' }
NeoBundle 'Shougo/neosnippet', {
      \ 'depends': 'Shougo/neocomplete'}
NeoBundle 'Shougo/unite.vim', { 'rev': 'ver.6.1' }
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'Shougo/unite-outline', { 'depends': 'Shougo/unite.vim' }

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-dispatch'
NeoBundleLazy 'tpope/vim-haml', { 'autoload': { 'filetypes': ['haml'] } }

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'

NeoBundle 'nelstrom/vim-visual-star-search'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-qfreplace'

NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-textobj-user'
NeoBundleLazy 'rhysd/vim-textobj-ruby', {
      \ 'depends': 'kana/vim-textobj-user',
      \ 'autoload': { 'filetypes': 'ruby' } }

NeoBundle 'tsukkee/unite-tag', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'basyura/unite-rails', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'Lokaltog/vim-easymotion', { 'rev': 'v2.1.0' }
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'rking/ag.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'szw/vim-tags'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'rodjek/vim-puppet'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'gregsexton/gitv'
NeoBundle 'Rykka/colorv.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'skwp/vim-rspec', { 'autoload': { 'filetypes': 'ruby' } }

NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'ZoomWin'
NeoBundle 'sudo.vim'
NeoBundle 'taglist.vim'

" End
call neobundle#end()

" Required
filetype plugin indent on

" Check all bundles are installed
NeoBundleCheck

" Call hook when reloading this file
if !has('vim_starting')
  call neobundle#call_hook('on_source')
endif
