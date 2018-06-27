@testable import BeerFacts

class MockBeerListViewController: BeerListViewProcotol {
    public var action: BeerListViewAction?
    
    func perform(action: BeerListViewAction) {
        self.action = action
    }
}
