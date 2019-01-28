//
//  Array+Extensions.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 28/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func contains(array: [Element]) -> Bool {
        for item in array {
            if !self.contains(item) { return false }
        }
        return true
    }
}
