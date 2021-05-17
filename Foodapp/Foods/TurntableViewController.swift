//
//  TurntableViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/10/19.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class TurntableViewController: UIViewController {
    
    var select = ["雞蛋","番茄","漢堡","咖哩","炒飯","麥當勞","鍋燒意麵","便當","火鍋","關東煮"]

    @IBOutlet weak var show_random: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func time (){
        
            
    }
    
    @IBAction func GO(_ sender: Any) {
        var result = ""
        var range = 0
        
        
        let group: DispatchGroup = DispatchGroup()
        let queue1 = DispatchQueue(label: "queue1", attributes: .concurrent)
        
        queue1.async(group: group) {
            repeat {
                sleep(1)
                DispatchQueue.main.async {
 
                    
                    let random = Int.random(in: 0..<10)
                    result = self.select[random]
                    self.show_random.text = result
                    UILabel.animate(withDuration: 1, animations: {
                         self.show_random.frame.origin.y += 30
                     },completion: nil)
                }
                range += 1
            }while range < 10
        }
        
        
        
        
        group.notify(queue: DispatchQueue.main) {
            sleep(1)
            let alert = UIAlertController(title: "拉霸結果", message: result, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
