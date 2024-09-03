//
//  NavigationBar.swift
//  HotDog
//
//  Created by Mangust on 01.09.2024.
//

import UIKit

final class NavigationBar: UINavigationBar {
    var preferredHeight: CGFloat = .zero

    override var frame: CGRect {
        get {
            super.frame
        } set {
            var frame = newValue
            frame.size.height = preferredHeight
            super.frame = frame
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        frame = CGRect(
            x: frame.minX,
            y: frame.minY,
            width: frame.width,
            height: preferredHeight
        )
    }
}

