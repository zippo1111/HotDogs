//
//  DogsCollectionView.swift
//  NewsMVVM
//
//  Created by Mangust on 28.08.2024.
//

import SnapKit
import UIKit

final class DogsCollectionView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModelData: [DogBreedViewModel]?) {
        self.viewModelData = viewModelData

        guard let viewModelData = viewModelData else {
            return
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, DogBreedViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModelData, toSection: .main)

        DispatchQueue.main.async {
            self.diffableDataSource.applySnapshotUsingReloadData(snapshot)
        }
    }

    private func setupView() {
        backgroundColor = Colors.lightGray
        showsHorizontalScrollIndicator = false
        scrollsToTop = true
        dataSource = diffableDataSource

        collectionViewLayout = CustomLayout(
            interItemSpacing: Constants.offsetOuter,
            scrollDirection: .vertical,
            itemHeight: Constants.defaultItemHeight,
            groupInsets: NSDirectionalEdgeInsets(
                top: .leastNormalMagnitude,
                leading: Constants.offsetOuter,
                bottom: .leastNormalMagnitude,
                trailing: Constants.offsetOuter
            )
        )

        register(
            DogCell.self,
            forCellWithReuseIdentifier: String(describing: DogCell.self)
        )
    }

    private var viewModel: DogsViewModelProtocol?
    private var viewModelData: [DogBreedViewModel]?
    private lazy var diffableDataSource = DogsDiffableDataSource(collectionView: self, viewModel)
}

fileprivate extension DogsCollectionView {
    enum Constants {
        static let defaultItemHeight: CGFloat = 200
        static let offsetInner: CGFloat = 14
        static let offsetOuter: CGFloat = 20
    }
}
