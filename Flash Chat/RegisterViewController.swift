//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    @IBAction func registerPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, err) in
            if err != nil {
                SVProgressHUD.dismiss()
                self.showError(err!)
            } else {
                if let user : User = Auth.auth().currentUser {
                    user.sendEmailVerification() { (err) in
                        SVProgressHUD.dismiss()
                        if err != nil {
                            self.showError(err!)
                        } else {
                            let alert = UIAlertController(title: "Email Verification Sent",
                                                          message: "Please follow the instructions in the email to complete registration.",
                                                          preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { _ in
                                self.performSegue(withIdentifier: "goToLoginAfterRegistration", sender: self)
                            })
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    func showError(_ err: Error) {
        print(err)
        let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
