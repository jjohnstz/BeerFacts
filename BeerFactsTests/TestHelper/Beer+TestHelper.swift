@testable import BeerFacts

extension Beer {
    static func testMake(name: String = "", tagline: String = "", description: String = "", image_url: String = "", target_fg: Double = 0.0, target_og: Double = 0.0, ebc: Double? = nil, srm: Double? = nil, ph: Double? = nil, attenuation_level: Double = 0.0, abv: Double = 0.0, ibu: Double? = nil, food_pairing: [String] = []) -> Beer {
        return Beer(name: name, tagline: tagline, description: description, image_url: image_url, target_fg: target_fg, target_og: target_og, ebc: ebc, srm: srm, ph: ph, attenuation_level: attenuation_level, abv: abv, ibu: ibu, food_pairing: food_pairing)
    }
}
