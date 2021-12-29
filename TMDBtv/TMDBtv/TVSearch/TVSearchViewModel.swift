//
//  TVSearchViewModel.swift
//  TMDBtv
//
//  Created by 신상원 on 2021/12/29.
//

import Foundation

class TVSearchViewModel {
    
    var tvSearch: Observable<TVSearch> = Observable(TVSearch(page: 0, results: [], totalPages: 0, totalResults: 0))
    
    func fetchTvSearch(query: String) {
        APIService.requestDetail(query) { search in
            print(search)
            guard let search = search else {
                print("Fetch ERROR")
                return
            }
            self.tvSearch.value = search
        }
    }
}

extension TVSearchViewModel {
    
    var numberOfItemsInSection: Int {
        return tvSearch.value.results.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> ResultSearch {
        return tvSearch.value.results[indexPath.item]
    }
}
