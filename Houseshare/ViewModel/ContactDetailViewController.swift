//
//  ContactDetailViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 13/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//
import UIKit
import Foundation

class ContactDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var selectedProfile: Profile?
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var payTable: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        if let selectedProfile = selectedProfile
        {
            profilePic.image = UIImage(data: selectedProfile.userImage! as Data)
            name.text = "\(selectedProfile.fname!) \(selectedProfile.lname!)"
            email.text = selectedProfile.email
            phone.text = selectedProfile.pnum
            
            //Assign the tables data and delegation
            payTable.dataSource = self
            payTable.delegate = self
        }
    }

    //This is for finding the number of rows, basically how many items in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //we will return the count
        if let count = selectedProfile?.paymentDetails?.count
        {
            return count
        }
        
        return 0
    }
        
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //you need to provided the resuable cell attribute that we set on the prototype cell
        //in the storyboard, in this case it is a custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "payCell", for: indexPath)
        
        let accName = cell.viewWithTag(6000) as? UILabel
        
        let bsb = cell.viewWithTag(6001) as? UILabel
        
        let accNum = cell.viewWithTag(6002) as? UILabel
            
        //Assigning the acc num and name that is the current index
        accName?.text = selectedProfile?.paymentDetailArray()[indexPath.row].accName
        accNum?.text = selectedProfile?.paymentDetailArray()[indexPath.row].accNum
        bsb?.text = selectedProfile?.paymentDetailArray()[indexPath.row].bsb
            
        return cell
    }
        
}

