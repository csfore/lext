module main

fn test_get_deep() {
	mut sum := 0
	deep := get_deep('test/', false, 0)?

	for _,value in deep {
		sum += value
	}

	expected := 4
	assert expected == sum
}

fn test_get_deep_common() {
	mut sum := 0
	deep := get_deep('test/', true, 0)?
	println(deep)

	for _,value in deep {
		sum += value
	}

	expected := 2
	assert expected == sum
}