//
//  CurrentScreenReducer.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 27/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift

final class CurrentScreenReducer {
    func handleAction(action: Action, state: CurrentScreenState?) -> CurrentScreenState {
        var state = state ?? CurrentScreenReducer.initialState

        switch action {
        case let action as UpdateBoardUIAction:
            state = CurrentScreenReducer.handleUpdateBoardUIAction(action: action, state: state)
        case let action as StartGameAction:
            state = CurrentScreenReducer.handleStartGameAction(action: action, state: state)
        default:
            break
        }
        return state
    }

    static var initialState: CurrentScreenState {
        return CurrentScreenState()
    }

    private static func handleUpdateBoardUIAction(action: UpdateBoardUIAction, state: CurrentScreenState?) -> CurrentScreenState {
        var state = state ?? CurrentScreenReducer.initialState
        state.indexPath = action.indexPath
        state.mark = action.player == "player 1" ? "X" : "O"
        return state
    }

    private static func handleStartGameAction(action: StartGameAction, state: CurrentScreenState?) -> CurrentScreenState {
        let state = CurrentScreenReducer.initialState
        return state
    }
}
