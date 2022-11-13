module main

import os
import flag
// test
// main Entry point

struct Ext {
	name string
mut:
	count int
}

struct Test {
	name  string
	count int
}

const (
	recursive_bit = 0x1
	common_bit    = 0x2
	sorted_bit    = 0x4
	tabd_bit      = 0x8
)

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('lext')
	fp.version('v0.1.0')
	fp.usage_examples = ['[options] [ARGS]', '[path]']
	// fp.limit_free_args(0, 0)! // comment this, if you expect arbitrary texts after the options
	fp.description('Show many files have an extension, option to sort and recursively search')
	fp.skip_executable()
	recursive := fp.bool('recursive', `r`, false, 'Recursive search')
	common := fp.bool('common', `c`, false, 'Search only for common extensions (Negates `-m` flag)')
	sorted := fp.bool('sorted', `s`, false, 'Sort the values (low => high)')
	output := fp.string('output', `o`, '', 'Output text to a file')
	mut path := fp.string('path', `p`, '.', 'Path to search for extensions (defaults to `.`)')
	max := fp.int('max', `m`, 0, 'Define the max amount of characters to display, denoted by a `#` (0 is default)')
	tab := fp.bool('tabulated', `t`, false, 'Prints it in tabulated format (Not recommended for large datasets)')

	fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}

	// Allowing usage of `lext /path/to/search` rather than explicitly needing
	// to use the `-p` flag
	if os.args.len > 1 && os.is_dir(os.args[1]) {
		path = os.args[1]
	}

	mut settings := parse_settings(recursive, common, sorted, tab)

	mut ext_arr := []Ext{}

	// Checking if the recursive bit is on
	if (settings & recursive_bit) == 1 {
		ext_arr = get_deep(path, settings, max)!
	} else {
		ext_arr = get_shallow(path, settings, max)!
	}

	// Checking if the output length is more than 0,
	// If it is then it'll attempt the write_output function
	if output.len > 0 {
		write_output(output, ext_arr)!
	}

	// Checking if the sorted bit is on
	if (settings & sorted_bit) == 4 {
		results := print_sorted(mut ext_arr).join('\n')
		println(results)

		println('Sorted through $results.len elements')
		return
	}

	if (settings & tabd_bit) == 8 {
		print_tabulated(ext_arr)
		return
	}

	print_results(ext_arr)
	// mut test := []Test{}

	// for key, value in ext_map {
	// 	test << Test{
	// 		name: key
	// 		count: value
	// 	}
	// }
	// println(test)
	return
}

fn parse_settings(recursive bool, common bool, sorted bool, tab bool) int {
	settings := {
		'recursive': recursive_bit
		'common':    common_bit
		'sorted':    sorted_bit
		'tabd':      tabd_bit
	}

	options := {
		'recursive': recursive
		'common':    common
		'sorted':    sorted
		'tabd':      tab
	}

	mut set_val := 0
	// println(settings)
	for key, value in options {
		if value == true {
			set_val |= settings[key]
		}
		// set_val |= value
	}
	return set_val
}

fn get_longest(ext_arr []Ext) int {
	mut longest := 0
	for entry in ext_arr {
		if entry.name.len > longest {
			longest = entry.name.len
		}
	}

	return longest
}

fn bad() {
	var := 0
	badvar := 1
	formatting := 'formatting'
}
