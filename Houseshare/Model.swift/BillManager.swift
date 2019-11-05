//
//  BillManager.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 22/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class BillManager
{
    //Static To declare this is a singleton
    static let shared = BillManager()
    
    //give us access to manageContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //we can now use this
    let managedContext: NSManagedObjectContext
    
    //This is just in memory, this IS NOT the database
    private (set) var bills:[Bills] = []
    
    //Private init To declare this is a singleton
    private init()
    {
        //Creates persistance
        managedContext = appDelegate.persistentContainer.viewContext
        
        //Load the bookdatabase. Because this is a singleton, it will only be called once
        //in the WHOLE app, so you wont accidentally duplicate the database or results
        loadBillDatabase()
    }
    
    //Create a new Bill
    private func createNSBill(_ billType: billType, _ dueDate: Date, _ amount: Double) -> Bills
    {
        //creates an entity author and insert into Core Data (memory)
        let billsEntity = NSEntityDescription.entity(forEntityName: "Bills", in: managedContext)!
        
        //create the object and intsert it into, this is like creating a Class Init, and instead
        //of passing with parameters we use the setValue method below
        let nsBill = NSManagedObject(entity: billsEntity, insertInto: managedContext) as! Bills
        
        nsBill.setValue(billType.rawValue, forKey: "billType")
        nsBill.setValue(dueDate, forKey: "dueDate")
        nsBill.setValue(amount, forKey: "amount")
        
        return nsBill
    }

    //called from view model
    func addBill(_ billType: billType, _ dueDate: Date, _ amount: Double)
    {
        let nsBill = createNSBill(billType, dueDate, amount)
        
        bills.append(nsBill)
        
        //save to database
        do{
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error) \(error.userInfo)")
        }
    }

    
    func removeBill(_ index:Int)
    {
        let billToDelete = bills[index] as NSManagedObject
        
        managedContext.delete(billToDelete)
        
        bills.remove(at: index)
        
        do{
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error) \(error.userInfo)")
        }
    }
    
    //load our database
    private func loadBillDatabase()
    {
        do
        {
            //create a fetch query
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Bills")
            
            //run fetch query, results is generic/any -> results = [Any]
            let result = try managedContext.fetch(fetchRequest)
            
            //Assign the results to the book array
            bills = result as! [Bills]
            
        }
        catch let error as NSError
        {
            print("Could not load \(error) \(error.userInfo)")
        }
    }
    
    
}
