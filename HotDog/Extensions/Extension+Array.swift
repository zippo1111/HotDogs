//
//  Extension+Array.swift
//  ProductsGallery
//
//  Created by Mangust on 11.08.2024.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
