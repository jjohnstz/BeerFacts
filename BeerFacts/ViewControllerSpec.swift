import Foundation

import Quick
import Nimble

@testable import BeerFacts

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("ViewController") {
            
            var subject: ViewController!
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "CoolView") as! ViewController
                self.displayViewController(subject)
            }
            
            it("should be setup") {
                let label = self.tester().waitForView(withAccessibilityLabel: "InfoLabel") as! UILabel
                expect(label.text).to(equal("Cool info"))
            }

        }
    }
}
