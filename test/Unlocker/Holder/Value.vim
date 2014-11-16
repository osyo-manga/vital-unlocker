call vital#of("vital").unload()
let s:Value = vital#of("vital").import("Unlocker.Holder.Value")


function! s:test_value_dict()
	let dict = { "homu" : 42, "mami" : 42 }
	let holder = s:Value.make(dict)
	OwlCheck holder.get() == dict
	OwlCheck holder.get() is dict

	let dict.homu = 0
	OwlCheck holder.get().homu == 0

	let dict.mado = 0
	OwlCheck holder.get().mado == 0

	let tmp = holder.get()
	let tmp.mami = 0
	OwlCheck dict.mami == 0

	call holder.set({ "homu" : 42, "mami" : 42 })
	OwlCheck dict == { "homu" : 42, "mami" : 42 }
endfunction


function! s:test_value_list()
	let list = [1, 2, 3]
	let holder = s:Value.make(list)

	OwlCheck holder.get() == list
	OwlCheck holder.get() is list

	let list[0] = 10
	OwlCheck holder.get()[0] == 10

	call add(list, 42)
	OwlCheck holder.get()[3] == 42

	let tmp = holder.get()
	let tmp[1] = -1
	OwlCheck list[1] == -1
	
	call add(tmp, -42)
	OwlCheck list[-1] == -42

	call holder.set([1, 2, 3])
	OwlCheck list == [1, 2, 3]
endfunction



function! s:test_throw()
" 	OwlThrow s:Value.make(10), E605
endfunction

