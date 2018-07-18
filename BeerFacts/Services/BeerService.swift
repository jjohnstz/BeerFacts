import Foundation
import Alamofire
import BrightFutures

public enum BeerError: Error {
    case decodeError
    case serviceError
}

protocol BeerServiceProtocol: class {
    func getBeers() -> Future<[Beer], BeerError>
    func getBeer(withName name:String) -> Future<Beer, BeerError>
}

class BeerService: BeerServiceProtocol {
    private enum Constants {
        static let beersEndPoint = "https://api.punkapi.com/v2/beers"
        static let beerNameParam = "beer_name"
    }
    
    func getBeers() -> Future<[Beer], BeerError> {
        let promise = Promise<[Beer], BeerError>()
        
        Alamofire.request(Constants.beersEndPoint).responseJSON { response in
            if let jsonData = response.data{
                do {
                    let beers = try JSONDecoder().decode([Beer].self, from: jsonData)
                    promise.success(beers)
                }
                catch {
                    promise.failure(.decodeError)
                }
            } else {
                promise.failure(.serviceError)
            }
        }
        
        return promise.future
    }
    
    func getBeer(withName name:String) -> Future<Beer, BeerError> {
        let promise = Promise<Beer, BeerError>()

        let parameters: Parameters = [Constants.beerNameParam: name]

        Alamofire.request(Constants.beersEndPoint,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .queryString)).responseJSON { response in
            if let jsonData = response.data{
                do {
                    let beer = try JSONDecoder().decode([Beer].self, from: jsonData)[0]
                    promise.success(beer)
                }
                catch {
                    promise.failure(.decodeError)
                }
            } else {
                promise.failure(.serviceError)
            }
        }
        
        return promise.future
    }
}
