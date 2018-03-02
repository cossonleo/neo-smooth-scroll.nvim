func Scroll_down(timer)
	call nvim_input("<c-e>")
endfunc

func Scroll_up(timer)
	call nvim_input("<c-y>")
endfunc

func Smooth_up()
	lua << EOF
	scroll = require "scroll"
	scroll.scroll_up()
EOF
endfunc

func Smooth_down()
	lua << EOF
	scroll = require "scroll"
	scroll.scroll_down()
EOF
endfunc

noremap <c-d> :call Smooth_down()<cr>
noremap <c-u> :call Smooth_up()<cr>
