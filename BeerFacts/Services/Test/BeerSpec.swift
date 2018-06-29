import Quick
import Nimble

@testable import BeerFacts

class BeerSpec: QuickSpec {
    override func spec() {
        describe("Beer") {
            
            var subject: [Beer]!
            
            describe("Decode Beers") {
                beforeEach {
                    let bundle = Bundle(for: type(of: self))
                    let fileUrl = bundle.url(forResource: "GetBeersFixture", withExtension: "json")
                    let jsonData: Data = try! Data(contentsOf: fileUrl!)
                    subject = try! JSONDecoder().decode([Beer].self, from: jsonData)
                }

                it("should have decoded beer data") {
                    expect(subject.count).to(equal(3))
                    
                    expect(subject[0].name).to(equal("Buzz"))
                    
                    //TODO: Finish me
                }
                
            }
        }
    }
}
