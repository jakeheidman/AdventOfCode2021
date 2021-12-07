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
/*
 Efficient implementation of Part I
 The median of a set of numbers will always minimize
 the sum of absolute deviations
 */
func day7_part1_efficient() -> Int {
    let crabs = parse_day7(input: input7)
    let alignTo = Int(calculateMedian(array: crabs))
    return calculate_static_fuel(crabs: crabs, individual: alignTo)
}
/*
 Efficient implementation of Part II
 The avg of a set is a close enough approximation of
 the sequence n*(n+1)/2, which is the dynamic fuel cost. You can
 approximate that, and then check the averages neighbors to account for
 rounding to an integer to find the lowest cost.
 */
func day7_part2_efficient() -> Int{
    let crabs = parse_day7(input: input7)
    let avg = calculateAverage(array: crabs)
    var lowestFuel = Int.max
    for alignPosition in avg-1...avg+1 {
        let fuel = calculate_dynamic_fuel(crabs: crabs, individual: alignPosition)
        if fuel < lowestFuel {
            lowestFuel = fuel
        }
    }
    return lowestFuel
}

func calculateMedian(array: [Int]) -> Float {
    let sorted = array.sorted()
    if sorted.count % 2 == 0 {
        return Float((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
    } else {
        return Float(sorted[(sorted.count - 1) / 2])
    }
}

func calculateAverage(array: [Int]) -> Int {
    return array.reduce(0, +) / array.count
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
