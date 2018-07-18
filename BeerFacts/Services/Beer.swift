import Foundation

struct Beer: Codable {
    let name: String
    let tagline: String
    let description: String
    
    let image_url: String
    
    let target_fg: Double
    let target_og: Double
    let ebc: Double?
    let srm: Double?
    let ph: Double?
    let attenuation_level: Double
    let abv: Double
    let ibu: Double?
    
    let food_pairing: [String]
}
