//
//  GameBoardCoordinator.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import UIKit

final class GameBoardCoordinator: BaseCoordinator {
    
    private var window: UIWindow?
    private var storeProvider: (() -> StoreProtocol)?
    private weak var gameBoardViewController: GameBoardViewController? {
        return window?.rootViewController as? GameBoardViewController
    }
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    convenience init(window: UIWindow?, navigationController: UINavigationController, storeProvider: @escaping () -> StoreProtocol) {
        self.init(navigationController: navigationController)
        self.window = window
        self.storeProvider = storeProvider
    }
    
    override func start() {
        guard let getStore = storeProvider else {
            print("storeProvider missing after initialization")
            return
        }
        let viewModel = GameBoardViewModel(getStore: getStore)
        viewModel.delegate = self
        let viewController = GameBoardViewController(viewModel: viewModel)
        window?.rootViewController = viewController
    }
}

extension GameBoardCoordinator: GameBoardViewModelDelegate {
    
}
