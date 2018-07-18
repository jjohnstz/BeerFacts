import Foundation

struct BeerDetailsViewState: Equatable {
    let name: String
    let tagline: String
    let description: String
    let abv: String
    let ibu: String
    let imageURL: URL?
    let foodPairings: [String]
}

protocol BeerDetailsPresenterProtocol {
    func getViewState(beer:Beer) -> BeerDetailsViewState
}

class BeerDetailsPresenter: BeerDetailsPresenterProtocol {
    func getViewState(beer: Beer) -> BeerDetailsViewState {
        let imageURL = URL(string: beer.image_url)
        let ibuString: String
        if let ibu = beer.ibu {
            ibuString = "IBU: \(ibu)"
        } else {
            ibuString = "IBU: Unknown"
        }
        
        return BeerDetailsViewState(
            name: beer.name,
            tagline: beer.tagline,
            description: beer.description,
            abv: "ABV: \(beer.abv) %",
            ibu: ibuString,
            imageURL: imageURL,
            foodPairings: beer.food_pairing)
    }
}
