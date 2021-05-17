//
//  FoodManagementViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/11/11.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit
import Firebase
fileprivate let baseRef = Database.database().reference()

class FoodManagementViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {

    var dictionary =  [[String:Any]]()
    var post : [String:String] = [:]

    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var foodTime: UITextField!
    @IBOutlet weak var foodName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var pickView: UIPickerView!
    var foodTimeSelection = ["☀️" , "🌙" , "🕗"]
    var todayYM = ""
    var selectDay = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        pickView.delegate = self
        pickView.dataSource = self
        
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        todayYM = dateFormatter.string(from: today)
        date.text = selectDay

        
        let loc = Locale(identifier: "zh_tw")
        self.datePicker.locale = loc
        
        datePicker?.addTarget(self, action: #selector(FoodManagementViewController.dateChange(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FoodManagementViewController.viewTapped(gestureRecognizer:)))
        
        date.addTarget(self, action: #selector(FoodManagementViewController.inputFieldPush(inputFieldPush:)), for: .touchDown)
        view.addGestureRecognizer(tapGesture)
        date.inputView = datePicker
        foodTime.addTarget(self, action: #selector(FoodManagementViewController.inputFieldPushFood(inputFieldPush:)), for: .touchDown)
        
        fetchdate()

        
        
    }
    
    @objc func inputFieldPush(inputFieldPush:UITextField){
        datePicker.isHidden = false
    }
    @objc func inputFieldPushFood(inputFieldPush:UITextField){
        pickView.isHidden = false
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }

    @objc func dateChange(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        self.selectDay = date.text!
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        foodTimeSelection.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foodTimeSelection[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        foodTime.text = foodTimeSelection[row]
        foodTime.resignFirstResponder()
        pickView.isHidden = true

    }
    

    
    @IBAction func saveFoodData(_ sender: Any) {
        if foodTime.text! != "" && foodName.text! != ""{
            if foodTime.text! == "☀️" {
                self.post["lunch"] = "☀️" + " " + foodName.text!
            }
            else if foodTime.text! == "🌙"{
                self.post["dinner"] = "🌙" + " " + foodName.text!
            }
            else if foodTime.text! == "🕗"{
                self.post["breakfast"] = "🕗" + " " + foodName.text!
            }
            let childUpdates = ["/FoodManage/\(date.text!)": self.post]
            baseRef.updateChildValues(childUpdates)
            fetchdate()
            dismiss(animated: true, completion: nil)

        }
        
    }
    
    
    func fetchdate(){
        self.dictionary =  [[String:String]]()
        let ref = Database.database().reference()
        ref.child("FoodManage").child(self.selectDay).observe(.value, with: { (snapshot) in
            if ( snapshot.value is NSNull ) {

               print("– – – Data was not found – – –")

            } else {
                
            let dic = snapshot.value as! [String:String]
            self.post = dic
            print(self.post)

            }
        })
    }
}
