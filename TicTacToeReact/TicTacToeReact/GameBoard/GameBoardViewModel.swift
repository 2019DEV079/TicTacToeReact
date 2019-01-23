//
//  GameBoardViewModel.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

protocol GameBoardViewModelDelegate: class {
    
}

class GameBoardViewModel {
    
    // MARK: Properties
    
    var delegate: GameBoardViewModelDelegate?
    
}
