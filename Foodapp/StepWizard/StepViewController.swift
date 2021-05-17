//
//  StepViewController.swift
//  Foodapp
//
//  Created by STRAW on 2020/6/1.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class StepViewController: UIViewController {
    var data1: String = ""
    var recipename: String? = ""
    var stepcount : [String]=["0","0","0","0","0","0","0"]
    @IBOutlet weak var titlename: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var pic1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = data1
        var finalindex:Int = 0
        stepcount[6] = recipename!
        titlename.text = recipename
        
        var i:Int = 0
        //if let index = str.range(of: "2."){
        if str.contains("2."){
            let range1 = str.range(of: "2.")!
            let index1 = str.distance(from: str.startIndex, to: range1.lowerBound)
            let start = str.index(str.startIndex, offsetBy: 0)
            let end = str.index(str.startIndex, offsetBy: index1)
            let rag1 = start..<end
            finalindex = index1
            stepcount[i] = String(str[rag1])
        }
            
        if str.contains("3."){
            let range2 = str.range(of: "3.")!
            let index2 = str.distance(from: str.startIndex, to: range2.lowerBound)
            let start2 = str.index(str.startIndex, offsetBy: finalindex)
            let end2 = str.index(str.startIndex, offsetBy: index2)
            let rag2 = start2..<end2
            finalindex = index2
            i=i+1
            stepcount[i] = String(str[rag2])
        }
        if str.contains("4."){
            let range3 = str.range(of: "4.")!
            let index3 = str.distance(from: str.startIndex, to: range3.lowerBound)
            let start3 = str.index(str.startIndex, offsetBy: finalindex)
            let end3 = str.index(str.startIndex, offsetBy: index3)
            let rag3 = start3..<end3
            finalindex = index3
            i=i+1
            stepcount[i]  = String(str[rag3])
        }
        
        if str.contains("5."){
            let range4 = str.range(of: "5.")!
            let index4 = str.distance(from: str.startIndex, to: range4.lowerBound)
            let start4 = str.index(str.startIndex, offsetBy: finalindex)
            let end4 = str.index(str.startIndex, offsetBy: index4)
            let rag4 = start4..<end4
            finalindex = index4
            i=i+1
            stepcount[i]  = String(str[rag4])
        }
        
        if str.contains("6."){
            let range5 = str.range(of: "6.")!
            let index5 = str.distance(from: str.startIndex, to: range5.lowerBound)
            let start5 = str.index(str.startIndex, offsetBy: finalindex)
            let end5 = str.index(str.startIndex, offsetBy: index5)
            let rag5 = start5..<end5
            finalindex = index5
            i=i+1
            stepcount[i]  = String(str[rag5])
        }
        
        
        let finalstart = str.index(str.startIndex, offsetBy: finalindex)
        let finalend = str.index(str.endIndex, offsetBy: 0)
        let finalrag = finalstart..<finalend
        i=i+1
        stepcount[i] = String(str[finalrag])
        
        print(stepcount)
        label1.text = stepcount[0]
        label2.text = stepcount[1]
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.identifier == "SendDiyData2" {

        let stepvc = segue.destination as! Step2ViewController
        stepvc.data2 = stepcount

    }
    }
    @IBAction func switch_first(){
        bt1.setImage(UIImage(named: "switchBt_5"), for: .normal)
        if (bt1.imageView?.image == UIImage(named: "switchBt_5")) && (bt2.imageView?.image == UIImage(named: "switchBt_5")) {
            pic1.image = UIImage(named: "finish_6")
        }
    }
    @IBAction func switch_second(){
        bt2.setImage(UIImage(named: "switchBt_5"), for: .normal)
        if (bt1.imageView?.image == UIImage(named: "switchBt_5")) && (bt2.imageView?.image == UIImage(named: "switchBt_5")) {
            pic1.image = UIImage(named: "finish_6")
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
