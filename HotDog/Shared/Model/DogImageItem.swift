//
//  DogImageItem.swift
//  HotDog
//
//  Created by Mangust on 12.09.2024.
//

import UIKit

enum Section: Hashable {
    case main
}

struct DogImageSections {
    var key: Section
    var values: [DogImageItem]
}

final class DogImageItem: Hashable {
    var image: UIImage!
    let url: URL!
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: DogImageItem, rhs: DogImageItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    init(image: UIImage, url: URL) {
        self.image = image
        self.url = url
    }
}
