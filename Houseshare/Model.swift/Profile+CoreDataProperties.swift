//
//  Profile+CoreDataProperties.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 22/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var userImage: NSData?
    @NSManaged public var fname: String?
    @NSManaged public var lname: String?
    @NSManaged public var gender: String?
    @NSManaged public var pnum: String?
    @NSManaged public var email: String?
    @NSManaged public var chore: NSSet?
    @NSManaged public var paymentDetails: NSSet?

}

// MARK: Generated accessors for chore
extension Profile {

    @objc(addChoreObject:)
    @NSManaged public func addToChore(_ value: Chore)

    @objc(removeChoreObject:)
    @NSManaged public func removeFromChore(_ value: Chore)

    @objc(addChore:)
    @NSManaged public func addToChore(_ values: NSSet)

    @objc(removeChore:)
    @NSManaged public func removeFromChore(_ values: NSSet)

}

// MARK: Generated accessors for paymentDetails
extension Profile {

    @objc(addPaymentDetailsObject:)
    @NSManaged public func addToPaymentDetails(_ value: PaymentOption)

    @objc(removePaymentDetailsObject:)
    @NSManaged public func removeFromPaymentDetails(_ value: PaymentOption)

    @objc(addPaymentDetails:)
    @NSManaged public func addToPaymentDetails(_ values: NSSet)

    @objc(removePaymentDetails:)
    @NSManaged public func removeFromPaymentDetails(_ values: NSSet)

}

enum Gender: String, CaseIterable
{
    case male = "Male", female = "Female", other = "Other"
}



