//
//  TVShowViewModel.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/29.
//

import Foundation

class TVShowViewModel {
    
    var tvTrendingWeek: Observable<TVShow> = Observable(TVShow(page: 0, results: [], totalPages: 0, totalResults: 0))
    
    func fetchTrendingWeek() {
        APIService.requestCast { trending in
            guard let trending = trending else {
                return
            }
            self.tvTrendingWeek.value = trending
        }
    }
}

extension TVShowViewModel {
    var numberOfItemsInSection: Int {
        return tvTrendingWeek.value.results.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> Result {
        return tvTrendingWeek.value.results[indexPath.item]
    }
    
}
