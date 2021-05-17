//
//  CalendarFeaturesViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/10/29.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit
import Firebase
fileprivate let baseRef = Database.database().reference()

class CalendarFeaturesViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var TitleBar: UILabel!
    var dictionary =  [[String:Any]]()


    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var Switch: UISegmentedControl!
    var Year = Calendar.current.component(.year, from: Date())

    var Month = Calendar.current.component(.month, from: Date())
    
    var Day = Calendar.current.component(.day, from: Date())

    var todayYMD = ""

    var selectDay = ""
    var months = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
    var data = [
        [],
        []
    ]

    var p: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDate()
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "customCell")
        
        p = 0
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        todayYMD = dateFormatter.string(from: today)
        update()

        
//        let timer = Timer(timeInterval: 0.4, target: self, selector: "update:", userInfo: nil, repeats: true)
//        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)

        

    }
    
    func update() {

        DispatchQueue.global(qos: .background).async {

            // Background Thread

            DispatchQueue.main.async {
                self.tableview.reloadData()
                
            }
        }
    }

    
    var whatDay:Int{
        let dateComponents = DateComponents(year: Year, month: Month)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    
    
    var DayInMonth:Int{
        let dateComponents = DateComponents(year: Year, month: Month)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }
    
    var ItemsAdd:Int{
        return whatDay - 1
    }
    
    
    func setDate(){
        TitleBar.text = "\(Year)-" + months[Month - 1]
        calendar.reloadData()
    }
    
    @IBAction func lastMonth(_ sender: Any) {
        Month -= 1
        if Month == 0{
            Month = 12
            Year -= 1
        }
        setDate()
    }
    @IBAction func nextMonth(_ sender: Any) {
        Month += 1
        if Month == 13{
            Month = 1
            Year += 1
        }
        setDate()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DayInMonth + ItemsAdd
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            if indexPath.row < ItemsAdd{
                textLabel.text = ""
            }else{

                if todayYMD == "\(Year)-\(Month)-\(Day)" && "\(indexPath.row + 1 - ItemsAdd)" == "\(Day)"{
                    textLabel.text = "今天"
                    
                }else{
                    textLabel.text = "\(indexPath.row + 1 - ItemsAdd)"

                }
                
            }
            
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        
        return CGSize(width: width, height: 40)
    }
    
    
    //        var cells = (cell.contentView.subviews[0].value(forKeyPath: "text"))! as! String
    //
    //        print(cells)
    //        if cells == "今天"{
    //            cell.backgroundColor = UIColor.orange
    //        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.orange
        
        var selectDay = (cell?.contentView.subviews[0].value(forKeyPath: "text"))! as! String
        if selectDay == "今天"{
            self.selectDay = todayYMD
            print(self.selectDay)
        }else{
            self.selectDay = "\(Year)-\(Month)-" + selectDay
            print(self.selectDay)
        }
        
        fetchdate()
        update()

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.darkGray
        self.data = [[],[]]

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendar.collectionViewLayout.invalidateLayout()
        calendar.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[p].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        let str = (data[p][indexPath.row] as AnyObject).components(separatedBy: " ")
        cell.customInit(content: str[1], title: str[0])
        return cell
    }


    @IBAction func SwitchCustomTableview(_ sender: UISegmentedControl) {
        p = sender.selectedSegmentIndex
        tableview.reloadData()
    }
    
    @IBAction func createData(){
        if selectDay == ""{
            selectDay = todayYMD
        }
        let vc = storyboard?.instantiateViewController(identifier: "keepAccount") as! KeepAccountViewController
        vc.modalPresentationStyle = .fullScreen
        vc.selectDay = selectDay
//        vc.completionHandler = { text in
//            self.a.text = text
//
//        }
        present(vc,animated: true)
        
     
    }
    
    func fetchdate(){
        self.dictionary =  [[String:String]]()
        let ref = Database.database().reference()
        ref.child("FoodManage").child(self.selectDay).observe(.value, with: { (snapshot) in
            if ( snapshot.value is NSNull ) {
               print("– – – Data was not found – – –")
            } else {
                let dic = snapshot.value as! [String:String]
                print(dic)
                print(dic["lunch"])
                self.data[0] = [String](dic.values)
                print(self.data)
            }
        })
        
        ref.child("KeepAccount").child(self.selectDay).observe(.value, with: { (snapshot) in
            if ( snapshot.value is NSNull ) {
               print("– – – Data was not found – – –")
            } else {
                let dic = snapshot.value as! [String:String]
                self.data[1] = [String](dic.values)
            }
        })
    }
    
    @IBAction func comeBackCalendar(_ sender: UIStoryboardSegue){}
}
