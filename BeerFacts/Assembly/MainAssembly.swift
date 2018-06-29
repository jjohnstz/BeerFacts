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
            return BeerListInteractor(beerService: beerService)
        }
        
        container.register(BeerService.self) { _ in
            return BeerService()
        }
    }

}
