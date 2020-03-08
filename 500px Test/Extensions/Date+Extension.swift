//
//  Date+Extension.swift
//  500px Test
//
//  Created by Viswa Kodela on 2020-03-07.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

extension Date {
    var stringFromDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: self)
        if components.hour ?? 0 > 24 {
            return dateFormatter.string(from: self)
        } else if components.hour ?? 0 == 1 {
            return "\(String(components.hour ?? 0)) hour ago"
        } else {
            return "\(String(components.hour ?? 0)) hours ago"
        }
    }
}
