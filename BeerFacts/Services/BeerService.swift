import Foundation
import Alamofire
import BrightFutures

public enum BeerError: Error {
    case decodeError
    case serviceError
}

protocol BeerServiceProtocol: class {
    func getBeers() -> Future<[Beer], BeerError>
}

class BeerService: BeerServiceProtocol {
    private enum Constants {
        static let beersEndPoint = "https://api.punkapi.com/v2/beers"
    }
    
    func getBeers() -> Future<[Beer], BeerError> {
        let promise = Promise<[Beer], BeerError>()
        
        Alamofire.request(Constants.beersEndPoint).responseJSON { response in
            if let jsonData = response.data{
                guard let beers = try? JSONDecoder().decode([Beer].self, from: jsonData) else {
                    promise.failure(.decodeError)
                    return
                }
                
                promise.success(beers)
            } else {
                promise.failure(.serviceError)
            }
        }
        
        return promise.future
    }
}
