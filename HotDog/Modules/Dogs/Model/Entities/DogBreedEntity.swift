//
//  DogBreedEntity.swift
//  HotDog
//
//  Created by Mangust on 28.08.2024.
//

import UIKit

struct DogBreedEntity: Decodable {
    let id: Int
    let name: String
    let purpose: String?
    let group: String?
    let lifetime: String
    let temperament: String
    let origin: String?
    let imageId: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case purpose = "bred_for"
        case group = "breed_group"
        case lifetime = "life_span"
        case temperament
        case origin
        case imageId = "reference_image_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageId = try values.decode(String.self, forKey: .imageId)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        purpose = try? values.decode(String.self, forKey: .purpose)
        group = try? values.decode(String.self, forKey: .group)
        lifetime = try values.decode(String.self, forKey: .lifetime)
        temperament = try values.decode(String.self, forKey: .temperament)
        origin = try? values.decode(String.self, forKey: .origin)
    }
}
