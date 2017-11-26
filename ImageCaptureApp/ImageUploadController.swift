//
//  ImageUploadController.swift
//  ImageCaptureApp
//
//  Created by Herath Mudiyanselage Nethanjan Danindu Premaratne on 3/11/17.
//  Copyright © 2017 Herath Mudiyanselage Nethanjan Danindu Premaratne. All rights reserved.
//

import UIKit
import CoreData

class ImageUploadController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Outlet for the image upload process
    // Outlet for image View
    @IBOutlet weak var ImageUploadView: UIImageView!
    
    // Outlet for Title Text Field
    @IBOutlet weak var titleView: UITextField!
    
    // Outlet for Lcation Text Field
    @IBOutlet weak var locationView: UITextField!
    
    // Outlet for Date Text Field
    @IBOutlet weak var dateView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //function for pick the photo
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        ImageUploadView.image = image
        dismiss(animated: false, completion: nil)
    }
    

    // action for upload a photo
    @IBAction func UploadImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        controller.allowsEditing = false;
        controller.delegate = self;
        present(controller, animated: true, completion: nil)
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action for save all the data in the database
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Insert data into Picture Entity
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Picture", into: context)
        
        // Save values getting from titleView in title coloum in database
        entity.setValue(titleView.text, forKey: "title")
        
        // Save value getting from locationView in location coloum in database
        entity.setValue(locationView.text, forKey: "location")
        
        // Save value getting from dateView in date coloum in database
        entity.setValue(dateView.text, forKey: "date")
        
        let image = UIImageJPEGRepresentation(ImageUploadView.image!, 1)
        
        // Save value getting from ImageUploadView in date coloum in database
        entity.setValue(image, forKey: "image")
        
        do{
            try context.save()
            print("done")
            
            // alert to inform user, success of the submission
            let alert = UIAlertController(title: "Cogratulations", message: "Successfully Updated the Database", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        catch{
            print("Enter")
            
            //alert user to error of submission
            let alert = UIAlertController(title: "Sorry", message: "Error While Updating Database", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }


}
