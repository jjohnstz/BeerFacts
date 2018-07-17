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
                    expect(subject[0].tagline).to(equal("A Real Bitter Experience."))
                    expect(subject[0].description).to(equal("A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once."))
                    expect(subject[0].abv).to(equal(4.5))
                    expect(subject[0].ibu).to(equal(60))
                    
                    expect(subject[1].name).to(equal("Trashy Blonde"))
                    expect(subject[1].tagline).to(equal("You Know You Shouldn't"))
                    expect(subject[1].description).to(equal("A titillating, neurotic, peroxide punk of a Pale Ale. Combining attitude, style, substance, and a little bit of low self esteem for good measure; what would your mother say? The seductive lure of the sassy passion fruit hop proves too much to resist. All that is even before we get onto the fact that there are no additives, preservatives, pasteurization or strings attached. All wrapped up with the customary BrewDog bite and imaginative twist."))
                    expect(subject[1].abv).to(equal(4.1))
                    expect(subject[1].ibu).to(equal(41.5))
                    
                    expect(subject[2].name).to(equal("Berliner Weisse With Yuzu - B-Sides"))
                    expect(subject[2].tagline).to(equal("Japanese Citrus Berliner Weisse."))
                    expect(subject[2].description).to(equal("Japanese citrus fruit intensifies the sour nature of this German classic."))
                    expect(subject[2].abv).to(equal(4.2))
                    expect(subject[2].ibu).to(beNil())
                }
                
            }
        }
    }
}
