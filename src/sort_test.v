module main

fn test_sort() {
	mut to_sort := {
		'a': 1,
		'c': 3,
		'b': 2
	}

	result := sort_ext(to_sort)

	expected := [Ext{name: 'a', count: 1}, Ext{name: 'b', count: 2}, Ext{name: 'c', count: 3}]

	assert expected == result
}