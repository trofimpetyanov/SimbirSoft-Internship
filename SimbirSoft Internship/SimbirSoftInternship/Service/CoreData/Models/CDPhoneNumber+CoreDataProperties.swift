//
//  CDPhoneNumber+CoreDataProperties.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 06.08.2022.
//
//

import Foundation
import CoreData

extension CDPhoneNumber {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPhoneNumber> {
        return NSFetchRequest<CDPhoneNumber>(entityName: "CDPhoneNumber")
    }

    @NSManaged public var phoneNumber: String?
    @NSManaged public var helpEvent: CDHelpEvent?

}
