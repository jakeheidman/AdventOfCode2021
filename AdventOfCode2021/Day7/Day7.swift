//
//  Day7.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/6/21.
//

import Foundation

func parse_day7(input: String) -> [Int] {
    let crabs: [Int] = input.components(separatedBy: ",").map({Int($0) ?? 0}).sorted()
    return crabs
}

func day7_part1() -> Int {
    let crabs = parse_day7(input: input7)
    var lowest_fuel = Int.max
    for c in crabs {
        let alignToC = calculate_static_fuel(crabs: crabs, individual: c)
        if alignToC < lowest_fuel {
            lowest_fuel = alignToC
        }
    }
    return lowest_fuel
}

func day7_part2() -> Int {
    let crabs = parse_day7(input: input7)
    var lowest_fuel = Int.max
    for c in crabs[0]...crabs[crabs.count-1] {
        let alignToC = calculate_dynamic_fuel(crabs: crabs, individual: c)
        if alignToC < lowest_fuel {
            lowest_fuel = alignToC
        }
    }
    return lowest_fuel
}

func calculate_static_fuel(crabs: [Int], individual: Int) -> Int {
    var fuel = 0
    for c in crabs {
        let fuelDifference = abs(c - individual)
        fuel += fuelDifference
    }
    return fuel
}

func calculate_dynamic_fuel(crabs: [Int], individual: Int) -> Int {
    var fuel = 0
    for c in crabs {
        fuel += dynamicAlignCost(original: c, alignTo: individual)
    }
    return fuel
}

func dynamicAlignCost(original: Int, alignTo: Int) -> Int {
    var totalCost = 0
    var stepCost = 1
    var smaller = original > alignTo ? alignTo : original
    var bigger = original > alignTo ? original : alignTo
    while smaller != bigger {
        smaller += 1
        totalCost += stepCost
        stepCost += 1
    }
    return totalCost
}
