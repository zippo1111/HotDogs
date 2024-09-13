//
//  DogBreedViewModel.swift
//  HotDog
//
//  Created by Mangust on 28.08.2024.
//

import UIKit

struct DogBreedViewModel: Hashable {
    let id: Int
    let name: String
    let purpose: String?
    let group: String?
    let lifetime: String
    let temperament: String
    let origin: String?
    let imageId: String
    var image: UIImage?
}
