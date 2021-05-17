//
//  DetailViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/4/13.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

extension UIImageView {
    func Downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func Downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class DetailViewController: UIViewController {

    @IBOutlet weak var FoodName: UILabel!
    @IBOutlet weak var FoodImage: UIImageView!
    @IBOutlet weak var Item: UILabel!
    
    
    @IBOutlet weak var Seasoning: UILabel!
    @IBOutlet weak var Step: UILabel!
    @IBOutlet weak var button_back: UIImageView!
    var Food:Food_Json?
    var stepdata1: String = ""
    var name1: String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        FoodName.text = Food?.name
        Item.text = Food?.itme
        Seasoning.text = Food?.seasoning
        Step.text = "【作法】" + "\n" + Food!.step!
        stepdata1 = Food!.step!
        name1 = Food?.name
        let urlString = (Food?.image_url)!
        
        let url = URL(string: urlString)
        
        FoodImage.Downloaded(from: url!)
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func changelable_item(){
           Item.isHidden = false
           Seasoning.isHidden = true
           Step.isHidden = true
           button_back.frame.origin = CGPoint(x: 48, y: 256)
       }
       @IBAction func changelable_seasoning(){
           Item.isHidden = true
           Seasoning.isHidden = false
           Step.isHidden = true
           button_back.frame.origin = CGPoint(x: 147, y: 256)
       }
       @IBAction func changelable_step(){
           Item.isHidden = true
           Seasoning.isHidden = true
           Step.isHidden = false
           button_back.frame.origin = CGPoint(x: 247, y: 256)
       }

    @IBAction func ulterder(_ sender: Any){
           let alert = UIAlertController(title: "成功", message: "報名成功", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if segue.identifier == "SendDiyData" {

                let stepvc = segue.destination as! StepViewController

                stepvc.data1 = stepdata1
                stepvc.recipename = name1
            }
        }

}
