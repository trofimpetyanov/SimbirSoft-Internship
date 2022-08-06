//
//  CDHelpEvent+CoreDataProperties.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 06.08.2022.
//
//

import Foundation
import CoreData

extension CDHelpEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDHelpEvent> {
        return NSFetchRequest<CDHelpEvent>(entityName: "CDHelpEvent")
    }

    @NSManaged public var address: String?
    @NSManaged public var contactLink: String?
    @NSManaged public var detail: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var fundName: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var organizationLink: String?
    @NSManaged public var peopleCount: Int32
    @NSManaged public var shortDetail: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var imageNames: NSOrderedSet?
    @NSManaged public var phoneNumbers: NSOrderedSet?

}

// MARK: Generated accessors for imageNames
extension CDHelpEvent {

    @objc(insertObject:inImageNamesAtIndex:)
    @NSManaged public func insertIntoImageNames(_ value: CDImageName, at idx: Int)

    @objc(removeObjectFromImageNamesAtIndex:)
    @NSManaged public func removeFromImageNames(at idx: Int)

    @objc(insertImageNames:atIndexes:)
    @NSManaged public func insertIntoImageNames(_ values: [CDImageName], at indexes: NSIndexSet)

    @objc(removeImageNamesAtIndexes:)
    @NSManaged public func removeFromImageNames(at indexes: NSIndexSet)

    @objc(replaceObjectInImageNamesAtIndex:withObject:)
    @NSManaged public func replaceImageNames(at idx: Int, with value: CDImageName)

    @objc(replaceImageNamesAtIndexes:withImageNames:)
    @NSManaged public func replaceImageNames(at indexes: NSIndexSet, with values: [CDImageName])

    @objc(addImageNamesObject:)
    @NSManaged public func addToImageNames(_ value: CDImageName)

    @objc(removeImageNamesObject:)
    @NSManaged public func removeFromImageNames(_ value: CDImageName)

    @objc(addImageNames:)
    @NSManaged public func addToImageNames(_ values: NSOrderedSet)

    @objc(removeImageNames:)
    @NSManaged public func removeFromImageNames(_ values: NSOrderedSet)

}

// MARK: Generated accessors for phoneNumbers
extension CDHelpEvent {

    @objc(insertObject:inPhoneNumbersAtIndex:)
    @NSManaged public func insertIntoPhoneNumbers(_ value: CDPhoneNumber, at idx: Int)

    @objc(removeObjectFromPhoneNumbersAtIndex:)
    @NSManaged public func removeFromPhoneNumbers(at idx: Int)

    @objc(insertPhoneNumbers:atIndexes:)
    @NSManaged public func insertIntoPhoneNumbers(_ values: [CDPhoneNumber], at indexes: NSIndexSet)

    @objc(removePhoneNumbersAtIndexes:)
    @NSManaged public func removeFromPhoneNumbers(at indexes: NSIndexSet)

    @objc(replaceObjectInPhoneNumbersAtIndex:withObject:)
    @NSManaged public func replacePhoneNumbers(at idx: Int, with value: CDPhoneNumber)

    @objc(replacePhoneNumbersAtIndexes:withPhoneNumbers:)
    @NSManaged public func replacePhoneNumbers(at indexes: NSIndexSet, with values: [CDPhoneNumber])

    @objc(addPhoneNumbersObject:)
    @NSManaged public func addToPhoneNumbers(_ value: CDPhoneNumber)

    @objc(removePhoneNumbersObject:)
    @NSManaged public func removeFromPhoneNumbers(_ value: CDPhoneNumber)

    @objc(addPhoneNumbers:)
    @NSManaged public func addToPhoneNumbers(_ values: NSOrderedSet)

    @objc(removePhoneNumbers:)
    @NSManaged public func removeFromPhoneNumbers(_ values: NSOrderedSet)

}
