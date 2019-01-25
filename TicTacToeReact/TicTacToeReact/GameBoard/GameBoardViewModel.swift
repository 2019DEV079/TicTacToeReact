//
//  GameBoardViewModel.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift
import RxSwift
import RxCocoa

protocol GameBoardViewModelDelegate: class {
    
}

class GameBoardViewModel {
    
    // MARK: Properties

    var delegate: GameBoardViewModelDelegate?
    private let getStore: () -> StoreProtocol
    private let disposeBag = DisposeBag()

    private let boardCells: [[BoardCell]] = [
        [.topLeft, .topMiddle, .topRight],
        [.secondLeft, .secondMiddle, .secondRight],
        [.bottomLeft, .bottomMiddle, .bottomRight]
    ]

    lazy var gameStatusObservable: Observable<GameStatus?> = createGameStatusObervable()
    lazy var currentPlayerObservable: Observable<String?> = createCurrentPlayerObervable()

    // MARK: Initializers

    init(getStore: @escaping () -> StoreProtocol) {
        self.getStore = getStore
        gameStatusObservable.subscribe(onNext: { [weak self] gameStatus in
            guard let `self` = self else { return }
            if let status = gameStatus, status == .started {
                self.startGame()
            }
        }).disposed(by: disposeBag)
    }

    // MARK: Creation of Observables

    func createGameStatusObervable() -> Observable<GameStatus?> {
        return getStore().observable.asObservable()
            .map { $0.gameState }
            .unwrap()
            .distinctUntilChanged()
            .map { $0.gameStatus }
            .distinctUntilChanged { $0 == $1 }
            .map { $0 }
    }

    func createCurrentPlayerObervable() -> Observable<String?> {
        return getStore().observable.asObservable()
            .map { $0.gameState }
            .unwrap()
            .distinctUntilChanged()
            .map { $0.currentPlayer }
            .distinctUntilChanged { $0 == $1 }
            .map { $0 }
    }

    // MARK: Custom Methods
    func didTapStart() {
        let action = StartGameAction()
        getStore().dispatch(action)
    }

    func getLocalizedStartButtonTitle() -> String? {
        return TranslationConstants.startButtonTitle.text
    }

    func getLocalizedTitleLabelText() -> String? {
        return TranslationConstants.titleLabelText.text
    }

    func boardCellSelectedAt(_ indexPath: IndexPath) {
        let boardCell = boardCells[indexPath.section][indexPath.row]
        let action = BoardCellSelectionAction(boardCell: boardCell)
        getStore().dispatch(action)
    }

    private func startGame() {
        let action = UpdatePlayerTurnAction(player: "player 1")
        getStore().dispatch(action)
    }
}
