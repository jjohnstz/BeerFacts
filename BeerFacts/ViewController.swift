//
//  ViewController.swift
//  BeerFacts
//
//  Created by Jesse Johnston on 6/10/18.
//  Copyright © 2018 Jesse Johnston. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.accessibilityLabel = "InfoLabel"
        }
    }


}

