import Foundation
import UIKit

// Helpers to display view controller so that KIF can interact with it
class TestView {
    
    static func displayViewController(_ viewController: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    static func displayTableViewCell(_ cell: UITableViewCell) {
        let tableViewController = UITableViewController()
        
        let delegate = TableViewCellDelegate(cell)
        tableViewController.tableView.delegate = delegate
        tableViewController.tableView.dataSource = delegate
        
        displayViewController(tableViewController)
    }
}

private class TableViewCellDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    let tableViewCell: UITableViewCell
    
    init(_ cell: UITableViewCell) {
        self.tableViewCell = cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewCell
    }
}


