//
//  MainAssembly.swift
//  BeerFacts
//
//  Created by Jesse Johnston on 6/18/18.
//  Copyright © 2018 Jesse Johnston. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class MainAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(BeerListViewController.self) { (resolver, viewController) in
            let interactor = BeerListInteractor()
            viewController.inject(interactor: interactor)
        }
        
    }
    

}
