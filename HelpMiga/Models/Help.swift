//
//  Help.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 07/02/23.
//

import Firebase

struct Help: Identifiable, Codable {
    let id: String
    let requesterUid: String
    let helperUid: String
    let requesterName: String
    let helperName: String
    let requesterLocation: GeoPoint
    let helperLocation: GeoPoint
    let mettingLocationName: String
    let destinationLocationName: String
    let mettingLocationAddres: String
    let mettingLocation: GeoPoint
    let destinationLocation: GeoPoint
    var distanceToRequester: Double
    var walkingTimeToRequester: Int
    
}

