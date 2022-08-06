//
//  CDHelpCategory+CoreDataProperties.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 06.08.2022.
//
//

import Foundation
import CoreData

extension CDHelpCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDHelpCategory> {
        return NSFetchRequest<CDHelpCategory>(entityName: "CDHelpCategory")
    }

    @NSManaged public var id: Int32
    @NSManaged public var imageName: String?
    @NSManaged public var name: String?
    @NSManaged public var eventIds: NSOrderedSet?

}

// MARK: Generated accessors for eventIds
extension CDHelpCategory {

    @objc(insertObject:inEventIdsAtIndex:)
    @NSManaged public func insertIntoEventIds(_ value: CDEventId, at idx: Int)

    @objc(removeObjectFromEventIdsAtIndex:)
    @NSManaged public func removeFromEventIds(at idx: Int)

    @objc(insertEventIds:atIndexes:)
    @NSManaged public func insertIntoEventIds(_ values: [CDEventId], at indexes: NSIndexSet)

    @objc(removeEventIdsAtIndexes:)
    @NSManaged public func removeFromEventIds(at indexes: NSIndexSet)

    @objc(replaceObjectInEventIdsAtIndex:withObject:)
    @NSManaged public func replaceEventIds(at idx: Int, with value: CDEventId)

    @objc(replaceEventIdsAtIndexes:withEventIds:)
    @NSManaged public func replaceEventIds(at indexes: NSIndexSet, with values: [CDEventId])

    @objc(addEventIdsObject:)
    @NSManaged public func addToEventIds(_ value: CDEventId)

    @objc(removeEventIdsObject:)
    @NSManaged public func removeFromEventIds(_ value: CDEventId)

    @objc(addEventIds:)
    @NSManaged public func addToEventIds(_ values: NSOrderedSet)

    @objc(removeEventIds:)
    @NSManaged public func removeFromEventIds(_ values: NSOrderedSet)

}
