//
//  Trip.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 07/02/23.
//

import Firebase

struct Trip: Identifiable, Codable {
    let id: String
    let requesterUid: String
    let helperUid: String
    let requesterName: String
    let helperName: String
    let requesterLocation: GeoPoint
    let helperLocation: GeoPoint
    let gatheringLocationName: String
    let destinationLocationName: String
    let gadheringLocationAddres: String
    let gatheringLocation: GeoPoint
    let destinationLocation: GeoPoint
}

