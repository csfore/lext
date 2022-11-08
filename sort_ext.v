module main

struct Pair {
	key   string
	value int
}

fn sort_ext(ext_map map[string]int) map[string]int {
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
	// for key,value in ext_map {
	// 	if value > biggest {
	// 		biggest = value
	// 		sorted_map[key] = value
	// 	} else if value == biggest {
	// 		sorted_map[key] = value
	// 	}
	// }
	return sorted_map
}

fn print_sorted(ext_map map[string]int) {
	sorted := sort_ext(ext_map)
	for key, value in sorted {
		println('${key:-15}$value')
	}
}
