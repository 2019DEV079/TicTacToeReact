//
//  GameManager.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 25/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import RxSwift

protocol GameManagerProtocol {}

final class GameManager {

    // MARK: Properties

    private let getStore: () -> StoreProtocol
    private let disposeBag = DisposeBag()
    private lazy var gameStateObservable: Observable<GameState> = self.createGameStateObservable()

    private var currentPlayer: String?
    private var selectedBoardCell: BoardCell?
    private var gameStatus: GameStatus?

    // MARK: Initializers

    init(getStore: @escaping () -> StoreProtocol) {
        self.getStore = getStore

        gameStateObservable
            .subscribe(onNext: { [weak self] gameState in
                guard let `self` = self else { return }
                // TO DO
            }).disposed(by: disposeBag)
    }

    // MARK: Creation of Observables

    private func createGameStateObservable() -> Observable<GameState> {
        return getStore().observable.asObservable()
            .map { $0.gameState }
            .unwrap()
            .distinctUntilChanged()
    }
}
