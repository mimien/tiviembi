//
//  ProfileViewController.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 29/04/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import UIKit
import Stormpath

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Logout(sender: AnyObject) {
        Stormpath.sharedSession.logout()
        
        dismissViewControllerAnimated(false, completion: nil)

    }
}
