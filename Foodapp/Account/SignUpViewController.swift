//
//  SignUpViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/4/21.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class SignUpViewController: UIViewController {

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var SignStatus: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginGO(_ sender: Any) {
        if Email.text?.isEmpty == true{
            self.SignStatus.text = "請輸入信箱"

            return
        }
        if Password.text?.isEmpty == true{
            self.SignStatus.text = "請輸入密碼"

            return
        }
        
        signUp()
    }
    func signUp(){
        Auth.auth().createUser(withEmail: Email.text!, password: Password.text!){
            (authResult, error) in
            guard let user = authResult?.user, error == nil else{
                print("Error \(error?.localizedDescription)")
                self.SignStatus.text = error?.localizedDescription
                return
            }
            self.sendVerificationMail()
            
            let alertController = UIAlertController(title: "註冊成功！", message: "message", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
//            let stroyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = stroyboard.instantiateViewController(withIdentifier: "Success")
//            self.present(vc,animated: true)
            
            
        }
    }
    
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }

    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                print("sent to email")
            })
        }
        else {
            print("error")
        }
    }
   

}
