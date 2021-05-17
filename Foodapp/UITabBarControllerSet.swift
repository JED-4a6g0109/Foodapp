//
//  UITabBarControllerSet.swift
//  Foodapp
//
//  Created by STRAW on 2020/6/16.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class UITabBarControllerSet: UITabBarController {

    @IBOutlet weak var rabbarset: UITabBar!
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
        var tabFrame = rabbarset.frame
        tabFrame.size.height = 60
        tabFrame.origin.y = view.frame.size.height - 60
        rabbarset.frame = tabFrame
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
