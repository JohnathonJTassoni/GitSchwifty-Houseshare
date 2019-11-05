//
//  FileViewController.swift
//  Houseshare
//
//  Created by Johnathon Tassoni on 25/10/19.
//  Copyright © 2019 GitSchwifty. All rights reserved.
//

import UIKit
import GoogleSignIn

class FileViewController: UIViewController, GIDSignInUIDelegate
{
    

    @IBOutlet weak var signIn: GIDSignInButton?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
   
        let gsignIn = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 230, height: 48))
        gsignIn.center = view.center
        view.addSubview(gsignIn)
        
    }
    
}

extension FileViewController: UIDocumentPickerDelegate
{
    
}
