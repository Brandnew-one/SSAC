//
//  SignInModel.swift
//  1227MVVM
//
//  Created by 신상원 on 2021/12/28.
//

import Foundation

// MARK: - User
struct User: Codable {
    let jwt: String
    let user: UserClass
}

// MARK: - UserClass
struct UserClass: Codable {
    let id: Int
    let username, email: String
}
