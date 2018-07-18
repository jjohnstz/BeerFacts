import BrightFutures

@testable import BeerFacts

class MockBeerService: BeerServiceProtocol {
    func getBeer(withName name: String) -> Future<Beer, BeerError> {
        //TODO
        return Promise<Beer, BeerError>().future
    }
    
    
    public var getBeersStub: Promise<[Beer], BeerError>?
    public var didCallGetBeers: Bool = false
    
    func getBeers() -> Future<[Beer], BeerError> {
        didCallGetBeers = true
        
        guard let stub = getBeersStub else {
            return Promise<[Beer], BeerError>().future
        }
        
        return stub.future
    }
}
