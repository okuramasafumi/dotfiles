"************************
" Rails.vim configuration
"************************

" Key mappings
nnoremap [Rails] <Nop>
function! s:RailsConfigration()
  nmap <Leader>r [Rails]

  nnoremap [Rails]m :<C-u>Emodel<space>
  nnoremap [Rails]c :<C-u>Econtroller<space>
  nnoremap [Rails]v :<C-u>Eview<space>
  nnoremap [Rails]s :<C-u>Espec<space>

  nnoremap [Rails]sm :<C-u>Smodel<space>
  nnoremap [Rails]sc :<C-u>Scontroller<space>
  nnoremap [Rails]sv :<C-u>Sview<space>
  nnoremap [Rails]ss :<C-u>Sspec<space>

  nnoremap [Rails]vm :<C-u>Vmodel<space>
  nnoremap [Rails]vc :<C-u>Vcontroller<space>
  nnoremap [Rails]vv :<C-u>Vview<space>
  nnoremap [Rails]vs :<C-u>Vspec<space>

  nnoremap [Rails]tm :<C-u>Tmodel<space>
  nnoremap [Rails]tc :<C-u>Tcontroller<space>
  nnoremap [Rails]tv :<C-u>Tview<space>
  nnoremap [Rails]ts :<C-u>Tspec<space>
endfunction

if has("autocmd")
  autocmd User Rails call s:RailsConfigration()
  autocmd User Rails DashKeywords rails rubygems ruby
endif

" Rails.vim projections
" Require vim-bundler
let g:rails_gem_projections = {
      \ "carrierwave": {
      \   "app/uploaders/*_uploader.rb": {
      \     "command": "uploader",
      \     "template":
      \       "class %SUploader < CarrierWave::Uploader::Base\nend",
      \     "test": "spec/models/%s_uploader_spec.rb",
      \     "related": "app/models/images/%s.rb",
      \     "keywords": "process version"
      \ }},
      \ "paper_trail": {
      \   "app/models/*.rb": {
      \     "keywords": "has_paper_trail"}},
      \ "squeel":{
      \   "app/models/*.rb": {
      \     "keywords": "sifter"}},
      \ "sidekiq": {
      \   "app/workers/*.rb": {
      \     "command": "worker",
      \     "template": "class %SWorker\n  include Sidekiq::Worker\nend",
      \     "keywords": "sidekiq_options"}}}

let g:rails_projections = {
      \ "app/forms/*_form.rb": {
      \   "command": "form",
      \   "test": "spec/forms/%s_form_spec.rb" },
      \ "app/presenters/*_presenter.rb": {
      \   "command": "presenter",
      \   "test": "spec/presenters/%s_presenter_spec.rb"},
      \ "app/services/*.rb": {
      \   "command": "service",
      \   "test": "spec/services/%s_spec.rb" }
      \ }
