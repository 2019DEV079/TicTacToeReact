//
//  GameBoardCollectionViewCell.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 24/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class GameBoardCollectionViewCell: UICollectionViewCell {

    // MARK: Properties

    var viewModel: GameBoardCollectionViewCellViewModel? {
        didSet {
            setupRx()
        }
    }
    private let displayLabel = UILabel()
    private let disposeBag = DisposeBag()

    override var reuseIdentifier: String? {
        return "boardcell"
    }

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        styleViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    private func styleViews() {
        backgroundColor = .white
        displayLabel.font = UIFont.systemFont(ofSize: 60)
        displayLabel.textAlignment = .center

        addSubview(displayLabel)
        displayLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }

    // MARK: Reactive Code

    private func setupRx() {
        guard let viewModel = viewModel else { return }

        viewModel.mark.subscribe(onNext: { [weak self] mark in
            guard let `self` = self else { return }
            self.displayLabel.text = mark
        }).disposed(by: disposeBag)

        viewModel.gameStatusObservable.subscribe(onNext: { [weak self] gameStatus in
            guard let `self` = self else { return }
            if gameStatus == .started {
                self.displayLabel.text = ""
            }
        }).disposed(by: disposeBag)
    }
}
