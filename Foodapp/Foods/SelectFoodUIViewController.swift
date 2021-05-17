//
//  SelectFoodUIViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/6/5.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class SelectFoodUIViewController: UIViewController {
    var select = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Vegetables_clicked(_ sender: UIButton) {
        self.select = "Vegetables"
        
        performSegue(withIdentifier: "ShowFoods", sender: self)

    }
    
    @IBAction func DGI_clicked(_ sender: UIButton) {
        self.select = "DGI"
        
        performSegue(withIdentifier: "ShowFoods", sender: self)

    }
    @IBAction func Homely(_ sender: UIButton) {
        self.select = "Homely"
        
        performSegue(withIdentifier: "ShowFoods", sender: self)
    }
    @IBAction func Dessert(_ sender: UIButton) {
        self.select = "Dessert"
        
        performSegue(withIdentifier: "ShowFoods", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if select == "Vegetables"{
            if segue.identifier == "ShowFoods"{
                let FoodCollectionViewController = segue.destination as! FoodCollectionViewController
                FoodCollectionViewController.select = "Vegetables"
            }
        }
        else if select == "DGI"{
            if segue.identifier == "ShowFoods"{
                let FoodCollectionViewController = segue.destination as! FoodCollectionViewController
                FoodCollectionViewController.select = "DGI"
            }
        }
        else if select == "Homely"{
            if segue.identifier == "ShowFoods"{
                let FoodCollectionViewController = segue.destination as! FoodCollectionViewController
                FoodCollectionViewController.select = "Homely"
            }
        }
        else if select == "Dessert"{
            if segue.identifier == "ShowFoods"{
                let FoodCollectionViewController = segue.destination as! FoodCollectionViewController
                FoodCollectionViewController.select = "Dessert"
            }
        }
        
    }
        

}
