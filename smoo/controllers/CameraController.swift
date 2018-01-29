//
//  CameraController.swift
//  smoo
//
//  Created by Jessica Joseph on 1/25/18.
//  Copyright © 2018 Jessica Joseph. All rights reserved.
//

import UIKit

class CameraController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage]as? UIImage {
            self.image.image = image
        } else {
            print("issue")
        }
        
        self.dismiss(animated: true , completion: nil)
    }
    
    @IBAction func importImage(_ sender: AnyObject) {
     
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


