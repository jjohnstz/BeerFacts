//
//  BeerListInteractor.swift
//  BeerFacts
//
//  Created by Jesse Johnston on 6/15/18.
//  Copyright © 2018 Jesse Johnston. All rights reserved.
//

import Foundation

enum BeerListViewEvent {
    case viewDidLoad
}

protocol BeerListInteractorProtocol {
    func onViewEvent(event: BeerListViewEvent)
}

class BeerListInteractor: BeerListInteractorProtocol {
    
    let beerService: BeerService
    
    init() {
        beerService = BeerService() // TODO : inject me
    }
    
    func onViewEvent(event: BeerListViewEvent) {
        switch event {
        case .viewDidLoad:
            //TODO : tell view to show spinner
            handleViewDidLoad()
        }
    }
    
    private func handleViewDidLoad() {
        beerService.getRandom()
            .onSuccess { (beer) in
                print("Name: " + beer.name)
                print("Tagline: " + beer.tagline)
                print("Description: " + beer.description)
                print("ABV: " + String(beer.abv))
                print("IBU: " + String(beer.ibu!))
            }.onFailure { (error) in
                print("Failure")
        }
    }
    
}
