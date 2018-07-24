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
//        view?.perform(action: .showActivityIndicator(true)) //TODO

        print("looking for a beer", beerName)
        beerService.getBeer(withName: beerName)
            .onSuccess { (beer) in
                print("Found a beer: ", beer)
                //self.view?.perform(action: .showActivityIndicator(false))

                let viewState = self.presenter.getViewState(beer: beer)
                self.view?.perform(action: .display(viewState))
            }
            .onFailure { (error) in
                print("failed to find a beer", error)
                //TODO : self.view?.perform(action: .errorMessage("Failed to load beers.  Sorry :("))
        }
    }
    

}

