//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Harris Tang on 10/21/15.
//  Copyright © 2015 Harris Tang. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func getMemes() -> [Meme] {
        let memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        return memes
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMemes().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell", forIndexPath: indexPath)
        let meme = getMemes()[indexPath.row]

        cell.textLabel!.text = meme.memeTitle()
        cell.imageView?.image = meme.memeImageWithText

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memeDetailViewController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = getMemes()[indexPath.row]
        navigationController!.pushViewController(memeDetailViewController, animated: true)
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
