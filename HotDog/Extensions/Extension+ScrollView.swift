//
//  Extension+ScrollView.swift
//  DogsMVVM
//
//  Created by Mangust on 27.08.2024.
//

import UIKit

extension UIScrollView {

    var scrolledToTop: Bool {
        let topEdge = 0 - contentInset.top
        return contentOffset.y <= topEdge
    }

    var scrolledToBottom: Bool {
        let bottomEdge = contentSize.height + contentInset.bottom - bounds.height
        return contentOffset.y >= bottomEdge
    }
}
