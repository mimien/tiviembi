//
//  DisplayTopViewController.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 03/05/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import UIKit

class DisplayTopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var top: Top = Tops.example
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        nameLabel.text = top.name
        categoriesLabel.text = top.icons()
        listTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return top.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("displayTopCell", forIndexPath: indexPath)
        let number = top.list.count - indexPath.row
        cell.textLabel?.text = "#\(number) - " + top.list[number - 1]
        return cell
    }
    
}
