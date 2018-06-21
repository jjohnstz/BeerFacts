import Foundation

import Quick
import Nimble

@testable import BeerFacts

class BeerListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("BeerListViewController") {
            
            var subject: BeerListViewController!
            
            beforeEach {
                let storyboard = UIStoryboard(name: "BeerList", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "BeerListView") as! BeerListViewController
                self.displayViewController(subject)
            }
            
            it("should have hidden activity indicator") {
                self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.activityIndicator)
            }
            
            //TODO : view did Load
            
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
