module main

import os
import flag

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
	common := fp.bool('common', `c`, false, 'Search only for common extensions')
	sorted := fp.bool('sorted', `s`, false, 'Sort the values (low => high)')
	output := fp.string('output', `o`, '', 'Output text to a file')
	mut path := fp.string('path', `p`, '.', 'Path to search for extensions (defaults to `.`)')

	fp.finalize() or {
        eprintln(err)
        println(fp.usage())
        return
    }
	
	if os.args.len > 1 && os.is_dir(os.args[1]) {
		path = os.args[1]
	}

	mut ext_map := map[string]int{}
	if recursive {
		ext_map = get_deep(path, common)!
	} else {
		ext_map = get_shallow(path, common)!
	}
	if output != '' {
		write_output(output, ext_map)!
	}

	// println('Results:')
	match sorted {
		true {
			sort := sort_ext(ext_map)
			mut longest := 0
			for element in sort {
				if element.name.len > longest {
					longest = element.name.len
				}
			}
			println('${'-'.repeat(longest + 7)}')
			println('Extension${' '.repeat(longest - 4)}#')
			println('${'-'.repeat(longest + 7)}')
			for element in sort {
				println('$element.name${' '.repeat(longest - element.name.len + 5)}$element.count')
			}
			println('Sorted through $sort.len elements')
		}
		false {
			mut longest := 0
			for key, _ in ext_map {
				if key.len > longest {
					longest = key.len
				}
			}
			println('Extension${' '.repeat(longest - 4)}#')
			for key, value in ext_map {
				println('$key${' '.repeat(longest - key.len + 5)}$value')
			}
		}
	}
	// println(path)
	return
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
