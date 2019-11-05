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
    private var billManager = BillManager.shared
    
    //This will help with knowing how many characters we have
    var count:Int
    {
        return billManager.bills.count
    }
    
    var bills:[Bills]
    {
        return billManager.bills
    }
    
    //this function will as for an index (byIndex) and return a tuple
    //this is how other methods in the program can get the data of our array
    func getBill(byIndex index:Int) -> (type:String, dueDate:Date, amount:String, logo:String)
    {
        //creating internal vars that we will assigne the values we need acording to the index provided
        let type = billManager.bills[index].billType!
        let dueDate = billManager.bills[index].dueDate! as Date
        let amount = String(billManager.bills[index].amount)
        let logo = billManager.bills[index].billType!
        
        //return these as a tuple
        return(type, dueDate, amount, logo)
    }
    
    mutating func addBill(_ billType: billType, _ dueDate: Date, _ amount: Double)
    {
    
        billManager.addBill(billType, dueDate, amount)
        
    }
    
    mutating func removeBill(index:Int)
    {
        billManager.removeBill(index)
    }
    

}

