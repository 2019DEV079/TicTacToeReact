//
//  Actions.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift

struct StartGameAction: Action {}

struct UpdateGameStatusAction: Action {
    let status: GameStatus
}

struct UpdatePlayerTurnAction: Action {
    let player: String
}

struct BoardCellSelectionAction: Action {
    let boardCell: BoardCell
}

struct UpdateBoardUIAction: Action {
    let player: String
    let indexPath: IndexPath
}

struct EndGameAction: Action {
    let message: String
}
