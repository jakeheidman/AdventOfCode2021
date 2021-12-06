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
    let numberList = parse_input(input: input)
    var counter = 0
    for index in 0...(numberList.count - 2) {
        if Int(numberList[index]) ?? 0 < Int(numberList[index+1]) ?? 0 {
            counter += 1
        }
    }
    return counter
}

func part2(input: String) -> Int {
    let numberList = parse_input(input: input)
    var counter = -1
    var prevSlidingWindow = 0
    for index in 1...(numberList.count - 2) {
        let prev = Int(numberList[index-1]) ?? 0
        let current = Int(numberList[index]) ?? 0
        let next = Int(numberList[index+1]) ?? 0
        let slidingWindow = prev + current + next
        if slidingWindow > prevSlidingWindow {
            counter += 1
        }
        prevSlidingWindow = slidingWindow
    }
    return counter
}
