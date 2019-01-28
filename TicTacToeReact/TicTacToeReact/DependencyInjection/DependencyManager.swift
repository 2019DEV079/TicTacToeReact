//
//  DependencyManager.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import Foundation
import RxSwift
import ReSwift
import Swinject

final class DependencyManager {
    static func createContainer() -> Container {
        let container = Container { container in
            self.registerRedux(container)
            self.registerServices(container)
        }
        self.fillInjectionMap(container: container)
        return container
    }

    private static func fillInjectionMap(container: Container) {
        InjectionMap.gameManager = container.resolve(GameManagerProtocol.self)!
    }

    private static func registerServices(_ container: Container) {
        container.register(GameManagerProtocol.self) { resolver in
            GameManager(
                getStore: {resolver.resolve(StoreProtocol.self)!}
            )
            }.inObjectScope(.container)
    }

    private static func registerRedux(_ container: Container) {
        container.register(GameReducer.self) { _ in
            GameReducer()
            }.inObjectScope(.container)
        container.register(CurrentScreenReducer.self) { _ in
            CurrentScreenReducer()
            }.inObjectScope(.container)
        container.register(MainReducer.self) { resolver in
            MainReducer(gameReducer: resolver.resolve(GameReducer.self)!.handleAction,
                        currentScreenReducer: resolver.resolve(CurrentScreenReducer.self)!.handleAction)
            }.inObjectScope(.container)
        container.register(ReSwift.Store<MainState>.self) { resolver in
            return ReSwift.Store<MainState>(
                reducer: resolver.resolve(MainReducer.self)!.handleAction,
                state: nil)
            }.inObjectScope(.container)
        container.register(StoreProtocol.self) { resolver in
            MainStore(reSwiftStore: resolver.resolve(ReSwift.Store<MainState>.self)!)
            }.inObjectScope(.container)
    }
}
