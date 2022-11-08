module main

// sort_ext Sorts an extension map and returns the sorted map of it
fn sort_ext(ext_map map[string]int) map[string]int {
	// I know this isn't efficient but speed shouldn't be an issue for a while
	mut sorted_map := map[string]int{}

	mut index := 0
	for index <= ext_map.len {
		for key, value in ext_map {
			if value != index {
				continue
			}
			sorted_map[key] = index
		}
		index++
	}
	return sorted_map
}

// print_sorted Prints the sorted extension map
fn print_sorted(ext_map map[string]int) {
	sorted := sort_ext(ext_map)
	for key, value in sorted {
		println('${key:-15}$value')
	}
}
