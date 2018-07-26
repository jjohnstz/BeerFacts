@testable import BeerFacts

class MockBeerDetailsInteractor: BeerDetailsInteractorProtocol {
    public var event: BeerDetailsViewEvent?
    
    func handle(event: BeerDetailsViewEvent) {
        self.event = event
    }
}
