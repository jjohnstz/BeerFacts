@testable import BeerFacts

class MockBeerDetailsPresenter: BeerDetailsPresenterProtocol {
    var inputBeer: Beer = Beer.testMake()
    var mockViewState: BeerDetailsViewState = BeerDetailsViewState.testMake()
    
    func getViewState(beer: Beer) -> BeerDetailsViewState {
        inputBeer = beer
        return mockViewState
    }
}
