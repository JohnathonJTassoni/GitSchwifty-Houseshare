//
//  Chore+CoreDataProperties.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 22/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//
//

import Foundation
import CoreData


extension Chore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chore> {
        return NSFetchRequest<Chore>(entityName: "Chore")
    }

    @NSManaged public var choreName: String?
    @NSManaged public var dueDate: NSDate?
    @NSManaged public var completed: Bool
    @NSManaged public var assignedUser: Profile?

}
