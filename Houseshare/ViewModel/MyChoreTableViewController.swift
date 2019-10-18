//
//  ChoreDetailTableViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 15/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import UIKit

class MyChoreTableViewController: UITableViewController
{
    var viewModel = ChoreViewModel()
    var delegate:ChoreDelegate?
    var userName = "Taylor"
    private (set) var usersChores:[Chore] = []
    

    
    @IBAction func Dismiss(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func getUsersChores()
    {

        usersChores = viewModel.getChores(byUser: userName)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(usersChores.count)
        return usersChores.count
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
            //index path starts at 0 and goes up for the amount of characters/rows,
            //we are using this num to get our characters
           
                let currentChore = usersChores[indexPath.row]
            
                let formattedDate = DateFormatter()
                formattedDate.setLocalizedDateFormatFromTemplate("ddMMYYYY")
            
                //setting the storyboard elements to the data that we are getting from the model
                name.text = currentChore.choreName
                dueDate.text = "Due: \(formattedDate.string(from: currentChore.dueDate))"
                assignedUser.text = "Assigned to: \(currentChore.assignedUser)"
            
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let completeChoreAction = UIAlertAction(title: "Complete Chore", style: .destructive, handler:
        {
            (action:UIAlertAction) in
            self.delegate?.updateChore(completedChore: self.usersChores[indexPath.row])
            self.usersChores.remove(at: indexPath.row)
            self.loadView()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
        actionSheet.addAction(completeChoreAction)
        actionSheet.addAction(cancelAction)
    
    
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getUsersChores()
    }
    
}
