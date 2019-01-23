//
//  GameBoardViewController.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    // MARK: Properties
    
    private(set) var viewModel: GameBoardViewModel
    
    // MARK: Initializers
    
    init(viewModel: GameBoardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.styleViews()
    }
    
    // MARK: Custom Methods
    
    private func styleViews() {
        view.backgroundColor = .white
    }
}
