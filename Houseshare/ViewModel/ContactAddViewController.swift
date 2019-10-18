//
//  ContactAddViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 13/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import UIKit
import Foundation

protocol PaymentMethodDelegate
{
    func addPaymentOption(paymentOption: PaymentOption)
}

class ContactAddViewController: UIViewController, PaymentMethodDelegate
{
    //All the outlets
    @IBOutlet weak var paymentOptionTable: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastnNameField: UITextField!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pnumField: UITextField!
    
    @IBOutlet weak var imageButton: UIButton!
    //delegate property to connect to the
    //table view controller
    var delegate:AddContactDelegate?
    
    private var paymentOptionArray:[PaymentOption] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Assign the tables data and delegation
        paymentOptionTable.dataSource = self
        paymentOptionTable.delegate = self
        genderPicker.dataSource = self
        genderPicker.delegate = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submit(_ sender: Any)
    {
        //Unwrap the need fields
        if let fname = firstNameField.text, let lname = lastnNameField.text, let email = emailField.text, let pnum = pnumField.text
        {
            print("Delegating new contact....")
            
            //Get the gender from the gender picker
            let gender = Gender.allCases[genderPicker.selectedRow(inComponent: 0)]
            
            //Create new profile, with the vars needed, then use the update for the rest
            let newProfile = Profile(fname: fname, lname: lname, gender: gender, userImage: profileImage.image)
            newProfile.updateDetails(email:email, pnum:pnum)
            
            //Add the payment options, this will add all from the array
            for payOption in paymentOptionArray
            {
                newProfile.addPaymentDetails(BSB: payOption.BSB, accNum: payOption.accNum, accName: payOption.accName)
            }
            
            //add the new contact to the array
            delegate?.addContact(profile: newProfile)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPayment(_ sender: UIButton)
    {
        //Get the storyboard and the view for the popover
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "paymentPopOver") as! PaymentPopupViewController
        
        //delegate
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    //add Payment option protocol
    func addPaymentOption(paymentOption: PaymentOption)
    {
        paymentOptionArray.append(paymentOption)
        paymentOptionTable.reloadData()
    }
    
    
    @IBAction func cancel(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
}


extension ContactAddViewController: UITableViewDelegate, UITableViewDataSource
{
    //This is for finding the number of rows, basically how many items in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //we will return the count
        return paymentOptionArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //you need to provided the resuable cell attribute that we set on the prototype cell
        //in the storyboard, in this case it is a custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "payCell") as! PaymentOptionCell
        
        //Assigning the acc num and name that is the current index
        cell.nameLabel.text = paymentOptionArray[indexPath.row].accName
        cell.numLabel.text = paymentOptionArray[indexPath.row].accNum
        
        return cell
    }
    
}

//Code for the image picker, controlls the actionsheet with options
//and also controlls photolibrary and camera functions
extension ContactAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    //button has been placed over the image
    @IBAction func choosePhoto(_ sender: Any)
    {
        //create image picker controller and delegate to self
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        //Action sheet with title and message
        let actionSheet = UIAlertController(title: "Choose Photo Source", message: "Choose and image from the library or take a new one.", preferredStyle: .actionSheet)
        
        //Firt actionsheet ooption for camera
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                imagePickerController.sourceType = (.camera)
                
                self.present(imagePickerController, animated: true, completion: nil)
            }
             
        }))
        
        //Second actionsheet option for photo library
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
            {
                (action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
                
        }))
        
        //Cancel option
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true, completion: nil)
    }
    
    //Function to dismiss after choosing a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            //Set the image in the outlet and hide the text
            profileImage.image = image
            imageButton.setTitle( "", for: .normal)
            imageButton.alpha = 0
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    //function to dismiss if user selects cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}


//Extension for the UIPicker
extension ContactAddViewController: UIPickerViewDataSource, UIPickerViewDelegate
{
    //Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return Gender.allCases.count
    }
    
    //Number of componenets
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    //returns the all possible values of the Gender Enum
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return Gender.allCases[row].rawValue
    }
}
