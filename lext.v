module main

import os
import flag

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('lext')
	fp.version('v0.1.0')
	// fp.limit_free_args(0, 0)! // comment this, if you expect arbitrary texts after the options
	fp.description('This program is used to show file extension count')
	fp.skip_executable()
	recursive := fp.bool('recursive', `r`, false, 'Recursive search')
	common := fp.bool('common', `c`, false, 'Search only for common extensions')
	output := fp.string('output', `o`, '', 'Output text to a file')
	path := fp.string('path', `p`, '~', 'Path')

	fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
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

	return
}

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
