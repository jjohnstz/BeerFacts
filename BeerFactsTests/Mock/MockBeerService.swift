import BrightFutures

@testable import BeerFacts

class MockBeerService: BeerServiceProtocol {
    public var getBeerStub: Promise<Beer, BeerError>?
    public var getBeerInput: String = ""
    
    public var getBeersStub: Promise<[Beer], BeerError>?
    public var didCallGetBeers: Bool = false
    
    
    func getBeer(withName name: String) -> Future<Beer, BeerError> {
        getBeerInput = name
        
        guard let stub = getBeerStub else {
            return Promise<Beer, BeerError>().future
        }
        
        return stub.future
    }
    
    func getBeers() -> Future<[Beer], BeerError> {
        didCallGetBeers = true
        
        guard let stub = getBeersStub else {
            return Promise<[Beer], BeerError>().future
        }
        
        return stub.future
    }
}
