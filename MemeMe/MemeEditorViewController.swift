//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Harris Tang on 9/27/15.
//  Copyright © 2015 Harris Tang. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topMemeField: UITextField!
    @IBOutlet weak var bottomMemeField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeCaptureView: UIView!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    var memeForEditing: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // enable the camera if available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // set defaults for text fields
        setupMemeField(topMemeField)
        setupMemeField(bottomMemeField)
    }
    
    override func viewWillAppear(animated: Bool) {
        subscribeToKeyboardNotifications()
        
        if (memeForEditing != nil) {
            loadMeme()
        }
        // enable share button when image is present
        checkImageForShareButton()
    }
    
    @IBAction func cancelMeme(sender: UIBarButtonItem) {
        memeImageView.image = nil
        checkImageForShareButton()
        topMemeField.text = "TOP"
        bottomMemeField.text = "BOTTOM"
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromAlbum(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        memeImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }

    func setupMemeField(textField: UITextField) {
        textField.delegate = self
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomMemeField.isFirstResponder() {
            view.frame.origin.y = -getKeyboardHeight(notification)
            topMemeField.enabled = false
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
        topMemeField.enabled = true
    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        let generatedMemeImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [generatedMemeImage], applicationActivities: nil)

        activityViewController.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.saveMeme(self.topMemeField.text!, bottomMemeText: self.bottomMemeField.text!, memeImage: self.memeImageView.image!, memeImageWithText: generatedMemeImage)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }

    func saveMeme(topMemeText: String, bottomMemeText: String, memeImage: UIImage, memeImageWithText: UIImage) {
   
        let meme = Meme(topMemeText: topMemeText, bottomMemeText: bottomMemeText, memeImage: memeImage, memeImageWithText: memeImageWithText)
   
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }

    func generateMemedImage() -> UIImage
    {
        // hide toolbars
        topToolBar.hidden = true
        bottomToolbar.hidden = true

        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // show toolbars
        topToolBar.hidden = false
        bottomToolbar.hidden = false
        
        return memedImage
    }
    
    func checkImageForShareButton() {
        if memeImageView.image != nil {
            shareButton.enabled = true
        } else {
            shareButton.enabled = false
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if topMemeField.isFirstResponder() {
            if topMemeField.text == "TOP" {
                topMemeField.text = ""
            }
        } else if bottomMemeField.isFirstResponder() {
            if bottomMemeField.text == "BOTTOM" {
                bottomMemeField.text = ""
            }
        }
    }
    
    func loadMeme() {
        topMemeField.text = memeForEditing.topMemeText
        bottomMemeField.text = memeForEditing.bottomMemeText
        memeImageView.image = memeForEditing.memeImage
    }
}

