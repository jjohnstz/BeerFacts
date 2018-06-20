import Foundation
import UIKit

enum BeerListViewAction {
    case showActivityIndicator(Bool)
}

protocol BeerListViewProcotol: class {
    func perform(action: BeerListViewAction)
}

class BeerListViewController: UIViewController, BeerListViewProcotol {
    
    enum AccessibilityLabel {
        static let activityIndicator = "activityIndicator"
    }

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.accessibilityLabel = AccessibilityLabel.activityIndicator
            activityIndicator.isHidden = true
        }
    }
    
    private var interactor: BeerListInteractorProtocol!
    
    func inject(interactor: BeerListInteractorProtocol) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.onViewEvent(event: .viewDidLoad)
    }
    
    func perform(action: BeerListViewAction) {
        switch(action) {
        case .showActivityIndicator(let show):
            handleShowActivityIndicator(show)
        }
    }
    
    private func handleShowActivityIndicator(_ show: Bool) {
        activityIndicator.isHidden = !show
    }
}
