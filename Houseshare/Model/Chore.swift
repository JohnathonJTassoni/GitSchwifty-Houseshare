//
//  Chore.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 15/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation


class Chore
{
    private (set) var choreName:String
    private (set) var dueDate:Date
    private (set) var completed:Bool
    private (set) var assignedUser:String
    
    init(choreName: String, dueDate: Date, assignedUser: String = " ")
    {
        self.choreName = choreName
        self.dueDate = dueDate
        self.completed = false
        self.assignedUser = assignedUser
    }
    
    func choreCompleted()
    {
        self.completed = true
    }

    func choreDetails() -> (choreName:String, dueDate:Date, completed:Bool, assignedUser:String)
    {
        return(self.choreName, self.dueDate, self.completed, self.assignedUser)
    }
}
