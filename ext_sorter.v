module main
import os
import flag

// file_ext
// normal: top directory
// extensive: os.walk()

fn main() {
	mut fp := flag.new_flag_parser(os.args)
    fp.application('sortx')
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
		get_deep(path, common)
		return
	}

	get_shallow(path, common)
	return
}

fn get_shallow(path string, common_only bool) {
	mut ext_map := map[string]int{}
	
	files := os.ls(path) or {
		eprintln('An error occurred')
		return
	}
	for file in files {
		if os.is_dir('$path/$file') {
			ext_map['dir'] += 1
			continue
		}
		ext := os.file_ext('$path/$file')
		if common_only {
			if ext in common_ext {
				ext_map[ext] += 1
			}
			continue
		}
		ext_map[ext] += 1
	}
	println('Results:')
	for key, value in ext_map {
		println('${key:-15}${value}')
	}
}

fn get_deep(path string, common_only bool) {
	mut ext_map := map[string]int{}
	mut pext_map := &ext_map

	os.walk(path, fn [mut pext_map, common_only] (file string) {
		ext := os.file_ext('$file')
		if ext == '' {
			(*pext_map)['None'] += 1
		} else {
			if common_only {
				if ext in common_ext{
					(*pext_map)[ext] += 1
				}
			} else {
				(*pext_map)[ext] += 1
			}
		}
		
	})
	mut biggest := 0
	for key,value in ext_map {
		if key.len > biggest {
			biggest = key.len
		}
		println("${key:-30}${value}")
	}
	println(biggest)
}