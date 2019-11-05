//
//  TableViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 2/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import UIKit

protocol AddContactDelegate
{
    func addContact(_ userImage: UIImage, _ fname: String, _ lname: String, _ gender:Gender, _ email:String?, _ pnum:String?, _ paymentOptions:[PaymentOption]?)
}

class ContactsTableViewController: UITableViewController, AddContactDelegate
{
    
    //this connects to the view model
    private var viewModel = ContactsViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //Add contact button
    @IBAction func btnAddContact(_ sender: UIBarButtonItem)
    {
        // grab the view controller we want to show
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactAdd") as! ContactAddViewController
        vc.view.backgroundColor = UIColor.yellow
        
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.barButtonItem = sender
        
        //This deleagte property connects this view controller
        //to the BillAdd controller
        vc.delegate = self
        
        present(vc, animated: true, completion: nil)
    }
    
    //calls the protocol function
    func addContact(_ userImage: UIImage, _ fname: String, _ lname: String, _ gender:Gender, _ email:String?, _ pnum:String?, _ paymentOptions:[PaymentOption]?)
    {
        viewModel.addProfile(userImage, fname, lname, gender, email, pnum, paymentOptions)
        //refresh the view so we can see the new bill added
        self.loadView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //get the selected item or return and do nothing
        guard let selectedRow = self.tableView.indexPathForSelectedRow else
        {
            return
        }
        
        //This returns a UIViewController, which is where we are going to (the next scene)
        let destination = segue.destination as? ContactDetailViewController
        
        let selectedProfile = viewModel.getProfile(byIndex: selectedRow.row)
        
        destination?.selectedProfile = selectedProfile
    }
    
    
    
    //This is for finding the number of rows, basically how many items in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //this is the func we created in the view model
        //we will retunr the count
        return viewModel.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //you need to provided the resuable cell attribute that we set on the prototype cell
        //in the storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        
        //Here we are getting the image view, giving it the tag we set in the storyboard
        let profilePic = cell.viewWithTag(3000) as? UIImageView
        
        let fullName = cell.viewWithTag(3001) as? UILabel
        
        let email = cell.viewWithTag(3002) as? UILabel
        
        //We must unwrap the variables we just made
        //This ensures that this is executed as long as they are ALL not nil
        if let profilePic = profilePic, let fullName = fullName, let email = email
        {
            //index path starts at 0 and goes up for the amount of characters/rows,
            //we are using this num to get our characters
            let currentProfile = viewModel.getProfile(byIndex: indexPath.row)
            
            //setting the storyboard elements to the data that we are getting from the model
            if let Email = currentProfile.email
            {
                email.text = Email
            }
            
            let image = UIImage(data: currentProfile.userImage! as Data)
            
            profilePic.image = image
            fullName.text = "\(currentProfile.fname!) \(currentProfile.lname!)"
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") {(rowAction, indexPath) in self.contactEditPopover(indexPath.row); self.tableView.reloadData()}
        
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") {(rowAction, indexPath) in self.viewModel.removeProfile(index:indexPath.row); self.tableView.reloadData()}
        
        editButton.backgroundColor = UIColor.green
        deleteButton.backgroundColor = UIColor.red
        
        return[deleteButton,editButton]
    }
    
    func contactEditPopover(_ index:Int)
    {
        // grab the view controller we want to show
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditContact") as! ContactEditPopover
        
        vc.modalPresentationStyle = .popover
        vc.index = index
        
        present(vc, animated: true, completion: self.tableView.reloadData)
    }
    
}
