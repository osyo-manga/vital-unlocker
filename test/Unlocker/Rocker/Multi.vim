call vital#of("vital").unload()
let s:Rocker = vital#of("vital").import("Unlocker.Rocker")
let s:Multi = vital#of("vital").import("Unlocker.Rocker.Multi")


function! s:test_multi()
	let dict = { "homu" : 42, "mami" : 42 }
	let incsearch = &incsearch

	let locker_value = s:Rocker.value(dict)
	let locker_option = s:Rocker.option("incsearch")
	let lockers = s:Multi.make([locker_value, locker_option])
	call lockers.lock()

	let dict.homu = 0
	let dict.mami = 0
	let dict.mado = 0
	let &incsearch = !incsearch

	call lockers.unlock()

	OwlCheck dict == { "homu" : 42, "mami" : 42 }
	OwlCheck incsearch == &incsearch
endfunction

