module main

import os

fn print_sorted(mut ext_arr []Ext) []string {
	mut sorted := []string{}
	sort := sort_ext(mut ext_arr)
	longest := get_longest(ext_arr)

	println('${'-'.repeat(longest + 7)}')
	println('Ext.${' '.repeat(longest + 1)}#')
	println('${'-'.repeat(longest + 7)}')
	for element in sort {
		sorted << '$element.name${' '.repeat(longest - element.name.len + 5)}$element.count'
	}
	return sorted
}

fn print_tabulated(ext_arr []Ext) {
	longest := get_longest(ext_arr)

	println('${'_'.repeat(longest + 10)}')
	println('| Extension${' '.repeat(longest - 4)}# |')
	println('|${'-'.repeat(longest + 8)}|')
	for entry in ext_arr {
		// println('${key:-15}$value')
		println('| $entry.name${' '.repeat(longest - entry.name.len + 5)}$entry.count |')
	}
	println('${'-'.repeat(longest + 10)}')
}

fn print_results(ext_arr []Ext) {
	longest := get_longest(ext_arr)

	println('${'-'.repeat(longest + 7)}')
	println('Ext.${' '.repeat(longest + 1)}#')
	println('${'-'.repeat(longest + 7)}')
	for entry in ext_arr {
		println('$entry.name${' '.repeat(longest - entry.name.len + 5)}$entry.count')
	}
}

// write_output Writes the output to a file
fn write_output(path string, ext_arr []Ext) ! {
	if os.exists(path) {
		os.rm(path)!
	}
	mut out_file := os.open_append(path)!
	for entry in ext_arr {
		out_string := '${entry.name:-15}$entry.count\n'
		out_file.write_string(out_string)!
	}
}
