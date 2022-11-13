module main

import os

// get_shallow Searches shallowly, not going into subdirectories
fn get_shallow(path string, settings int, max int) ![]Ext {
	mut ext_map := map[string]int{}
	mut ext_arr := []Ext{}

	files := os.ls(path) or {
		eprintln('An error occurred')
		return error('Error')
	}
	for file in files {
		mut ext := os.file_ext('$path/$file')
		
		// Checking if it's a directory
		if os.is_dir('$path/$file') {
			ext_map['dir/'] += 1
			continue
		}

		// Checking if the length of the name is 0
		if ext.len == 0 {
			ext_map['None'] += 1
			continue
		}

		// Checking if there's a maximum length specified,
		// If there is, then it'll truncate it to that length
		// Denoted by ending with a `#`
		if max > 0 && ext.len > max {
			ext = ext[0..max] + '#'
		}

		// Checking if the settings bit is set to 2
		if (settings & 0x2) == 2 {
			if ext in common_ext {
				ext_map[ext] += 1
			}
			continue
		}

		// Base case
		ext_map[ext] += 1
	}

	for key, value in ext_map {
		ext_arr << Ext{
			name: key
			count: value
		}
	}

	return ext_arr
}
