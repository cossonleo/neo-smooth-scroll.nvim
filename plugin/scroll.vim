""""""""""""""""""""""""""""""""""""""""""
"    LICENSE: MIT
"     Author: Cosson2017
"    Version: 0.2
" CreateTime: 2018-03-02 18:11:09
" LastUpdate: 2018-03-05 13:20:09
"       Desc: vim function offer to lua
""""""""""""""""""""""""""""""""""""""""""

func! Scroll_down(timer)
	call nvim_input("<c-e>")
endfunc

func! Scroll_up(timer)
	call nvim_input("<c-y>")
endfunc

func! Smooth_up()
	lua << EOF
	scroll = require "scroll"
	scroll.scroll_up()
EOF
endfunc

func! Smooth_down()
	lua << EOF
	scroll = require "scroll"
	scroll.scroll_down()
EOF
endfunc

noremap <silent> <c-d> :call Smooth_down()<cr>
noremap <silent> <c-u> :call Smooth_up()<cr>
