//
//  HelperAnnotation.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 06/02/23.
//

import MapKit
import Firebase

class HelperAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let uid: String
    
    init(helper: User) {
        self.uid = helper.uid
        self.coordinate = CLLocationCoordinate2D(latitude: helper.coordinates.latitude,
                                                 longitude: helper.coordinates.longitude)
    }
}
