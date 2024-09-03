//
//  Extension+UISearchBar.swift
//  HotDog
//
//  Created by Mangust on 30.08.2024.
//

import UIKit

extension UISearchBar {
    func setForeground(_ color: UIColor) {
        guard let textField = self.value(forKey: Constants.textFieldKey) as? UITextField else {
            return
        }

        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }

    func setBackground(_ color: UIColor) {
        guard let textField = self.value(forKey: Constants.textFieldKey) as? UITextField else {
            return
        }

        textField.backgroundColor = color
    }

    func setLeftIcon(color: UIColor, image: UIImage? = nil) {
        guard let textField = self.value(forKey: Constants.textFieldKey) as? UITextField,
              let leftView = textField.leftView as? UIImageView else {
            return
        }

        setLeftIconIfNeeded(image, leftView)
        leftView.tintColor = color
    }

    func setRightIcon(color: UIColor, image: UIImage? = nil) {
        guard let textField = self.value(forKey: Constants.textFieldKey) as? UITextField,
              let rightView = textField.rightView as? UIImageView else {
            return
        }

        setLeftIconIfNeeded(image, rightView)
        rightView.tintColor = color
    }

    func setCancelButton(title: String) {
        UIBarButtonItem.appearance(
            whenContainedInInstancesOf: [UISearchBar.self]
        ).title = title
    }

    private func setLeftIconIfNeeded(_ image: UIImage?, _ leftView: UIImageView) {
        guard let image = image else {
            return
        }

        leftView.image = image.withRenderingMode(.alwaysTemplate)
    }

    func changePlaceholderColor(_ color: UIColor) {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

fileprivate extension UISearchBar {
    enum Constants {
        static let textFieldKey = "searchField"
        static let placeholderKey = "placeholderLabel"
    }
}
