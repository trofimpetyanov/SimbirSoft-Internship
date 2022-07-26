//
//  DataManager.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import Foundation

struct DataManager {
    enum DataKey {
        static let helpCategories = "HelpCategories"
        static let helpEvents = "HelpEvents"
    }
    
    static let shared = DataManager()
    
    var helpCategories: [HelpCategory] {
        unarchiveJSON(key: DataKey.helpCategories) ?? []
    }
    
    var helpEvents: [HelpEvent] {
        unarchiveJSON(key: DataKey.helpEvents) ?? []
    }
    
    private init() { }
    
    private func unarchiveJSON<T: Decodable>(key: String) -> T? {
        sleep(1)
        
        guard
            let filepath = Bundle.main.path(forResource: key, ofType: "json"),
            let string = try? String(contentsOfFile: filepath),
            let data = string.data(using: .utf8)
        else {
            print("Error while reading a JSON file")
            
            return nil
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error while decoding a JSON file")
            
            return nil
        }
    }
}
