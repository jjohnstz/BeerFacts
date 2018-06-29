import Quick
import Nimble

@testable import BeerFacts

class BeerListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("BeerListViewController") {
            
            var subject: BeerListViewController!
            var interactor: MockBeerListInteractor!
            
            beforeEach {
                interactor = MockBeerListInteractor()
                
                let storyboard = UIStoryboard(name: "BeerList", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "BeerListView") as! BeerListViewController
                subject.inject(interactor: interactor)
                self.displayViewController(subject)
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
                    
                    it("should have shown activity spinner") {
                        self.tester().waitForView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.activityIndicator)
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
            }
        }
    }
}
