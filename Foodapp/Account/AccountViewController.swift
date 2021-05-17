//
//  AccountViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/4/22.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit
import Firebase
class AccountViewController: UIViewController {
    var name = ""
    @IBOutlet weak var account_name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        account_name.text = "歡迎"+name
    }
    

    override func didMove(toParent parent: UIViewController?) {
        if(parent == nil){
            let firebaseAuth = Auth.auth()
            do{
                try firebaseAuth.signOut()
            }catch let signOutError as NSError{
                print("登出失敗",signOutError)
            }
        }
    }
    
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

    
    
    
    @IBAction func GoChat(_ sender: Any) {
        let dic5 : Dictionary<String, String> = ["name":name, "email":name, "uid":Auth.auth().currentUser!.uid]
        let arrDic = NSMutableDictionary()
//        var pickerView: UIPickerView!

        let dic : Dictionary<String, String> = ["name":name, "email":name, "uid":Auth.auth().currentUser!.uid]
        arrDic.setValue(dic, forKey: name)
        arrDic.setValue(dic5, forKey: "nilson")
        openChattingView(self.name,arrDic)
    }
    
    func openChattingView(_ name: String,_ arrDic: NSMutableDictionary) {
        
        let rdic : Dictionary<String, String> = arrDic.object(forKey: name) as! Dictionary<String, String>
        
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
