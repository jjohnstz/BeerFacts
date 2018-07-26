import BrightFutures
import Quick
import Nimble

@testable import BeerFacts

class BeerDetailsInteractorSpec: QuickSpec {
    override func spec() {
        describe("BeerDetailsInteractor") {
            
            var subject: BeerDetailsInteractor!
            var view: MockBeerDetailsViewController!
            var service: MockBeerService!
            var presenter: MockBeerDetailsPresenter!
            
            beforeEach {
                view = MockBeerDetailsViewController()
                service = MockBeerService()
                presenter = MockBeerDetailsPresenter()
                
                subject = BeerDetailsInteractor(beerService: service, presenter: presenter)
                subject.view = view
            }
            
            describe("handle events") {
                describe("viewDidLoad event") {
                    var promise: Promise<Beer, BeerError>!
                    let beerName = "Beer1"
                    
                    beforeEach {
                        promise = Promise<Beer, BeerError>()
                        service.getBeerStub = promise
                        
                        subject.handle(event: .viewDidLoad(beerName: beerName))
                    }

                    it("should send showActivityIndicator with true") {
                        expect(view.action).to(equal(BeerDetailsViewAction.showActivityIndicator(true)))
                    }

                    it("should have called getBeers()") {
                        expect(service.getBeerInput).to(equal(beerName))
                    }

                    describe("resolving promise") {
                        context("promise suceeds") {
                            let beer = Beer.testMake(name: "Beer1")
                            let mockViewState = BeerDetailsViewState.testMake(name: "Beer1")
                            
                            beforeEach {
                                presenter.mockViewState = mockViewState
                                promise.success(beer)
                            }

                            it("should call presenter with data from service") {
                                expect(presenter.inputBeer).toEventually(equal(beer))
                            }

                            it("should send viewState to view") {
                                expect(view.action).toEventually(equal(BeerDetailsViewAction.display(mockViewState)))
                            }
                        }

                        context("promise fails") {
                            beforeEach {
                                promise.failure(.serviceError)
                            }
                            
                            it("should display error message") {
                                expect(view.action).toEventually(equal(BeerDetailsViewAction.errorMessage("Failed to load beers.  Sorry :(")))
                            }
                        }
                    }
                }
            }
        }
    }
}

