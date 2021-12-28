//
//  SignInViewModel.swift
//  1227MVVM
//
//  Created by 신상원 on 2021/12/28.
//

import Foundation

class SignInViewModel {
    
    var username = Observable("")
    var email = Observable("")
    var password = Observable("")
    
    func fetchSignInAPI(name: String, mail: String, password: String) {
        APIService.signin(username: name, email: mail, password: password) { userData, error in
            guard let userData = userData else {
                return
            }
//            print(userData.jwt)
//            print(userData.user.username)
//            print(userData.user.id)
//            print(userData.user.email)
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "name")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
        }
    }
}

extension SignInViewModel {
    func fetchAPI() {
        fetchSignInAPI(name: username.value, mail: email.value, password: password.value)
    }
}
