scriptencoding utf-8

if exists('g:loaded_comment')
  finish
endif
let g:loaded_comment= 1

let s:save_cpo = &cpo
set cpo&vim

"初期化
let b:comment_char = ''

augroup comment
    autocmd!
    autocmd FileType sh let b:comment_char = '#'
    autocmd FileType zsh let b:comment_char = '#'
    autocmd FileType vim let b:comment_char = '"'
    autocmd FileType ruby let b:comment_char = '#'
    autocmd FileType javascript let b:comment_char = '//'
augroup END

command! -range -nargs=+ Comment call comment#toggle(<f-args>)
command! -range -nargs=1 CommentOut call comment#out(<f-args>)
command! -range -nargs=1 CommentIn call comment#in(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

