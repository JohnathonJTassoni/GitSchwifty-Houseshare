//
//  ContactsViewModel.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 11/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import UIKit

struct ContactsViewModel
{
    private var contactManager = ContactsManager.shared
    
    //This will help with knowing how many characters we have
    var count:Int
    {
        return contactManager.profiles.count
    }
    
    func getProfile(byIndex index:Int) -> Profile
    {
        // this will hold the selected profile chosen by index
        let selectedProfile = contactManager.profiles[index]
        
        //return the profile
        return selectedProfile
    }
    
    mutating func addProfile(_ userImage: UIImage, _ fname: String, _ lname: String, _ gender:Gender, _ email:String?, _ pnum:String?, _ paymentOptions:[PaymentOption]?)
    {
        
        contactManager.addContact(userImage, fname, lname, gender, email, pnum, paymentOptions)

    }
    
    mutating func updateContact(_ index:Int, _ profile:Profile?)
    {
        contactManager.updateContact(index, profile)
    }
    
    mutating func removeProfile(index:Int)
    {
        contactManager.removeContact(index)
    }
    
}
