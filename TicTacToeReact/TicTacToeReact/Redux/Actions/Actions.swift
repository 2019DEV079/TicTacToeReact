//
//  Actions.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift

struct StartGameAction: Action {}

struct UpdatePlayerTurnAction: Action {
    let player: String
}

struct BoardCellSelectionAction: Action {
    let boardCell: BoardCell
}
