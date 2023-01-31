//
//  DistanceCalculatedType.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 29/01/23.
//

import Foundation

enum DistanceCalculatedType: Int, CaseIterable, Identifiable {
    case meters
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .meters: return "Distance"
            
        }
    }
    
    func computeDistance (for distanceInMeters: Double) -> Double {
        
        switch self {
        case .meters: return distanceInMeters
            
        }
    }

}
