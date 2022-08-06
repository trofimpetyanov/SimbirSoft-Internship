//
//  CDEventId+CoreDataProperties.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 06.08.2022.
//
//

import Foundation
import CoreData


extension CDEventId {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEventId> {
        return NSFetchRequest<CDEventId>(entityName: "CDEventId")
    }

    @NSManaged public var id: Int32
    @NSManaged public var helpCategory: CDHelpCategory?

}
