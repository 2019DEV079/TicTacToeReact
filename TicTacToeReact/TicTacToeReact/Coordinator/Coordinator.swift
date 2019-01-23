//
//  Coordinator.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class BaseCoordinator: Coordinator {
    
    var childCoordinators = [String: Coordinator]()
    weak var navigationController: UINavigationController?
    
    func start() {}
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
