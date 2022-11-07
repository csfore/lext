module main

import os

fn get_shallow(path string, common_only bool) !map[string]int {
	mut ext_map := map[string]int{}

	files := os.ls(path) or {
		eprintln('An error occurred')
		return error('Error')
	}
	for file in files {
		// println(file)
		if os.is_dir('$path/$file') {
			ext_map['dir'] += 1
			continue
		}
		ext := os.file_ext('$path/$file')

		match common_only {
			true {
				if ext in common_ext {
					ext_map[ext] += 1
				}
			}
			false {
				match ext {
					'' { ext_map['None'] += 1 }
					else { ext_map[ext] += 1 }
				}
			}
		}
	}

	println('Results:')
	for key, value in ext_map {
		println('${key:-15}$value')
	}
	return ext_map
}
