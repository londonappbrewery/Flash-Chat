//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase


class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUser = Auth.auth().currentUser {
            signOut()
            emailTextfield.text = currentUser.email!
            passwordTextfield.becomeFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, err) in
            if err != nil {
                let alert = UIAlertController(title: "Error", message: err?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.retryLogin()
            } else if !user!.isEmailVerified {
                let alert = UIAlertController(title: "Email Address Not Verified",
                                              message: "Please check your email and verify your email address before logging in.",
                                              preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // TODO: Add option to resend verification
                self.present(alert, animated: true, completion: nil)
                self.retryLogin()
            } else {
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
    
    func retryLogin() {
        self.passwordTextfield.text = ""
        self.passwordTextfield.becomeFirstResponder()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let err as NSError {
            print("Error signing out: \(err)")
        }
    }
}
