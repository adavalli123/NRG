//
//  ViewController.swift
//  ANSI-Solutions
//
//  Created by yashwanth on 12/3/16.
//  Copyright © 2016 srikanth. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        loginButton.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(_ sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        // Validate the text fields
        if (username!.characters.count) < 5 {
            
            let alertController = UIAlertController(title: "Invalid", message: "Username must be greater than 5 characters", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
        } else if (password!.characters.count) > 8 && checkTextSufficientComplexity(password!){
            self.performSegue(withIdentifier: "showFeed", sender: nil)
            
        } else {
            let alertController = UIAlertController(title: "Invalid", message: "Password must be greater than 8 characters, atleast One Capital Letter, atleast One Number", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func checkTextSufficientComplexity(_ text : String) -> Bool{
        
        let text = text
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        
        let specialresult = texttest2.evaluate(with: text)
        return (capitalresult || numberresult) && !specialresult
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case "showFeed"?:
            _ = segue.destination as? GoogleFeedsViewController
        default:
            break
        }
    }
}

