//
//  CourseController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/3/22.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

class CourseController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!
    
    let Name = ["無菜單葷食場","料理聯誼派對","小當家培養班","食在很健康場"]
    let Time = ["課程時間：5/22(三) 10:00-14:00","課程時間：4/22(五)13:00-17:00","課程時間：3/31(日) 18:00-20:00","課程時間：3/29(四) 17:00-19:00"]
    let CourseImage: [UIImage] = [
        UIImage(named: "Taiwan")!,
        UIImage(named: "Janpa")!,
        UIImage(named: "USA")!,
        UIImage(named: "start")!,

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.CourseName.text = Name[indexPath.item]
        cell.CourseTime.text = Time[indexPath.item]
        cell.CourseImage.image = CourseImage[indexPath.item]

        return cell
        
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
