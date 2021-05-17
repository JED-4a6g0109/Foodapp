//
//  LoginViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/4/21.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController ,GIDSignInDelegate{

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var LoginStatus: UILabel!
    var Emial = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginGo(_ sender: Any) {
        loginError()
    }
    
    
    
    
    func loginError(){
        if Email.text?.isEmpty == true{
            self.LoginStatus.text = "請輸入信箱"

            return
        }
        if Password.text?.isEmpty == true{
            self.LoginStatus.text = "請輸入密碼"

            return
        }
        
        login()
    }
        
    func login(){
        Auth.auth().signIn(withEmail: Email.text!, password: Password.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error{
                print(error.localizedDescription)
                self?.LoginStatus.text = error.localizedDescription

            }
            else{
                self!.checkUserInput()
            }
            
        }
    }
        
    func checkUserInput(){
        if Auth.auth().currentUser != nil && Auth.auth().currentUser?.isEmailVerified != false{
            self.Emial = ((Auth.auth().currentUser?.email!)!)

   
            navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
            performSegue(withIdentifier: "Account", sender: self)
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "登出", style: .done, target: nil, action: nil)
            let AccountLogout = UIImage(named: "signs")
            navigationController?.navigationBar.backIndicatorImage = AccountLogout
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = AccountLogout
            
        }
        else{
            self.LoginStatus.text = "請至信箱認證此帳號"

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Account"{
            let AccountViewController = segue.destination as! AccountViewController
            AccountViewController.name = Emial
        }
    }
    
    @IBAction func googleAction(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print("\(error.localizedDescription)")
        }
        else{
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                                  accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential, completion: {(authResult, error)in
                
                if (error != nil){
                    return
                }else{
                    self.checkUserInput()
                }
                
            })
        }
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //
    }
    
    
    
    @IBAction func facebookLogin(sender: UIButton) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logOut()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
     
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    
                    return
                }
                else{

                        self.Emial = ((Auth.auth().currentUser?.email!)!)

                        self.performSegue(withIdentifier: "Account", sender: self)
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "登出", style: .done, target: nil, action: nil)
                    
                }
                
                
            })
     
        }
    }
    
}
