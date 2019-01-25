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

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
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

    private lazy var gameCollectionView: UICollectionView = self.createGameCollectionView()

    // MARK: Initializers
    
    init(viewModel: GameBoardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        setupRx()
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
        view.backgroundColor = .cyan
        titleLabel.textAlignment = .center
        titleLabel.text = viewModel.getLocalizedTitleLabelText()
        titleLabel.backgroundColor = .clear
        statusLabel.textAlignment = .center
        statusLabel.backgroundColor = .clear
        startButton.setTitle(viewModel.getLocalizedStartButtonTitle(), for: .normal)
        startButton.backgroundColor = .clear

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(40)
        }

        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
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

        view.addSubview(gameCollectionView)
        gameCollectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(gameCollectionView.snp.width)
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

        viewModel.gameStatusObservable.subscribe(onNext: { [weak self] gameStatus in
            guard let `self` = self else { return }
            if let status = gameStatus, status == .started {
                self.gameCollectionView.reloadData()
            }
        })
            .disposed(by: disposeBag)

        viewModel.currentPlayerObservable.subscribe(onNext: { [weak self] player in
            guard let `self` = self else { return }
            if let playerOnTurn = player {
                self.statusLabel.text = "\(playerOnTurn): Make your choice"
            }
        })
            .disposed(by: disposeBag)
    }

    // MARK: Custom Methods

    private func createGameCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GameBoardCollectionViewCell.self, forCellWithReuseIdentifier: "boardcell")
        collectionView.backgroundColor = .black
        return collectionView
    }
}

extension GameBoardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: "boardcell", for: indexPath)
        let gameBoardCollectionViewCell = cell as? GameBoardCollectionViewCell
        if gameBoardCollectionViewCell?.viewModel == nil {
            gameBoardCollectionViewCell?.viewModel = GameBoardCollectionViewCellViewModel()
        }
        return gameBoardCollectionViewCell ?? UICollectionViewCell()
    }
}

extension GameBoardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath)")
        viewModel.boardCellSelectedAt(indexPath)
    }
}

extension GameBoardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let boardCellWidth = (screenWidth / 3.0) - 10
        return CGSize(width: boardCellWidth, height: boardCellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
