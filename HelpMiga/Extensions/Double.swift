//
//  Double.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 30/01/23.
//

import Foundation

extension Double {
    
    
    private var distanceFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter
    }
    
    func toDecimal() -> String {
        return distanceFormatter.string (for: self) ?? ""
    } 
}

