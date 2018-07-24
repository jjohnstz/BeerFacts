import Quick
import Nimble
import Swinject
import SwinjectStoryboard

@testable import BeerFacts

class MainAssemblySpec: QuickSpec {
    override func spec() {
        describe("MainAssembly") {
            var resolver: Resolver!
            let testContainer = Container()
            
            beforeEach {
                let assemblies = [MainAssembly()]
                let assembler = Assembler(assemblies, container: testContainer)
                
                resolver = assembler.resolver
            }
            
            describe("BeerListViewController") {
                var beerListViewController: BeerListViewController?
                
                beforeEach {
                    let storyboard = SwinjectStoryboard.create(name: "BeerList", bundle: nil, container: testContainer)
                    beerListViewController = storyboard.instantiateInitialViewController() as? BeerListViewController
                }
                
                it("should get resolved") {
                    expect(beerListViewController).toNot(beNil())
                }
            }
            
            describe("BeerListInteractor") {
                var beerListInteractor: BeerListInteractor?
                
                beforeEach {
                    beerListInteractor = resolver.resolve(BeerListInteractor.self)
                }
                
                it("should get resolved") {
                    expect(beerListInteractor).toNot(beNil())
                }
            }
            
            describe("BeerDetailsViewController") {
                var beerDetailsViewController: BeerDetailsViewController?
                
                beforeEach {
                    let storyboard = SwinjectStoryboard.create(name: "BeerDetails", bundle: nil, container: testContainer)
                    beerDetailsViewController = storyboard.instantiateInitialViewController() as? BeerDetailsViewController
                }
                
                it("should get resolved") {
                    expect(beerDetailsViewController).toNot(beNil())
                }
            }
            
            describe("BeerService") {
                var beerService: BeerService?
                
                beforeEach {
                    beerService = resolver.resolve(BeerService.self)
                }
                
                it("should get resolved") {
                    expect(beerService).toNot(beNil())
                }
            }
            
            describe("SegueRouter") {
                var segueRouter: SegueRouter?
                
                beforeEach {
                    segueRouter = resolver.resolve(SegueRouter.self)
                }
                
                it("should get resolved") {
                    expect(segueRouter).toNot(beNil())
                }
            }
        }
    }
}
