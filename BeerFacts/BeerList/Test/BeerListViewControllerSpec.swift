import Quick
import Nimble

@testable import BeerFacts

class BeerListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("BeerListViewController") {
            
            var subject: BeerListViewController!
            var interactor: MockBeerListInteractor!
            var segueRouter: MockSegueRouter!
            
            beforeEach {
                interactor = MockBeerListInteractor()
                segueRouter = MockSegueRouter()
                
                let storyboard = UIStoryboard(name: "BeerList", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "BeerListView") as! BeerListViewController
                subject.inject(interactor: interactor, router: segueRouter)
                TestView.displayViewController(subject)
            }
            
            it("should have hidden activity indicator") {
                self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.activityIndicator)
            }
            
            it("should have sent viewDidLoad to interactor") {
                expect(interactor.event).to(equal(BeerListViewEvent.viewDidLoad))
            }
            
            describe("perform actions") {
                context("activity spinner, show = true") {
                    beforeEach {
                        subject.perform(action: .showActivityIndicator(true))
                    }
                    
                    it("should have shown activity spinner and hidden tableview, errorLabel ") {
                        self.tester().waitForView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.activityIndicator)
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.errorLabel)
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.tableView)
                    }
                }
                
                context("activity spinner, show = false") {
                    beforeEach {
                        subject.perform(action: .showActivityIndicator(false))
                    }
                    
                    it("should have hidden activity indicator") {
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.activityIndicator)
                    }
                }
                
                context("error message") {
                    let message = "Something bad"
                    
                    beforeEach {
                        subject.perform(action: .errorMessage(message))
                    }
                    
                    it("should have hidden tableview and activity spinner") {
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.activityIndicator)
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.tableView)
                    }
                    
                    it("should have shown errorLabel with message") {
                        let label = self.tester().waitForView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.errorLabel) as! UILabel
                        expect(label.text).to(equal(message))
                    }
                }
                

                
                context("display view state") {
                    let viewState = BeerListViewState(beerTableViewStates: [
                        BeerListTableViewState.testMake(name: "Beer1"),
                        BeerListTableViewState.testMake(name: "Beer2"),
                        BeerListTableViewState.testMake(name: "Beer3")
                        ])
                    
                    beforeEach {
                        subject.perform(action: .display(viewState))
                    }
                    
                    it("should have hidden errorLabel and activity spinner") {
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.activityIndicator)
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.errorLabel)
                    }
                    
                    it("should have shown tableview and  configured table view cells") {
                        let tableView = self.tester().waitForView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.tableView) as! UITableView
                        expect(tableView.numberOfRows(inSection: 0)).to(equal(3))
                        
                        let cell0 = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! BeerListTableViewCell
                        let cell1 = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! BeerListTableViewCell
                        let cell2 = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! BeerListTableViewCell
                        
                        expect(cell0.viewState).to(equal(viewState.beerTableViewStates[0]))
                        expect(cell1.viewState).to(equal(viewState.beerTableViewStates[1]))
                        expect(cell2.viewState).to(equal(viewState.beerTableViewStates[2]))
                    }
                    
                    describe("tapping cell") {
                        let index = 2
                        var tableView: UITableView!
                        
                        beforeEach {
                            tableView = self.tester().waitForView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.tableView) as! UITableView
                            self.tester().tapRow(at: IndexPath(row: index, section: 0), in: tableView)
                        }
                        
                        it("should send select index event to interactor") {
                            expect(interactor.event).to(equal(BeerListViewEvent.didSelectIndex(index)))
                        }
                        
                        describe("route to details") {
                            beforeEach {
                                subject.perform(action: .routeToBeerDetails(beerName: "Beer1"))
                            }
                            
                            it("should deselect table view row") {
                                expect(tableView.indexPathForSelectedRow).to(beNil())
                            }
                            
                            it("should call segue router") {
                                expect(segueRouter.inputViewController).to(be(subject))
                                expect(segueRouter.inputSegueIdentifier).to(equal(BeerListViewController.Constants.showDetailsSegue))
                            }
                            
                        }
                    }
                }
            }
        }
    }
}
