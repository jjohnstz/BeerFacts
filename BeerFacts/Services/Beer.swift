import Foundation

struct Beer: Codable {
    let name: String
    let tagline: String
    let description: String
    
    let abv: Double
    let ibu: Double?
}
