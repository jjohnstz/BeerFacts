import Foundation

enum BeerListViewEvent: Equatable {
    case viewDidLoad
    case didSelectIndex(Int)
}

protocol BeerListInteractorProtocol {
    func handle(event: BeerListViewEvent)
}

class BeerListInteractor: BeerListInteractorProtocol {
    
    private let beerService: BeerServiceProtocol
    private let beerListPresenter: BeerListPresenterProtocol
    
    private var beers: [Beer]?
    
    weak var view: BeerListViewProcotol?
    
    init(beerService: BeerServiceProtocol, beerListPresenter: BeerListPresenterProtocol) {
        self.beerService = beerService
        self.beerListPresenter = beerListPresenter
    }
    
    func handle(event: BeerListViewEvent) {
        switch event {
        case .viewDidLoad:
            handleViewDidLoad()
        case .didSelectIndex(let index):
            handleSelectIndex(index)
        }
    }
    
    private func handleViewDidLoad() {
        view?.perform(action: .showActivityIndicator(true))
        
        beerService.getBeers()
            .onSuccess { (beers) in
                self.view?.perform(action: .showActivityIndicator(false))
                
                self.beers = beers
                
                let beerListViewState = self.beerListPresenter.getBeerListViewState(beers: beers)
                self.view?.perform(action: .display(beerListViewState))
            }
            .onFailure { (error) in
                self.view?.perform(action: .errorMessage("Failed to load beers.  Sorry :("))
            }
    }
    
    private func handleSelectIndex(_ index: Int) {
        if let beer = beers?[index] {
            view?.perform(action: .routeToBeerDetails(beerName: beer.name))
        }
    }
}
