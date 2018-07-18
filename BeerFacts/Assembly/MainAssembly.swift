import Swinject
import SwinjectStoryboard

class MainAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(BeerListViewController.self) { (resolver, viewController) in
            let interactor = resolver.resolve(BeerListInteractor.self)!
            viewController.inject(interactor: interactor)
            interactor.view = viewController
        }
        
        container.register(BeerListInteractor.self) { resolver in
            let beerService = resolver.resolve(BeerService.self)!
            let beerListPresenter = resolver.resolve(BeerListPresenter.self)!
            
            return BeerListInteractor(beerService: beerService, beerListPresenter: beerListPresenter)
        }
        
        container.register(BeerService.self) { _ in
            return BeerService()
        }
        
        container.register(BeerListPresenter.self) { _ in
            return BeerListPresenter()
        }
    }

}
