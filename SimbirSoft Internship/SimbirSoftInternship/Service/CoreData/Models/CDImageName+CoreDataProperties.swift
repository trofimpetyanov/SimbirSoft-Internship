//
//  CDImageName+CoreDataProperties.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 06.08.2022.
//
//

import Foundation
import CoreData


extension CDImageName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDImageName> {
        return NSFetchRequest<CDImageName>(entityName: "CDImageName")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var helpEvent: CDHelpEvent?

}
