import Foundation
import UIKit

import Kingfisher

enum BeerDetailsViewAction: Equatable {
    case showActivityIndicator(Bool)
    case display(BeerDetailsViewState)
    case errorMessage(String)
}

protocol BeerDetailsViewProcotol: class {
    func perform(action: BeerDetailsViewAction)
}

class BeerDetailsViewController: UIViewController, BeerDetailsViewProcotol {
    
    enum AccessibilityLabel {
        static let activityIndicator = "activityIndicator"
        static let imageView = "imageView"
        static let nameLabel = "nameLabel"
        static let tagLabel = "tagLabel"
        static let ibuLabel = "ibuLabel"
        static let abvLabel = "abvLabel"
        static let descriptionLabel = "descriptionLabel"
        static let stackView = "stackView"
        static let errorLabel = "errorLabel"
        
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.accessibilityLabel = AccessibilityLabel.activityIndicator
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.accessibilityLabel = AccessibilityLabel.nameLabel
        }
    }
    
    @IBOutlet weak var tagLabel: UILabel! {
        didSet {
            tagLabel.accessibilityLabel = AccessibilityLabel.tagLabel
        }
    }
    
    @IBOutlet weak var ibuLabel: UILabel! {
        didSet {
            ibuLabel.accessibilityLabel = AccessibilityLabel.ibuLabel
        }
    }
    
    @IBOutlet weak var abvLabel: UILabel! {
        didSet {
            abvLabel.accessibilityLabel = AccessibilityLabel.abvLabel
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.accessibilityLabel = AccessibilityLabel.descriptionLabel
        }
    }
    
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.accessibilityLabel = AccessibilityLabel.stackView
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.accessibilityLabel = AccessibilityLabel.errorLabel
        }
    }
    
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
            
            activityIndicator.isHidden = true
            errorLabel.isHidden = true
            stackView.isHidden = false
            imageView.isHidden = false
            
            nameLabel.text = viewState.name
            tagLabel.text = viewState.tagline
            descriptionLabel.text = viewState.description
            abvLabel.text = viewState.abv
            ibuLabel.text = viewState.ibu
            
            imageCache.cacheAndDisplayImage(on: imageView, imageURL: viewState.imageURL)
            
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
    private var imageCache: ImageCacheProtocol!
    
    func inject(interactor: BeerDetailsInteractorProtocol, router: SegueRouterProtocol, imageCache: ImageCacheProtocol) {
        self.interactor = interactor
        self.router = router
        self.imageCache = imageCache
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
        case .showActivityIndicator(let show):
            handleShowActivityIndicator(show)
        case .display(let viewState):
            self.viewState = viewState
        case .errorMessage(let message):
            handleErrorMessage(message)
        }
    }
    
    private func handleShowActivityIndicator(_ show: Bool) {
        activityIndicator.isHidden = !show
        errorLabel.isHidden = true
        stackView.isHidden = true
        imageView.isHidden = true
    }
    
    private func handleErrorMessage(_ message: String) {
        activityIndicator.isHidden = true
        errorLabel.isHidden = false
        stackView.isHidden = true
        imageView.isHidden = true
        
        errorLabel.text = message
    }
}
