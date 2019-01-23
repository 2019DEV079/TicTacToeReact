//
//  MainReducer.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift

final class MainReducer {
    private let gameReducer: Reducer<GameState>
    
    init(gameReducer: @escaping Reducer<GameState>) {
        self.gameReducer = gameReducer
    }
    
    func handleAction(_ action: Action, _ state: MainState?) -> MainState {
        let state = state ?? MainReducer.initialState
        
        return MainState(gameState: gameReducer(action, state.gameState))
    }
    
    static var initialState: MainState {
        return MainState()
    }
}
