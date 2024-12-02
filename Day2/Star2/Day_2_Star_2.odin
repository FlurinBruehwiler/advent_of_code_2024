package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:sort"
import "core:math"
import "core:slice"

main :: proc() {
	data, success := os.read_entire_file_from_filename("../day2.txt")

	if !success {
		fmt.println("Error reading file")
		return
	}

	stringData := string(data)

	saveCount := 0;

	reports := strings.split(stringData, "\n")
	for report in reports {
		levels := strings.split(report, " ")
		
		for i in -1..<len(levels) {
			if(isSave(levels, i)){
				saveCount += 1
				break;
			}	
		}
	}

	fmt.println(saveCount)
}

isSave :: proc(levels: []string, indexToIgnore: int) -> bool{

	previousValue := strconv.atoi(levels[0]) 
	direction : f32 = 0
	startIndex := 1

	if(indexToIgnore == 0){
		previousValue = strconv.atoi(levels[1])
		startIndex = 2
	}

	for i := startIndex; i < len(levels); i += 1 {

		if(indexToIgnore == i){
			continue
		}

		currentValue := strconv.atoi(levels[i])
		diff := math.abs(previousValue - currentValue);
		if(diff < 1 || diff > 3){
			return false
		}

		sign := math.sign(f32(previousValue - currentValue))
		if(direction == 0){
			direction = sign
		}else{
			if(direction != sign){
				return false
			}
		}

		previousValue = currentValue;
	}
	return true
}