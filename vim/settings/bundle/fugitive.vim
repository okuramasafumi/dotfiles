"******************
" Fugitive configuration
"******************

" Fugitive key mappings
" Fugitive prefix
nnoremap [Fugitive] <Nop>
nmap <Leader>g [Fugitive]

nnoremap [Fugitive]d :<C-u>Gdiff<CR>
nnoremap [Fugitive]s :<C-u>Gstatus<CR>
nnoremap [Fugitive]l :<C-u>Glog<CR>
nnoremap [Fugitive]a :<C-u>Gwrite<CR>
nnoremap [Fugitive]c :<C-u>Gcommit<CR>
nnoremap [Fugitive]C :<C-u>Gcommit --amend<CR>
nnoremap [Fugitive]b :<C-u>Gblame<CR>
