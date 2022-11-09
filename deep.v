module main

import os

// get_deep Searches deep, recursively searching
fn get_deep(path string, common_only bool) !map[string]int {
	mut ext_map := map[string]int{}
	mut pext_map := &ext_map

	os.walk(path, fn [mut pext_map, common_only] (file string) {
		ext := os.file_ext('$file')
		if ext == '' {
			(*pext_map)['None'] += 1
		} else {
			if common_only {
				if ext in common_ext {
					(*pext_map)[ext] += 1
				}
			} else {
				(*pext_map)[ext] += 1
			}
		}
	})
	return ext_map
}

/*
mut biggest := 0
	for key, value in ext_map {
		if key.len > biggest {
			biggest = key.len
		}
		println('${key:-30}${value:-10}')
	}
*/
