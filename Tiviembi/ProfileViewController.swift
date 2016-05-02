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

    @IBOutlet weak var profileTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Stormpath.sharedSession.me { (account, error) -> Void in
            if let account = account {
                self.profileTitle.title = account.username
            }
        }
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
    @IBAction func moreOptions(sender: AnyObject) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//        alert.popoverPresentationController?.sourceView = sender.superview
//        alert.popoverPresentationController?.sourceRect = sender.frame
        let logOut = UIAlertAction(title: "Log out", style: .Destructive) { (action) -> Void in
            Stormpath.sharedSession.logout()
            self.dismissViewControllerAnimated(false, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in })
        alert.addAction(logOut)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
    }
}
