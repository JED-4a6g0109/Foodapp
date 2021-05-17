//
//  FoodCollectionViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/4/11.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit

enum vegetables {
    case capitata
    case penkinensin
}

struct Food_Json: Codable {
    var name: String?
    var image_url: String
    var itme: String?
    var seasoning: String?
    var step: String?
}

class FoodCollectionViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var UpButoon: UIButton!
    
    @IBOutlet weak var AIButton: UIButton!
    var select = ""
    var FoodUrl = ""
    var predict = ""
    var check = 0
    var searchActive : Bool = false
    var search_status = false
    let searchController = UISearchController(searchResultsController: nil)
    var Foods = [Food_Json]()
    var filtered = [Food_Json]()
    private let trainedImageSize = CGSize(width: 300, height: 300)
    private let model = vg()
    var refreshControl: UIRefreshControl!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource=self
        collectionView.delegate=self
        
        searchbutton()
        floatbutton()
        loadjson()
    }
    
    func searchbutton(){
        //searchbar set
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.definesPresentationContext = true
        searchController.searchBar.placeholder = "菜餚搜尋"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar
        
    }
    func floatbutton(){
        // 回到最上頁按鈕 and AI set
        // UpButoon
        UpButoon.layer.shadowOffset = CGSize(width: UpButoon.bounds.width / 10, height: UpButoon.bounds.width / 10)
        // 陰影透明度
        UpButoon.layer.shadowOpacity = 0.75
        // 陰影模糊度
        UpButoon.layer.shadowRadius = 5
        // 陰影顏色
        UpButoon.layer.shadowColor = UIColor.black.cgColor
        UpButoon.layer.shadowOffset = CGSize(width: UpButoon.bounds.width / 10, height: UpButoon.bounds.width / 10)
        UpButoon.layer.shadowOpacity = 0.75
        UpButoon.layer.shadowRadius = 5
        UpButoon.layer.shadowColor = UIColor.black.cgColor
        //AI
        AIButton.layer.shadowOffset = CGSize(width: AIButton.bounds.width / 10, height: AIButton.bounds.width / 10)
        // 陰影透明度
        AIButton.layer.shadowOpacity = 0.75
        // 陰影模糊度
        AIButton.layer.shadowRadius = 5
        // 陰影顏色
        AIButton.layer.shadowColor = UIColor.black.cgColor
        AIButton.layer.shadowOffset = CGSize(width: UpButoon.bounds.width / 10, height: UpButoon.bounds.width / 10)
        AIButton.layer.shadowOpacity = 0.75
        AIButton.layer.shadowRadius = 5
        AIButton.layer.shadowColor = UIColor.black.cgColor
                
    }
    
    //接收SelectFood 使用者選擇
    func loadjson(){
        if select == "Vegetables"{
            FoodUrl =  "https://raw.githubusercontent.com/JEDEngineer/public-project/master/Food_vegetables.json"
        }
        else if select == "DGI"{
            FoodUrl =  "https://raw.githubusercontent.com/JEDEngineer/public-project/master/Foods_json.json"
        }
        else if select == "Homely"{
            FoodUrl =  "https://raw.githubusercontent.com/JED-4a6g0109/public-project/master/Food_homely.json"
        }
        else if select == "Dessert"{
            FoodUrl =  "https://raw.githubusercontent.com/JEDEngineer/public-project/master/Food_Dessert.json"
        }
        
    //Json
        let url = URL(string: FoodUrl)
        
            URLSession.shared.dataTask(with: url!){(data,response,error)in
                if error == nil{
                    do{
                        self.Foods = try JSONDecoder().decode([Food_Json].self, from: data!)
                
                    }catch{
                        print("error")
                    }
                    DispatchQueue.main.async {
                        print(self.Foods.count)
                        self.collectionView.reloadData()
                    }
                }
        }.resume()
    }
    
    
