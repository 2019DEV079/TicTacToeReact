//
//  MainStore.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import Foundation
import RxSwift
import ReSwift
import RxSwiftExt

typealias MainStore = Store<Variable<MainState>>

protocol StoreProtocol: class, StateType {
    var observable: Observable<MainState> { get }
    func dispatch(_ action: Action)
}

final class Store<ObservableProperty: Variable<MainState>>: StoreProtocol, StoreSubscriber {
    private let store: ReSwift.Store<MainState>
    private let stateVariable: Variable<MainState?>
    var observable: Observable<MainState>
    
    func newState(state: MainState) {
        // async need to prevent rxFatalError("Warning: Recursive call or synchronization error!")
        DispatchQueue.main.async {
            self.stateVariable.value = state
        }
    }
    
    init(reSwiftStore: ReSwift.Store<MainState>) {
        self.store = reSwiftStore
        stateVariable = Variable<MainState?>(nil)
        observable = stateVariable.asObservable().unwrap()
        reSwiftStore.subscribe(self)
    }
    
    func dispatch(_ action: Action) {
        self.store.dispatch(action)
    }
}
