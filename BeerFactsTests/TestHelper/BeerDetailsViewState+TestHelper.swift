import Foundation

@testable import BeerFacts

extension BeerDetailsViewState {
    static func testMake(name: String = "", tagline: String = "", description: String = "", abv: String = "", ibu: String = "", imageURL: URL? = nil, foodPairings: [String] = []) -> BeerDetailsViewState {
        return BeerDetailsViewState(name: name, tagline: tagline, description: description, abv: abv, ibu: ibu, imageURL: imageURL, foodPairings: foodPairings)
    }
}
