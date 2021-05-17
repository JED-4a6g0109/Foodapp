//
//  Step2ViewController.swift
//  Foodapp
//
//  Created by STRAW on 2020/6/2.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class Step2ViewController: UIViewController {
    
    @IBOutlet weak var titlename2: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var bt3: UIButton!
    @IBOutlet weak var bt4: UIButton!
    @IBOutlet weak var pic2: UIImageView!
    
    var data2: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        titlename2.text = data2[6]
        label3.text=data2[2]
        if data2[3] != "0" {
            label4.text=data2[3]
            label4.isHidden = false
            bt4.isHidden = false
            bt4.setImage(UIImage(named: "switchBt2_5"), for: .normal)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SendDiyData3" {

            let stepvc = segue.destination as! StepFinishViewController
            stepvc.data3 = data2

        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switch_third(){
        bt3.setImage(UIImage(named: "switchBt_5"), for: .normal)
        if data2[3] == "0" {
            pic2.image = UIImage(named: "finish_6")
        }
        if (bt3.imageView?.image == UIImage(named: "switchBt_5")) && (bt4.imageView?.image == UIImage(named: "switchBt_5")) {
                   pic2.image = UIImage(named: "finish_6")
               }
    }
    
    @IBAction func switch_fourth(){
        bt4.setImage(UIImage(named: "switchBt_5"), for: .normal)
        if (bt3.imageView?.image == UIImage(named: "switchBt_5")) && (bt4.imageView?.image == UIImage(named: "switchBt_5")) {
            pic2.image = UIImage(named: "finish_6")
        }
        
        
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
