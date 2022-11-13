module main

fn print_sorted(ext_map map[string]int) {
	sort := sort_ext(ext_map)
	mut longest := 0
	for element in sort {
		if element.name.len > longest {
			longest = element.name.len
		}
	}
	println('${'-'.repeat(longest + 7)}')
	println('Ext.${' '.repeat(longest + 1)}#')
	println('${'-'.repeat(longest + 7)}')
	for element in sort {
		println('$element.name${' '.repeat(longest - element.name.len + 5)}$element.count')
	}
	println('Sorted through $sort.len elements')
	return
}

// fn print_tabulated(ext_map map[string]int, sorted bool) {
// 	println('${'_'.repeat(longest + 10)}')
// 	println('| Extension${' '.repeat(longest - 4)}# |')
// 	println('|${'-'.repeat(longest + 8)}|')
// 	for key, value in ext_map {
// 		// println('${key:-15}$value')
// 		println('| ${key}${' '.repeat(longest - key.len + 5)}${value} |')
// 	}
// 	println('${'-'.repeat(longest + 10)}')
// }

fn print_results(ext_map map[string]int) {
	mut longest := 0
	for key, _ in ext_map {
		if key.len > longest {
			longest = key.len
		}
	}
	println('${'-'.repeat(longest + 7)}')
	println('Ext.${' '.repeat(longest + 1)}#')
	println('${'-'.repeat(longest + 7)}')
	for key, value in ext_map {
		println('$key${' '.repeat(longest - key.len + 5)}$value')
	}
}