//
//  CurrentScreenState.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 27/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import ReSwift

struct CurrentScreenState: StateType {
    var indexPath: IndexPath? = IndexPath(row: 10, section: 10)
    var mark: String?
}

extension CurrentScreenState: Equatable {

    static func == (lhs: CurrentScreenState, rhs: CurrentScreenState) -> Bool {
        return lhs.indexPath == rhs.indexPath &&
            lhs.mark == rhs.mark
    }
}
