//
//  DestinationLocation.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 30/01/23.
//

import CoreLocation

struct DestinationLocation: Identifiable {
    let id = NSUUID().uuidString 
    let title: String
    let coordinate: CLLocationCoordinate2D
}
