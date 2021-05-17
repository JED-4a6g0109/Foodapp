//
//  CustomCell.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/11/9.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customInit(content: String, title: String ){
        self.content.text = content
        self.title.text = title
        self.title.textColor = UIColor.white
        self.content.backgroundColor = UIColor.darkGray
    }
}
