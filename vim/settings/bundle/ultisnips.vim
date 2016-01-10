let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

if has('autocmd')
  autocmd BufNewFile,BufRead *_spec.rb UltiSnipsAddFiletypes ruby.rspec
endif
