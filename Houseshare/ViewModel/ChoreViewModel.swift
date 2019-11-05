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
    private var choreManager = ChoreManager.shared
    
    var count:Int
    {
        return choreManager.chores.count
    }
    //Counting our chores not yet completed
    var countActive:Int
    {
        var count:Int = 0
        
        for chore in choreManager.chores where chore.completed == false
        {
            count+=1
        }
        
        return count
    }
    
    //Counting the chores completed
    var countCompleted:Int
    {
        var count:Int = 0
        
        for chore in choreManager.chores where chore.completed == true
        {
            count+=1
        }
        
        return count
    }
    
    func getChore(byIndex index:Int) -> Chore
    {
        // this will hold the selected profile chosen by index
        let selectedChore = choreManager.chores[index]
        
        //return the profile
        return selectedChore
    }
    
    //return a chore array by selected user
    func getChores(byUser name:String) -> [Chore]
    {
        var usersChores:[Chore] = []
            
        for chore in self.getActiveChores()
        {
            if "\(chore.assignedUser!.fname!) \(chore.assignedUser!.lname!)" == name
            {
                usersChores.append(chore)
            }
        }
        
        return usersChores
    }
    
    //return all the active chroes
    func getActiveChores() -> [Chore]
    {
        var activeChores:[Chore] = []
        
        for chores in choreManager.chores
        {
            if chores.completed == false
            {
                activeChores.append(chores)
            }
        }
        
        return activeChores
    }
    
    //return all the completed chores
    func getCompletedChores() -> [Chore]
    {
        var completedChores:[Chore] = []
        
        for chores in choreManager.chores
        {
            if chores.completed == true
            {
                completedChores.append(chores)
            }
        }
        
        return completedChores
    }
    
    //add new chore
    mutating func addChore(_ choreName:String, _ dueDate: Date, _ assignedUser:Profile)
    {
        choreManager.addChore(choreName, dueDate, assignedUser)
    }
    
    //set a chore to complete
    func choreCompleted(byIndex index:Int)
    {
        choreManager.chores[index].completed = true
    }
    
}
