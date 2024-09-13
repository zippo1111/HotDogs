//
//  DogsViewModel.swift
//  DogsMVVM
//
//  Created by Mangust on 25.08.2024.
//

import UIKit

protocol DogsViewModelProtocol {
    func fetchDogs() async -> [DogBreedViewModel]?
    func fetchDogsWithImages(by data: [DogBreedViewModel]) async -> [DogBreedViewModel]?
}

final class DogsViewModel: DogsViewModelProtocol {

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

    func fetchDogsWithImages(by data: [DogBreedViewModel]) async -> [DogBreedViewModel]? {
        guard let imagesData = await loadImages(by: data.map { $0.imageId }) else {
            return nil
        }

        return data.map { item in
            var itemWithImage = item
            itemWithImage.image = imagesData.first(where: { $0.key == item.imageId })?.value

            return itemWithImage
        }
    }

    private func loadImages(by ids: [String?]) async -> [String: UIImage?]? {
        await withThrowingTaskGroup(of: (String, UIImage?).self) { group -> [String: UIImage?]? in
            for id in ids {
                group.addTask{
                    let image = await self.model.getImage(by: id)
                    return (id ?? "", image)
                }
            }

            var images = [String: UIImage?]()

            do {
                for try await (id, image) in group {
                    images[id] = image
                }
            } catch {
                return nil
            }

            return images
        }
    }

    private var model = DogsModel()
}
