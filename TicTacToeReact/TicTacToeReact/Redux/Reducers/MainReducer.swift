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
    private let currentScreenReducer: Reducer<CurrentScreenState>
    
    init(gameReducer: @escaping Reducer<GameState>, currentScreenReducer: @escaping Reducer<CurrentScreenState>) {
        self.gameReducer = gameReducer
        self.currentScreenReducer = currentScreenReducer
    }
    
    func handleAction(_ action: Action, _ state: MainState?) -> MainState {
        let state = state ?? MainReducer.initialState
        
        return MainState(gameState: gameReducer(action, state.gameState), currentScreenState: currentScreenReducer(action, state.currentScreenState))
    }
    
    static var initialState: MainState {
        return MainState()
    }
}
