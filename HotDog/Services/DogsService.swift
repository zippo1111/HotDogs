//
//  DogsService.swift
//  DogsMVVM
//
//  Created by Mangust on 25.08.2024.
//

import UIKit

struct DogsService {
    private var image: UIImage?
    private let imageLoader = ImageLoader()

    func getDogBreeds() async -> [DogBreedEntity]? {
        let breeds: [DogBreedEntity]? = try? await getData(from: Hosts.breeds)
        return breeds
    }

    func getImageAddress(by id: String) -> String? {
        "\(Hosts.imageById)/\(id)\(Hosts.imageExtension)"
    }

    mutating func loadImage(at source: URLRequest) async {
        do {
            image = try await imageLoader.fetch(source)
        } catch {
            print(error)
        }
    }
}

fileprivate extension DogsService {
    func decode(from data: Data) -> [DogBreedEntity]? {
        let decoder = JSONDecoder()

        do {
            return try decoder.decode([DogBreedEntity].self, from: data)
        } catch {
            return nil
        }
    }

    func getData(from urlString: String) async throws -> [DogBreedEntity]? {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let breeds = decode(from: data) else {
            return decode(from: getOfflineData())
        }

        return breeds
    }

    private func getOfflineData() -> Data {
        Hosts.json.data(using: .utf8)!
    }

    enum Hosts {
        static let breeds = "https://api.thedogapi.com/v1/breeds"
        static let imageById = "https://cdn2.thedogapi.com/images"
        static let imageExtension = ".jpg"
        static let json = """
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
              },
              {
                "weight": {
                  "imperial": "44 - 66",
                  "metric": "20 - 30"
                },
                "height": {
                  "imperial": "30",
                  "metric": "76"
                },
                "id": 3,
                "name": "African Hunting Dog",
                "bred_for": "A wild pack animal",
                "life_span": "11 years",
                "temperament": "Wild, Hardworking, Dutiful",
                "origin": "",
                "reference_image_id": "rkiByec47"
              },
              {
                "weight": {
                  "imperial": "40 - 65",
                  "metric": "18 - 29"
                },
                "height": {
                  "imperial": "21 - 23",
                  "metric": "53 - 58"
                },
                "id": 4,
                "name": "Airedale Terrier",
                "bred_for": "Badger, otter hunting",
                "breed_group": "Terrier",
                "life_span": "10 - 13 years",
                "temperament": "Outgoing, Friendly, Alert, Confident, Intelligent, Courageous",
                "origin": "United Kingdom, England",
                "reference_image_id": "1-7cgoZSh"
              },
              {
                "weight": {
                  "imperial": "90 - 120",
                  "metric": "41 - 54"
                },
                "height": {
                  "imperial": "28 - 34",
                  "metric": "71 - 86"
                },
                "id": 5,
                "name": "Akbash Dog",
                "bred_for": "Sheep guarding",
                "breed_group": "Working",
                "life_span": "10 - 12 years",
                "temperament": "Loyal, Independent, Intelligent, Brave",
                "origin": "",
                "reference_image_id": "26pHT3Qk7"
              },
              {
                "weight": {
                  "imperial": "65 - 115",
                  "metric": "29 - 52"
                },
                "height": {
                  "imperial": "24 - 28",
                  "metric": "61 - 71"
                },
                "id": 6,
                "name": "Akita",
                "bred_for": "Hunting bears",
                "breed_group": "Working",
                "life_span": "10 - 14 years",
                "temperament": "Docile, Alert, Responsive, Dignified, Composed, Friendly, Receptive, Faithful, Courageous",
                "reference_image_id": "BFRYBufpm"
              },
              {
                "weight": {
                  "imperial": "55 - 90",
                  "metric": "25 - 41"
                },
                "height": {
                  "imperial": "18 - 24",
                  "metric": "46 - 61"
                },
                "id": 7,
                "name": "Alapaha Blue Blood Bulldog",
                "description": "The Alapaha Blue Blood Bulldog is a well-developed, exaggerated bulldog with a broad head and natural drop ears. The prominent muzzle is covered by loose upper lips. The prominent eyes are set well apart. The Alapaha's coat is relatively short and fairly stiff. Preferred colors are blue merle, brown merle, or red merle all trimmed in white or chocolate and white. Also preferred are the glass eyes (blue) or marble eyes (brown and blue mixed in a single eye). The ears and tail are never trimmed or docked. The body is sturdy and very muscular. The well-muscled hips are narrower than the chest. The straight back is as long as the dog is high at the shoulders. The dewclaws are never removed and the feet are cat-like.",
                "bred_for": "Guarding",
                "breed_group": "Mixed",
                "life_span": "12 - 13 years",
                "history": "",
                "temperament": "Loving, Protective, Trainable, Dutiful, Responsible",
                "reference_image_id": "33mJ-V3RX"
              },
              {
                "weight": {
                  "imperial": "38 - 50",
                  "metric": "17 - 23"
                },
                "height": {
                  "imperial": "23 - 26",
                  "metric": "58 - 66"
                },
                "id": 8,
                "name": "Alaskan Husky",
                "bred_for": "Sled pulling",
                "breed_group": "Mixed",
                "life_span": "10 - 13 years",
                "temperament": "Friendly, Energetic, Loyal, Gentle, Confident",
                "reference_image_id": "-HgpNnGXl"
              },
              {
                "weight": {
                  "imperial": "65 - 100",
                  "metric": "29 - 45"
                },
                "height": {
                  "imperial": "23 - 25",
                  "metric": "58 - 64"
                },
                "id": 9,
                "name": "Alaskan Malamute",
                "bred_for": "Hauling heavy freight, Sled pulling",
                "breed_group": "Working",
                "life_span": "12 - 15 years",
                "temperament": "Friendly, Affectionate, Devoted, Loyal, Dignified, Playful",
                "reference_image_id": "dW5UucTIW"
              },
              {
                "weight": {
                  "imperial": "60 - 120",
                  "metric": "27 - 54"
                },
                "height": {
                  "imperial": "22 - 27",
                  "metric": "56 - 69"
                },
                "id": 10,
                "name": "American Bulldog",
                "breed_group": "Working",
                "life_span": "10 - 12 years",
                "temperament": "Friendly, Assertive, Energetic, Loyal, Gentle, Confident, Dominant",
                "reference_image_id": "pk1AAdloG"
              },
              {
                "weight": {
                  "imperial": "30 - 150",
                  "metric": "14 - 68"
                },
                "height": {
                  "imperial": "14 - 17",
                  "metric": "36 - 43"
                },
                "id": 11,
                "name": "American Bully",
                "country_code": "US",
                "bred_for": "Family companion dog",
                "breed_group": "",
                "life_span": "8 – 15 years",
                "temperament": "Strong Willed, Stubborn, Friendly, Clownish, Affectionate, Loyal, Obedient, Intelligent, Courageous",
                "reference_image_id": "sqQJDtbpY"
              },
              {
                "weight": {
                  "imperial": "20 - 40",
                  "metric": "9 - 18"
                },
                "height": {
                  "imperial": "15 - 19",
                  "metric": "38 - 48"
                },
                "id": 12,
                "name": "American Eskimo Dog",
                "country_code": "US",
                "bred_for": "Circus performer",
                "breed_group": "Non-Sporting",
                "life_span": "12 - 15 years",
                "temperament": "Friendly, Alert, Reserved, Intelligent, Protective",
                "reference_image_id": "Bymjyec4m"
              },
              {
                "weight": {
                  "imperial": "7 - 10",
                  "metric": "3 - 5"
                },
                "height": {
                  "imperial": "9 - 12",
                  "metric": "23 - 30"
                },
                "id": 13,
                "name": "American Eskimo Dog (Miniature)",
                "country_code": "US",
                "bred_for": "Companionship",
                "life_span": "13 – 15 years",
                "temperament": "Friendly, Alert, Reserved, Intelligent, Protective",
                "reference_image_id": "_gn8GLrE6"
              },
              {
                "weight": {
                  "imperial": "65 - 75",
                  "metric": "29 - 34"
                },
                "height": {
                  "imperial": "21 - 28",
                  "metric": "53 - 71"
                },
                "id": 14,
                "name": "American Foxhound",
                "country_code": "US",
                "bred_for": "Fox hunting, scent hound",
                "breed_group": "Hound",
                "life_span": "8 - 15 years",
                "temperament": "Kind, Sweet-Tempered, Loyal, Independent, Intelligent, Loving",
                "reference_image_id": "S14n1x9NQ"
              },
              {
                "weight": {
                  "imperial": "30 - 60",
                  "metric": "14 - 27"
                },
                "height": {
                  "imperial": "17 - 21",
                  "metric": "43 - 53"
                },
                "id": 15,
                "name": "American Pit Bull Terrier",
                "country_code": "US",
                "bred_for": "Fighting",
                "breed_group": "Terrier",
                "life_span": "10 - 15 years",
                "temperament": "Strong Willed, Stubborn, Friendly, Clownish, Affectionate, Loyal, Obedient, Intelligent, Courageous",
                "reference_image_id": "HkC31gcNm"
              },
              {
                "weight": {
                  "imperial": "50 - 60",
                  "metric": "23 - 27"
                },
                "height": {
                  "imperial": "17 - 19",
                  "metric": "43 - 48"
                },
                "id": 16,
                "name": "American Staffordshire Terrier",
                "country_code": "US",
                "bred_for": "",
                "breed_group": "Terrier",
                "life_span": "12 - 15 years",
                "temperament": "Tenacious, Friendly, Devoted, Loyal, Attentive, Courageous",
                "reference_image_id": "rJIakgc4m"
              },
              {
                "weight": {
                  "imperial": "25 - 45",
                  "metric": "11 - 20"
                },
                "height": {
                  "imperial": "15 - 18",
                  "metric": "38 - 46"
                },
                "id": 17,
                "name": "American Water Spaniel",
                "country_code": "US",
                "bred_for": "Bird flushing and retrieving",
                "breed_group": "Sporting",
                "life_span": "10 - 12 years",
                "temperament": "Friendly, Energetic, Obedient, Intelligent, Protective, Trainable",
                "reference_image_id": "SkmRJl9VQ"
              },
              {
                "weight": {
                  "imperial": "80 - 150",
                  "metric": "36 - 68"
                },
                "height": {
                  "imperial": "27 - 29",
                  "metric": "69 - 74"
                },
                "id": 18,
                "name": "Anatolian Shepherd Dog",
                "bred_for": "Livestock herding",
                "breed_group": "Working",
                "life_span": "11 - 13 years",
                "temperament": "Steady, Bold, Independent, Confident, Intelligent, Proud",
                "reference_image_id": "BJT0Jx5Nm"
              },
              {
                "weight": {
                  "imperial": "48 - 55",
                  "metric": "22 - 25"
                },
                "height": {
                  "imperial": "20 - 22",
                  "metric": "51 - 56"
                },
                "id": 19,
                "name": "Appenzeller Sennenhund",
                "bred_for": "Herding livestock, pulling carts, and guarding the farm",
                "life_span": "12 – 14 years",
                "temperament": "Reliable, Fearless, Energetic, Lively, Self-assured",
                "reference_image_id": "HkNkxlqEX"
              },
              {
                "weight": {
                  "imperial": "44 - 62",
                  "metric": "20 - 28"
                },
                "height": {
                  "imperial": "17 - 20",
                  "metric": "43 - 51"
                },
                "id": 21,
                "name": "Australian Cattle Dog",
                "country_code": "AU",
                "bred_for": "Cattle herding, herding trials",
                "breed_group": "Herding",
                "life_span": "12 - 14 years",
                "temperament": "Cautious, Energetic, Loyal, Obedient, Protective, Brave",
                "reference_image_id": "IBkYVm4v1"
              },
              {
                "weight": {
                  "imperial": "31 - 46",
                  "metric": "14 - 21"
                },
                "height": {
                  "imperial": "17 - 20",
                  "metric": "43 - 51"
                },
                "id": 22,
                "name": "Australian Kelpie",
                "country_code": "AU",
                "bred_for": "Farm dog, Cattle herding",
                "breed_group": "Herding",
                "life_span": "10 - 13 years",
                "temperament": "Friendly, Energetic, Alert, Loyal, Intelligent, Eager",
                "reference_image_id": "Hyq1ge9VQ"
              },
              {
                "weight": {
                  "imperial": "35 - 65",
                  "metric": "16 - 29"
                },
                "height": {
                  "imperial": "18 - 23",
                  "metric": "46 - 58"
                },
                "id": 23,
                "name": "Australian Shepherd",
                "country_code": "AU",
                "bred_for": "Sheep herding",
                "breed_group": "Herding",
                "life_span": "12 - 16 years",
                "temperament": "Good-natured, Affectionate, Intelligent, Active, Protective",
                "reference_image_id": "B1-llgq4m"
              },
              {
                "weight": {
                  "imperial": "14 - 16",
                  "metric": "6 - 7"
                },
                "height": {
                  "imperial": "10 - 11",
                  "metric": "25 - 28"
                },
                "id": 24,
                "name": "Australian Terrier",
                "country_code": "AU",
                "bred_for": "Cattle herdering, hunting snakes and rodents",
                "breed_group": "Terrier",
                "life_span": "15 years",
                "temperament": "Spirited, Alert, Loyal, Companionable, Even Tempered, Courageous",
                "reference_image_id": "r1Ylge5Vm"
              },
              {
                "weight": {
                  "imperial": "33 - 55",
                  "metric": "15 - 25"
                },
                "height": {
                  "imperial": "23 - 29",
                  "metric": "58 - 74"
                },
                "id": 25,
                "name": "Azawakh",
                "bred_for": "Livestock guardian, hunting",
                "breed_group": "Hound",
                "life_span": "10 - 13 years",
                "temperament": "Aloof, Affectionate, Attentive, Rugged, Fierce, Refined",
                "reference_image_id": "SkvZgx94m"
              },
              {
                "weight": {
                  "imperial": "40 - 65",
                  "metric": "18 - 29"
                },
                "height": {
                  "imperial": "20 - 26",
                  "metric": "51 - 66"
                },
                "id": 26,
                "name": "Barbet",
                "bred_for": "Hunting water game",
                "life_span": "13 – 15 years",
                "temperament": "Obedient, Companionable, Intelligent, Joyful",
                "reference_image_id": "HyWGexcVQ"
              },
              {
                "weight": {
                  "imperial": "22 - 24",
                  "metric": "10 - 11"
                },
                "height": {
                  "imperial": "16 - 17",
                  "metric": "41 - 43"
                },
                "id": 28,
                "name": "Basenji",
                "bred_for": "Hunting",
                "breed_group": "Hound",
                "life_span": "10 - 12 years",
                "temperament": "Affectionate, Energetic, Alert, Curious, Playful, Intelligent",
                "reference_image_id": "H1dGlxqNQ"
              },
              {
                "weight": {
                  "imperial": "35 - 40",
                  "metric": "16 - 18"
                },
                "height": {
                  "imperial": "13 - 15",
                  "metric": "33 - 38"
                },
                "id": 29,
                "name": "Basset Bleu de Gascogne",
                "bred_for": "Hunting on foot.",
                "breed_group": "Hound",
                "life_span": "10 - 14 years",
                "temperament": "Affectionate, Lively, Agile, Curious, Happy, Active",
                "reference_image_id": "BkMQll94X"
              },
              {
                "weight": {
                  "imperial": "50 - 65",
                  "metric": "23 - 29"
                },
                "height": {
                  "imperial": "14",
                  "metric": "36"
                },
                "id": 30,
                "name": "Basset Hound",
                "bred_for": "Hunting by scent",
                "breed_group": "Hound",
                "life_span": "12 - 15 years",
                "temperament": "Tenacious, Friendly, Affectionate, Devoted, Sweet-Tempered, Gentle",
                "reference_image_id": "Sy57xx9EX"
              },
              {
                "weight": {
                  "imperial": "20 - 35",
                  "metric": "9 - 16"
                },
                "height": {
                  "imperial": "13 - 15",
                  "metric": "33 - 38"
                },
                "id": 31,
                "name": "Beagle",
                "bred_for": "Rabbit, hare hunting",
                "breed_group": "Hound",
                "life_span": "13 - 16 years",
                "temperament": "Amiable, Even Tempered, Excitable, Determined, Gentle, Intelligent",
                "reference_image_id": "Syd4xxqEm"
              },
              {
                "weight": {
                  "imperial": "45 - 55",
                  "metric": "20 - 25"
                },
                "height": {
                  "imperial": "20 - 22",
                  "metric": "51 - 56"
                },
                "id": 32,
                "name": "Bearded Collie",
                "bred_for": "Sheep herding",
                "breed_group": "Herding",
                "life_span": "12 - 14 years",
                "temperament": "Self-confidence, Hardy, Lively, Alert, Intelligent, Active",
                "reference_image_id": "A09F4c1qP"
              },
              {
                "weight": {
                  "imperial": "80 - 110",
                  "metric": "36 - 50"
                },
                "height": {
                  "imperial": "24 - 27.5",
                  "metric": "61 - 70"
                },
                "id": 33,
                "name": "Beauceron",
                "bred_for": "Boar herding, hunting, guarding",
                "breed_group": "Herding",
                "life_span": "10 - 12 years",
                "temperament": "Fearless, Friendly, Intelligent, Protective, Calm",
                "reference_image_id": "HJQ8ge5V7"
              },
              {
                "weight": {
                  "imperial": "17 - 23",
                  "metric": "8 - 10"
                },
                "height": {
                  "imperial": "15 - 16",
                  "metric": "38 - 41"
                },
                "id": 34,
                "name": "Bedlington Terrier",
                "bred_for": "Killing rat, badger, other vermin",
                "breed_group": "Terrier",
                "life_span": "14 - 16 years",
                "temperament": "Affectionate, Spirited, Intelligent, Good-tempered",
                "reference_image_id": "ByK8gx947"
              },
              {
                "weight": {
                  "imperial": "40 - 80",
                  "metric": "18 - 36"
                },
                "height": {
                  "imperial": "22 - 26",
                  "metric": "56 - 66"
                },
                "id": 36,
                "name": "Belgian Malinois",
                "bred_for": "Stock herding",
                "breed_group": "Herding",
                "life_span": "12 - 14 years",
                "temperament": "Watchful, Alert, Stubborn, Friendly, Confident, Hard-working, Active, Protective",
                "reference_image_id": "r1f_ll5VX"
              },
              {
                "weight": {
                  "imperial": "40 - 65",
                  "metric": "18 - 29"
                },
                "height": {
                  "imperial": "22 - 26",
                  "metric": "56 - 66"
                },
                "id": 38,
                "name": "Belgian Tervuren",
                "bred_for": "Guarding, Drafting, Police work.",
                "breed_group": "Herding",
                "life_span": "10 - 12 years",
                "temperament": "Energetic, Alert, Loyal, Intelligent, Attentive, Protective",
                "reference_image_id": "B1KdxlcNX"
              },
              {
                "weight": {
                  "imperial": "65 - 120",
                  "metric": "29 - 54"
                },
                "height": {
                  "imperial": "23 - 27.5",
                  "metric": "58 - 70"
                },
                "id": 41,
                "name": "Bernese Mountain Dog",
                "bred_for": "Draft work",
                "breed_group": "Working",
                "life_span": "7 - 10 years",
                "temperament": "Affectionate, Loyal, Intelligent, Faithful",
                "reference_image_id": "S1fFlx5Em"
              },
              {
                "weight": {
                  "imperial": "10 - 18",
                  "metric": "5 - 8"
                },
                "height": {
                  "imperial": "9.5 - 11.5",
                  "metric": "24 - 29"
                },
                "id": 42,
                "name": "Bichon Frise",
                "bred_for": "Companion",
                "breed_group": "Non-Sporting",
                "life_span": "15 years",
                "temperament": "Feisty, Affectionate, Cheerful, Playful, Gentle, Sensitive",
                "reference_image_id": "HkuYlxqEQ"
              },
              {
                "weight": {
                  "imperial": "65 - 100",
                  "metric": "29 - 45"
                },
                "height": {
                  "imperial": "23 - 27",
                  "metric": "58 - 69"
                },
                "id": 43,
                "name": "Black and Tan Coonhound",
                "bred_for": "Hunting raccoons, night hunting",
                "breed_group": "Hound",
                "life_span": "10 - 12 years",
                "temperament": "Easygoing, Gentle, Adaptable, Trusting, Even Tempered, Lovable",
                "reference_image_id": "HJAFgxcNQ"
              },
              {
                "weight": {
                  "imperial": "80 - 110",
                  "metric": "36 - 50"
                },
                "height": {
                  "imperial": "23 - 27",
                  "metric": "58 - 69"
                },
                "id": 45,
                "name": "Bloodhound",
                "bred_for": "Trailing",
                "breed_group": "Hound",
                "life_span": "8 - 10 years",
                "temperament": "Stubborn, Affectionate, Gentle, Even Tempered",
                "reference_image_id": "Skdcgx9VX"
              },
              {
                "weight": {
                  "imperial": "45 - 80",
                  "metric": "20 - 36"
                },
                "height": {
                  "imperial": "21 - 27",
                  "metric": "53 - 69"
                },
                "id": 47,
                "name": "Bluetick Coonhound",
                "bred_for": "Hunting with a superior sense of smell.",
                "breed_group": "Hound",
                "life_span": "12 - 14 years",
                "temperament": "Friendly, Intelligent, Active",
                "reference_image_id": "rJxieg9VQ"
              },
              {
                "weight": {
                  "imperial": "110 - 200",
                  "metric": "50 - 91"
                },
                "height": {
                  "imperial": "22 - 27",
                  "metric": "56 - 69"
                },
                "id": 48,
                "name": "Boerboel",
                "bred_for": "Guarding the homestead, farm work.",
                "breed_group": "Working",
                "life_span": "10 - 12 years",
                "temperament": "Obedient, Confident, Intelligent, Dominant, Territorial",
                "reference_image_id": "HyOjge5Vm"
              },
              {
                "weight": {
                  "imperial": "30 - 45",
                  "metric": "14 - 20"
                },
                "height": {
                  "imperial": "18 - 22",
                  "metric": "46 - 56"
                },
                "id": 50,
                "name": "Border Collie",
                "bred_for": "Sheep herder",
                "breed_group": "Herding",
                "life_span": "12 - 16 years",
                "temperament": "Tenacious, Keen, Energetic, Responsive, Alert, Intelligent",
                "reference_image_id": "sGQvQUpsp"
              },
              {
                "weight": {
                  "imperial": "11.5 - 15.5",
                  "metric": "5 - 7"
                },
                "height": {
                  "imperial": "11 - 16",
                  "metric": "28 - 41"
                },
                "id": 51,
                "name": "Border Terrier",
                "bred_for": "Fox bolting, ratting",
                "breed_group": "Terrier",
                "life_span": "12 - 14 years",
                "temperament": "Fearless, Affectionate, Alert, Obedient, Intelligent, Even Tempered",
                "reference_image_id": "HJOpge9Em"
              },
              {
                "weight": {
                  "imperial": "10 - 25",
                  "metric": "5 - 11"
                },
                "height": {
                  "imperial": "16 - 17",
                  "metric": "41 - 43"
                },
                "id": 53,
                "name": "Boston Terrier",
                "bred_for": "Ratting, Companionship",
                "breed_group": "Non-Sporting",
                "life_span": "11 - 13 years",
                "temperament": "Friendly, Lively, Intelligent",
                "reference_image_id": "rkZRggqVX"
              },
              {
                "weight": {
                  "imperial": "70 - 110",
                  "metric": "32 - 50"
                },
                "height": {
                  "imperial": "23.5 - 27.5",
                  "metric": "60 - 70"
                },
                "id": 54,
                "name": "Bouvier des Flandres",
                "bred_for": "Cattle herding",
                "breed_group": "Herding",
                "life_span": "10 - 15 years",
                "temperament": "Protective, Loyal, Gentle, Intelligent, Familial, Rational",
                "reference_image_id": "Byd0xl5VX"
              },
              {
                "weight": {
                  "imperial": "50 - 70",
                  "metric": "23 - 32"
                },
                "height": {
                  "imperial": "21.5 - 25",
                  "metric": "55 - 64"
                },
                "id": 55,
                "name": "Boxer",
                "bred_for": "Bull-baiting, guardian",
                "breed_group": "Working",
                "life_span": "8 - 10 years",
                "temperament": "Devoted, Fearless, Friendly, Cheerful, Energetic, Loyal, Playful, Confident, Intelligent, Bright, Brave, Calm",
                "reference_image_id": "ry1kWe5VQ"
              },
              {
                "weight": {
                  "imperial": "25 - 40",
                  "metric": "11 - 18"
                },
                "height": {
                  "imperial": "14 - 18",
                  "metric": "36 - 46"
                },
                "id": 56,
                "name": "Boykin Spaniel",
                "bred_for": "Turkey retrieving",
                "breed_group": "Sporting",
                "life_span": "10 - 14 years",
                "temperament": "Friendly, Energetic, Companionable, Intelligent, Eager, Trainable",
                "reference_image_id": "ryHJZlcNX"
              },
              {
                "weight": {
                  "imperial": "55 - 88",
                  "metric": "25 - 40"
                },
                "height": {
                  "imperial": "21.5 - 26.5",
                  "metric": "55 - 67"
                },
                "id": 57,
                "name": "Bracco Italiano",
                "bred_for": "Versatile gun dog",
                "breed_group": "Sporting",
                "life_span": "10 - 12 years",
                "temperament": "Stubborn, Affectionate, Loyal, Playful, Companionable, Trainable",
                "reference_image_id": "S13yZg5VQ"
              },
              {
                "weight": {
                  "imperial": "70 - 90",
                  "metric": "32 - 41"
                },
                "height": {
                  "imperial": "22 - 27",
                  "metric": "56 - 69"
                },
                "id": 58,
                "name": "Briard",
                "bred_for": "Herding, guarding sheep",
                "breed_group": "Herding",
                "life_span": "10 - 12 years",
                "temperament": "Fearless, Loyal, Obedient, Intelligent, Faithful, Protective",
                "reference_image_id": "rkVlblcEQ"
              },
              {
                "weight": {
                  "imperial": "30 - 45",
                  "metric": "14 - 20"
                },
                "height": {
                  "imperial": "17.5 - 20.5",
                  "metric": "44 - 52"
                },
                "id": 59,
                "name": "Brittany",
                "bred_for": "Pointing, retrieving",
                "breed_group": "Sporting",
                "life_span": "12 - 14 years",
                "temperament": "Agile, Adaptable, Quick, Intelligent, Attentive, Happy",
                "reference_image_id": "HJWZZxc4X"
              },
              {
                "weight": {
                  "imperial": "50 - 70",
                  "metric": "23 - 32"
                },
                "height": {
                  "imperial": "21 - 22",
                  "metric": "53 - 56"
                },
                "id": 61,
                "name": "Bull Terrier",
                "bred_for": "Bull baiting, Fighting",
                "breed_group": "Terrier",
                "life_span": "10 - 12 years",
                "temperament": "Trainable, Protective, Sweet-Tempered, Keen, Active",
                "reference_image_id": "VSraIEQGd"
              },
              {
                "weight": {
                  "imperial": "25 - 33",
                  "metric": "11 - 15"
                },
                "height": {
                  "imperial": "10 - 14",
                  "metric": "25 - 36"
                },
                "id": 62,
                "name": "Bull Terrier (Miniature)",
                "bred_for": "An elegant man's fashion statement",
                "life_span": "11 – 14 years",
                "temperament": "Trainable, Protective, Sweet-Tempered, Keen, Active, Territorial",
                "reference_image_id": "BkKZWlcVX"
              },
              {
                "weight": {
                  "imperial": "100 - 130",
                  "metric": "45 - 59"
                },
                "height": {
                  "imperial": "24 - 27",
                  "metric": "61 - 69"
                },
                "id": 64,
                "name": "Bullmastiff",
                "bred_for": "Estate guardian",
                "breed_group": "Working",
                "life_span": "8 - 12 years",
                "temperament": "Docile, Reliable, Devoted, Alert, Loyal, Reserved, Loving, Protective, Powerful, Calm, Courageous",
                "reference_image_id": "r1ifZl5E7"
              },
              {
                "weight": {
                  "imperial": "13 - 14",
                  "metric": "6 - 6"
                },
                "height": {
                  "imperial": "9 - 10",
                  "metric": "23 - 25"
                },
                "id": 65,
                "name": "Cairn Terrier",
                "bred_for": "Bolting of otter, foxes, other vermin",
                "breed_group": "Terrier",
                "life_span": "14 - 15 years",
                "temperament": "Hardy, Fearless, Assertive, Gay, Intelligent, Active",
                "reference_image_id": "Sk7Qbg9E7"
              },
              {
                "weight": {
                  "imperial": "88 - 120",
                  "metric": "40 - 54"
                },
                "height": {
                  "imperial": "23.5 - 27.5",
                  "metric": "60 - 70"
                },
                "id": 67,
                "name": "Cane Corso",
                "bred_for": "Companion, guard dog, and hunter",
                "breed_group": "Working",
                "life_span": "10 - 11 years",
                "temperament": "Trainable, Reserved, Stable, Quiet, Even Tempered, Calm",
                "reference_image_id": "r15m-lc4m"
              },
              {
                "weight": {
                  "imperial": "25 - 38",
                  "metric": "11 - 17"
                },
                "height": {
                  "imperial": "10.5 - 12.5",
                  "metric": "27 - 32"
                },
                "id": 68,
                "name": "Cardigan Welsh Corgi",
                "bred_for": "Cattle droving",
                "breed_group": "Herding",
                "life_span": "12 - 14 years",
                "temperament": "Affectionate, Devoted, Alert, Companionable, Intelligent, Active",
                "reference_image_id": "SyXN-e9NX"
              }
            ]
        """
    }
}
