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
    //This is connecting to the LKCharacter file in the Model folder
    //This is private so that nothing can change the array
    private (set) var profiles:[Profile] = []
    
    //This will help with knowing how many characters we have
    var count:Int
    {
        return profiles.count
    }
    
    init()
    {
        loadData()
    }
    
    //this just populates our array
    private mutating func loadData()
    {
        var newProfile = Profile(fname: "Liam", lname: "Gallagher", gender: .male)
        newProfile.updateDetails(email: "Oasis@gmail.com")
        newProfile.addPaymentDetails(BSB: "123456", accNum: "987654321", accName: "Savings Acc")
        profiles.append(newProfile)
        
        newProfile = Profile(fname: "Mick", lname: "Jagger", gender: .male)
        newProfile.updateDetails(email: "Mick69@Hotmail.com")
        profiles.append(newProfile)
        
        newProfile = Profile(fname: "Taylor", lname: "Swift", gender: .female)
        newProfile.updateDetails(pnum: "0422334455")
        profiles.append(newProfile)
        
        newProfile = Profile(fname: "Lana", lname: "Del Ray")
        newProfile.updateDetails(email: "ILoveMusic@AOL.com")
        profiles.append(newProfile)
    }
    
    func getProfile(byIndex index:Int) -> Profile
    {
        // this will hold the selected profile chosen by index
        let selectedProfile = profiles[index]
        
        //return the profile
        return selectedProfile
    }
    
    mutating func addProfile(newProfile:Profile)
    {
        profiles.append(newProfile)
    }
    
}
