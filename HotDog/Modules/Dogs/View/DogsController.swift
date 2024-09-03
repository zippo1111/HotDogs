//
//  DogsController.swift
//  DogsMVVM
//
//  Created by Mangust on 25.08.2024.
//

import SnapKit
import UIKit

final class SearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class DogsController: UIViewController {

    init(viewModel: DogsViewModel?) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.red

        loadData { [weak self] in
            DispatchQueue.main.async {
                self?.refreshCollection()
            }
        }

        setupSearch()
        setupNavigation()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureConstraints()
    }

    private func setupNavigation() {
        navigationController?.navigationBar.topItem?.title = "H0TD0G"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Constants.menuIcon,
            style: .plain,
            target: self,
            action: #selector(menuTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Constants.searchIcon,
            style: .plain,
            target: self,
            action: #selector(searchTapped)
        )
    }

    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(spinner)
    }

    private func setupSearch() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }

    private func showSearchFocused() {
        UIView.animate(withDuration: 0, delay: 0.1, options: .curveEaseIn) { [weak self] in
            guard let search = self?.searchController else {
                return
            }

            self?.navigationItem.searchController = search
            self?.didFocusSearchBar?()
        } completion: { [weak self] _ in
            self?.searchController.searchBar.layer.opacity = 1
            self?.searchController.searchBar.becomeFirstResponder()
        }
    }

    private func configureConstraints() {
        collectionView.snp.makeConstraints {
            if let bottomConstant = navigationController?.navigationBar.snp.bottom {
                $0.top.equalTo(bottomConstant)
            }
            $0.bottom.left.right.equalToSuperview()
        }
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func loadData(callback: (() -> Void)?) {
        spinner.startAnimating()
        Task {
            guard let data = await viewModel?.fetchDogs() else {
                spinner.stopAnimating()
                return
            }

            dogsViewModelData = data
            callback?()
        }
    }

    private func refreshCollection() {
        let data = (filteredDogs ?? []).isEmpty ? dogsViewModelData : filteredDogs

        collectionView.configure(
            viewModelData: data,
            viewModel: viewModel
        )
        collectionView.reloadData()

        if spinner.isAnimating {
            spinner.stopAnimating()
        }
    }

    private func clearSearch() {
        filteredDogs = []

        UIView.animate(withDuration: 0, delay: 0.1, options: .curveEaseOut) { [weak self] in
            guard let search = self?.searchController else {
                return
            }

            self?.navigationItem.searchController = nil
            search.searchBar.removeFromSuperview()
            self?.navigationItem.searchController?.removeFromParent()
            self?.didDefocusSearchBar?()
        }
    }

    @objc
    private func searchTapped() {
        showSearchFocused()
    }

    @objc
    private func menuTapped() {
        didTapBackButton?()
    }

    var didTapBackButton: (() -> Void)?
    var didFocusSearchBar: (() -> Void)?
    var didDefocusSearchBar: (() -> Void)?

    private var dogsViewModelData: [DogBreedViewModel]?
    private var filteredDogs: [DogBreedViewModel]?

    private let viewModel: DogsViewModel?
    private let collectionView = DogsCollectionView()
    private let spinner = UIActivityIndicatorView()
    private let searchController = DogsSearchController(searchResultsController: nil)
    private let delayHelper = Delays()
}

extension DogsController {
    func filterContentForSearchText(_ searchText: String) {
        filteredDogs = dogsViewModelData?.filter {
            [
                $0.name.lowercased(),
                ($0.purpose ?? "").lowercased(),
                ($0.group ?? "").lowercased(),
                $0.temperament.lowercased(),
                ($0.origin ?? "").lowercased()
            ]
                .joined(separator: ",")
                .contains(searchText.lowercased())
        }

        refreshCollection()
    }

    func searchBarIsEmpty() -> Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
}

extension DogsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar

        if searchBarIsEmpty() {
            refreshCollection()
        } else {
            filterContentForSearchText(searchBar.text!)
        }
    }
}

extension DogsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBarIsEmpty() {
            clearSearch()
            refreshCollection()
        }
    }
}

fileprivate extension DogsController {
    enum Constants {
        static let configuration = UIImage.SymbolConfiguration(
            pointSize: 40,
            weight: .medium,
            scale: .large
        )
        static let searchIcon = UIImage(
            systemName: "magnifyingglass",
            withConfiguration: configuration
        )?.withTintColor(.white, renderingMode: .alwaysOriginal)
        static let menuIcon = UIImage(
            systemName: "text.alignleft",
            withConfiguration: configuration
        )?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
}
