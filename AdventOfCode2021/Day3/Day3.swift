//
//  Day3.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/3/21.
//

import Foundation

func day3_part1(binary_numbers: [String]) -> Int {
    var number_of_zeroes = Array(repeating: 0, count: binary_numbers[0].count)
    var number_of_ones = Array(repeating: 0, count: binary_numbers[0].count)
    for number in binary_numbers {
        var idx = 0
        for char in number {
            if char == "1" {
                number_of_ones[idx] += 1
            }
            else if char == "0" {
                number_of_zeroes[idx] += 1
            }
            else {
                continue
            }
            idx += 1
        }
    }
    let gamma_epsilon = find_gamma_epsilon(ones: number_of_ones, zeroes: number_of_zeroes)
    let gamma = gamma_epsilon.0
    let epsilon = gamma_epsilon.1
    return gamma * epsilon
}

func find_gamma_epsilon(ones: Array<Int>, zeroes: Array<Int>) -> (Int, Int) {
    var gamma_binary = ""
    var epsilon_binary = ""
    for index in 0...ones.count - 1 {
        if ones[index] > zeroes[index] {
            gamma_binary += "1"
            epsilon_binary += "0"
        }
        else if zeroes[index] > ones[index] {
            gamma_binary += "0"
            epsilon_binary += "1"
        }
        else {
            continue
        }
    }
    let gamma = binary_string_to_int(number: gamma_binary)
    let epsilon = binary_string_to_int(number: epsilon_binary)
    return (gamma, epsilon)
}

func binary_string_to_int(number: String) -> Int {
    var counter = 0
    var power_counter = number.count - 2
    for char in number {
        if char == "1" {
            counter += 2 << power_counter
        }
        power_counter -= 1
    }
    return counter
}

func day3_part2(binary_numbers: [String]) -> Int {
    
    let oxygen = find_oxygen_generator_rating(binary_numbers: binary_numbers, bit_index: 0)
    let co2 = find_co2_scrubber_rating(binary_numbers: binary_numbers, bit_index: 0)
    
    return oxygen * co2
}

func find_oxygen_generator_rating(binary_numbers: [String], bit_index: Int) -> Int {
    if binary_numbers.count == 1 {
        return binary_string_to_int(number: binary_numbers[0])
    }
    var one_in_bit_position: [String] = []
    var zero_in_bit_position: [String] = []
    var number_of_zeroes = 0
    var number_of_ones = 0
    for number in binary_numbers {
        let char = Array(number)[bit_index]
        if char == "1" {
            number_of_ones += 1
            one_in_bit_position.append(number)
        }
        else if char == "0" {
            number_of_zeroes += 1
            zero_in_bit_position.append(number)
        }
        else {
            continue
        }
    }
    let most_common = number_of_ones >= number_of_zeroes ? one_in_bit_position : zero_in_bit_position
    return find_oxygen_generator_rating(binary_numbers: most_common, bit_index: bit_index+1)
}

func find_co2_scrubber_rating(binary_numbers: [String], bit_index: Int) -> Int {
    if binary_numbers.count == 1 {
        return binary_string_to_int(number: binary_numbers[0])
    }
    var one_in_bit_position: [String] = []
    var zero_in_bit_position: [String] = []
    var number_of_zeroes = 0
    var number_of_ones = 0
    for number in binary_numbers {
        let char = Array(number)[bit_index]
        if char == "1" {
            number_of_ones += 1
            one_in_bit_position.append(number)
        }
        else if char == "0" {
            number_of_zeroes += 1
            zero_in_bit_position.append(number)
        }
        else {
            continue
        }
    }
    let least_common = number_of_ones >= number_of_zeroes ? zero_in_bit_position : one_in_bit_position
    return find_co2_scrubber_rating(binary_numbers: least_common, bit_index: bit_index+1)
}
