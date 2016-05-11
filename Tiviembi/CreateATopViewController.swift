//
//  CreateATopViewController.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 02/05/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import UIKit
import Stormpath
class CreateATopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bookSwitch: UISwitch!
    @IBOutlet weak var videogameSwitch: UISwitch!
    @IBOutlet weak var tvSwitch: UISwitch!
    @IBOutlet weak var filmSwitch: UISwitch!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var topsTableView: UITableView!
    
    var items: [String] = []
    var itemsCount: Int = 3
    var username = ""
    let reuseIdentifier = "itemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        Stormpath.sharedSession.me { (account, error) -> Void in
            if let account = account {
                self.username = account.username
                print(self.username)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! ItemTableViewCell
        let number = (indexPath.row + 1)
        cell.itemTextField.placeholder = "Top \(number)"
        cell.numberLabel.text = "#" + String(number)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func addItem(sender: AnyObject) {
        itemsCount += 1
        topsTableView.reloadData()
    }
    @IBAction func createTop(sender: AnyObject) {
        let paths = topsTableView.indexPathsForVisibleRows
        for path in paths! {
            print(path.item)
            print(itemsCount)
            if path.item == itemsCount {
                break
            }
            let cell = topsTableView.cellForRowAtIndexPath(path) as! ItemTableViewCell
            items.append(cell.itemTextField.text!)
           
        }
        let newTop = Top.init(name: nameTextField.text!, categories: (filmSwitch.on, tvSwitch.on, videogameSwitch.on, bookSwitch.on), list: items)
        print(username)
        if Tops.map[username] == nil {
            Tops.map[username] = [newTop]
        } else {
            Tops.map[username]!.append(newTop)
        }
        print(Tops.map[username]!)
        dismissViewControllerAnimated(true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
