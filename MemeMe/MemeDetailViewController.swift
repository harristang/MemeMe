//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Harris Tang on 10/18/15.
//  Copyright © 2015 Harris Tang. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var memeDetailImageView: UIImageView!
    var meme: Meme!

    override func viewWillAppear(animated: Bool) {
        memeDetailImageView.image = meme.memeImageWithText
        tabBarController?.tabBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
    }

    @IBAction func editMeme(sender: UIBarButtonItem) {
        let memeEditorViewControlller = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController

        memeEditorViewControlller.memeForEditing = meme
        presentViewController(memeEditorViewControlller, animated: true, completion: nil)
    }
}
