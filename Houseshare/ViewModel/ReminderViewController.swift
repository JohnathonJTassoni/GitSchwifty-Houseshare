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
    
    private (set) var bills:[Bills] = []
    private (set) var chores:[Chore] = []
    @IBOutlet weak var reminderTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        
        bills = billViewModel.bills
        chores = choreViewModel.getActiveChores()
        
    }
    
    func getDate(dueDate: Date) -> String
    {
        
        var message:String = ""
        let calendar = Calendar.current
        let requestedComponent: Set<Calendar.Component> = [ .month, .day, .hour]
        
        
        var date = DateComponents()
        date.day = calendar.component(.day, from: Date())
        date.month = calendar.component(.month, from: Date())
        date.year = calendar.component(.year, from: Date())
        
        let timeDifference = calendar.dateComponents(requestedComponent, from: dueDate, to: calendar.date(from: date)!)
        
        if timeDifference.day! > 0
        {
            message = "Due in \(timeDifference.day!) days."
        }
        else
        {
            message = "Your bill is overdue."
        }

        
        
        return message
    }
}


extension ReminderViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
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
        switch(section)
        {
            case 0: return chores.count
            case 1: return bills.count
            default: return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let formattedDate = DateFormatter()
        formattedDate.setLocalizedDateFormatFromTemplate("ddMMYYYY")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        
        switch(indexPath.section)
        {
        case 0:
                    let object = chores[indexPath.row]
                    let name = cell.viewWithTag(1000) as? UILabel?
                    let assigned = cell.viewWithTag(1001) as? UILabel?
                    let date = cell.viewWithTag(1002) as? UILabel?
                    
                    if let name = name, let assigned = assigned, let date = date
                    {
                        name?.text = object.choreName
                        assigned?.text = object.assignedUser
                        date?.text = "\(getDate(dueDate: object.dueDate))"
                        
                        
                    }
            
            
        case 1:
                    let object = bills[indexPath.row]
                    let name = cell.viewWithTag(1000) as? UILabel?
                    let amount = cell.viewWithTag(1001) as? UILabel?
                    let date = cell.viewWithTag(1002) as? UILabel?
                    
                    if let name = name, let amount = amount, let date = date
                    {
                        name?.text = object.type.rawValue
                        amount?.text = "$\(object.amount)"
                        date?.text = "\(getDate(dueDate: object.dueDate))"
                    }
        
            
        default: return cell
        }
     
        return cell
    }
}
