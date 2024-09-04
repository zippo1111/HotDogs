//
//  MenuController.swift
//  HotDog
//
//  Created by Mangust on 28.08.2024.
//

import SnapKit
import UIKit

final class MenuController: UIViewController {

    init(viewModel: MenuViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = nil
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPreview()
        buildNavigation()
    }

    override func viewWillDisappear(_ animated: Bool) {


        super.viewWillDisappear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dogsController.didTapBackButton = { [weak self] in
            self?.presentedViewController?.dismiss(animated: true)
        }

        dogsController.didFocusSearchBar = { [weak self] in
            self?.setNavigationBarHeightWithSearch()
        }

        dogsController.didDefocusSearchBar = { [weak self] in
            self?.setNavigationBarHeightInitial()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presentController { [weak self] in
            self?.setupRealView()
        }
    }

    private func setupPreview() {
        view.backgroundColor = Colors.red

        navigation.modalPresentationStyle = .custom
        navigation.transitioningDelegate = sheetTransitioningDelegate
    }

    private func setupRealView() {
        view.addSubview(label)
        label.text = viewModel?.getViewModel()?.title
        view.backgroundColor = Colors.mint

        configureConstraints()
    }

    private func configureConstraints() {
        label.snp.makeConstraints {
            $0.top.equalTo(Constants.topOffset)
            $0.left.equalTo(Constants.leftOffset)
        }
    }

    private func updateNavbarConstraints() {
        (navigation.navigationBar as? NavigationBar)?.snp.remakeConstraints {
            $0.height.equalTo(Constants.navigationHeightWithSearchBar)
        }
    }

    private func buildNavigation() {
        UINavigationBar
            .appearance()
            .titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        (navigation.navigationBar as? NavigationBar)?.preferredHeight = Constants.navigationHeightInitial
        navigation.navigationItem.hidesSearchBarWhenScrolling = false
        navigation.setViewControllers([dogsController], animated: false)
    }

    private func setNavigationBarHeightWithSearch() {
        (navigation.navigationBar as? NavigationBar)?.preferredHeight = Constants.navigationHeightWithSearchBar
    }

    private func setNavigationBarHeightInitial() {
        (navigation.navigationBar as? NavigationBar)?.preferredHeight = Constants.navigationHeightInitial
    }

    private func presentController(callback: (() -> Void)?) {
        present(navigation, animated: true, completion: callback)
    }

    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white

        return label
    }()
    private let navigation = UINavigationController(
        navigationBarClass: NavigationBar.self,
        toolbarClass: nil
    )
    private let sheetTransitioningDelegate = SheetTransitioningDelegate()
    private let dogsController = DogsController(
        viewModel: DogsViewModel()
    )
    private let viewModel: MenuViewModel?
}

fileprivate enum Constants {
    static let navigationHeightInitial: CGFloat = 67
    static let navigationHeightWithSearchBar: CGFloat = 112
    static let topOffset: CGFloat = 50
    static let leftOffset: CGFloat = 20
}
