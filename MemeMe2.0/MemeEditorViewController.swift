//
//  MemeEditorViewController.swift
//  MemeMe2.0
//
//  Created by Taylor Masterson on 7/25/17.
//  Copyright © 2017 Taylor Masterson. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let myTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        if sender == albumButton {
            presentImagePickerWith(sourceType: .photoLibrary)
        } else {
            presentImagePickerWith(sourceType: .camera)
        }
    }
    
    @IBAction func cancelMemeCreation(_ sender: Any) {
        configureTextField(textField: topTextField, text: "TOP", defaultAttributes: myTextAttributes)
        configureTextField(textField: bottomTextField, text: "BOTTOM", defaultAttributes: myTextAttributes)
        imageView.image = nil
        shareButton.isEnabled = false
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let meme = generateMemeImage()
        let activityViewController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activityTyp: UIActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) in
                if completed {
                    self.save(memeImage: meme)
                    activityViewController.dismiss(animated: true, completion: nil)
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField(textField: topTextField, text: "TOP", defaultAttributes: myTextAttributes)
        configureTextField(textField: bottomTextField, text: "BOTTOM", defaultAttributes: myTextAttributes)
        shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    // MARK: - Top and Botom Text Field Attributes 
    
    func configureTextField(textField: UITextField, text: String, defaultAttributes: [String: Any]) {
        textField.delegate = self
        textField.text = text
        textField.defaultTextAttributes = defaultAttributes
        textField.textAlignment = .center
    }
    
    // MARK: - Image Picker Delegate and Presentation
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if imageView.image == nil {
            shareButton.isEnabled = false
        }
        shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Keyboard Presentation and Notification Setup
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillShow(_ notification: Notification){
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Text Field Delegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Create and Save Meme Object
    
    func setToolbars(visible: Bool) {
        topToolbar.isHidden = !visible
        topToolbar.isHidden = !visible
    }
    
    func generateMemeImage() -> UIImage {
        // hide toolbars temporarily to capture image from view
        setToolbars(visible: false)
        
        // get the size of the view and build an image from whats on the screen
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // give toolbars back to user
        setToolbars(visible: true)
        
        return memeImg
    }
    
    func save(memeImage: UIImage) {
        // Create the meme
        let meme = Meme(topText: topTextField.text!,
                        bottomText: bottomTextField.text!,
                        originalImage: imageView.image,
                        memeImage: memeImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }

}


















