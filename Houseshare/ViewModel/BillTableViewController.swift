//
//  TableViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 2/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import UIKit

protocol AddBillDelegate
{
    func addNewBill(bill:Bills)
}

class BillTableViewController: UITableViewController
{
    
    //this connects to the view model
    private var viewModel = BillViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func btnAddBill(_ sender: UIBarButtonItem)
    {
        // grab the view controller we want to show
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BillAdd") as! BillAddViewController
        //vc.view.backgroundColor = UIColor.yellow
        
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.barButtonItem = sender
        
        //This deleagte property connects this view controller
        //to the BillAdd controller
        vc.delegate = self
        
        present(vc, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillCell", for: indexPath)
        
        //Here we are getting the image view, giving it the tag we set in the storyboard
        let type = cell.viewWithTag(1000) as? UILabel
        
        let amount = cell.viewWithTag(1001) as? UILabel
        
        let dueDate = cell.viewWithTag(1002) as? UILabel
        
        let logo = cell.viewWithTag(1003) as? UIImageView
        
        //We must unwrap the variables we just made
        //This ensures that this is executed as long as they are ALL not nil
        if let type = type, let dueDate = dueDate, let amount = amount, let logo = logo
        {
            //index path starts at 0 and goes up for the amount of characters/rows,
            //we are using this num to get our characters
            let  currentBill = viewModel.getBill(byIndex: indexPath.row)
            let formattedDate = DateFormatter()
            formattedDate.setLocalizedDateFormatFromTemplate("ddMMYYYY")
            
            //setting the storyboard elements to the data that we are getting from the model
            type.text = currentBill.type
            dueDate.text = "Due: \(formattedDate.string(from: currentBill.dueDate))"
            amount.text = "$ \(currentBill.amount)"
            logo.image = UIImage(named: currentBill.logo)
        }
        
        return cell
    }
    
}

extension BillTableViewController: AddBillDelegate
{
    //We could just extend/conform the main class above
    //but will use this just to show extensions
    
    //calls the protocol
    func addNewBill(bill: Bills)
    {
        viewModel.addBill(bill: bill)
        //refresh the view so we can see the new bill added
        self.loadView()
    }
}
