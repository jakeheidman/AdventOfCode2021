//
//  BingoBoard.swift
//  AdventOfCode2021
//
//  Created by Jake Heidman on 12/4/21.
//

import Foundation

class Bingo {
    var boardSize: Int = 5
    var board: [[(String, Bool)]]
    init(boardInput: String) {
        let newBoard = parse_board_input(input: boardInput)
        self.board = newBoard
    }
    func is_bingo() -> Bool {
        for index in 0...boardSize-1 {
            if horizontal_bingo(index: index) {
                return true
            }
            else if vertical_bingo(index: index) {
                    return true
                }
            else {
                continue
            }
        }
        if diagonal_bingo() {
            return true
        }
        else {
            return false
        }

    }

    func horizontal_bingo(index: Int) -> Bool {
        return board[index].reduce(true, {x, y in
            x && (y.1)
        })
    }

    func vertical_bingo(index: Int) -> Bool {
        for row in 0...boardSize-1 {
            if board[row][index].1 == false {
                return false
            }
        }
        return true
    }

    func diagonal_bingo() -> Bool {
        var left_to_right = true
        var right_to_left = true
        for idx in 0...boardSize-1 {
            if board[idx][idx].1 == false {
                left_to_right = false
                break
            }
        }
        for idx in 0...boardSize-1 {
            if board[idx][boardSize-idx-1].1 == false {
                right_to_left = false
                break
            }
        }
        return left_to_right || right_to_left
    }

    func apply_piece(piece: String) -> Bool {
        for column in 0...boardSize-1 {
            for row in 0...boardSize-1 {
                if board[column][row].0 == piece {
                    board[column][row].1 = true
                    return true
                }
            }
        }
        return false
    }

    func calculate_score(numberCalled: String) -> Int {
        var unmarked = 0
        for column in 0...boardSize-1 {
            for row in 0...boardSize-1 {
                if board[column][row].1 == false {
                    unmarked += Int(board[column][row].0) ?? 0
                }
            }
        }
        let number = Int(numberCalled) ?? 0
        return unmarked * number
    }

}
