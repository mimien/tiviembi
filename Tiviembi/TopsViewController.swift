//
//  TopsViewController.swift
//  Tiviembi
//
//  Created by Emilio Cornejo on 29/04/16.
//  Copyright © 2016 Emilio Cornejo. All rights reserved.
//

import UIKit

class TopsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var currentTop: Top?
    @IBOutlet weak var topsCollectionView: UICollectionView!
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup .after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        topsCollectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Tops.arrayOfTops.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TopCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.title.text = Tops.arrayOfTops[indexPath.item].description
        cell.categories.text = Tops.arrayOfTops[indexPath.item].icons()
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4
        return cell
    }
        
    // MARK: - UICollectionViewDelegate protocol
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextVC = segue.destinationViewController as? DisplayTopViewController {
            nextVC.top = currentTop!
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentTop = Tops.arrayOfTops[indexPath.item]
        performSegueWithIdentifier("displayTop", sender: self)
        print("You selected cell #\(indexPath.item)!")
    }
}
