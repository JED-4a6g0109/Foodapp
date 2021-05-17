//
//  KeepAccountViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/11/10.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit
import Firebase
fileprivate let baseRef = Database.database().reference()
class KeepAccountViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet var itemName: UITextField!
    @IBOutlet weak var date: UITextField!
    
    public var completionHandler:((String) -> Void)?
    
    @IBOutlet weak var keepAccount: UIView!
    @IBOutlet weak var foodManage: UIView!
    var selectDay:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loc = Locale(identifier: "zh_tw")
        self.datePicker.locale = loc
        
        datePicker?.addTarget(self, action: #selector(KeepAccountViewController.dateChange(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(KeepAccountViewController.viewTapped(gestureRecognizer:)))
        
        inputTextField.addTarget(self, action: #selector(KeepAccountViewController.inputFieldPush(inputFieldPush:)), for: .touchDown)
        view.addGestureRecognizer(tapGesture)
        inputTextField.inputView = datePicker
        inputTextField.text = selectDay
    }
    
    @objc func inputFieldPush(inputFieldPush: UITextField){
        datePicker.isHidden = false

    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        inputTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }

    
    @IBAction func SaveData(_ sender: Any) {
        if amount.text! != "" && inputTextField.text != ""{
            var ref: DatabaseReference!

            ref = Database.database().reference()
            let item = itemName.text!
            ref.child("KeepAccount/\(inputTextField.text!)/\(item)").setValue(amount.text! + " " + item)

            completionHandler?(itemName.text!)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func createFoodManage(_ sender: Any){

        let vc = storyboard?.instantiateViewController(identifier: "foodManage") as! FoodManagementViewController
        vc.modalPresentationStyle = .fullScreen
        vc.selectDay = selectDay
        present(vc,animated: true)

    }
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {

    }
    
    @IBAction func comeBackKeepAccount(_ sender: UIStoryboardSegue){}
}
