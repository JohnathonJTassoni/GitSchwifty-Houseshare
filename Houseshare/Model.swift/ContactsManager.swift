//
//  ContactsManager.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 22/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//
import Foundation
import CoreData
import UIKit

class ContactsManager
{
    //Static To declare this is a singleton
    static let shared = ContactsManager()
    
    //give us access to manageContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //we can now use this
    let managedContext: NSManagedObjectContext
    
    //This is just in memory, this IS NOT the database
    private (set) var profiles:[Profile] = []
    
    
    //Private init To declare this is a singleton
    private init()
    {
        //Creates persistance
        managedContext = appDelegate.persistentContainer.viewContext
        
        //Load the bookdatabase. Because this is a singleton, it will only be called once
        //in the WHOLE app, so you wont accidentally duplicate the database or results
        loadContactsDatabase()
    }
    
    //Create a new Contact
    private func createNSContact(_ userImage: UIImage, _ fname: String, _ lname: String, _ gender:Gender, _ email:String?, _ pnum:String?, _ paymentOptions:[PaymentOption]?) -> Profile
    {
        //creates an entity author and insert into Core Data (memory)
        let profileEntity = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext)!
        
        //create the object and intsert it into, this is like creating a Class Init, and instead
        //of passing with parameters we use the setValue method below
        let nsProfile = NSManagedObject(entity: profileEntity, insertInto: managedContext) as! Profile
        
        let image = userImage.pngData() as NSData?
        nsProfile.userImage = image
        
        nsProfile.paymentDetails = NSSet.init(array: paymentOptions!)
        
        nsProfile.setValue(fname, forKey: "fname")
        nsProfile.setValue(lname, forKey: "lname")
        nsProfile.setValue(gender.rawValue, forKey: "gender")
        nsProfile.setValue(email, forKey: "email")
        nsProfile.setValue(pnum, forKey: "pnum")
        return nsProfile
    }
    
    //called from view model
    func addContact(_ userImage: UIImage, _ fname: String, _ lname: String, _ gender:Gender, _ email:String?, _ pnum:String?, _ paymentOptions:[PaymentOption]?)
    {
        let nsContact = createNSContact(userImage, fname, lname, gender, email, pnum, paymentOptions)
        
        profiles.append(nsContact)
        
        //save to database
        do{
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error) \(error.userInfo)")
        }
    }
    
    
    func updateContact(_ index:Int, _ profile:Profile?)
    {
        
        if profiles[index] == profile
        {
            profiles[index] = profile!
        }
        
        do{
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error) \(error.userInfo)")
        }
    }
 
 
    func removeContact(_ index:Int)
    {
        let contactToDelete = profiles[index] as NSManagedObject
        
        managedContext.delete(contactToDelete)
        
        profiles.remove(at: index)
        
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
    private func loadContactsDatabase()
    {
        do
        {
            //create a fetch query
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Profile")
            
            //run fetch query, results is generic/any -> results = [Any]
            let result = try managedContext.fetch(fetchRequest)
            
            //Assign the results to the book array
            profiles = result as! [Profile]
            
        }
        catch let error as NSError
        {
            print("Could not load \(error) \(error.userInfo)")
        }
    }
    
    
}
