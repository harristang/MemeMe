//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Harris Tang on 10/21/15.
//  Copyright © 2015 Harris Tang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"

class MemeCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }

    func getMemes() -> [Meme] {
        let memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        return memes
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMemes().count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        let meme = getMemes()[indexPath.item]
        let imageView = UIImageView(image: meme.memeImageWithText)
        imageView.contentMode = .ScaleAspectFit
        cell.backgroundView = imageView
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetailViewController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = getMemes()[indexPath.item]
        navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
}
