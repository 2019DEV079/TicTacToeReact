//
//  AppDelegate.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var container: Container?
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        container = DependencyManager.createContainer()
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = .lightGray
        
        guard let container = container else {
            print("Container not succesfully initialized")
            return false
        }
        guard let store = container.resolve(StoreProtocol.self) else {
            print("Store not succesfully initialized")
            return false
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = GameBoardCoordinator(window: window, navigationController: navigationController, storeProvider: { store })
        coordinator.start()
        window?.makeKeyAndVisible()
        
        return true
    }
}

