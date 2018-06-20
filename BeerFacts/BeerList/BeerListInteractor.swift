import Foundation

enum BeerListViewEvent {
    case viewDidLoad
}

protocol BeerListInteractorProtocol {
    func onViewEvent(event: BeerListViewEvent)
}

class BeerListInteractor: BeerListInteractorProtocol {
    
    private let beerService: BeerService
    
    weak var view: BeerListViewProcotol?
    
    init(beerService: BeerService) {
        self.beerService = beerService
    }
    
    func onViewEvent(event: BeerListViewEvent) {
        switch event {
        case .viewDidLoad:
            handleViewDidLoad()
        }
    }
    
    private func handleViewDidLoad() {
        view?.perform(action: .showActivityIndicator(true))
        
        beerService.getRandom()
            .onSuccess { (beer) in
                self.view?.perform(action: .showActivityIndicator(false))
                print("Finished loading beers")
            }
            .onFailure { (error) in
                print("Failure")
                //TODO : Display something to user
            }
    }
    
}
