import Foundation
import Alamofire
import BrightFutures

public enum BeerError: Error {
    case someError //TODO, need some better errors
}

protocol BeerServiceProtocol: class {
    func getBeers() -> Future<[Beer], BeerError>
}

class BeerService: BeerServiceProtocol {
    func getBeers() -> Future<[Beer], BeerError> {
        let promise = Promise<[Beer], BeerError>()
        
        Alamofire.request("https://api.punkapi.com/v2/beers").responseJSON { response in
            
            if let jsonData = response.data{
                
                let decoder = JSONDecoder()
                let beers = try! decoder.decode([Beer].self, from: jsonData)
                
                promise.success(beers)
                
            } else {
                promise.failure(.someError)
            }
        }
        
        return promise.future
    }
}
