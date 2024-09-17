//
//  Date+Extension.swift
//  Prewarming
//
//  Created by Jonatan Nielavitzky on 17/09/2024.
//

import Foundation

extension Date {
    var timestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date.now)
    }
}
