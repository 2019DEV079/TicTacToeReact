//
//  GameManager.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 25/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import RxSwift

protocol GameManagerProtocol {}

final class GameManager: GameManagerProtocol {

    // MARK: Properties
    typealias WinCondition = [BoardCell]

    private let getStore: () -> StoreProtocol
    private let disposeBag = DisposeBag()
    private lazy var gameStatusObservable: Observable<GameStatus> = self.createGameStatusObservable()
    private lazy var gameBoardObservable: Observable<BoardCell> = self.createGameBoardObservable()

    private var currentPlayer: String?

    private var playerOneSelected: [BoardCell] = []
    private var playerTwoSelected: [BoardCell] = []

    private let boardCellToIndexPath: [BoardCell: IndexPath] = [
       .topLeft : IndexPath(row: 0, section: 0),
       .topMiddle: IndexPath(row: 1, section: 0),
       .topRight: IndexPath(row: 2, section: 0),
       .secondLeft: IndexPath(row: 0, section: 1),
       .secondMiddle: IndexPath(row: 1, section: 1),
       .secondRight: IndexPath(row: 2, section: 1),
       .bottomLeft: IndexPath(row: 0, section: 2),
       .bottomMiddle: IndexPath(row: 1, section: 2),
       .bottomRight: IndexPath(row: 2, section: 2),
    ]

    private let winConditions: [WinCondition] = [
        [.topLeft, .topMiddle, .topRight],
        [.secondLeft, .secondMiddle, .secondRight],
        [.bottomLeft, .bottomMiddle, .bottomRight],
        [.topLeft, .secondLeft, .bottomLeft],
        [.topMiddle, .secondMiddle, .bottomMiddle],
        [.topRight, .secondRight, .bottomRight],
        [.topLeft, .secondMiddle, .bottomRight],
        [.bottomLeft, .secondMiddle, .topRight]
    ]

    // MARK: Initializers

    init(getStore: @escaping () -> StoreProtocol) {
        self.getStore = getStore

        gameStatusObservable
            .subscribe(onNext: { [weak self] gameStatus in
                guard let `self` = self else { return }
                self.handleNextStepFor(gameStatus: gameStatus)
            }).disposed(by: disposeBag)
        gameBoardObservable
            .subscribe(onNext: { [weak self] boardCell in
                guard let `self` = self else { return }
                self.handleGameBoardStatusForSelectedBoardCell(boardCell)
            }).disposed(by: disposeBag)
    }

     //MARK: Creation of Observables

    private func createGameStatusObservable() -> Observable<GameStatus> {
        return getStore().observable.asObservable()
            .map { $0.gameState }
            .unwrap()
            .distinctUntilChanged()
            .map { $0.gameStatus}
            .unwrap()
            .distinctUntilChanged()
    }

    private func createGameBoardObservable() -> Observable<BoardCell> {
        return getStore().observable.asObservable()
            .map { $0.gameState }
            .unwrap()
            .distinctUntilChanged()
            .map { $0.currentCellSelected }
            .unwrap()
            .distinctUntilChanged()
    }

    // MARK: Custom Methods

    private func handleNextStepFor(gameStatus status: GameStatus) {
        switch status {
        case .active:
            currentPlayer = "player 1"
            let action = UpdatePlayerTurnAction(player: currentPlayer!)
            getStore().dispatch(action)
        case .ended, .draw:
            currentPlayer = nil
        case .started:
            playerOneSelected = []
            playerTwoSelected = []
        }
    }

    private func handleGameBoardStatusForSelectedBoardCell(_ boardCell: BoardCell) {
        guard let player = currentPlayer, let indexPath = boardCellToIndexPath[boardCell] else { return }

        let action = UpdateBoardUIAction(player: player, indexPath: indexPath)
        getStore().dispatch(action)


        var gameStatus = GameStatus.active

        switch player {
        case "player 1":
            playerOneSelected.append(boardCell)
            gameStatus = validateBoardCells(cells: playerOneSelected)
            if gameStatus == .active {
                currentPlayer = "player 2"
                let action = UpdatePlayerTurnAction(player: currentPlayer!)
                getStore().dispatch(action)
            } else if gameStatus == .ended {
                let action = EndGameAction(message: "\(currentPlayer!) WON!")
                getStore().dispatch(action)
            } else if gameStatus == .draw {
                let action = EndGameAction(message: "It's a DRAW!")
                getStore().dispatch(action)
            }
        case "player 2":
            playerTwoSelected.append(boardCell)
            gameStatus = validateBoardCells(cells: playerTwoSelected)
            if gameStatus == .active {
                currentPlayer = "player 1"
                let action = UpdatePlayerTurnAction(player: currentPlayer!)
                getStore().dispatch(action)
            } else if gameStatus == .ended {
                let action = EndGameAction(message: "\(currentPlayer!) WON!")
                getStore().dispatch(action)
            } else if gameStatus == .draw {
                let action = EndGameAction(message: "It's a DRAW!")
                getStore().dispatch(action)
            }
        default:
            print("UNKNOWN PLAYER!")
            return
        }
    }

    private func validateBoardCells(cells: [BoardCell]) -> GameStatus {
        if cells.count >= 3 {
            for winCondition in winConditions {
                if cells.contains(array: winCondition) {
                    return .ended
                }
            }
            if playerOneSelected.count + playerTwoSelected.count == 9 {
                return .draw
            }
            return .active
        } else {
            return .active
        }
    }
 }
