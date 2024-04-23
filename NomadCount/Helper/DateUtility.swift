//
//  Date.swift
//  NomadCount
//
//  Created by Joseph Bouhanef on 2024-04-23.
//

import Foundation

import Foundation

extension Date {
    // Formatting date
    func formatted(as format: String = "MMMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    // Computed properties for common relative dates
    static var today: Date {
        Date()
    }
    
  
    static func daysAgo(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: Date())!
    }
}
