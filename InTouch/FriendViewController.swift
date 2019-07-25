//
//  FriendViewController.swift
//  InTouch
//
//  Created by Yunfan Xing on 7/4/19.
//  Copyright © 2019 Yunfan Xing. All rights reserved.
//

import UIKit
import os.log

class FriendViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        addFriend.isEnabled = false
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        OccupationText.delegate = self
        RelationText.delegate = self

        
        // Enable the Save button only if the text field has a valid Friend name.
        updateSaveButtonState()
    }

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var OccupationText: UITextField!
    @IBOutlet weak var RelationText: UITextField!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var addFriend: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var friend: Friend?
    
    //MARK: Navigation
    @IBAction func canceAddFriend(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImage.image
        let rating = ratingControl.rating
        let occupation = OccupationText.text ?? ""
        let relation = RelationText.text ?? ""
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        friend = Friend(name: name, photo: photo, rating: rating, occupation: occupation, relation: relation)
    }
    //MARK: Action
    @IBAction func selectImageFromPhoto(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        addFriend.isEnabled = !text.isEmpty
    }
    
}

