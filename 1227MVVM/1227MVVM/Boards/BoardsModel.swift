//
//  BoardsModel.swift
//  1227MVVM
//
//  Created by 신상원 on 2021/12/28.
//

import Foundation

// MARK: - BoardElement
struct BoardElement: Codable {
    let id: Int
    let text: String
    let usersPermissionsUser: UsersPermissionsUser
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text
        case usersPermissionsUser = "users_permissions_user"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UsersPermissionsUser
struct UsersPermissionsUser: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let role: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias Board = [BoardElement]

