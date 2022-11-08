module main

struct Ext {
	name string
	count int
}

// sort_ext Sorts an extension map and returns the sorted map of it
fn sort_ext(ext_map map[string]int) []Ext {
	// I know this isn't efficient but speed shouldn't be an issue for a while
	mut sorted_map := map[string]int{}

	mut ext_arr := []Ext

	for key,value in ext_map {
		ext_arr << Ext{
			name: key
			count: value
		}
	}
	quicksort(mut ext_arr, 0, ext_arr.len - 1)
	return ext_arr
}

fn quicksort(mut alist []Ext, first int, last int) {
	if first < last {
		splitpoint := partition(mut alist, first, last)

		quicksort(mut alist, first, splitpoint - 1)
		quicksort(mut alist, splitpoint+1, last)
	}
}

fn partition(mut alist []Ext, first int, last int) int {
	pivotvalue := alist[first].count

	mut leftmark := first+1
	mut rightmark := last

	mut done := false

	for !done {
		for leftmark <= rightmark && alist[leftmark].count <= pivotvalue {
			leftmark += 1
		}

		for alist[rightmark].count >= pivotvalue && rightmark >= leftmark {
			rightmark -= 1
		}

		if rightmark < leftmark {
			done = true
		} else {
			mut temp := alist[leftmark]
			alist[leftmark]= alist[rightmark]
			alist[rightmark] = temp
		}
	}

	temp := alist[first]
	alist[first] = alist[rightmark]
	alist[rightmark] = temp
	
	return rightmark
}