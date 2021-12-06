//
//  Day2.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/2/21.
//

import Foundation

struct Command {
    var direction = ""
    var distance = 0
}

func parse_day2_input() -> [Command] {
    let inputList = day2_input.components(separatedBy: "\n") //["forward 2", "up 3",]
    
    return inputList.map {
                            let cmdDistancePair = $0.components(separatedBy: " ");
                            let cmd = cmdDistancePair[0];
                            let distance = Int(cmdDistancePair[1]) ?? 0;
                            return Command(direction: cmd, distance: distance)
        
                            }
}

func day2_part1(input: [Command]) -> Int {
    var horizontal = 0
    var depth = 0
    for cmd in input {
        switch cmd.direction {
        case "forward":
            horizontal += cmd.distance
        case "up":
            depth -= cmd.distance
        case "down":
            depth += cmd.distance
        default:
            continue
        
        }
    }
    return horizontal * depth
}

func day2_part2(input: [Command]) -> Int {
    var horizontal = 0
    var depth = 0
    var aim = 0
    for cmd in input {
        switch cmd.direction {
        case "forward":
            horizontal += cmd.distance
            depth += aim * cmd.distance
        case "up":
            aim -= cmd.distance
        case "down":
            aim += cmd.distance
        default: //should never trigger
            continue
        }
    }
    return horizontal * depth
}
