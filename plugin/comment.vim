scriptencoding utf-8

if exists('g:loaded_comment')
  finish
endif
let g:loaded_comment= 1

let s:save_cpo = &cpo
set cpo&vim

augroup comment
    autocmd!
    autocmd FileType vim let b:comment_out_line = '"'
    autocmd FileType ruby let b:comment_out_line = '#'
    autocmd FileType javascript let b:comment_out_line = '//'
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo

