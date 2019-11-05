//
//  ChoresTableViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 15/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import UIKit

protocol ChoreDelegate
{
    func updateChore(completedChore: Chore)
    func addChore(_ choreName:String, _ dueDate:Date, _ assignedUser:Profile)
}

class ChoresTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    //this connects to the view model
    private var viewModel = ChoreViewModel()
    //private var userName:String = "Taylor"

    @IBOutlet weak var ChoresTable: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        ChoresTable.delegate = self
        ChoresTable.dataSource = self
    }
    
    @IBAction func pastChores(_ sender: Any)
    {
        //Get the storyboard and the view for the popover

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PastChores") as! ChoreHistoryTableViewController
        
        vc.viewModel = viewModel
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func myChores(_ sender: Any)
    {
        //Get the storyboard and the view for the popover
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyChores") as! MyChoreTableViewController

        vc.delegate = self
        vc.viewModel = viewModel
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addChore(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddChore") as! ChoreAddViewController

        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    
    
    //This is for finding the number of rows, basically how many items in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //this is the func we created in the view model
        //we will retunr the count
        return viewModel.countActive
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //you need to provided the resuable cell attribute that we set on the prototype cell
        //in the storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoreCell", for: indexPath)
        
        //Here we are getting the image view, giving it the tag we set in the storyboard
        let name = cell.viewWithTag(7000) as? UILabel
            
        let assignedUser = cell.viewWithTag(7001) as? UILabel
            
        let dueDate = cell.viewWithTag(7002) as? UILabel
        
        let activeChores:[Chore] = viewModel.getActiveChores()
        
        
        
            
        //We must unwrap the variables we just made
        //This ensures that this is executed as long as they are ALL not nil
        if let name = name, let assignedUser = assignedUser, let dueDate = dueDate
        {
            //index path starts at 0 and goes up for the amount of characters/rows,
            //we are using this num to get our characters
            
            let currentChore = activeChores[indexPath.row]
                
            if currentChore.completed == false
            {
                let formattedDate = DateFormatter()
                formattedDate.setLocalizedDateFormatFromTemplate("ddMMYYYY")
                        
                //setting the storyboard elements to the data that we are getting from the model
                name.text = currentChore.choreName
                dueDate.text = "Due: \(formattedDate.string(from: currentChore.dueDate! as Date))"
                
                assignedUser.text = "\(currentChore.assignedUser!.fname!) \(currentChore.assignedUser!.lname!)"
                
                
                return cell
                
            }
                
        }
            
        return cell
    }
    
}

extension ChoresTableViewController: ChoreDelegate
{
    func updateChore(completedChore: Chore)
    {
        for chore in viewModel.getActiveChores()
        {
            if chore.choreName == completedChore.choreName
            {
                chore.completed = true
            }
        }
        ChoresTable.reloadData()
    }
    
    func addChore(_ choreName:String, _ dueDate:Date, _ assignedUser:Profile)
    {
        viewModel.addChore(choreName, dueDate, assignedUser)
        ChoresTable.reloadData()
        
    }
}
