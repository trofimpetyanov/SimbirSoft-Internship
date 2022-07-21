//
//  DateFormatter+CustomFormatters.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 15.07.2022.
//

import Foundation

extension DateFormatter {
    enum DateStyle: String {
        case ddMM = "dd.MM"
    }
    
    static func dateFormatter(for dateStyle: DateStyle) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateStyle.rawValue
        return dateFormatter
    }
    
    static func dateRange(startDate: Date, endDate: Date, style: DateStyle) -> String {
        let startDateString = DateFormatter.dateFormatter(for: style).string(from: startDate)
        let endDateString = DateFormatter.dateFormatter(for: style).string(from: endDate)
        
        return "\(startDateString) - \(endDateString)"
    }
}
