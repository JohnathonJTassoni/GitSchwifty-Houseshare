//
//  Bills.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 2/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation


class Bills
{
    private (set) var type:billType
    private (set) var dueDate:Date
    private (set) var amount:Double
    
    init(type:billType, dueDate:Date, amount:Double)
    {
        self.type = type
        self.amount = amount
        self.dueDate = dueDate;
    }
    
    func details() -> String
    {
        return "\(type), \(amount), \(dueDate)"
    }
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


