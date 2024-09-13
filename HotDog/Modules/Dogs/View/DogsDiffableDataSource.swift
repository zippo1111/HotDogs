//
//  DogsDiffableDataSource.swift
//  HotDog
//
//  Created by Mangust on 13.09.2024.
//

import UIKit

final class DogsDiffableDataSource: UICollectionViewDiffableDataSource<Section, DogBreedViewModel> {
    init(collectionView: UICollectionView, _ viewModel: DogsViewModelProtocol?) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            guard let cell = (collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: DogCell.self),
                for: indexPath
            ) as? DogCell) else {
                return UICollectionViewCell()
            }
            cell.configure(viewModel: item)

            return cell
        }
    }
}
