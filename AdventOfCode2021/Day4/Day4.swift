//
//  Day4.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/4/21.
//

import Foundation
extension String {
    func removingLeadingSpaces() -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
}

let test_case = """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
"""

func parse_day4() -> ([String], [Bingo])  {
    let separatedInput = input4.components(separatedBy: "\n\n")
    let rawMoveList = separatedInput[0]
    let moveList = rawMoveList.components(separatedBy: ",")
    let rawBoards = Array(separatedInput[1...separatedInput.count-1])
    var boards: [Bingo] = []
    for rb in rawBoards {
        let board = Bingo(boardInput: rb)
        boards.append(board)
    }
    return (moveList, boards)
}

/*
 @param input: newline terminated board
 3 4 5
 1 45 22,
 21 90 720
 */
func parse_board_input(input: String) -> [[(String, Bool)]] {
    let lines = input.components(separatedBy: "\n")
    let removeLeadingWhitespace = lines.map({$0.removingLeadingSpaces()})
    let removeDoubleSpaces: [String] = removeLeadingWhitespace.map({$0.replacingOccurrences(of: "  ", with: " ")})
    let rawBoard: [[String]] = removeDoubleSpaces.map({$0.components(separatedBy: " ")})
    let finishedBoard = rawBoard.map({$0.map({($0, false)})})
    return finishedBoard
}

func day4_part1() -> Int {
    let bingoGame = parse_day4()
    let moveList = bingoGame.0
    var boards = bingoGame.1
    for move in moveList {
        for board in boards {
            if board.apply_piece(piece: move) && board.is_bingo() {
                return board.calculate_score(numberCalled: move)
            }
        }
    }
    return 0
}

func day4_part2() -> Int {
    let bingoGame = parse_day4()
    let moveList = bingoGame.0
    var boards = bingoGame.1
    for move in moveList {
        var counter = 0
        for board in boards {
            if board.apply_piece(piece: move) && board.is_bingo() {
                if boards.count != 1 {
                    boards.remove(at: counter)
                    counter -= 1
                }
                else {
                    return board.calculate_score(numberCalled: move)
                }
            }
            counter += 1
        }
    }
    return 0
}

