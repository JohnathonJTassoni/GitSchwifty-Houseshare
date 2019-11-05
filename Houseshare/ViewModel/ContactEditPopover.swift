//
//  ContactEditPopover.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 25/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import UIKit

class ContactEditPopover:UIViewController
{
    private var viewModel = ContactsViewModel()
    var index:Int = 0
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pnum: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let selectedProfile = viewModel.getProfile(byIndex: index)
        
            profilePic.image = UIImage(data: selectedProfile.userImage! as Data)
            firstName.text = selectedProfile.fname
            surname.text = selectedProfile.lname
            email.text = selectedProfile.email
            pnum.text = selectedProfile.pnum
    }
    
    
    @IBAction func saveChanges(_ sender: Any)
    {
        
        let selectedProfile = viewModel.getProfile(byIndex: index)
        
        selectedProfile.userImage = profilePic.image?.pngData() as NSData?
        selectedProfile.fname = firstName.text
        selectedProfile.lname = surname.text
        selectedProfile.email = email.text
        selectedProfile.pnum = pnum.text
        
        viewModel.updateContact(index, selectedProfile)
        
        dismiss(animated: true, completion: nil)
          
    }
    
    @IBAction func cancel(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //Remove keyboard when another part of the storyboard is tappped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    

}
