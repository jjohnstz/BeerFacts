import Foundation
import UIKit

protocol SegueRouterProtocol {
    func route(from viewController: UIViewController, to segueIdentifier: String, handler: ((UIViewController) -> Void)?)
}

class SegueRouter: SegueRouterProtocol {
    var handler: ((UIViewController) -> Void)?
    
    func route(from viewController:UIViewController, to segueIdentifier: String, handler: ((UIViewController) -> Void)? = nil ) {
        self.handler = handler
        viewController.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}
