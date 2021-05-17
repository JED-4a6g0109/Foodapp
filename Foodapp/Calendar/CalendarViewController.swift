//
//  CalendarViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/5/17.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit
import Firebase

fileprivate let baseRef = Database.database().reference()
class CalendarViewController: UIViewController {
    
    
    @IBOutlet weak var breakfast: UILabel!
    @IBOutlet weak var lunch: UILabel!
    @IBOutlet weak var dinner: UILabel!
    @IBOutlet weak var day: UILabel!
    let arrMsg2 = NSMutableArray()
    var dictionary =  [[String:String]]()

    var select:String!
    var post : [String:String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        select = "1Monday"
        fetchdate()
//        fetchdate()
        

//        breakfast.text = self.dictionary[0]["breakfast"]!
//        lunch.text = self.dictionary[0]["lunch"]!
//        dinner.text = self.dictionary[0]["dinner"]!


        // Do any additional setup after loading the view.
    }
    @IBAction func Monday(_ sender: Any) {
        day.text = "1Monday"
        select = day.text
        breakfast.text = self.dictionary[0]["breakfast"]!
        lunch.text = self.dictionary[0]["lunch"]!
        dinner.text = self.dictionary[0]["dinner"]!

        
        
    }
    
    @IBAction func Tuesday(_ sender: Any) {
        day.text = "2Tuesday"
        select = day.text
        breakfast.text = self.dictionary[1]["breakfast"]!
        lunch.text = self.dictionary[1]["lunch"]!
        dinner.text = self.dictionary[1]["dinner"]!

        
        

    }
    
    
    @IBAction func Wednesday(_ sender: Any) {
        day.text = "3Wednesday"
        select = day.text
        breakfast.text = self.dictionary[2]["breakfast"]!
        lunch.text = self.dictionary[2]["lunch"]!
        dinner.text = self.dictionary[2]["dinner"]!


    }
    
    @IBAction func Thursday(_ sender: Any) {
        day.text = "4Thursday"
        select = day.text
        breakfast.text = self.dictionary[3]["breakfast"]!
        lunch.text = self.dictionary[3]["lunch"]!
        dinner.text = self.dictionary[3]["dinner"]!


    }
    
    @IBAction func Friday(_ sender: Any) {
        day.text = "5Friday"
        select = day.text
        breakfast.text = self.dictionary[4]["breakfast"]!
        lunch.text = self.dictionary[4]["lunch"]!
        dinner.text = self.dictionary[4]["dinner"]!

    }
    
    @IBAction func Saturday(_ sender: Any) {
        day.text = "6Saturday"
        select = day.text
        breakfast.text = self.dictionary[5]["breakfast"]!
        lunch.text = self.dictionary[5]["lunch"]!
        dinner.text = self.dictionary[5]["dinner"]!


    }
    
    @IBAction func Sunday(_ sender: Any) {
        day.text = "7Sunday"
        select = day.text
        breakfast.text = self.dictionary[6]["breakfast"]!
        lunch.text = self.dictionary[6]["lunch"]!
        dinner.text = self.dictionary[6]["dinner"]!


    }
    

    
    @IBAction func BreakfastEdit(_ sender: UIButton) {
        let alertController = UIAlertController(title: "早餐規劃", message: "規劃一下你的早餐吧！", preferredStyle: UIAlertController.Style.alert)
       alertController.addTextField { (textField : UITextField) -> Void in
           var frame: CGRect = textField.frame
           frame.size.height = 100
           textField.frame = frame
           textField.placeholder = "comment"
           print(textField.frame.size.height)
           textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 100))
       }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (result : UIAlertAction) -> Void in
       }

        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            
            let textField  = alertController.textFields![0]
            self.breakfast.text = textField.text!
            
       }

       alertController.addAction(cancelAction)
       alertController.addAction(okAction)
       self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func LunchEdit(_ sender: UIButton) {
        let alertController = UIAlertController(title: "午餐規劃", message: "規劃一下你的午餐吧！", preferredStyle: UIAlertController.Style.alert)
       alertController.addTextField { (textField : UITextField) -> Void in
           var frame: CGRect = textField.frame
           frame.size.height = 100
           textField.frame = frame
           textField.placeholder = "comment"
           print(textField.frame.size.height)
           textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 100))
       }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (result : UIAlertAction) -> Void in
       }

        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            
            let textField  = alertController.textFields![0]
            self.lunch.text = textField.text!
            
       }

       alertController.addAction(cancelAction)
       alertController.addAction(okAction)
       self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func DinnerEdit(_ sender: UIButton) {
        let alertController = UIAlertController(title: "晚餐規劃", message: "規劃一下你的晚餐吧！", preferredStyle: UIAlertController.Style.alert)
       alertController.addTextField { (textField : UITextField) -> Void in
           var frame: CGRect = textField.frame
           frame.size.height = 100
           textField.frame = frame
           textField.placeholder = "comment"
           print(textField.frame.size.height)
           textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 100))
       }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (result : UIAlertAction) -> Void in
       }

        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            
            let textField  = alertController.textFields![0]
            self.dinner.text = textField.text!
            
       }

       alertController.addAction(cancelAction)
       alertController.addAction(okAction)
       self.present(alertController, animated: true, completion: nil)
    }
    

    @IBAction func update(_ sender: UIButton) {
        print(select!)
//        let chatRef = baseRef.child("Calender").setValue([select!:select!])
        
        
        
        let post = ["breakfast": breakfast.text!,
                    "lunch": lunch.text!,
                    "dinner": dinner.text!]
        let childUpdates = ["/Calender/\(select!)": post]
        baseRef.updateChildValues(childUpdates)
        fetchdate()

    
    }
    
    func fetchdate(){
        self.dictionary =  [[String:String]]()

        let ref = Database.database().reference()
        ref.child("Calender").observe(.childAdded, with: { (snapshot) in

            let dic = snapshot.value as! [String:AnyObject]
            self.dictionary.append(dic as! [String : String])


            
            
        })

        
    }
    
    
    
}
