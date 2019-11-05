//
//  ChoreManager.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 23/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ChoreManager
{
    //Static To declare this is a singleton
    static let shared = ChoreManager()
    
    //give us access to manageContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //we can now use this
    let managedContext: NSManagedObjectContext
    
    //This is just in memory, this IS NOT the database
    private (set) var chores:[Chore] = []
    
    //Private init To declare this is a singleton
    private init()
    {
        //Creates persistance
        managedContext = appDelegate.persistentContainer.viewContext
        
        //Load the bookdatabase. Because this is a singleton, it will only be called once
        //in the WHOLE app, so you wont accidentally duplicate the database or results
        loadChoreDatabase()
        
        //removed the chores to start fresh
        //chores.remove(at: 0)

    }
    
    //Create a new Bill
    private func createNSChore(_ choreName: String, _ dueDate: Date, _ assignedUser:Profile) -> Chore
    {
        //creates an entity author and insert into Core Data (memory)
        let choreEntity = NSEntityDescription.entity(forEntityName: "Chore", in: managedContext)!
        
        //create the object and intsert it into, this is like creating a Class Init, and instead
        //of passing with parameters we use the setValue method below
        let nsChore = NSManagedObject(entity: choreEntity, insertInto: managedContext) as! Chore
        
        nsChore.setValue(choreName, forKey: "choreName")
        nsChore.setValue(dueDate, forKey: "dueDate")
        nsChore.setValue(false, forKey: "completed")
        nsChore.setValue(assignedUser, forKey: "assignedUser")
        
        return nsChore
    }
    
    //called from view model
    func addChore(_ choreName: String, _ dueDate: Date, _ assignedUser:Profile)
    {
        let nsChore = createNSChore(choreName, dueDate, assignedUser)
        
        chores.append(nsChore)
        
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
    private func loadChoreDatabase()
    {
        do
        {
            //create a fetch query
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Chore")
            
            //run fetch query, results is generic/any -> results = [Any]
            let result = try managedContext.fetch(fetchRequest)
            
            //Assign the results to the book array
            chores = result as! [Chore]
            
        }
        catch let error as NSError
        {
            print("Could not load \(error) \(error.userInfo)")
        }
    }
    
    
}
