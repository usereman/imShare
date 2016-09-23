//
//  LoginViewController.swift
//  imshare
//
//  Created by Abdullah Hafeez on 08/09/2016.
//  Copyright © 2016 Abdullah Hafeez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        super.viewDidLoad()
        if let user = FIRAuth.auth()?.currentUser
        {
            self.performSegueWithIdentifier("showHome", sender: self)
            func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
                segue.destinationViewController as! ViewController
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createuserAction(sender: AnyObject) {
        if self.emailTxtField.text == "" || self.passTxtField.text == ""
        {
            let alertController = UIAlertController(title: "Oops", message: "Please enter an Email and Password", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.createUserWithEmail(self.emailTxtField.text!, password: self.passTxtField.text!, completion: { (user, error) in
                if error == nil
                {
                    self.emailTxtField.text = ""
                    self.passTxtField.text = ""
                    self.performSegueWithIdentifier("showHome", sender: self)
                }
                else
                {
                    let alertController = UIAlertController(title: "Oops", message: error?.localizedDescription, preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            })
            func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
                segue.destinationViewController as! ViewController
            }
        }
    

}
    @IBAction func loginAction(sender: AnyObject) {
        if self.emailTxtField.text == "" || self.passTxtField.text == ""
        {
            let alertController = UIAlertController(title: "Oops", message: "Please enter an Email and Password", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.signInWithEmail(self.emailTxtField.text!, password: self.passTxtField.text!, completion: {(user,error) in
                if error == nil
                {
                    self.emailTxtField.text = ""
                    self.passTxtField.text = ""
                    self.performSegueWithIdentifier("showHome", sender: self)
                }
                else
                {
                    let alertController = UIAlertController(title: "Oops", message: error?.localizedDescription, preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }

            })
            func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
                segue.destinationViewController as! ViewController
            }
        
        }
    }
}
