//
//
//  PaymentOptionsManager.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 23/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PaymentOptionManager
{
    //Static To declare this is a singleton
    static let shared = PaymentOptionManager()
    
    //give us access to manageContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //we can now use this
    let managedContext: NSManagedObjectContext
    
    //This is just in memory, this IS NOT the database
    private (set) var paymentOptions:[PaymentOption] = []
    
    //Private init To declare this is a singleton
    private init()
    {
        //Creates persistance
        managedContext = appDelegate.persistentContainer.viewContext
        
        //Load the bookdatabase. Because this is a singleton, it will only be called once
        //in the WHOLE app, so you wont accidentally duplicate the database or results
        loadPaymentOptionsDatabase()
    }
    
    //Create a new Bill
    private func createNSPayOption(_ accName: String, _ bsb: String, _ accNum: String) -> PaymentOption
    {
        //creates an entity author and insert into Core Data (memory)
        let payEntity = NSEntityDescription.entity(forEntityName: "PaymentOption", in: managedContext)!
        
        //create the object and intsert it into, this is like creating a Class Init, and instead
        //of passing with parameters we use the setValue method below
        let nsPaymentOption = NSManagedObject(entity: payEntity, insertInto: managedContext) as! PaymentOption
        
        nsPaymentOption.setValue(accName, forKey: "accName")
        nsPaymentOption.setValue(bsb, forKey: "bsb")
        nsPaymentOption.setValue(accNum, forKey: "accNum")
        
        return nsPaymentOption
    }
    
    //called from view model
    func addPaymentOption(_ accName: String, _ bsb: String, _ accNum: String)
    {
        let nsPaymentOption = createNSPayOption(accName, bsb, accNum)
        
        paymentOptions.append(nsPaymentOption)
        
        //save to database
        do{
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error) \(error.userInfo)")
        }
    }
    
    //load our database
    private func loadPaymentOptionsDatabase()
    {
        do
        {
            //create a fetch query
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"PaymentOption")
            
            //run fetch query, results is generic/any -> results = [Any]
            let result = try managedContext.fetch(fetchRequest)
            
            //Assign the results to the book array
            paymentOptions = result as! [PaymentOption]
        }
        catch let error as NSError
        {
            print("Could not load \(error) \(error.userInfo)")
        }
    }
    
    
}
