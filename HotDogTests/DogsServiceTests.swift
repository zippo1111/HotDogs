//
//  HotDogTests.swift
//  HotDogTests
//
//  Created by Mangust on 28.08.2024.
//

import XCTest
@testable import HotDog

class DogsServiceTests: XCTestCase {

    let service = DogsService()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        
    }

    func testGetBreedsDecoder() {
        let json = """
            [
              {
                "weight": {
                  "imperial": "6 - 13",
                  "metric": "3 - 6"
                },
                "height": {
                  "imperial": "9 - 11.5",
                  "metric": "23 - 29"
                },
                "id": 1,
                "name": "Affenpinscher",
                "bred_for": "Small rodent hunting, lapdog",
                "breed_group": "Toy",
                "life_span": "10 - 12 years",
                "temperament": "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
                "origin": "Germany, France",
                "reference_image_id": "BJa4kxc4X"
              },
                {
                    "weight": {
                      "imperial": "50 - 60",
                      "metric": "23 - 27"
                    },
                    "height": {
                      "imperial": "25 - 27",
                      "metric": "64 - 69"
                    },
                    "id": 2,
                    "name": "Afghan Hound",
                    "country_code": "AG",
                    "bred_for": "Coursing and hunting",
                    "breed_group": "Hound",
                    "life_span": "10 - 13 years",
                    "temperament": "Aloof, Clownish, Dignified, Independent, Happy",
                    "origin": "Afghanistan, Iran, Pakistan",
                    "reference_image_id": "hMyT4CDXR"
                  }
            ]
        """

        let decoder = JSONDecoder()
        let data = json.data(using: .utf8)!
        var result: [DogBreedEntity]?

        do {
            result = try decoder.decode([DogBreedEntity].self, from: data)
        } catch {
            result = nil
        }

        XCTAssertEqual(result?.first?.name, "Affenpinscher")
    }
}
