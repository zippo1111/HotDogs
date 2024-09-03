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

    func configure(viewModelData: [DogBreedViewModel]?, viewModel: DogsViewModel?) {
        self.viewModelData = viewModelData
        self.viewModel = viewModel
    }

    private func setupView() {
        backgroundColor = Colors.lightGray
        showsHorizontalScrollIndicator = false
        scrollsToTop = true
        dataSource = self
        prefetchDataSource = self
        delegate = self

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

    private var viewModel: DogsViewModel?
    private var viewModelData: [DogBreedViewModel]?
    private var idsWithImagesToLoad = [Int: UIImage?]()

}

extension DogsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModelData?.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = dequeueReusableCell(
            withReuseIdentifier: String(describing: DogCell.self),
            for: indexPath
        ) as? DogCell {
            let data = viewModelData?[safeIndex: indexPath.row]
            cell.configure(viewModel: data)

            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension DogsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = (cell as? DogCell) else {
            return
        }

        cell.showSpinnerInImage()

        Task {
            guard let imageId = viewModelData?.first(where: { $0.id == cell.id })?.imageId,
                  let image = await viewModel?.loadImage(by: imageId) else {
                DispatchQueue.main.async {
                    cell.hideSpinnerInImage()
                }
                return
            }

            await MainActor.run {
                cell.addImage(image)
                cell.hideSpinnerInImage()
            }
        }
    }
}

extension DogsCollectionView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            guard let cell = dequeueReusableCell(
                withReuseIdentifier: String(describing: DogCell.self),
                for: indexPath
            ) as? DogCell,
               let imageId = viewModelData?.first(where: {
                   $0.id == cell.id
               })?.imageId else {
                return
            }

            guard let cellId = cell.id, let image = viewModel?.inCache(id: cellId) else {
                cell.showSpinnerInImage()

                Task {
                    guard let image = await viewModel?.loadImage(by: imageId) else {
                        cell.hideSpinnerInImage()
                        return
                    }

                    await MainActor.run {
                        cell.addImage(image)
                        cell.hideSpinnerInImage()
                    }
                }

                return
            }

            cell.addImage(image)
        }
    }
}

fileprivate extension DogsCollectionView {
    enum Constants {
        static let defaultItemHeight: CGFloat = 200
        static let offsetInner: CGFloat = 14
        static let offsetOuter: CGFloat = 20
    }
}
