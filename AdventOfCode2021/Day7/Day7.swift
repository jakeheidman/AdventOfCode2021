//
//  Day7.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/6/21.
//

import Foundation
/*
 Sorts & converts input string to [Int]
 "1,7,4,9,3" -> [1, 3, 4, 7, 9]
 */
func parse_day7(input: String) -> [Int] {
    let crabs: [Int] = input.components(separatedBy: ",").map({Int($0) ?? 0}).sorted()
    return crabs
}

/*
 Efficient implementation of Part I
 The median of a set of numbers will always minimize
 the sum of absolute deviations
 */
func day7_part1() -> Int {
    let crabs = parse_day7(input: input7)
    let alignTo = Int(calculateMedian(array: crabs))
    return calculate_static_fuel(crabs: crabs, individual: alignTo)
}

/*
 Efficient implementation of Part II
 The avg of a set is a close enough approximation of
 the sequence n*(n+1)/2, which is the dynamic fuel cost. You can
 approximate that, and then check only the avg and avg + 1 to account for rounding
 (ie if avg was 4.6 we would want to check both 4 and 5, since calculateAverage would return 4).
 */
func day7_part2() -> Int{
    let crabs = parse_day7(input: input7)
    let avg = calculateAverage(array: crabs)
    var lowestFuel = Int.max
    for alignPosition in avg...avg+1 {
        let fuel = calculate_dynamic_fuel(crabs: crabs, individual: alignPosition)
        if fuel < lowestFuel {
            lowestFuel = fuel
        }
    }
    return lowestFuel
}

/*
 returns median of sorted array
 */
func calculateMedian(array: [Int]) -> Float {
    if array.count % 2 == 0 {
        return Float((array[(array.count / 2)] + array[(array.count / 2) - 1])) / 2
    } else {
        return Float(array[(array.count - 1) / 2])
    }
}

func calculateAverage(array: [Int]) -> Int {
    return array.reduce(0, +) / array.count
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
    let bigger = original > alignTo ? original : alignTo
    while smaller != bigger {
        smaller += 1
        totalCost += stepCost
        stepCost += 1
    }
    return totalCost
}
