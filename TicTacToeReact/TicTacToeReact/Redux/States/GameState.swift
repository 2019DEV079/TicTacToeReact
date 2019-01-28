//
//  GameState.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift

enum GameStatus {
    case started, active, draw, ended
}

struct GameState: StateType {
    var currentPlayer: String?
    var gameStatus: GameStatus?
    var currentCellSelected: BoardCell?
    var winner: String?
}

extension GameState: Equatable {
    
    static func == (lhs: GameState, rhs: GameState) -> Bool {
        return lhs.currentPlayer == rhs.currentPlayer &&
            lhs.gameStatus == rhs.gameStatus &&
            lhs.currentCellSelected == rhs.currentCellSelected &&
            lhs.winner == rhs.winner
    }
}
