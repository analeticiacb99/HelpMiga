//
//  GeoPoint.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 08/02/23.
//

import Firebase
import CoreLocation

extension GeoPoint {
    func toCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
