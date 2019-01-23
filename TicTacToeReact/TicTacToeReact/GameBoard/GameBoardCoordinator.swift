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
    private weak var gameBoardViewController: GameBoardViewController? {
        return window?.rootViewController as? GameBoardViewController
    }
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    convenience init(window: UIWindow?, navigationController: UINavigationController) {
        self.init(navigationController: navigationController)
        self.window = window
    }
    
    override func start() {
        let viewModel = GameBoardViewModel()
        viewModel.delegate = self
        let viewController = GameBoardViewController(viewModel: viewModel)
        window?.rootViewController = viewController
    }
}

extension GameBoardCoordinator: GameBoardViewModelDelegate {
    
}
