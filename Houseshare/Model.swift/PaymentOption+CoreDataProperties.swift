//
//  PaymentOption+CoreDataProperties.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 22/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//
//

import Foundation
import CoreData


extension PaymentOption {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PaymentOption> {
        return NSFetchRequest<PaymentOption>(entityName: "PaymentOption")
    }

    @NSManaged public var accName: String?
    @NSManaged public var accNum: String?
    @NSManaged public var bsb: String?
    @NSManaged public var profile: Profile?

}
