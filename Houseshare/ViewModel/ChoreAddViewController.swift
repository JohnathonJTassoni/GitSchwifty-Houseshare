//
//  ChoreAddViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 16/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import UIKit

class ChoreAddViewController: UIViewController, UITextFieldDelegate
{

    private var viewModel = ContactsViewModel()
    var delegate: ChoreDelegate?
    
    @IBOutlet weak var choreNameField: UITextField!
    
    @IBOutlet weak var assignmentPicker: UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        assignmentPicker.delegate = self
        assignmentPicker.dataSource = self
        choreNameField.delegate? = self
    }
    
    
    @IBAction func submit(_ sender: Any)
    {
        //unwrap the amount text field
        if let choreName = choreNameField.text
        {
            print("Delegating....")
        
            //Create the new bill, and pass it to the add bill protocol
            let assignedUser = viewModel.profiles[assignmentPicker.selectedRow(inComponent: 0)]
            let fullname = "\(assignedUser.fname) \(assignedUser.lname)"
            let choreToAdd = Chore(choreName: choreName, dueDate: datePicker.date, assignedUser: fullname)
            delegate?.addChore(newChore: choreToAdd)
        }
        
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



extension ChoreAddViewController: UIPickerViewDataSource, UIPickerViewDelegate
{
    //Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return viewModel.profiles.count
    }
    
    //Number of componenets
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    //returns the all possible values of the profiles in the viewmodel
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {

        return "\(viewModel.getProfile(byIndex: row).fname) \(viewModel.getProfile(byIndex: row).lname)"

    }
}
