@testable import BeerFacts

class MockBeerListInteractor: BeerListInteractorProtocol {
    public var event: BeerListViewEvent?
    
    func handle(event: BeerListViewEvent) {
        self.event = event
    }
}
