//
//  BillViewModel.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 2/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import UIKit

struct BillViewModel
{
    //This is connecting to the LKCharacter file in the Model folder
    //This is private so that nothing can change the array
    private (set) var bills:[Bills] = []
    
    //This will help with knowing how many characters we have
    var count:Int
    {
        return bills.count
    }
    
    init()
    {
        loadData()
    }
    
    //this just populates our array
    private mutating func loadData()
    {
        let calender = Calendar.current
        var myDate = DateComponents(calendar: calender, year: 2019, month: 2, day: 12)
        var newBill = Bills(type: .Internet, dueDate: calender.date(from: myDate)!, amount: 99.99)
        bills.append(newBill)
        
        myDate = DateComponents(calendar: calender, year: 2019, month: 3, day: 12)
        newBill = Bills(type: .Gas, dueDate: calender.date(from: myDate)!, amount: 45.99)
        bills.append(newBill)
        
        myDate = DateComponents(calendar: calender, year: 2019, month: 2, day: 5)
        newBill = Bills(type: .Power, dueDate: calender.date(from: myDate)!, amount: 321.79)
        bills.append(newBill)
        
        myDate = DateComponents(calendar: calender, year: 2019, month: 3, day: 12)
        newBill = Bills(type: .Internet, dueDate: calender.date(from: myDate)!, amount: 99.99)
        bills.append(newBill)
    }
    
    //this function will as for an index (byIndex) and return a tuple
    //this is how other methods in the program can get the data of our array
    func getBill(byIndex index:Int) -> (type:String, dueDate:Date, amount:String, logo:String)
    {
        //creating internal vars that we will assigne the values we need acording to the index provided
        let type = bills[index].type.rawValue
        let dueDate = bills[index].dueDate
        let amount = String(bills[index].amount)
        let logo = bills[index].type.logo
        
        //return these as a tuple
        return(type, dueDate, amount, logo)
    }
    
    mutating func addBill(bill:Bills)
    {
    
        bills.append(bill)
        
    }
}
