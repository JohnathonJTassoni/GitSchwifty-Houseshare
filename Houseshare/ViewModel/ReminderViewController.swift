//
//  ReminderViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 18/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import UIKit

class ReminderViewController: UIViewController
{
    
    let choreViewModel = ChoreViewModel()
    let billViewModel = BillViewModel()
    
    private (set) var reminders:[String:Any?] = [:]
    
    @IBOutlet weak var reminderTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        
        for chore in choreViewModel.getActiveChores()
        {
            reminders.updateValue(chore, forKey: "Chores")
        }

        
        for bill in billViewModel.bills
        {
            reminders.updateValue(bill, forKey: "Bills")
     
        }

    }
}


extension ReminderViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.reminders.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch(section)
        {
            case 0: return "Chores"
            case 1: return "Bills"
            default: return "Error"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var count:Int = 0
        
        switch(section)
        {
            case 0:  for object in reminders
            {
                
                if object.key == "Chores"
                {
                    count+=1;
                }
                
            }
            case 1: for object in reminders
            {
                if object.key == "Bills"
                {
                    count+=1;
                }
                
            }
            default: return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let formattedDate = DateFormatter()
        formattedDate.setLocalizedDateFormatFromTemplate("ddMMYYYY")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! UITableViewCell
        
        switch(indexPath.section)
        {
        case 0:
            for(key, value) in reminders
            {
                if key == "Chores"
                {
                    let value = value as? Chore
                    let name = cell.viewWithTag(1000) as? UILabel?
                    let assigned = cell.viewWithTag(1001) as? UILabel?
                    let date = cell.viewWithTag(1002) as? UILabel?
                    
                    if let name = name, let assigned = assigned, let date = date
                    {
                        name?.text = value?.choreName
                        assigned?.text = value?.assignedUser
                        date?.text = "Due: \(formattedDate.string(from: value!.dueDate))"
                        
                    }
                }
            }
        case 1:
            for(key, value) in reminders
            {
                if key == "Bills"
                {
                    let value = value as? Bills
                    let name = cell.viewWithTag(1000) as? UILabel?
                    let amount = cell.viewWithTag(1001) as? UILabel?
                    let date = cell.viewWithTag(1002) as? UILabel?
                    
                    if let name = name, let amount = amount, let date = date
                    {
                        name?.text = value?.type.rawValue
                        amount?.text = "$\(value!.amount)"
                        date?.text = "Due: \(formattedDate.string(from: value!.dueDate))"
                    }
                }
            }
        default: return cell
        }
     
        return cell
    }
}
