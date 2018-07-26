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
            var presenter: MockBeerListPresenter!
            
            beforeEach {
                view = MockBeerListViewController()
                service = MockBeerService()
                presenter = MockBeerListPresenter()
                
                subject = BeerListInteractor(beerService: service, beerListPresenter: presenter)
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
                            let beers = [Beer.testMake(name: "Beer1"), Beer.testMake(name: "Beer2")]
                            let mockViewState = BeerListViewState(beerTableViewStates: [BeerListTableViewState.testMake(name: "Beer1")])
                            
                            beforeEach {
                                presenter.mockViewState = mockViewState
                                promise.success(beers)
                            }
                            
                            it("should call presenter with data from service") {
                                expect(presenter.inputBeers).toEventually(equal(beers))
                            }
                            
                            it("should send viewState to view") {
                                expect(view.action).toEventually(equal(BeerListViewAction.display(mockViewState)))
                            }
                            
                            describe("beer selected") {
                                beforeEach {
                                    //Wait for previous test to finish
                                    expect(view.action).toEventually(equal(BeerListViewAction.display(mockViewState)))
                                    
                                    subject.handle(event: .didSelectIndex(1))
                                }
                                
                                it("should send route to view") {
                                    expect(view.action).toEventually(equal(BeerListViewAction.routeToBeerDetails(beerName: beers[1].name)))
                                }
                            }
                        }
                        
                        context("promise fails") {
                            beforeEach {
                                promise.failure(.serviceError)
                            }
                            
                            it("should display error message") {
                                expect(view.action).toEventually(equal(BeerListViewAction.errorMessage("Failed to load beers.  Sorry :(")))
                            }
                        }
                    }
                }
            }
        }
    }
}
