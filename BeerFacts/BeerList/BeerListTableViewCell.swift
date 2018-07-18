import Foundation
import UIKit

class BeerListTableViewCell: UITableViewCell {
    
    enum AccessibilityLabel {
        static let nameLabel = "nameLabel"
        static let tagLabel = "tagLabel"
        static let abvLabel = "abvLabel"
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
    
    @IBOutlet weak var abvLabel: UILabel! {
        didSet {
            abvLabel.accessibilityLabel = AccessibilityLabel.abvLabel
        }
    }
    
    var viewState: BeerListTableViewState? {
        didSet {
            guard let viewState = viewState else {
                return
            }
            
            nameLabel.text = viewState.name
            tagLabel.text = viewState.tagLine
            abvLabel.text = viewState.abv
        }
    }
    
    func configure(with viewState: BeerListTableViewState) {
        self.viewState = viewState
    }
}
