//
//  PaymentOptionsViewModel.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 23/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation

struct PaymentOptionsViewModel
{
    //This is connecting to the LKCharacter file in the Model folder
    //This is private so that nothing can change the array
    private var paymentManager = PaymentOptionManager.shared
    
    //this function will as for an index (byIndex) and return a tuple
    //this is how other methods in the program can get the data of our array
    func getPaymentOptions(_ profile:Profile) -> [PaymentOption]
    {
        var payOptions:[PaymentOption] = []
        
        for paymentOption in paymentManager.paymentOptions
        {
            if (paymentOption.profile == profile)
            {
                payOptions.append(paymentOption)
            }
        }
        
        return payOptions
    }
    
    func newPaymentOptions() -> [PaymentOption]
    {
        var payOptions:[PaymentOption] = []
        
        for paymentOption in paymentManager.paymentOptions
        {
            if (paymentOption.profile == nil)
            {
                payOptions.append(paymentOption)
            }
        }
        
        return payOptions
    }
    
    mutating func addPaymentOption(_ accName: String, _ bsb: String, _ accNum: String)
    {
        paymentManager.addPaymentOption(accName, bsb, accNum)
    }
}
