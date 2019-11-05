//
//  PaymentOption.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 13/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation

class PaymentOption
{
    private (set) var BSB:String
    private (set) var accNum:String
    private (set) var accName:String
    
    init(BSB:String, accNum:String, name:String)
    {
        self.BSB = BSB
        self.accNum = accNum
        self.accName = name
    }
    
    func showDetails() -> String
    {
        return "Name: \(accName), BSB: \(BSB), Account number: \(accNum)"
    }
    
    //Allows updating of a payment profile where you dont
    //have to provide all of the parameters
    func updateDetails(BSB:String? = nil, accNum:String? = nil, accName:String? = nil)
    {
        //Check for each variable seperately, or it will fail if
        //not every variable is provided
        if let BSB = BSB
        {
            self.BSB = BSB
        }
        else if let accNum = accNum
        {
            self.accNum = accNum
        }
        else if let accName = accName
        {
            self.accName = accName
        }
    }
}
