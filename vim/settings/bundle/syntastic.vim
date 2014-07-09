"************************
" Syntastic configuration
"************************
let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': ['ruby', 'html', 'haml', 'javascript',
      \ 'sass', 'scss'],
      \ 'passive_filetypes': []}

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages={ 'level': 'warnings' }
