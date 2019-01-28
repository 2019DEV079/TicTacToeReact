//
//  GameBoardCollectionViewCellViewModel.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 24/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import RxSwift

class GameBoardCollectionViewCellViewModel {

    // MARK: Properties

    private let getStore: () -> StoreProtocol
    private let disposeBag = DisposeBag()

    lazy var gameStatusObservable: Observable<GameStatus?> = createGameStatusObervable()
    private let indexPath: IndexPath
    let mark: Observable<String?>

    // MARK: Initializers

    init(getStore: @escaping () -> StoreProtocol, indexPath: IndexPath) {
        self.getStore = getStore
        self.indexPath = indexPath

        let currentScreenStateObservable = getStore().observable.asObservable()
            .map { $0.currentScreenState }
            .unwrap()
            .distinctUntilChanged()

        self.mark = currentScreenStateObservable
            .filter { $0.indexPath! == indexPath }
            .map { $0.mark }
    }

    // MARK: Creation of Observables

    private func createGameStatusObervable() -> Observable<GameStatus?> {
        return getStore().observable.asObservable()
            .map { $0.gameState }
            .unwrap()
            .distinctUntilChanged()
            .map { $0.gameStatus }
            .distinctUntilChanged { $0 == $1 }
            .map { $0 }
    }
}
