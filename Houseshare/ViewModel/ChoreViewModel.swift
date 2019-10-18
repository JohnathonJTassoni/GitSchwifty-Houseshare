//
//  ChoreViewModel.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 15/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation

struct ChoreViewModel
{
    //This is connecting to the LKCharacter file in the Model folder
    //This is private so that nothing can change the array
    private (set) var chores:[Chore] = []
    
    //Counting our chores not yet completed
    var countActive:Int
    {
        var count:Int = 0
        
        for chore in chores where chore.completed == false
        {
            count+=1
        }
        
        return count
    }
    
    //Counting the chores completed
    var countCompleted:Int
    {
        var count:Int = 0
        
        for chore in chores where chore.completed == true
        {
            count+=1
        }
        
        return count
    }
    
    
    init()
    {
        loadData()
    }
    
    //this just populates our array
    private mutating func loadData()
    {
        let calender = Calendar.current
        var myDate = DateComponents(calendar: calender, year: 2019, month: 2, day: 12)
        var newChore = Chore(choreName: "Clean Dishes", dueDate: calender.date(from: myDate)!, assignedUser: "Lana")
        chores.append(newChore)
        
        myDate = DateComponents(calendar: calender, year: 2019, month: 3, day: 22)
        newChore = Chore(choreName: "Vacuum House", dueDate: calender.date(from: myDate)!, assignedUser: "Mick")
        newChore.choreCompleted()
        chores.append(newChore)
        
        myDate = DateComponents(calendar: calender, year: 2019, month: 3, day: 1)
        newChore = Chore(choreName: "Vacuum House", dueDate: calender.date(from: myDate)!, assignedUser: "Taylor")
        chores.append(newChore)
    }
    
    func getChore(byIndex index:Int) -> Chore
    {
        // this will hold the selected profile chosen by index
        let selectedChore = chores[index]
        
        //return the profile
        return selectedChore
    }
    
    func getChores(byUser name:String) -> [Chore]
    {
        var usersChores:[Chore] = []
            
        for chore in self.getActiveChores()
        {
            if chore.assignedUser == name
            {
                usersChores.append(chore)
            }
        }
        
        return usersChores
    }
    
    func getActiveChores() -> [Chore]
    {
        var activeChores:[Chore] = []
        
        for chores in self.chores
        {
            if chores.completed == false
            {
                activeChores.append(chores)
            }
        }
        
        return activeChores
    }
    
    func getCompletedChores() -> [Chore]
    {
        var completedChores:[Chore] = []
        
        for chores in self.chores
        {
            if chores.completed == true
            {
                completedChores.append(chores)
            }
        }
        
        return completedChores
    }
    
    
    mutating func addChore(chore: Chore)
    {
        chores.append(chore)
    }
    
    func choreCompleted(byIndex index:Int)
    {
        chores[index].choreCompleted()
    }
    
}
