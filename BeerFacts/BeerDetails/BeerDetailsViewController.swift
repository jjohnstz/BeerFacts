import Foundation
import UIKit

import Kingfisher

enum BeerDetailsViewAction: Equatable {
    case showActivityIndicator(Bool)
    case display(BeerDetailsViewState)
}

protocol BeerDetailsViewProcotol: class {
    func perform(action: BeerDetailsViewAction)
}

class BeerDetailsViewController: UIViewController, BeerDetailsViewProcotol {
    
    enum AccessibilityLabel {
        static let activityIndicator = "activityIndicator"
        static let imageView = "imageView"
    }
    
    //TODO : add accessibility labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var ibuLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.accessibilityLabel = AccessibilityLabel.imageView
        }
    }
    
    private var beerName: String?
    
    private var viewState: BeerDetailsViewState? {
        didSet {
            guard let viewState = viewState else {
                return
            }
            
            nameLabel.text = viewState.name
            tagLabel.text = viewState.tagline
            descriptionLabel.text = viewState.description
            abvLabel.text = viewState.abv
            ibuLabel.text = viewState.ibu
            imageView.kf.setImage(with: viewState.imageURL) //TODO: create wrapper for Kingfisher
            
            for pairing in viewState.foodPairings {
                let label = UILabel()
                label.text = pairing
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
                label.font = UIFont.systemFont(ofSize: 15)
                
                stackView.addArrangedSubview(label)
            }
        }
    }
 
    private var interactor: BeerDetailsInteractorProtocol!
    private var router: SegueRouterProtocol!
    
    func inject(interactor: BeerDetailsInteractorProtocol, router: SegueRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func configure(beerName: String) {
        self.beerName = beerName
    }
    
    override func viewDidLoad() {
        if let beerName = beerName {
            interactor.handle(event: .viewDidLoad(beerName: beerName))
        }
    }
    
    func perform(action: BeerDetailsViewAction) {
        switch(action) {
        case .showActivityIndicator(_):
            break //TODO
        case .display(let viewState):
            self.viewState = viewState
        }
    }
}
