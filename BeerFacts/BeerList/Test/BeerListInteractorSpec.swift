import BrightFutures
import Quick
import Nimble

@testable import BeerFacts

class BeerListInteractorSpec: QuickSpec {
    override func spec() {
        describe("BeerListInteractor") {
            
            var subject: BeerListInteractor!
            var view: MockBeerListViewController!
            var service: MockBeerService!
            
            beforeEach {
                view = MockBeerListViewController()
                service = MockBeerService()
                
                subject = BeerListInteractor(beerService: service)
                subject.view = view
            }
            
            describe("handle events") {
                describe("viewDidLoad event") {
                    var promise: Promise<[Beer], BeerError>!
                    
                    beforeEach {
                        promise = Promise<[Beer], BeerError>()
                        service.getBeersStub = promise
                        
                        subject.handle(event: .viewDidLoad)
                    }
                    
                    it("should send showActivityIndicator with true") {
                        expect(view.action).to(equal(BeerListViewAction.showActivityIndicator(true)))
                    }
                    
                    it("should have called getBeers()") {
                        expect(service.didCallGetBeers).to(beTrue())
                    }
                    
                    describe("resolving promise") {
                        context("promise suceeds") {
                            beforeEach {
                                //TODO:
                                //promise.success()
                            }
                        }
                        
                        context("promise fails") {
                            beforeEach {
                                //TODO:
                                //promise.failure()
                            }
                        }
                    }
                }
            }
        }
    }
}
