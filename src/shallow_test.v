module main

fn test_get_shallow() {
	shallow := get_shallow('test/', 0x0, 0)?
	println(shallow)
	assert shallow.len == 3
}

fn test_get_shallow_common() {
	shallow := get_shallow('test/', 0x2, 0)?
	println(shallow)
	assert shallow.len == 2
}
