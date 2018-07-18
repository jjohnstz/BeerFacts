import Foundation
import UIKit

enum BeerListViewAction: Equatable {
    case showActivityIndicator(Bool)
    case display(BeerListViewState)
    case errorMessage(String)
    case routeToBeerDetails(beerName: String)
}

protocol BeerListViewProcotol: class {
    func perform(action: BeerListViewAction)
}

class BeerListViewController: UIViewController, BeerListViewProcotol {
    
    enum AccessibilityLabel {
        static let activityIndicator = "activityIndicator"
        static let tableView = "tableView"
    }
    
    enum Constants {
        static let showDetailsSegue = "ShowBeerDetails"
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
            tableView.delegate = self
            
            tableView.register(UINib(nibName: BeerListTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: BeerListTableViewCell.identifier)
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
    private var router: SegueRouterProtocol!
    
    func inject(interactor: BeerListInteractorProtocol, router: SegueRouterProtocol) {
        self.interactor = interactor
        self.router = router
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
        case .errorMessage(_):
            break //TODO
        case .routeToBeerDetails(let name):
            handleRouteToBeerDetails(name: name)
        }
    }
    
    private func handleShowActivityIndicator(_ show: Bool) {
        activityIndicator.isHidden = !show
    }
    
    private func handleRouteToBeerDetails(name: String) {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
        
        router.route(from: self, to: Constants.showDetailsSegue) { (destinationVC) in
            if let beerDetailsVC = destinationVC as? BeerDetailsViewController {
                beerDetailsVC.configure(beerName: name)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let router = sender as? SegueRouter {
            router.handler?(segue.destination)
        }
    }
}

extension BeerListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState?.beerTableViewStates.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListTableViewCell.identifier, for: indexPath) as? BeerListTableViewCell, let viewState = viewState?.beerTableViewStates[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewState)
        return cell
    }
}

extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.handle(event: .didSelectIndex(indexPath.row))
    }
}