//    collectionview and searchactive
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchActive {
            return filtered.count
        }
        else
        {
            return Foods.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell

        if searchActive {
            cell.Fname.text =  self.filtered[indexPath.row].name
            cell.Fimage.contentMode = .scaleAspectFill
            cell.Fimage.downloaded(from: filtered[indexPath.row].image_url)
            search_status = true
            
            
        } else {
            
            cell.Fname.text =  self.Foods[indexPath.row].name?.capitalized
            cell.Fimage.contentMode = .scaleAspectFill
            cell.Fimage.downloaded(from: Foods[indexPath.row].image_url)
        }
        return cell
        
    }
//    cell anime
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: cell.bounds.width, y: cell.bounds.height / 5).concatenating(CGAffineTransform(scaleX: -2.0, y: -2.0))
        UIView.animate(withDuration: 0.7) {
            cell.alpha = 1
            cell.transform = CGAffineTransform.identity
        }
    }
    
    
    
    
//    篩選後食譜資料更新
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if search_status == false{
            if let controller = segue.destination as? DetailViewController, let indexPath = collectionView.indexPathsForSelectedItems?.first {
                controller.Food = self.Foods[indexPath.row]
            }
        }
        else if search_status == true{
            if let controller = segue.destination as? DetailViewController, let indexPath = collectionView.indexPathsForSelectedItems?.first {
                controller.Food = self.filtered[indexPath.row]
            }
        }
    }
        
            

    
//    searchbar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        search_status = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        filtered = Foods.filter({ (item) -> Bool in
            if let title = item.name {
                return title.lowercased().contains(searchString.lowercased())
            } else {
                return false
            }
        })
        
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        collectionView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        collectionView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            collectionView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    

    
//    上拉按鈕
    @IBAction func scrollToTop(_ sender: UIButton) {
      collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
//    取得相簿與圖片處理
    @IBAction func takePhotoClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "初學者不懂蔬菜時", message: "讓ＡＩ幫你辨識你不了解的蔬菜吧！！", preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
        alertController.addAction(UIAlertAction(title: "前往相簿", style: .default, handler: { (yesAction) in
            print("User tapped Yes.")
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }))
    }
    
 
    

    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    
    
//    AI預測
    private func predict(image: UIImage) -> vegetables? {
        do {
            if let resizedImage = resize(image: image, newSize: trainedImageSize), let pixelBuffer = resizedImage.toCVPixelBuffer() {
                let prediction = try model.prediction(image: pixelBuffer)
                let value = prediction.output[0].intValue
                print(prediction.output)
                print(value)
                if prediction.output[0].intValue == 1{
                    return .capitata
                }
                else if prediction.output[1].intValue == 1{
                    return .penkinensin
                }
                

            }
        } catch {
            print("Error while doing predictions: \(error)")
        }

        return nil
    }

    
    func resize(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            self.check = 0
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let imageBase64 = self.convertImageToBase64String(img: image)
                
                let Url = String(format: "http://192.168.50.199:5000/api/ios_post")
                guard let serviceUrl = URL(string: Url) else { return }
                let parameters: [String: Any] = [
                    "imageBase64" : imageBase64
                ]
                var request = URLRequest(url: serviceUrl)
                request.httpMethod = "POST"
                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                    return
                }
                request.httpBody = httpBody
                request.timeoutInterval = 20
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    if let response = response {
                        print(response)
                    }
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print("Server return")
                            print(json)
                            print(type(of: json))
                            let response = json as! Dictionary<String,Any>
                            self.predict = response["predict_vegetable"]! as! String
                            self.check = 1
                            
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
                repeat{
                   print("wait")
                }while self.check == 0
                
                self.searchController.searchBar.text = self.predict
                self.searchActive = true
                self.collectionView.reloadData()
 
            }
        }
    }

    
   
}

//圖片url下載
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
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
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


//image shape調整
extension UIImage {
    func toCVPixelBuffer() -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(self.size.width), Int(self.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }

        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)

        UIGraphicsPushContext(context!)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

        return pixelBuffer
    }
    
    
}
