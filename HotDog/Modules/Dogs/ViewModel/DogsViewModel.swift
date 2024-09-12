//
//  DogsViewModel.swift
//  DogsMVVM
//
//  Created by Mangust on 25.08.2024.
//

import UIKit

final class DogsViewModel {

    func fetchDogs() async -> [DogBreedViewModel]? {
        guard let response = await model.getDogs() else {
            return nil
        }

        return response.map {
            DogBreedViewModel(
                id: $0.id,
                name: $0.name,
                purpose: $0.purpose,
                group: $0.group,
                lifetime: $0.lifetime,
                temperament: $0.temperament,
                origin: $0.origin,
                imageId:  $0.imageId
            )
        }
    }

    func loadImage(by id: String?) async -> UIImage? {
        await model.getImage(by: id)
    }

    private var model = DogsModel()
}
