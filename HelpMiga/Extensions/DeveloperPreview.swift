//
//  DeveloperPreview.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 05/02/23.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview{
    static let shared = DeveloperPreview()

    let mockUser = User(fullname: "Ana Leticia",
                        email: "analeticia@gmail.com",
                        uid: NSUUID().uuidString,
                        coordinates: GeoPoint(latitude: -22.97, longitude: -43.23),
                        accountMode: .inactive
                        )
}

