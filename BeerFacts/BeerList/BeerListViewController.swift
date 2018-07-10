import Foundation
import UIKit

enum BeerListViewAction: Equatable {
    case showActivityIndicator(Bool)
    case display(BeerListViewState)
}

protocol BeerListViewProcotol: class {
    func perform(action: BeerListViewAction)
}

class BeerListViewController: UIViewController, BeerListViewProcotol {
    
    enum AccessibilityLabel {
        static let activityIndicator = "activityIndicator"
        static let tableView = "tableView"
    }

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.accessibilityLabel = AccessibilityLabel.activityIndicator
            activityIndicator.isHidden = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.accessibilityLabel = AccessibilityLabel.tableView
            tableView.dataSource = self
        }
    }
    
    private var viewState: BeerListViewState? {
        didSet {
            guard viewState != nil else {
                return
            }
            
            tableView.reloadData()
        }
    }
    
    private var interactor: BeerListInteractorProtocol!
    
    func inject(interactor: BeerListInteractorProtocol) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.handle(event: .viewDidLoad)
    }
    
    func perform(action: BeerListViewAction) {
        switch(action) {
        case .showActivityIndicator(let show):
            handleShowActivityIndicator(show)
        case .display(let viewState):
            self.viewState = viewState
        }
    }
    
    private func handleShowActivityIndicator(_ show: Bool) {
        activityIndicator.isHidden = !show
    }
}

extension BeerListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState?.beerTableViewStates.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewState?.beerTableViewStates[indexPath.row].name
        return cell
    }
}
