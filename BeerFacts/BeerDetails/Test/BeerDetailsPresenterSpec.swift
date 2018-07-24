import Quick
import Nimble

@testable import BeerFacts

class BeerDetailsPresenterSpec: QuickSpec {
    override func spec() {
        describe("BeerDetailsPresenter") {
            var subject: BeerDetailsPresenter!
            let beer = Beer.testMake(
                name: "Beer1",
                tagline: "tag1",
                description: "This beer is great",
                image_url: "https://fake.com/image",
                abv: 1.5,
                food_pairing: ["food1", "food2"])
            
            var viewState: BeerDetailsViewState!
            
            beforeEach {
                subject = BeerDetailsPresenter()
                viewState = subject.getViewState(beer: beer)
            }
            
            it("should have created correct viewState") {
                expect(viewState.name).to(equal(beer.name))
                expect(viewState.tagline).to(equal(beer.tagline))
                expect(viewState.description).to(equal(beer.description))
                expect(viewState.abv).to(equal("ABV: 1.5 %"))
                expect(viewState.imageURL).to(equal(URL(string:beer.image_url)))
                expect(viewState.foodPairings).to(equal(beer.food_pairing))
            }
            
            describe("ibu") {
                context("beer ibu is nil") {
                    beforeEach {
                        viewState = subject.getViewState(beer: Beer.testMake(ibu: nil))
                    }
                    
                    it("it should be Unkown") {
                        expect(viewState.ibu).to(equal("IBU: Unknown"))
                    }
                    
                }
                
                context("beer ibu is NOT nil") {
                    beforeEach {
                        viewState = subject.getViewState(beer: Beer.testMake(ibu: 7.0))
                    }
                    
                    it("it should be IBU value") {
                        expect(viewState.ibu).to(equal("IBU: 7.0"))
                    }
                }
            }
        }
    }
}
