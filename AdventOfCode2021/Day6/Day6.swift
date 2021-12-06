//
//  Day6.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/6/21.
//
import Foundation

//func parse_day6(input: String) -> [Int] {
//    let timers: [Int] = input.components(separatedBy: ",").map({Int($0) ?? 0})
//    return timers
//}
/*
 @param input: "3,4,1,2,1,2,2,4,0"
 @return fish: number of fish of each age, where age is the index [1, 2, 3, 1, 2]
 (1 age 0 fish, 2 age 1 fish, etc
 */
func parse_day6(input: String) -> [Int] {
    let timers: [Int] = input.components(separatedBy: ",").map({Int($0) ?? 0})
    var fish = [Int](repeating: 0, count: 9)
    for f in timers {
        fish[f] += 1
    }
    return fish
}

func day6_part1() -> Int {
    let lanternfish: [Int] = parse_day6(input: input6)
    return simulate_generations(lanternfish: lanternfish, generations: 80)
}

func day6_part2() -> Int {
    let lanternfish: [Int] = parse_day6(input: input6)
    return simulate_generations(lanternfish: lanternfish, generations: 256)
}

func simulate_generations(lanternfish: [Int], generations: Int) -> Int {
    var currentGeneration = lanternfish
    for _ in 1...generations {
        var updatedGeneration = [Int](repeating: 0, count: 9)
        //spawn new fish from gen 0
        updatedGeneration[8] += currentGeneration[0]
        updatedGeneration[6] += currentGeneration[0]
        
        //loop through ages 1-8
        for idx in 0...currentGeneration.count - 2 {
            updatedGeneration[idx] += currentGeneration[idx+1]
        }
        currentGeneration = updatedGeneration
    }
    return currentGeneration.reduce(0, +)
}
