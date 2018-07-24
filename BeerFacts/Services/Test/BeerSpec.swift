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

                it("should have decoded data for first beer") {
                    expect(subject.count).to(equal(3))
                    
                    expect(subject[0].name).to(equal("Buzz"))
                    expect(subject[0].tagline).to(equal("A Real Bitter Experience."))
                    expect(subject[0].description).to(equal("A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once."))
                    expect(subject[0].abv).to(equal(4.5))
                    expect(subject[0].ibu).to(equal(60))
                    expect(subject[0].image_url).to(equal("https://images.punkapi.com/v2/keg.png"))
                    expect(subject[0].target_fg).to(equal(1010))
                    expect(subject[0].target_og).to(equal(1044))
                    expect(subject[0].ebc).to(equal(20))
                    expect(subject[0].srm).to(equal(10))
                    expect(subject[0].ph).to(equal(4.4))
                    expect(subject[0].attenuation_level).to(equal(75))
                    expect(subject[0].food_pairing).to(equal(["Spicy chicken tikka masala",
                                                              "Grilled chicken quesadilla",
                                                              "Caramel toffee cake"]))
                }
                
                it("should have decoded data for second beer") {
                    expect(subject[1].name).to(equal("Trashy Blonde"))
                    expect(subject[1].tagline).to(equal("You Know You Shouldn't"))
                    expect(subject[1].description).to(equal("A titillating, neurotic, peroxide punk of a Pale Ale. Combining attitude, style, substance, and a little bit of low self esteem for good measure; what would your mother say? The seductive lure of the sassy passion fruit hop proves too much to resist. All that is even before we get onto the fact that there are no additives, preservatives, pasteurization or strings attached. All wrapped up with the customary BrewDog bite and imaginative twist."))
                    expect(subject[1].abv).to(equal(4.1))
                    expect(subject[1].ibu).to(equal(41.5))
                    expect(subject[1].image_url).to(equal("https://images.punkapi.com/v2/2.png"))
                    expect(subject[1].target_fg).to(equal(1010))
                    expect(subject[1].target_og).to(equal(1041.7))
                    expect(subject[1].ebc).to(equal(15))
                    expect(subject[1].srm).to(equal(15))
                    expect(subject[1].ph).to(equal(4.4))
                    expect(subject[1].attenuation_level).to(equal(76))
                    expect(subject[1].food_pairing).to(equal(["Fresh crab with lemon",
                                                              "Garlic butter dipping sauce",
                                                              "Goats cheese salad",
                                                              "Creamy lemon bar doused in powdered sugar"]))
                }
                
                it("should have decoded data for third beer") {
                    expect(subject[2].name).to(equal("Berliner Weisse With Yuzu - B-Sides"))
                    expect(subject[2].tagline).to(equal("Japanese Citrus Berliner Weisse."))
                    expect(subject[2].description).to(equal("Japanese citrus fruit intensifies the sour nature of this German classic."))
                    expect(subject[2].abv).to(equal(4.2))
                    expect(subject[2].ibu).to(beNil())
                    expect(subject[2].image_url).to(equal("https://images.punkapi.com/v2/keg.png"))
                    expect(subject[2].target_fg).to(equal(1007))
                    expect(subject[2].target_og).to(equal(1040))
                    expect(subject[2].ebc).to(equal(8))
                    expect(subject[2].srm).to(equal(4))
                    expect(subject[2].ph).to(equal(3.2))
                    expect(subject[2].attenuation_level).to(equal(83))
                    expect(subject[2].food_pairing).to(equal(["Smoked chicken wings",
                                                              "Miso ramen",
                                                              "Yuzu cheesecake"]))
                }
                
            }
        }
    }
}
