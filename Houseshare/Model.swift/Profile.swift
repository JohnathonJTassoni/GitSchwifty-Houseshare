//
//  Profile.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 11/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import UIKit

class Profile
{
    //Display pic for profile
    private (set) var userImage:UIImage
    
    //first and last name
    private (set) var fname:String
    private (set) var lname:String
    private (set) var gender:Gender
    
    //email address
    private (set) var email:String?
    
    //phone number
    private (set) var pnum:String?
    
    //holds a list of payment details, init to 0
    private (set) var paymentDetails:[PaymentOption] = []
    
    //a profile only needs the names to be init
    init(fname:String, lname:String, gender:Gender = .other, userImage:UIImage? = UIImage(named: "basicAvatar"))
    {
        self.fname = fname
        self.lname = lname
        self.gender = gender
        
        
        if self.gender == .male && userImage == UIImage(named: "basicAvatar")
        {
            self.userImage = UIImage(named: "basicMale")!
        }
        else if self.gender == .female && userImage == UIImage(named: "basicAvatar")
        {
            self.userImage = UIImage(named: "basicFemale")!
        }
        else
        {
            self.userImage = userImage!
        }

    }
    
    
    func getProfileSummary() -> (userImage:UIImage?, fname:String, lname:String, email:String?)
    {
        return (userImage, fname, lname, email)
    }
    
    //adds a payment profile to the array, as a user may have more than 1
    func addPaymentDetails(BSB:String, accNum:String, accName:String)
    {
        let newDetails = PaymentOption(BSB: BSB, accNum: accNum, name: accName)
        
        paymentDetails.append(newDetails)
        
        //print("New payment details added!")
    }
    
    //can update one or more attributes
    func updateDetails(fname:String? = nil, lname:String? = nil, email:String? = nil, pnum:String? = nil, userImage:UIImage? = nil)
    {
        if let fname = fname
        {
            self.fname = fname
        }
        
        if let lname = lname
        {
            self.lname = lname
        }
        
        if let email = email
        {
            self.email = email
        }
            
        if let pnum = pnum
        {
            self.pnum = pnum
        }
            
        if let userImage = userImage
        {
            self.userImage = userImage
        }
    }
}


enum Gender: String, CaseIterable
{
    case male = "Male", female = "Female", other = "Other"
}
