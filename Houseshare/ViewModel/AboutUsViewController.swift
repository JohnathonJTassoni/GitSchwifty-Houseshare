//
//  AboutUsViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 20/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import Foundation
import UIKit

class AboutUsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private (set) var AuthorProfileArray:[Profile] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        /*
        //Only doing this here so that the profiles arent mixed up with the view model data
        var profile = Profile(fname: "John", lname: "Zealand-Doyle", gender: .male, userImage: UIImage(named: "JohnZ"))
        profile.updateDetails(email: "s3319550@student.rmit.edu.au", pnum:"S3319550")
        AuthorProfileArray.append(profile)
        
        profile = Profile(fname: "Johnno", lname: "Tassoni", gender: .male, userImage: UIImage(named: "JohnT"))
        profile.updateDetails(email: "S3800469@student.rmit.edu.au", pnum:"S3800469")
        AuthorProfileArray.append(profile)
        */
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //this is the func we created in the view model
        //we will retunr the count
        return AuthorProfileArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //Here we are getting the image view, giving it the tag we set in the storyboard
        let name = cell.viewWithTag(1000) as? UILabel
        
        let id = cell.viewWithTag(1001) as? UILabel
        
        let image = cell.viewWithTag(1002) as? UIImageView
        
        let email = cell.viewWithTag(1003) as? UILabel
        
        //We must unwrap the variables we just made
        //This ensures that this is executed as long as they are ALL not nil
        if let name = name, let id = id, let image = image, let email = email
        {
            name.text = "\(AuthorProfileArray[indexPath.row].fname) \(AuthorProfileArray[indexPath.row].lname)"
            id.text = "\(AuthorProfileArray[indexPath.row].pnum!)"
            email.text = "\(AuthorProfileArray[indexPath.row].email!)"
            //image.image = AuthorProfileArray[indexPath.row].userImage
        }
        
        return cell
    }
}
