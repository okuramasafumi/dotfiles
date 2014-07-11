"***********************
" Unite.vim configuration
"***********************

" Autocmd for unite
augroup UniteAutoCmd
  autocmd!
augroup END

" Unite.vim keymappings
" Unite prefix
nnoremap [Unite] <Nop>
nmap <Leader>u [Unite]

" Open buffers
nnoremap [Unite]b :<C-u>Unite buffer -no-start-insert<CR>

" Open files
nnoremap [Unite]f :<C-u>Unite file file/new<CR>

" Open project files
nnoremap [Unite]u :<C-u>Unite file_rec/async<CR>

" Open recently-opened files
nnoremap [Unite]l :<C-u>Unite file_mru<CR>

" Open all
nnoremap [Unite]a :<C-u>Unite buffer file file_mru file_rec/async<CR>

" Open tags
nnoremap [Unite]t :<C-u>Unite tag<CR>

" Open outline
nnoremap [Unite]o :<C-u>Unite outline<CR>

" Open completion candidates
nnoremap [Unite]c :<C-u>Unite neocomplcache<CR>
inoremap <C-x>c <ESC>:<C-u>Unite neocomplcache<CR>

" Create new file
nnoremap [Unite]n :<C-u>Unite file/new<CR>

" Open register
nnoremap [Unite]r :<C-u>Unite register<CR>

" Start insert-mode when opening unite.vim
let g:unite_enable_start_insert=1

" Ignore stuffs for rails
call unite#custom_source('file_rec/async', 'ignore_pattern', 'assets/fonts\|assets/images\|vendor/bundle')

" Cache
let g:unite_source_rec_max_cache_files=10000
let g:unite_source_rec_min_cache_files=10

autocmd UniteAutoCmd FileType unite call s:unite_my_configuration()
function! s:unite_my_configuration()

  " Open source with horizontally-splited window
  nnoremap <silent> <buffer> <expr> s unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-S> unite#do_action('split')

  " Open source with vertically-splited window
  nnoremap <silent> <buffer> <expr> v unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-V> unite#do_action('vsplit')

  " Open source with new tab
  nnoremap <silent> <buffer> <expr> t unite#do_action('tabopen')
  inoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')

  " Dig into directory
  nnoremap <silent> <buffer> <expr> r unite#do_action('rec/async')
  inoremap <silent> <buffer> <expr> <C-R> unite#do_action('rec/async')

  " Exit unite with escape
  nmap <silent> <buffer> <ESC> <Plug>(unite_exit)
  imap <silent> <buffer> <ESC><ESC> <ESC><Plug>(unite_exit)

  " Close unite with <C-q>
  imap <silent> <buffer> <C-q> <ESC><Plug>(unite_all_exit)
endfunction

autocmd User Rails call s:unite_rails_configuration()
function! s:unite_rails_configuration()
  nnoremap <buffer> [Unite]v :<C-u>Unite rails/view<CR>
  nnoremap <buffer> [Unite]m :<C-u>Unite rails/model<CR>
  nnoremap <buffer> [Unite]c :<C-u>Unite rails/controller<CR>
  nnoremap <buffer> [Unite]g :<C-u>Unite rails/config<CR>
  nnoremap <buffer> [Unite]s :<C-u>Unite rails/spec<CR>
  nnoremap <buffer> [Unite]k          :<C-u>Unite rails/rake<CR>
endfunction

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup'
  let g:unite_source_grep_max_candidate = 1000
end
