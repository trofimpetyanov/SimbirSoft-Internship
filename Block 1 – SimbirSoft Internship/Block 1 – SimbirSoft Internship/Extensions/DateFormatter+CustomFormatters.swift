//
//  DateFormatter+CustomFormatters.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 15.07.2022.
//

import Foundation

extension DateFormatter {
    static let ddMM: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter
    }()
}
