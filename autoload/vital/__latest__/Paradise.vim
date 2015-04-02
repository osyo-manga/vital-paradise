scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:get2char(...)
	let mode = get(a:, 1, 0)
	while 1
		" Workaround for https://github.com/osyo-manga/vital-over/issues/53
		try
			let char = call("getchar", a:000)
		catch /^Vim:Interrupt$/
			let char = 3 " <C-c>
		endtry
		" Workaround for the <expr> mappings
		if string(char) !=# "\x80\xfd`"
			return mode == 1 ? !!char
\				 : type(char) == type(0) ? nr2char(char) : char
		endif
	endwhile
endfunction


function! s:silent_feedkeys(expr, ...)
	let mode = get(a:, 1, "m")
	let name = "vital_paradise_silent_feedkeys"
	let map = printf("<Plug>(%s)", name)
	if mode == "n"
		let command = "nnoremap"
	else
		let command = "nmap"
	endif
	execute command "<silent>" map printf("%s:nunmap %s<CR>", a:expr, map)
	call feedkeys(printf("\<Plug>(%s)", name))
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
