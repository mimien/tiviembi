//
//  TopsViewController.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 29/04/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import UIKit
import Stormpath

class TopsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var topsCollectionView: UICollectionView!
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var username = ""
    var selectedCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup .after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        Stormpath.sharedSession.me { (account, error) -> Void in
            if let account = account {
                self.titleNavigationItem.title = account.username + " tops"
                self.username = account.username
                self.topsCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let tops = Tops.map[username] {
            messageLabel.hidden = tops.count == 0
            return tops.count
        }
        messageLabel.hidden = false
        return 0
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TopCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.title.text = Tops.map[username]![indexPath.item].description
        cell.title.userInteractionEnabled = false
        cell.categories.text = Tops.map[username]![indexPath.item].icons()
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4
        return cell
    }
        
    // MARK: - UICollectionViewDelegate protocol
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextVC = segue.destinationViewController as? DisplayTopViewController {
            nextVC.top = CurrentTop(username: username, topIndex: selectedCellIndex)
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedCellIndex = indexPath.item
        performSegueWithIdentifier("displayTop", sender: self)
    }
    @IBAction func viewOptions(sender: AnyObject) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        //        alert.popoverPresentationController?.sourceView = sender.superview
        //        alert.popoverPresentationController?.sourceRect = sender.frame
        
        // Alert actions
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
