import Quick
import Nimble

@testable import BeerFacts

class BeerListTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("BeerListTableViewCell") {
            var subject: BeerListTableViewCell!
            let viewState = BeerListTableViewState(name: "beerName", tagLine: "beer tag line", abv: "10.0 %")
            
            beforeEach {
                subject = Bundle.main.loadNibNamed("BeerListTableViewCell", owner: nil, options: nil)?.first as! BeerListTableViewCell
                subject.configure(with: viewState)
                
                TestView.displayTableViewCell(subject)
            }
            
            it("should have configured labels") {
                let nameLabel = self.tester().waitForView(withAccessibilityLabel: BeerListTableViewCell.AccessibilityLabel.nameLabel) as! UILabel
                let tagLabel = self.tester().waitForView(withAccessibilityLabel: BeerListTableViewCell.AccessibilityLabel.tagLabel) as! UILabel
                expect(nameLabel.text).to(equal(viewState.name))
                let abvLabel = self.tester().waitForView(withAccessibilityLabel: BeerListTableViewCell.AccessibilityLabel.abvLabel) as! UILabel
                
                expect(nameLabel.text).to(equal(viewState.name))
                expect(tagLabel.text).to(equal(viewState.tagLine))
                expect(abvLabel.text).to(equal(viewState.abv))
            }
        }
    }
}
