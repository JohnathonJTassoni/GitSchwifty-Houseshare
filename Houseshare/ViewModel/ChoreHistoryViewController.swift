//
//  ChoreHistoryViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 18/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import UIKit

class ChoreHistoryTableViewController: UITableViewController
{
    var viewModel = ChoreViewModel()
    
    @IBAction func dismiss(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.getCompletedChores().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoreCell", for: indexPath)
        
        //Here we are getting the image view, giving it the tag we set in the storyboard
        let name = cell.viewWithTag(7005) as? UILabel
        
        let assignedUser = cell.viewWithTag(7006) as? UILabel
        
        let dueDate = cell.viewWithTag(7007) as? UILabel
        
        if let name = name, let assignedUser = assignedUser, let dueDate = dueDate
        {
            //index path starts at 0 and goes up for the amount of rows,
            //we are using this num to get our characters
            
            let currentChore = viewModel.getCompletedChores()[indexPath.row]
            
            let formattedDate = DateFormatter()
            formattedDate.setLocalizedDateFormatFromTemplate("ddMMYYYY")
            
            //setting the storyboard elements to the data that we are getting from the model
            name.text = currentChore.choreName
            dueDate.text = "Due: \(formattedDate.string(from: currentChore.dueDate as! Date))"
            assignedUser.text = "Assigned to: \(currentChore.assignedUser!.fname!) \(currentChore.assignedUser!.lname!)"
            
            
        }
        
        return cell
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
