//
//  Day1.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/2/21.
//

import Foundation


func parse_input(input: String) -> [String] {
    return input.components(separatedBy: "\n")
}
func part1(input: String) -> Int {
    let number_list = parse_input(input: input)
    var counter = 0
    for index in 0...(number_list.count - 2) {
        if Int(number_list[index]) ?? 0 < Int(number_list[index+1]) ?? 0 {
            counter += 1
        }
    }
    return counter
}

func part2(input: String) -> Int {
    let number_list = parse_input(input: input)
    var counter = -1
    var prev_sliding_window = 0
    for index in 1...(number_list.count - 2) {
        let prev = Int(number_list[index-1]) ?? 0
        let current = Int(number_list[index]) ?? 0
        let next = Int(number_list[index+1]) ?? 0
        let sliding_window = prev + current + next
        if sliding_window > prev_sliding_window {
            counter += 1
        }
        prev_sliding_window = sliding_window
    }
    return counter
}
