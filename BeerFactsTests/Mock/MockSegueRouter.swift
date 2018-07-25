import UIKit

@testable import BeerFacts

class MockSegueRouter: SegueRouterProtocol {
    var inputViewController: UIViewController?
    var inputSegueIdentifier: String?
    var inputHandler: ((UIViewController) -> Void)?
    
    func route(from viewController: UIViewController, to segueIdentifier: String, handler: ((UIViewController) -> Void)?) {
        inputViewController = viewController
        inputSegueIdentifier = segueIdentifier
        inputHandler = handler
    }
}

