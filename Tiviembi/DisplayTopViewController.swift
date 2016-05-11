//
//  DisplayTopViewController.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 03/05/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import UIKit

class DisplayTopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    var top: CurrentTop?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        nameLabel.text = top!.get.name
        categoriesLabel.text = top!.get.category.rawValue
        listTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextVC = segue.destinationViewController as? CreateATopViewController {
            nextVC.username = top!.username
            nextVC.topIndex = top!.topIndex
            nextVC.isEditMode = true
        }
    }
    // MARK: - UITableViewDataSource
    @IBAction func edit(sender: AnyObject) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Alert actions
        let edit = UIAlertAction(title: "Edit Top", style: .Default) { (action) -> Void in
            self.performSegueWithIdentifier("editTop", sender: self)
        }
        let delete = UIAlertAction(title: "Delete Top", style: .Destructive) { (action) -> Void in
            Tops.map[self.top!.username]?.removeAtIndex(self.top!.topIndex)
            self.navigationController?.popViewControllerAnimated(true)
        }
    
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in })
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        presentViewController(alert, animated: true, completion: nil)
        
//        self.listTableView.editing = !self.listTableView.editing
//        listTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return top!.get.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("displayTopCell", forIndexPath: indexPath)
        let number = top!.get.list.count - indexPath.row
        cell.textLabel?.text = "#\(number) - " + top!.get.list[number - 1]
        return cell
    }
    
}
