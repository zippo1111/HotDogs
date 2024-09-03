//
//  DogsSearchController.swift
//  HotDog
//
//  Created by Mangust on 01.09.2024.
//

import UIKit

final class DogsSearchController: UISearchController {
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)

        setupSearch()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSearch() {
        searchBar.placeholder = Constants.searchPlaceholder
        searchBar.showsCancelButton = false
        searchBar.clearsContextBeforeDrawing = true
        hidesNavigationBarDuringPresentation = false

        searchBar.setForeground(.white)
        searchBar.changePlaceholderColor(.white)
        searchBar.setLeftIcon(color: .white)
        searchBar.setRightIcon(color: .white, image: Constants.closeIcon)
        searchBar.setImage(
            Constants.closeIcon,
            for: .clear,
            state: .normal
        )
    }
}

fileprivate extension DogsSearchController {
    enum Constants {
        static let closeIconConfiguration = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .regular,
            scale: .medium
        )
        static let closeIcon = UIImage(
            systemName: "xmark",
            withConfiguration: closeIconConfiguration
        )?.withTintColor(.white, renderingMode: .alwaysOriginal)
        static let searchPlaceholder = "Поиск"
    }
}
