//
//  StepFinishViewController.swift
//  Foodapp
//
//  Created by STRAW on 2020/6/2.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class StepFinishViewController: UIViewController {
    
    
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var finishname: UILabel!
    
    var data3: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        name1.text = data3[6]
        finishname.text = data3[6]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
