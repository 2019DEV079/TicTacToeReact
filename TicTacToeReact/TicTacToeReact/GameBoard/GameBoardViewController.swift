//
//  GameBoardViewController.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 23/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GameBoardViewController: UIViewController {
    
    // MARK: Properties
    
    private(set) var viewModel: GameBoardViewModel
    private let disposeBag = DisposeBag()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    private let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitleColor(.black, for: .normal)
        button.alpha = 1
        button.clipsToBounds = true
        return button
    }()

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
    
    // MARK: Layout
    
    private func styleViews() {
        view.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = viewModel.getLocalizedTitleLabelText()
        startButton.setTitle(viewModel.getLocalizedStartButtonTitle(), for: .normal)

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(40)
        }

        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-25)
        }
    }

    // MARK: Reactive Code

    private func setupRx() {
        startButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.viewModel.didTapStart()
            })
            .disposed(by: disposeBag)
    }
}
