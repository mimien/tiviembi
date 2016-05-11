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

    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var topsTableView: UITableView!
    
    let reuseIdentifier = "itemCell"
    var selectedCategory = Top.Category.movies
    var isEditMode = false
    var username: String?
    var topIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.endEditing(true)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if isEditMode {
            let top = CurrentTop(username: username!, topIndex: topIndex!)
            titleNavigationItem.title = "Edit top"
            nameTextField.text = top.get.name
            selectedCategory = top.get.category
            categoryPickerView.selectRow(top.get.categoryIndex(), inComponent: 0, animated: false)
        }
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
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! ItemTableViewCell
        let number = (indexPath.row + 1)
        if isEditMode {
            if let i = topIndex { if let name = username {
                    cell.itemTextField.text = Tops.map[name]![i].list[indexPath.row]
                }
            }
        }
        cell.numberLabel.text = "# " + String(number)
        cell.itemTextField.placeholder = "Top " + String(number)
        return cell
    }

    @IBAction func saveTop(sender: AnyObject) {
        var items: [String] = []
        let paths = topsTableView.indexPathsForVisibleRows
        var noErrors = true
        for path in paths! {
            if path.item == 5 {
                break
            }
            let cell = topsTableView.cellForRowAtIndexPath(path) as! ItemTableViewCell
            if cell.itemTextField.text == "" {
                self.showAlert(withTitle: "Error", message: "Do not leave elements of the top empty")
                noErrors = false
                break;
            }
         
            items.append(cell.itemTextField.text!)
        }
        if nameTextField.text == "" {
            self.showAlert(withTitle: "Error", message: "The top must have a name")
            noErrors = false
        }
        if noErrors {
            let newTop = Top.init(name: nameTextField.text!, category: selectedCategory, list: items)
            if isEditMode {
                if let i = topIndex { if let name = username {
                    Tops.map[name]![i] = newTop
                    }
                }
            } else {
                if (Tops.map[username!]) == nil {
                    Tops.map[username!] = [newTop]
                } else {
                    Tops.map[username!]!.append(newTop)
                }
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}
