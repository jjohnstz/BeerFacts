@testable import BeerFacts

class MockBeerDetailsViewController: BeerDetailsViewProcotol {
    public var action: BeerDetailsViewAction?
    
    func perform(action: BeerDetailsViewAction) {
        self.action = action
    }
}
