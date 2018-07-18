import Foundation

enum BeerListViewEvent: Equatable {
    case viewDidLoad
}

protocol BeerListInteractorProtocol {
    func handle(event: BeerListViewEvent)
}

class BeerListInteractor: BeerListInteractorProtocol {
    
    private let beerService: BeerServiceProtocol
    private let beerListPresenter: BeerListPresenterProtocol
    
    weak var view: BeerListViewProcotol?
    
    init(beerService: BeerServiceProtocol, beerListPresenter: BeerListPresenterProtocol) {
        self.beerService = beerService
        self.beerListPresenter = beerListPresenter
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
                
                let beerListViewState = self.beerListPresenter.getBeerListViewState(beers: beers)
                self.view?.perform(action: .display(beerListViewState))
            }
            .onFailure { (error) in
                print("Failure")
                //TODO : Display something to user
            }
    }
    
}
