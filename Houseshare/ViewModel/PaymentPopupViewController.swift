//
//  PaymentPopupViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 13/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import UIKit

class PaymentPopupViewController: UIViewController {

    //delegate to connect the view models and the protocol method
    var delegate:PaymentMethodDelegate?
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var bsbField: UITextField!
    
    @IBOutlet weak var accNumField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    
    @IBAction func savePayMethod(_ sender: UIButton)
    {
        print("Delegating new payment option....")
        //Unwrap fields
        if let bsb = bsbField.text, let accNum = accNumField.text, let name = nameField.text
        {
            //create new option
            
            //pass to protocol function
            delegate?.addPaymentOption(bsb, name, accNum)
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any)
    {
        dismiss(animated: true)
    }
    
    //Remove keyboard when another part of the storyboard is tappped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
}
