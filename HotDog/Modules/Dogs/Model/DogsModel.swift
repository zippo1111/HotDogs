//
//  DogsModel.swift
//  DogsMVVM
//
//  Created by Mangust on 25.08.2024.
//

import UIKit

struct DogsModel {
    func getDogs() async -> [DogBreed]? {
        let breeds = await dogsService.getDogBreeds()

        return breeds?.map {
            DogBreed(
                id: $0.id,
                name: $0.name,
                purpose: $0.purpose,
                group: $0.group,
                lifetime: $0.lifetime,
                temperament: $0.temperament,
                origin: $0.origin,
                imageId: $0.imageId
            )
        }
    }

    func getImage(by id: String?) async -> UIImage? {
        guard let imageId = id,
              let imageAddress = dogsService.getImageAddress(by: imageId),
              let url = URL(string: imageAddress) else {
            return nil
        }

        return try? await downloaderService.downloadImage(from: url)
    }

    private func getDogBreeds() async -> [DogBreedEntity]? {
        await dogsService.getDogBreeds()
    }

    private var dogsService = DogsService()
    private var downloaderService = ImageDownloaderService()
    private var imagesLoaded = [Int: UIImage]()
}
