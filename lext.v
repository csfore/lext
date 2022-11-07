module main
import os
import flag

// file_ext
// normal: top directory
// extensive: os.walk()

fn main() {
	mut fp := flag.new_flag_parser(os.args)
    fp.application('lext')
    fp.version('v0.0.1')
    // fp.limit_free_args(0, 0)! // comment this, if you expect arbitrary texts after the options
    fp.description('This program is used to show file extension count')
    fp.skip_executable()
    recursive := fp.bool('recursive', `r`, false, 'Recursive search')
	common := fp.bool('common', `c`, false, 'Search only for common extensions')
	path := fp.string('path', `p`, '~', 'Path')

    fp.finalize() or {
        eprintln(err)
        println(fp.usage())
        return
    }
    // println('recursive $recursive || path $path')
    // println(additional_args.join_lines())
	
	if recursive {
		get_deep(path, common)!
		return
	}

	get_shallow(path, common)!
	return
}