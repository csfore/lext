module main

fn get_longest(ext_arr []Ext) int {
	mut longest := 0
	for entry in ext_arr {
		if entry.name.len > longest {
			longest = entry.name.len
		}
	}

	return longest
}
