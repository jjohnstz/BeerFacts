@testable import BeerFacts

class MockBeerListPresenter: BeerListPresenterProtocol {
    var inputBeers: [Beer] = []
    var mockViewState: BeerListViewState = BeerListViewState(beerTableViewStates: [])
    
    func getBeerListViewState(beers: [Beer]) -> BeerListViewState {
        inputBeers = beers
        return mockViewState
    }
}
