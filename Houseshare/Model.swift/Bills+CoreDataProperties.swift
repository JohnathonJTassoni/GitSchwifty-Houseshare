//
//  Bills+CoreDataProperties.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 22/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//
//

import Foundation
import CoreData


extension Bills {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bills> {
        return NSFetchRequest<Bills>(entityName: "Bills")
    }

    @NSManaged public var billType: String?
    @NSManaged public var dueDate: NSDate?
    @NSManaged public var amount: Double

}

enum billType:String, CaseIterable
{
    case Internet = "Internet", Power = "Power", Water = "Water", Rent = "Rent", Gas = "Gas", Other = "Other"
    
    var logo:String
    {
        switch self
        {
        case .Internet: return "internet"
        case .Power: return "power"
        case .Water: return "water"
        case .Rent: return "rent"
        case .Gas: return "gas"
        case .Other: return "money"
        }
    }
}
