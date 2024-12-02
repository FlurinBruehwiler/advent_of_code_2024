package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:sort"
import "core:math"
import "core:slice"

main :: proc() {
	data, success := os.read_entire_file_from_filename("day1.txt")

	if !success {
		return
	}

	stringData := string(data)

	list1: [dynamic]int
	list2: [dynamic]int

	lines := strings.split(stringData, "\n")
	for line in lines {
		elements := strings.split(line, "   ")

		value1 := strconv.atoi(elements[0])
		value2 := strconv.atoi(elements[1])

		append(&list1, value1)
		append(&list2, value2)
	}

	slice.sort(list1[:])
	slice.sort(list2[:])

	sum : int

	for i := 0; i < len(list1); i += 1 {
		value1 := list1[i]
		value2 := list2[i]

		sum += math.abs(value1 - value2)
	}

	fmt.println(sum)
}