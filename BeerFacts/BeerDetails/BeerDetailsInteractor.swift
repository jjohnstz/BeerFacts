import Foundation

enum BeerDetailsViewEvent: Equatable {
    case viewDidLoad(beerName:String)
}

protocol BeerDetailsInteractorProtocol {
    func handle(event: BeerDetailsViewEvent)
}

class BeerDetailsInteractor: BeerDetailsInteractorProtocol {
    
    weak var view: BeerDetailsViewProcotol?
    
    private let beerService: BeerServiceProtocol
    private let presenter: BeerDetailsPresenterProtocol
    
    init(beerService: BeerServiceProtocol, presenter: BeerDetailsPresenterProtocol) {
        self.beerService = beerService
        self.presenter = presenter
    }
    
    func handle(event: BeerDetailsViewEvent) {
        switch event {
        case .viewDidLoad(let beerName):
            handleViewDidLoad(with: beerName)
        }
    }
    
    private func handleViewDidLoad(with beerName: String) {
        view?.perform(action: .showActivityIndicator(true))

        beerService.getBeer(withName: beerName)
            .onSuccess { (beer) in
                let viewState = self.presenter.getViewState(beer: beer)
                self.view?.perform(action: .display(viewState))
            }
            .onFailure { (error) in
                self.view?.perform(action: .errorMessage("Failed to load beers.  Sorry :("))
        }
    }
    

}

