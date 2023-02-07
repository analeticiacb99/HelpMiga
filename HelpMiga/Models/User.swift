//
//  User.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 03/02/23.
//

import Firebase

enum AccountMode: Int, Codable {
    case inactive = 0
    case active = 1
}

struct User: Codable {
    let fullname: String
    let email: String
    let uid: String
    var coordinates: GeoPoint
    var accountMode: AccountMode
}
