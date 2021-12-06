//
//  Day5.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/5/21.
//

import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

struct Line: Hashable {
    let p1: Point
    let p2: Point
    init(p1: Point, p2: Point) {
        self.p1 = p1
        self.p2 = p2
    }
}

let test_case5 = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""

func parse_day5() -> [Line] {
    var lines: [Line] = []
    let rawLines: [String] = input5.components(separatedBy: "\n") //["593,10 -> 593,98", ...]
    for line in rawLines {
        let points = line.components(separatedBy: " -> ") //["593,10", "593,98"]
        let rawP1 = points[0].components(separatedBy: ",")
        let rawP2 = points[1].components(separatedBy: ",")
        let p1X = Int(rawP1[0]) ?? 0
        let p2X = Int(rawP2[0]) ?? 0
        let p1Y = Int(rawP1[1]) ?? 0
        let p2Y = Int(rawP2[1]) ?? 0
        let p1: Point = Point(x: p1X, y: p1Y)
        let p2: Point = Point(x: p2X, y: p2Y)
        let l = Line(p1: p1, p2: p2)
        lines.append(l)
    }
    return lines
}

func create_points_in_between(p1: Point, p2: Point) -> [Point] {
    var points: [Point] = [p1, p2]
    if p1.x == p2.x {
        var highestYPoint = p1.y > p2.y ? p1 : p2
        let lowestY = p1.y > p2.y ? p2.y : p1.y
        while highestYPoint.y > lowestY + 1 {
            let newPoint = Point(x: p1.x, y: highestYPoint.y - 1)
            points.append(newPoint)
            highestYPoint = newPoint
        }
        //loop creating new points with x = p1.x and y = previous iteration - 1 until y == p1.y
        
    }
    else if p1.y == p2.y {
        var highestXPoint = p1.x > p2.x ? p1 : p2
        let lowestX = p1.x > p2.x ? p2.x : p1.x
        while highestXPoint.x > lowestX + 1 {
            let newPoint = Point(x: highestXPoint.x - 1, y: p1.y)
            points.append(newPoint)
            highestXPoint = newPoint
        }
    }
    else {
        return []
    }
    return points
}

func day5_part1() -> Int {
    let lines: [Line] = parse_day5()
    var intersectingPoints = 0
    var pointStore: [Point:Int] = [:]
    for line in lines {
        let allPointsOnLine = create_points_in_between(p1: line.p1, p2: line.p2)
        for point in allPointsOnLine {
            if let _ = pointStore[point] {
                pointStore[point]! += 1
            }
            else {
                pointStore[point] = 1
            }
        }
    }
    for key in pointStore.keys {
        if pointStore[key]! > 1 {
            intersectingPoints += 1
        }
    }
    return intersectingPoints
}
