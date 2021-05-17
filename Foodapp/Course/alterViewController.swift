//
//  alterViewController.swift
//  Foodapp
//
//  Created by STRAW on 2020/7/26.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class alterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func alert(_ sender: Any) {
        let alert = UIAlertController(title: "成功！！", message: "已完成報名", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
