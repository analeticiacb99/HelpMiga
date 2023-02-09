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
    
    let mockHelp = Help(requesterUid: NSUUID().uuidString,
                        helperUid: NSUUID().uuidString,
                        requesterName: "Ana Leticia 1",
                        helperName: "Ana Leticia 2",
                        requesterLocation: .init(latitude: -22.91, longitude: -43.19),
                        helperLocation: .init(latitude: -22.91, longitude: -43.19),
                        mettingLocationName: "Apple Campus",
                        destinationLocationName: "Starbuks",
                        mettingLocationAddress: "123 Main street, palo alto CA",
                        mettingLocation: .init(latitude: -22.91, longitude: -43.19),
                        destinationLocation: .init(latitude: -22.91, longitude: -43.19),
                        distanceToRequester: 0,
                        walkingTimeToRequester: 0,
                        state: .rejected)

    let mockUser = User(fullname: "Ana Leticia",
                        email: "analeticia@gmail.com",
                        uid: NSUUID().uuidString,
                        coordinates: GeoPoint(latitude: -22.97, longitude: -43.23),
                        accountMode: .inactive
                        )
}

