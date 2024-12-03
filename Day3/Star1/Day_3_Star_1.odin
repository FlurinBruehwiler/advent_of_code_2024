package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:sort"
import "core:math"
import "core:slice"

main :: proc() {
	data, success := os.read_entire_file_from_filename("../day3.txt")

	if !success {
		fmt.println("Error reading file")
		return
	}

	stringData := string(data)
	total := 0

	isEnabled := true

	for {
		nextIndex, len := strings.index_multi(stringData, []string{"mul(", "do()", "don't()"})
		if nextIndex == -1{
			break
		}

		start := stringData[nextIndex:]
		stringData = stringData[nextIndex + len:]

		if(strings.starts_with(start, "don't()")){
			isEnabled = false
		}else if (strings.starts_with(start, "do()")){
			isEnabled = true
		}
		else if(isEnabled){
			str := stringData

			num1, res1 := eatNum(&str)
			res2 := eatRune(&str, ',')
			num2, res3 := eatNum(&str)
			res4 := eatRune(&str, ')')

			if !res1 || !res2 || !res3 || !res4 {
				continue
			}
			total += num1 * num2;
		}
	}	

	fmt.println(total)
}

eatRune :: proc(str : ^string, charToEat: u8) -> bool {
	if len(str) == 0{
		return false
	}

	if str[0] != charToEat {
		return false
	}

	str^ = str[1:]
	return true
}

eatNum :: proc(str: ^string) -> (int, bool) {
	for i := 0; i < len(str); i += 1 {
		if str[i] < 48 || str[i] > 57 {
			if i == 0 {
				return 0, false
			}

			num := strconv.atoi(str[:i])
			str^ = str[i:]
			return num, true
		}
	}
	return 0, false
}