call vital#of("vital").unload()
let s:Rocker = vital#of("vital").import("Unlocker.Rocker")
let s:Holder = vital#of("vital").import("Unlocker.Holder")


function! s:test_value()
	let dict = { "homu" : 42, "mami" : 42 }
	let locker = s:Rocker.value(dict).lock()
	let dict.homu = 0
	let dict.mami = 0
	let dict.mado = 0
	call locker.unlock()
	OwlCheck dict == { "homu" : 42, "mami" : 42 }
endfunction


function! s:test_variable()
	let g:coaster_rocker_variable_test_variable = 42
	let locker = s:Rocker.variable("g:coaster_rocker_variable_test_variable").lock()
	let g:coaster_rocker_variable_test_variable = 0
	call locker.unlock()
	OwlCheck g:coaster_rocker_variable_test_variable == 42
	unlet g:coaster_rocker_variable_test_variable
endfunction


function! s:test_any()
	let dict = { "homu" : 42, "mami" : 42 }
	
	let locker = s:Rocker.any(dict).lock()

	let dict.homu = 0
	let dict.mami = 0
	let dict.mado = 0

	call locker.unlock()
	OwlCheck dict == { "homu" : 42, "mami" : 42 }

	let incsearch = &incsearch
	let locker = s:Rocker.any("incsearch")
	call locker.lock()

	let &incsearch = !incsearch

	call locker.unlock()

	OwlCheck &incsearch == incsearch

	let modifiable = &modifiable

	let locker = s:Rocker.any("&modifiable")
	call locker.lock()

	let &modifiable = !modifiable

	call locker.unlock()

	OwlCheck &modifiable == modifiable
endfunction


function! s:test_lock_local_value()
	let homu = 42
	let mami = -1
	let locker = s:Rocker.lock(l:)
	let homu = 0
	let mami = 0
	let mado = 0
	call locker.unlock()
	OwlCheck homu == 42
	OwlCheck mami == -1
	OwlCheck !exists("mado")
endfunction


function! s:test_lock_set_get()
	let holder = { "value" : { "value" : 42 } }

	function! holder.get()
		return self.value.value
	endfunction

	function! holder.set(value)
		let self.value.value = a:value
	endfunction

	let locker = s:Rocker.lock(holder)
	let holder.value.value = 0
	call locker.unlock()
	echo holder.value.value
	echo holder
	OwlCheck holder.value.value == 42

endfunction


function! s:test_as_locker()
	let Rocker = s:Rocker
	let locker = Rocker.as_locker(s:Holder.value({}))
	OwlCheck Rocker.is_locker(locker)
	OwlCheck Rocker.as_locker(locker) is locker
endfunction


function! s:test_lock_locker()
	let file = "text.txt"
	call writefile(["homu", "mami", "mado"], file)

	let locker = s:Rocker.lock(s:Rocker.file(file))

	call writefile(["homu"], file)
	OwlCheck readfile(file) != ["homu", "mami", "mado"]

	call locker.unlock()
	OwlCheck readfile(file) == ["homu", "mami", "mado"]

	call delete(file)
endfunction


function! s:test_lock()
	let dict = { "homu" : 42, "mami" : 42 }
	let incsearch = &incsearch
	let modifiable = &modifiable
	
	let lockers = s:Rocker.lock(dict, "incsearch", "&modifiable")

	let dict.homu = 0
	let dict.mami = 0
	let dict.mado = 0
	let &incsearch = !incsearch
	let &modifiable = !modifiable

	call lockers.unlock()

	OwlCheck dict == { "homu" : 42, "mami" : 42 }
	OwlCheck &incsearch == incsearch
	OwlCheck &modifiable == modifiable
endfunction
