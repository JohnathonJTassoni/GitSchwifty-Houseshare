//
//  Profile+CoreDataClass.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 22/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Profile)
public class Profile: NSManagedObject {
    
    
    
    func paymentDetailArray ()-> [PaymentOption]
    {
        return self.paymentDetails?.allObjects as! [PaymentOption]
    }


}
