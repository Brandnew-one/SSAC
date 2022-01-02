//
//  ViewModel.swift
//  PUNKBeer
//
//  Created by 신상원 on 2022/01/02.
//

import Foundation

class BeerViewModel {
    
    var randomBeer: Observable<Beer> = Observable(Beer())
    var detailBool: Observable<Bool> = Observable(false)
    
    func fetchRandomBeer() {
        APIService.requestBeer { beer in
            guard let beer = beer else {
                return
            }
            self.randomBeer.value = beer
//            print(beer.first)
        }
    }
}
