//
//  BoardsViewModel.swift
//  1227MVVM
//
//  Created by 신상원 on 2021/12/28.
//

import Foundation

class BoardsViewModel {
    
    var text = Observable("")
    var username = Observable("")
    var email = Observable("")
    var createdDate = Observable("")
    
    func fetchBoards() {
        let token = UserDefaults.standard.string(forKey: "token")!
        APIService.board(token: token) { userData, error in
            guard let userData = userData else {
                return
            }
            self.text.value = userData.first?.text ?? "ERROR"
            self.username.value = userData.first?.usersPermissionsUser.username ?? "ERROR"
            self.email.value = userData.first?.usersPermissionsUser.email ?? "ERROR"
            self.createdDate.value = userData.first?.createdAt ?? "ERROR"
        }
    }
}
