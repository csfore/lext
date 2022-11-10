module main

import os

// get_shallow Searches shallowly, not going into subdirectories
fn get_shallow(path string, common_only bool, max int) !map[string]int {
	mut ext_map := map[string]int{}

	files := os.ls(path) or {
		eprintln('An error occurred')
		return error('Error')
	}
	for file in files {
		// println(file)
		if os.is_dir('$path/$file') {
			ext_map['dir/'] += 1
			continue
		}
		mut ext := os.file_ext('$path/$file')
		
		if max > 0 && ext.len > max {
			ext = ext[0..max + 1] + '#'
		}

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

	return ext_map
}
