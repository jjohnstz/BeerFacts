@testable import BeerFacts

class MockBeerListPresenter: BeerListPresenterProtocol {
    func getBeerListViewState(beers: [Beer]) -> BeerListViewState {
        return BeerListViewState(beerTableViewStates: [])
    }
}
