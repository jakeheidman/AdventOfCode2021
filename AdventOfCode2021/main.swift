//
//  main.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/1/21.
//

import Foundation

let test_case = """
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
""".components(separatedBy: "\n")
let i = day3_input.components(separatedBy: "\n")
print(day3_part2(binary_numbers: i))
