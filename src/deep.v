module main

import os

// get_deep Searches deep, recursively searching
fn get_deep(path string, settings int, max int) ![]Ext {
	mut ext_map := map[string]int{}
	mut pext_map := &ext_map

	os.walk(path, fn [mut pext_map, settings, max] (file string) {
		mut ext := os.file_ext(file)
		
		// Checking for a max string value
		if max > 0 && ext.len > max {
			ext = ext[0..max + 1] + '#'
		}

		// Checking if the length of the extension is 0
		if ext.len == 0 {
			(*pext_map)['None'] += 1
			return
		} 

		// Making sure the common bit is set to 2
		if (settings & 0x2) == 2 {
			// Checking if the extension is in the common array
			if ext in common_ext {
				(*pext_map)[ext] += 1
			}
			return
		}

		// Base case
		(*pext_map)[ext] += 1
	})

	mut ext_arr := []Ext{}

	for key, value in ext_map {
		ext_arr << Ext{
			name: key
			count: value
		}
	}

	return ext_arr
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
