import Foundation

struct BeerListViewState: Equatable {
    let beerTableViewStates: [BeerListTableViewState]
}

struct BeerListTableViewState: Equatable {
    let name: String
    let tagLine: String
    let abv: String
}

protocol BeerListPresenterProtocol {
    func getBeerListViewState(beers:[Beer]) -> BeerListViewState
}

class BeerListPresenter: BeerListPresenterProtocol {
    func getBeerListViewState(beers:[Beer]) -> BeerListViewState {
        var beerTableViewStates: [BeerListTableViewState] = []
        for beer in beers {
            let beerListTableViewState = BeerListTableViewState(
                name: beer.name,
                tagLine: beer.tagline,
                abv: "\(beer.abv) %")
            beerTableViewStates.append(beerListTableViewState)
        }
        
        return BeerListViewState(beerTableViewStates: beerTableViewStates)
    }
}

