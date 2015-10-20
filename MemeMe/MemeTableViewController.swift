//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Harris Tang on 10/18/15.
//  Copyright © 2015 Harris Tang. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var memeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        memeTableView.reloadData()
    }
    
    func getMemes() -> [Meme] {
        let memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        return memes
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMemes().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID = "MemeCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellID, forIndexPath: indexPath)
        
        let meme = getMemes()[indexPath.row]

        cell.textLabel!.text = meme.memeTitle()
        cell.imageView?.image = meme.memeImageWithText

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = getMemes()[indexPath.row]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
}
