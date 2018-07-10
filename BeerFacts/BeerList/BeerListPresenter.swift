import Foundation

struct BeerListViewState: Equatable {
    let beerTableViewStates: [BeerListTableViewState]
}

struct BeerListTableViewState: Equatable {
    let name: String
}

protocol BeerListPresenterProtocol {
    func getBeerListViewState(beers:[Beer]) -> BeerListViewState
}

class BeerListPresenter: BeerListPresenterProtocol {
    func getBeerListViewState(beers:[Beer]) -> BeerListViewState {
        var beerTableViewStates: [BeerListTableViewState] = []
        for beer in beers {
            let beerListTableViewState = BeerListTableViewState(name: beer.name)
            beerTableViewStates.append(beerListTableViewState)
        }
        
        return BeerListViewState(beerTableViewStates: beerTableViewStates)
    }
}
