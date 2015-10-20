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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        memeDetailImageView.image = meme.memeImageWithText
        self.tabBarController?.tabBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    @IBAction func editMeme(sender: UIBarButtonItem) {
        let memeEditorViewControlller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        memeEditorViewControlller.memeForEditing = meme
        self.presentViewController(memeEditorViewControlller, animated: true, completion: nil)
    }
}
