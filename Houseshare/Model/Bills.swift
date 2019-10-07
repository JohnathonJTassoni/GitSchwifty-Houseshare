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
    private (set) var dueDate:String
    private (set) var amount:Double
    
    init(type:billType, dueDate:String, amount:Double)
    {
        self.type = type;
        self.dueDate = dueDate;
        self.amount = amount;
    }
    
    func details() -> String
    {
        return "\(type), \(amount), \(dueDate)"
    }
}


enum billType:String
{
    case Internet = "Internet", Power = "Power", Rent = "Rent", Gas = "Gas", Other = "Other"
}






//var newBill = Bills(type: .Internet, dueDate:"12/2/2019", amount:99.99)



