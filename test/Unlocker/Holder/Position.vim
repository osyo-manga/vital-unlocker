call vital#of("vital").unload()
let s:Position = vital#of("vital").import("Unlocker.Holder.Position")


function! s:test_position()
	let pos = getpos(".")

	let holder = s:Position.make(".")
	OwlCheck holder.get() == pos

	call holder.set([0, 1, 1, 0])
	OwlCheck getpos(".") == [0, 1, 1, 0]

	call setpos(".", pos)
endfunction



