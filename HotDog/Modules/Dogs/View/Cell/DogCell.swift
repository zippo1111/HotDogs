//
//  DogCell.swift
//  HotDog
//
//  Created by Mangust on 28.08.2024.
//

import SnapKit
import UIKit

final class DogCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        addShadowsOnLayoutSubviews()
    }

    func configure(viewModel: DogBreedViewModel?) {
        guard let viewModel = viewModel else {
            return
        }

        configureConstraints()
        setupData(viewModel)
    }

    func showSpinnerInImage() {
        spinner.startAnimating()
    }

    func hideSpinnerInImage() {
        spinner.stopAnimating()
    }

    func addImage(_ image: UIImage) {
        imageView.image = image
    }

    func hasNoImage() -> Bool {
        imageView.image == nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
    }

    private func setupView() {
        contentView.addSubview(container)

        container.addSubview(holder)
        holder.addSubview(imageView)
        holder.addSubview(header)
        holder.addSubview(content)
        holder.addSubview(bottomStack)
        bottomStack.addArrangedSubview(plusButton)

        plusButton.addAction(
            UIAction(
                handler: { [weak self] _ in
                    self?.plusTapped()
                }
            ),
            for: .touchUpInside
        )

        imageView.addSubview(spinner)
    }

    private func addShadowsOnLayoutSubviews() {
        container.layer.shadowPath = UIBezierPath(
            roundedRect: container.bounds,
            cornerRadius: Constants.cornerRadius
        ).cgPath
    }

    private func configureConstraints() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        holder.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(Constants.offsetInner)
            $0.right.bottom.equalToSuperview().offset(-Constants.offsetInner)
        }
        imageView.snp.makeConstraints {
            $0.height.equalTo(Constants.imageHeight)
            $0.top.left.right.equalToSuperview()
        }
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        header.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(Constants.offsetInner)
            $0.left.right.equalToSuperview()
        }
        content.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(Constants.offsetInner)
            $0.left.right.equalToSuperview()
        }

        bottomStack.snp.makeConstraints {
            $0.top.equalTo(content.snp.bottom).offset(Constants.offsetInner)
            $0.bottom.left.right.equalToSuperview()
        }
    }

    private func setupData(_ viewModelData: DogBreedViewModel) {
        header.text = viewModelData.name
        content.text = """
        \(viewModelData.purpose ?? "")
        \(viewModelData.group ?? "")
        \(viewModelData.lifetime)
        \(viewModelData.temperament)
        \(viewModelData.origin ?? "")
        """
        id = viewModelData.id
    }

    private func plusTapped() {
        print("+++++")
    }

    var id: Int?
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius

        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        view.layer.shadowRadius = 1

        return view
    }()

    private lazy var holder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius

        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        view.layer.shadowRadius = 1

        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white

        return imageView
    }()

    private let header: UILabel = {
        let label = UILabel(frame: .zero)

        if let descriptor = Constants.titleDescriptor {
            label.font = UIFont(descriptor: descriptor, size: 20)
        } else {
            label.font = UIFont.boldSystemFont(ofSize: 24)
        }

        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        label.textAlignment = .left




        return label
    }()

    private let content: UILabel = {
        let label = UILabel(frame: .zero)

        if let descriptor = Constants.bodyDescriptor {
            label.font = UIFont(descriptor: descriptor, size: 16)
        } else {
            label.font = UIFont.systemFont(ofSize: 20)
        }

        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        label.textAlignment = .left

        return label
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = Constants.offsetOuter

        return stack
    }()

    private var bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .trailing
        stack.spacing = Constants.offsetOuter

        return stack
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)
        let plusImage = UIImage(systemName: "plus.circle.fill", withConfiguration: configuration)?.withTintColor(
            Colors.red,
            renderingMode: .alwaysOriginal
        )
        button.contentMode = .scaleAspectFill
        button.setImage(plusImage, for: .normal)

        return button
    }()

    private let spinner = UIActivityIndicatorView()
}

fileprivate extension DogCell {
    enum Constants {
        static let offsetInner: CGFloat = 14
        static let offsetOuter: CGFloat = 20
        static let imageHeight: CGFloat = 160
        static let cornerRadius: CGFloat = 12
        static let bodyDescriptor: UIFontDescriptor? = UIFontDescriptor.preferredFontDescriptor(
            withTextStyle: .body)
            .withDesign(.serif)
        static let titleDescriptor: UIFontDescriptor? = UIFontDescriptor.preferredFontDescriptor(
            withTextStyle: .largeTitle)
            .withDesign(.serif)?
            .withSymbolicTraits([.traitBold])
        static let buttonHeight: CGFloat = 60
    }
}
