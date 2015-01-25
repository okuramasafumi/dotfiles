"***********************
" Neocomplete configuration
"***********************

" Autocmd
augroup NeocompleteAutoCmd
  autocmd!
augroup END

" Neocomplete enabling
let g:neocomplete#enable_at_startup = 1

" Start completion with 1 char
let g:neocomplete#auto_completion_start_length = 1

" When using snippet and syntax completion starts with 2 chars
call neocomplete#custom#source(
      \'snippets_complete', 'min_pattern_length', 1)
call neocomplete#custom#source(
      \'member_complete', 'min_pattern_length', 2)
call neocomplete#custom#source(
      \'syntax_complete', 'min_pattern_length', 2)
call neocomplete#custom#source(
      \'dictionary_complete', 'min_pattern_length', 2)
call neocomplete#custom#source(
      \'buffer_complete', 'min_pattern_length', 2)

" Tag completion is too heavy...
if !exists('g:neocomplete#disabled_sources_list')
  let g:neocomplete#disabled_sources_list = {}
endif
let g:neocomplete#disabled_sources_list._ = ['tags_complete']

" Force overwrite completefunc
let g:neocomplete#force_overwrite_completefunc = 1

" Disable preset snippets
let g:neosnippet#disable_runtime_snippets = {
      \ 'ruby': 1,
      \}

" Dictionary for ruby
let g:neocomplete#dictionary_filetype_lists = {
      \'ruby' : expand('~/.vim/dictionaries/ruby.dict'),
      \ }

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Snippets directory
let g:neosnippet#snippets_directory = '~/.vim/snippets/'

" Haml as ruby
if !exists('g:neocomplete#same_filetype_lists')
  let g:neocomplete#same_filetype_lists = {}
endif
call neocomplete#set_dictionary_helper(g:neocomplete#same_filetype_lists,
      \ 'haml', 'ruby')

" Snippets editing
noremap <silent> <Leader>es :NeoSnippetEdit<CR>

" Extract snippets with <C-k>
imap <silent> <C-k> <Plug>(neosnippet_expand_or_jump)
imap <silent> <C-j> <Plug>(neosnippet_jump)

" Disable preview
set completeopt-=preview

" Define functions for various ruby files
function! s:setup_for_rspec()
  NeoCompleteSetFileType ruby.rspec
  NeoSnippetSource ~/.vim/snippets/rspec.snip
endfunction

function! s:setup_for_rails()
  NeoCompleteSetFileType ruby.rails
  NeoCompleteSyntaxMakeCache
  NeoSnippetSource ~/.vim/snippets/rails.snip
endfunction

if has('autocmd')
  " set filetype for neocomplete and load snippet
  autocmd NeocompleteAutoCmd BufEnter *_spec.rb call s:setup_for_rspec()
  autocmd NeocompleteAutoCmd BufEnter *_steps.rb call s:setup_for_rspec()
  autocmd NeocompleteAutoCmd User Rails call s:setup_for_rails()
endif
