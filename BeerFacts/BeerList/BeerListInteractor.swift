import Foundation

enum BeerListViewEvent: Equatable {
    case viewDidLoad
}

protocol BeerListInteractorProtocol {
    func handle(event: BeerListViewEvent)
}

class BeerListInteractor: BeerListInteractorProtocol {
    
    private let beerService: BeerServiceProtocol
    
    weak var view: BeerListViewProcotol?
    
    init(beerService: BeerServiceProtocol) {
        self.beerService = beerService
    }
    
    func handle(event: BeerListViewEvent) {
        switch event {
        case .viewDidLoad:
            handleViewDidLoad()
        }
    }
    
    private func handleViewDidLoad() {
        view?.perform(action: .showActivityIndicator(true))
        
        beerService.getBeers()
            .onSuccess { (beers) in
                self.view?.perform(action: .showActivityIndicator(false))
                print("Finished loading beers")
            }
            .onFailure { (error) in
                print("Failure")
                //TODO : Display something to user
            }
    }
    
}
