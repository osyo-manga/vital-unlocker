call vital#of("vital").unload()
let s:File = vital#of("vital").import("Unlocker.Holder.File")


function! s:test_file()
	let File = s:File
	let file = "test.txt"

	OwlCheck !File.is_makeable(file)

	let holder = s:File.make(file)
	OwlCheck !File.is_makeable(file)

	call holder.set(["homu", "mamu", "mado"])
	OwlCheck File.is_makeable(file)
	OwlCheck readfile(file) == ["homu", "mamu", "mado"]
	OwlCheck readfile(file) == holder.get()

	call delete(file)
endfunction


