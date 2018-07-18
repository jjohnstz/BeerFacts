import Quick
import Nimble

@testable import BeerFacts

class BeerListPresenterSpec: QuickSpec {
    override func spec() {
        describe("BeerListPresenter") {
            var subject: BeerListPresenter!
            
            let beer1 = Beer.testMake(name: "Beer1", tagline: "tag1", abv: 1.5)
            let beer2 = Beer.testMake(name: "Beer2", tagline: "tag2", abv: 2.5)
            let beer3 = Beer.testMake(name: "Beer3", tagline: "tag3", abv: 3.5)
            
            var viewState: BeerListViewState!
            
            beforeEach {
                subject = BeerListPresenter()
                viewState = subject.getBeerListViewState(beers: [beer1, beer2, beer3])
            }
            
            it("should have created correct viewStates") {
                expect(viewState.beerTableViewStates[0].name).to(equal(beer1.name))
                expect(viewState.beerTableViewStates[0].tagLine).to(equal(beer1.tagline))
                expect(viewState.beerTableViewStates[0].abv).to(equal("\(beer1.abv) %"))
                
                expect(viewState.beerTableViewStates[1].name).to(equal(beer2.name))
                expect(viewState.beerTableViewStates[1].tagLine).to(equal(beer2.tagline))
                expect(viewState.beerTableViewStates[1].abv).to(equal("\(beer2.abv) %"))
                
                expect(viewState.beerTableViewStates[2].name).to(equal(beer3.name))
                expect(viewState.beerTableViewStates[2].tagLine).to(equal(beer3.tagline))
                expect(viewState.beerTableViewStates[2].abv).to(equal("\(beer3.abv) %"))
            }
        }
    }
}
