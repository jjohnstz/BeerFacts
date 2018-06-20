//
//  BeerListViewController.swift
//  BeerFacts
//
//  Created by Jesse Johnston on 6/15/18.
//  Copyright © 2018 Jesse Johnston. All rights reserved.
//

import Foundation
import UIKit

protocol BeerListViewProcotol {
    
}

class BeerListViewController: UIViewController, BeerListViewProcotol {
    
    private var interactor: BeerListInteractorProtocol!
    
    func inject(interactor: BeerListInteractorProtocol) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.onViewEvent(event: .viewDidLoad)
    }
}
