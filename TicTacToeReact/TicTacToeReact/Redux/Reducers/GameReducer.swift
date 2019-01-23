//
//  GameReducer.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift

final class GameReducer {
    
    func handleAction(action: Action, state: GameState?) -> GameState {
        var state = state ?? GameReducer.initialState
        
        switch action {
        case let action as UpdatePlayerTurnAction:
            state = GameReducer.handleUpdatePlayerTurnAction(action: action, state: state)
        default:
            break
        }
        return state
    }
    
    static var initialState: GameState {
        return GameState()
    }
    
    private static func handleUpdatePlayerTurnAction(action: UpdatePlayerTurnAction, state: GameState?) -> GameState {
        var state = state ?? GameReducer.initialState
        state.currentPlayer = action.player
        return state
    }
}
