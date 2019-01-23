//
//  GameState.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift

struct GameState: StateType {
    var currentPlayer: String?
}

extension GameState: Equatable {
    
    static func == (lhs: GameState, rhs: GameState) -> Bool {
        return lhs.currentPlayer == rhs.currentPlayer
    }
}
