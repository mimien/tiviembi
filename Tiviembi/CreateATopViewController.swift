//
//  CreateATopViewController.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 02/05/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import UIKit
import Stormpath
class CreateATopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var topsTableView: UITableView!
    
    var items: [String] = []
    var itemsCount: Int = 3
    var username = ""
    let reuseIdentifier = "itemCell"
    var selectedCategory = Top.Category.movies
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
    
   func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
 
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Top.Category.allValues.count;
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = Top.Category.allValues[row]
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.text = Top.Category.allValues[row].rawValue
        pickerLabel.font = UIFont(name: "System", size: 12)
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
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
        print(selectedCategory)
        let newTop = Top.init(name: nameTextField.text!, category: selectedCategory, list: items)

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
