//
//  CreateATopViewController.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 02/05/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import UIKit

class CreateATopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bookSwitch: UISwitch!
    @IBOutlet weak var videogameSwitch: UISwitch!
    @IBOutlet weak var tvSwitch: UISwitch!
    @IBOutlet weak var filmSwitch: UISwitch!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var topsTableView: UITableView!
    
    var items: Int = 3
    let reuseIdentifier = "itemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items
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
        items += 1
        topsTableView.reloadData()
    }
    @IBAction func createTop(sender: AnyObject) {
        let newTop = Top.init(name: nameTextField.text!, categories: (filmSwitch.on, tvSwitch.on, videogameSwitch.on, bookSwitch.on), list: )
        Tops.arrayOfTops.append(newTop)
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
