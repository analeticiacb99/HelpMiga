//
//  Help.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 07/02/23.
//

import FirebaseFirestoreSwift
import Firebase

enum HelpState: Int, Codable {
    case requested
    case rejected
    case accepted
    case requesterCancelled
    case helperCancelled
    
}

struct Help: Identifiable, Codable {
    @DocumentID var helpId: String?
    let requesterUid: String
    let helperUid: String
    let requesterName: String
    let helperName: String
    let requesterLocation: GeoPoint
    let helperLocation: GeoPoint
    let meetingLocationName: String
    let meetingLocationAddress: String
    let meetingLocation: GeoPoint
    var distanceToRequester: Double
    var walkingTimeToRequester: Int
    var state: HelpState
    
    var id: String {
        return helpId ?? ""
    }
}

