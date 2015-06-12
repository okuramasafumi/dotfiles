"***************************************************
" NeoBundle configuration
"***************************************************

filetype off " This is necessary

if has('vim_starting')
  set runtimepath&
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle'))


if neobundle#load_cache()
  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'Shougo/vimproc', {
        \ 'build': {
        \ 'windows': 'make -f make_mingw32.mak',
        \ 'mac': 'make -f make_mac.mak',
        \ 'unix': 'make -f make_unix.mak' } }

  " Load from TOML file
  call neobundle#load_toml(expand('~/.vim/neobundle.toml'))

  NeoBundleSaveCache
endif

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
