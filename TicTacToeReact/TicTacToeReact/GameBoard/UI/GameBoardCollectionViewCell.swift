//
//  GameBoardCollectionViewCell.swift
//  TicTacToeReact
//
//  Created by Kristof Peleman on 24/01/19.
//  Copyright © 2019 altran. All rights reserved.
//

import UIKit
import SnapKit

class GameBoardCollectionViewCell: UICollectionViewCell {

    var viewModel: GameBoardCollectionViewCellViewModel?
    private let displayLabel = UILabel()

    override var reuseIdentifier: String? {
        return "boardcell"
    }

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

        addSubview(displayLabel)
        displayLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }

    func update() {
        displayLabel.text = viewModel?.selected()
    }
}
