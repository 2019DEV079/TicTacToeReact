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
    private let getStore: () -> StoreProtocol

    // MARK: Initializers

    init(getStore: @escaping () -> StoreProtocol) {
        self.getStore = getStore
    }

    // MARK: Custom Methods
    func didTapStart() {
        // TO DO
    }

    func getLocalizedStartButtonTitle() -> String? {
        return TranslationConstants.startButtonTitle.text
    }

    func getLocalizedTitleLabelText() -> String? {
        return TranslationConstants.titleLabelText.text
    }
}
