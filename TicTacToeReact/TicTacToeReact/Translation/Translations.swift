//
//  Translations.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 24/01/19.
//  Copyright © 2019 altran. All rights reserved.
//
import Foundation

enum TranslationConstants {
    case startButtonTitle
    case titleLabelText
    
    var text: String {
        switch self {
        case .startButtonTitle: return NSLocalizedString("startButtonTitle", comment: "")
        case .titleLabelText: return NSLocalizedString("titleLabelText", comment: "")
        }
    }
}
