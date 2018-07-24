@testable import BeerFacts

extension BeerListTableViewState {
    static func testMake(name: String = "", tagLine: String = "", abv: String = "") -> BeerListTableViewState {
        return BeerListTableViewState(name: name, tagLine: tagLine, abv: abv)
    }
}
