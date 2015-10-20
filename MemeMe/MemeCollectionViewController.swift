//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Harris Tang on 10/19/15.
//  Copyright © 2015 Harris Tang. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var memeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeCollectionView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        memeCollectionView.reloadData()
    }
    
    func getMemes() -> [Meme] {
        let memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        return memes
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMemes().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = getMemes()[indexPath.item]

        let imageView = UIImageView(image: meme.memeImageWithText)
        imageView.contentMode = .ScaleAspectFit
        cell.backgroundView = imageView

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = getMemes()[indexPath.item]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
}
