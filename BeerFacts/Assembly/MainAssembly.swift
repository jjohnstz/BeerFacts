import Swinject
import SwinjectStoryboard

class MainAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(BeerListViewController.self) { (resolver, viewController) in
            let interactor = resolver.resolve(BeerListInteractor.self)!
            let router = resolver.resolve(SegueRouter.self)!
            
            viewController.inject(interactor: interactor, router: router)
            interactor.view = viewController
        }
        
        container.storyboardInitCompleted(BeerDetailsViewController.self) { (resolver, viewController) in
            let interactor = resolver.resolve(BeerDetailsInteractor.self)!
            let router = resolver.resolve(SegueRouter.self)!
            let imageCache = resolver.resolve(ImageCacheWrapper.self)!
            
            viewController.inject(interactor: interactor, router: router, imageCache: imageCache)
            interactor.view = viewController
        }
        
        container.register(BeerListInteractor.self) { resolver in
            let beerService = resolver.resolve(BeerService.self)!
            let beerListPresenter = resolver.resolve(BeerListPresenter.self)!
            
            return BeerListInteractor(beerService: beerService, beerListPresenter: beerListPresenter)
        }
        
        container.register(BeerDetailsInteractor.self) { resolver in
            let beerService = resolver.resolve(BeerService.self)!
            let presenter = resolver.resolve(BeerDetailsPresenter.self)!
            
            return BeerDetailsInteractor(beerService: beerService, presenter: presenter)
        }
        
        container.register(BeerService.self) { _ in
            return BeerService()
        }
        
        container.register(BeerListPresenter.self) { _ in
            return BeerListPresenter()
        }
        
        container.register(BeerDetailsPresenter.self) { _ in
            return BeerDetailsPresenter()
        }
        
        container.register(SegueRouter.self) { _ in
            return SegueRouter()
        }
        
        container.register(ImageCacheWrapper.self) { _ in
            return ImageCacheWrapper()
        }
    }
}
