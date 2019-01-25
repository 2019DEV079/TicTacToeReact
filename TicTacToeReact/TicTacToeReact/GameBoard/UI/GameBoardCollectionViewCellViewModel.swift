//
//  GameBoardCollectionViewCellViewModel.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 24/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

class GameBoardCollectionViewCellViewModel {
    var mark: String?

    func markedBy(player: String) {
        switch player {
        case "player 1": mark = "O"
        case "player 2": mark = "X"
        default: return
        }
    }

    func selected() -> String? {
        return mark
    }
}
