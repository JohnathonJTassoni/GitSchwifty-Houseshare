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
        
        //set the delegates
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        
        //popupale the appropriate arrays
        bills = billViewModel.bills
        chores = choreViewModel.getActiveChores()
        
    }
    
    //this will return how many days left
    func getDate(dueDate: Date) -> String
    {
        var message:String = ""
        let calendar = Calendar.current
        let requestedComponent: Set<Calendar.Component> = [ .month, .day, .hour]
        
        //get the current date
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
    
    //section titles
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch(section)
        {
            case 0: return "Chores"
            case 1: return "Bills"
            default: return "Error"
        }
    }
    
    //section header background colour and text colours
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        view.tintColor = UIColor.orange
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    //num of rows for section content
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
        
        //cell to return as default
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        
        //switch statement to choose header content
        switch(indexPath.section)
        {
        case 0:
                    let object = chores[indexPath.row]
                    let name = cell.viewWithTag(1000) as? UILabel?
                    let assigned = cell.viewWithTag(1001) as? UILabel?
                    let date = cell.viewWithTag(1002) as? UILabel?
                    
                    guard let selectedChoreDate = object.dueDate as Date? else
                    {
                        break
                    }
                    
                    if let name = name, let assigned = assigned, let date = date
                    {
                        name?.text = object.choreName
                        assigned?.text = "\(object.assignedUser!.fname!) \(object.assignedUser!.lname!)"
                        date?.text = "\(getDate(dueDate: selectedChoreDate))"
                    }
            
            
        case 1:
                    let object = bills[indexPath.row]
                    let name = cell.viewWithTag(1000) as? UILabel?
                    let amount = cell.viewWithTag(1001) as? UILabel?
                    let date = cell.viewWithTag(1002) as? UILabel?
                    
                    guard let selectedBillDate = object.dueDate as Date? else
                    {
                        break
                    }
                    
                    if let name = name, let amount = amount, let date = date
                    {
                        name?.text = object.billType
                        amount?.text = "$\(object.amount)"
                        date?.text = "\(getDate(dueDate: selectedBillDate))"
                    }
        
            
        default: return cell
        }
     
        return cell
    }
}
