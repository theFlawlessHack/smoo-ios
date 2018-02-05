//
//  ViewController.swift
//  smoo
//
//  Created by Jessica Joseph on 1/25/18.
//  Copyright © 2018 Jessica Joseph. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "Users")
        
        query.getObjectInBackground(withId: "7yYY4NOhUn") { (object, error) in
            if error != nil {
                print(error)
            } else {
                if let user = object {
                    print(user)
                    
                    user["name"] = "Blahity"
                    user.saveInBackground(block: { (success, error) in
                        if success {
                            print("Saved")
                        } else {
                            print("Error")
                        }
                    })
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

