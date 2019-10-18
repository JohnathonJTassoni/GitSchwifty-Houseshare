//
//  BillAddViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 9/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import UIKit

class BillAddViewController: UIViewController
{
    //delegate property to connect to the
    //table view controller
    var delegate:AddBillDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Datasource and delegation will be handled by this clase
        //Extension below.
        billPicker.delegate = self
        billPicker.dataSource = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var billPicker: UIPickerView!
    
    @IBOutlet weak var billAmount: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func submit(_ sender: Any)
    {
        //get the bill type from the UI picker
        let type = billType.allCases[billPicker.selectedRow(inComponent: 0)]
        
        //unwrap the amount text field
        if let amount = Double(billAmount.text!)
        {
            print("Delegating....")
            
            //Create the new bill, and pass it to the add bill protocol
            let billToAdd = Bills(type: type, dueDate: datePicker.date, amount: amount)
            delegate?.addNewBill(bill: billToAdd)
        }
         
        dismiss(animated: true, completion: nil)
    }
 
    
    @IBAction func cancel(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
   
}


//Extension for the UIPicker
extension BillAddViewController: UIPickerViewDataSource, UIPickerViewDelegate
{
    //Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return billType.allCases.count
    }
    
    //Number of componenets
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    //returns the all possible values of the billType Enum
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return billType.allCases[row].rawValue
    }
}
