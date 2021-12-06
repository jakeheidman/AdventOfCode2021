//
//  Day3.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/3/21.
//

import Foundation

func day3_part1(binaryNumbers: [String]) -> Int {
    var numberOfZeroes = Array(repeating: 0, count: binaryNumbers[0].count)
    var numberOfOnes = Array(repeating: 0, count: binaryNumbers[0].count)
    for number in binaryNumbers {
        var idx = 0
        for char in number {
            if char == "1" {
                numberOfOnes[idx] += 1
            }
            else if char == "0" {
                numberOfZeroes[idx] += 1
            }
            else {
                continue
            }
            idx += 1
        }
    }
    let gammaEpsilon = find_gamma_epsilon(ones: numberOfOnes, zeroes: numberOfZeroes)
    let gamma = gammaEpsilon.0
    let epsilon = gammaEpsilon.1
    return gamma * epsilon
}

func find_gamma_epsilon(ones: Array<Int>, zeroes: Array<Int>) -> (Int, Int) {
    var gammaBinary = ""
    var epsilonBinary = ""
    for index in 0...ones.count - 1 {
        if ones[index] > zeroes[index] {
            gammaBinary += "1"
            epsilonBinary += "0"
        }
        else if zeroes[index] > ones[index] {
            gammaBinary += "0"
            epsilonBinary += "1"
        }
        else {
            continue
        }
    }
    let gamma = binary_string_to_int(number: gammaBinary)
    let epsilon = binary_string_to_int(number: epsilonBinary)
    return (gamma, epsilon)
}

func binary_string_to_int(number: String) -> Int {
    var counter = 0
    var powerCounter = number.count - 2
    for char in number {
        if char == "1" {
            counter += 2 << powerCounter
        }
        powerCounter -= 1
    }
    return counter
}

func day3_part2(binaryNumbers: [String]) -> Int {
    
    let oxygen = find_oxygen_generator_rating(binaryNumbers: binaryNumbers, bitIndex: 0)
    let co2 = find_co2_scrubber_rating(binaryNumbers: binaryNumbers, bitIndex: 0)
    
    return oxygen * co2
}

func find_oxygen_generator_rating(binaryNumbers: [String], bitIndex: Int) -> Int {
    if binaryNumbers.count == 1 {
        return binary_string_to_int(number: binaryNumbers[0])
    }
    var oneInBitPosition: [String] = []
    var zeroInBitPosition: [String] = []
    var numZeroes = 0
    var numOnes = 0
    for number in binaryNumbers {
        let char = Array(number)[bitIndex]
        if char == "1" {
            numOnes += 1
            oneInBitPosition.append(number)
        }
        else if char == "0" {
            numZeroes += 1
            zeroInBitPosition.append(number)
        }
        else {
            continue
        }
    }
    let most_common = numOnes >= numZeroes ? oneInBitPosition : zeroInBitPosition
    return find_oxygen_generator_rating(binaryNumbers: most_common, bitIndex: bitIndex+1)
}

func find_co2_scrubber_rating(binaryNumbers: [String], bitIndex: Int) -> Int {
    if binaryNumbers.count == 1 {
        return binary_string_to_int(number: binaryNumbers[0])
    }
    var oneInBitPosition: [String] = []
    var zeroInBitPosition: [String] = []
    var numZeroes = 0
    var numOnes = 0
    for number in binaryNumbers {
        let char = Array(number)[bitIndex]
        if char == "1" {
            numOnes += 1
            oneInBitPosition.append(number)
        }
        else if char == "0" {
            numZeroes += 1
            zeroInBitPosition.append(number)
        }
        else {
            continue
        }
    }
    let leastCommon = numOnes >= numZeroes ? zeroInBitPosition : oneInBitPosition
    return find_co2_scrubber_rating(binaryNumbers: leastCommon, bitIndex: bitIndex+1)
}
