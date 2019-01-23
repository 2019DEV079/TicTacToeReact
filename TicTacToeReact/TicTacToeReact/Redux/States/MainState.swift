//
//  MainState.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift

struct MainState: StateType {
    var gameState: GameState?
}

extension MainState: Equatable {
    
    static func == (lhs: MainState, rhs: MainState) -> Bool {
        return lhs.gameState == rhs.gameState
    }
}
