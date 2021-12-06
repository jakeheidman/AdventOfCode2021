//
//  Day6.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/6/21.
//
import Foundation

func parse_day6(input: String) -> [Int] {
    let timers: [Int] = input.components(separatedBy: ",").map({Int($0) ?? 0})
    return timers
}

func day6_part1() -> Int {
    let lanternfish: [Int] = parse_day6(input: input6)
    return simulate_lanternfish(lanternfish: lanternfish, generations: 256)
}

func simulate_lanternfish(lanternfish: [Int], generations: Int) -> Int {
    var newLanternFish: [Int] = lanternfish
    for gen in 0...generations-1 {
        print(gen)
        newLanternFish = generation_simulate(lanternfish: newLanternFish)
    }
    return newLanternFish.count
}

func generation_simulate(lanternfish: [Int]) -> [Int] {
    var updatedLanternFish = lanternfish
    var newFish: [Int] = []
    for fish in 0...lanternfish.count-1 {
        if updatedLanternFish[fish] == 0 {
            newFish.append(8)
            updatedLanternFish[fish] = 6
        }
        else {
            updatedLanternFish[fish] -= 1
        }
    }
    updatedLanternFish += newFish
    return updatedLanternFish
}
