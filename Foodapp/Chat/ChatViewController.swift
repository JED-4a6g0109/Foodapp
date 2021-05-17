//
//  ChatViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/5/14.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var account: UITextField!
        
        @IBOutlet weak var password: UITextField!

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            unsubscribeFromKeyboardNotifications()
        }
        
        func getKeyboardHeight(_ notification: Notification) -> CGFloat {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            return keyboardSize.cgRectValue.height
        }
        
        func unsubscribeFromKeyboardNotifications() {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        var dic5 : Dictionary<String, String> = ["name":"", "email":"", "uid":""]
        var arrDic = NSMutableDictionary()
        var pickerView: UIPickerView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            

        }
        
        
    //    FirebaseDataHelper.instance.signIn(email: "bill@real.com", password: "123456") {

        @IBAction func go(_ sender: Any) {
            
            let dic : Dictionary<String, String> = ["name":account.text!, "email":account.text!, "uid":"cGiEeFazgWXie8hMCvVpmIqw8bq1"]
            arrDic.setValue(dic, forKey: account.text!)
            arrDic.setValue(dic5, forKey: "nilson")
            FirebaseDataHelper.instance.signIn(email: account.text!, password: password.text!) {
                self.openChattingView(self.account.text!)
            }
        }
        
          
        
        func openChattingView(_ name: String) {
            
            let rdic : Dictionary<String, String> = self.arrDic.object(forKey: name) as! Dictionary<String, String>
            let ref = FirebaseDataHelper.instance.chatRef.child(FirebaseDataHelper.instance.currentUserUid!)
            let data: Dictionary<String, AnyObject> = [
                "name": rdic["name"] as AnyObject,
                "uid": rdic["uid"] as AnyObject,
                "email": rdic["email"] as AnyObject
            ]
            print(ref.key as Any)
            ref.updateChildValues(data) { (err, ref) in
                guard err == nil else {
                    print(err as Any)
                    return
                }
                
                let data2: Dictionary<String, AnyObject> = [
                    "name": rdic["name"] as AnyObject,
                    "uid": rdic["uid"] as AnyObject
                ]
                
                let ref2 = FirebaseDataHelper.instance.groupRef.childByAutoId()
                ref2.updateChildValues(data2) { (err, ref3) in
                    guard err == nil else {
                        print(err as Any)
                        return
                    }
                    
                    print(ref.key as Any)
                    let vc = UIStoryboard(name: "ChatSB",bundle:nil).instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                    vc.groupKey = ref.key
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
                
            }
            
            
        }
        
}
