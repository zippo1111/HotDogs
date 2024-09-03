//
//  ImageDownloaderService.swift
//  DogsMVVM
//
//  Created by Mangust on 26.08.2024.
//

import UIKit

struct ImageDownloaderService {
    func downloadImage(from url: URL?) async throws -> UIImage {
        do {
            guard let url = url else {
                throw URLError(.badURL)
            }

            let (data, _) = try await URLSession.shared.data(from: url)

            guard let image = UIImage(data: data) else {
                throw URLError(.cannotDecodeContentData)
            }

            return image
        } catch {
            throw error
        }
    }

    func loadImages(from idsWithUrls: [Int: URL?]) async throws -> [Int: UIImage?] {
        try await withThrowingTaskGroup(of: (Int, UIImage?).self) { group in
            for idWithUrl in idsWithUrls {
                group.addTask{
                    let image = try await self.downloadImage(from: idWithUrl.value)
                    return (idWithUrl.key, image)
                }
            }

            var images = [Int: UIImage?]()

            for try await (id, image) in group {
                images[id] = image
            }

            return images
        }
    }
}
