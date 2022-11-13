module main

import os
import flag
// test
// main Entry point
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
	// println(max)
	if os.args.len > 1 && os.is_dir(os.args[1]) {
		path = os.args[1]
	}

	mut settings := parse_settings(recursive, common, sorted, tab)

	mut ext_map := map[string]int{}
	if recursive {
		ext_map = get_deep(path, settings, max)!
	} else {
		ext_map = get_shallow(path, settings, max)!
	}
	if output != '' {
		write_output(output, ext_map)!
	}

	if sorted {
		print_sorted(ext_map)
	}
	print_results(ext_map)
	
	// println(settings)
	// sets := [0x8, 0x4, 0x2, 0x1]
	// for val in sets {
	// 	println('Settings: $settings')
	// 	settings -= val
	// }
	// println(path)
	return
}

fn parse_settings(recursive bool, common bool, sorted bool, tab bool) int {
	settings := {
		'recursive': 0x1
		'common': 0x2
		'sorted': 0x4
		'tabd': 0x8
	}

	options := {
		'recursive': recursive
		'common': common
		'sorted': sorted
		'tabd': tab
	}

	mut set_val := 0
	// println(settings)
	for key,value in options {
		if value == true {
			set_val |= settings[key]
		}
		// set_val |= value
	}
	return set_val
}

/*
Table code for later
println('${'_'.repeat(longest + 10)}')
println('| Extension${' '.repeat(longest - 4)}# |')
println('|${'-'.repeat(longest + 8)}|')
for key, value in ext_map {
	// println('${key:-15}$value')
	println('| ${key}${' '.repeat(longest - key.len + 5)}${value} |')
}
println('${'-'.repeat(longest + 10)}')
*/

// write_output Writes the output to a file
fn write_output(path string, ext_map map[string]int) ! {
	if os.exists(path) {
		os.rm(path)!
	}
	mut out_file := os.open_append(path)!
	for key, value in ext_map {
		out_string := '${key:-15}$value\n'
		out_file.write_string(out_string)!
	}
}
