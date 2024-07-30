//
//  ProductLookViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 29/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ProductInCategoryViewController: UIViewController , UICollectionViewDelegateFlowLayout , UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    let tokenID = LoginPageController.DataLogin?.Token_Id

    private var CellID = "Cell"
    private var EditStatus : Bool = false
    
    var ImageProduct = [UIImage()]
    var indexfinish = 0
    
    var InCatagoryData = [[String:String]]()
    var catagory = String()
    
    weak var collectionView : UICollectionView?

    // ------------------------------------------------------------------
    // View Blur
    var view_Blur : UIView =  {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.7)
        view.alpha = 0
        return view
    }()
    // View of Loadinf
    var view_loader : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueLight
        return view
    }()
    // Loader Gift
    var Loader = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: .white, padding: 10)
    // ------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)

        // ConfigNavigation Bar
        navigationItem.title = ProductCategoryViewController.NameCatagory
        
        //navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
                
        navigationItem.rightBarButtonItem = editButtonItem
        
        
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [edit, add]
            
        //config collection view
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = collection
        collectionView!.register(ProductPhotolibraryViewCell.self, forCellWithReuseIdentifier: CellID)
        collectionView!.backgroundColor = .white
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
        
        //set layout viewController
        view.addSubview(collection)

        collection.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView!.register(ProductInCategoryViewCell.self, forCellWithReuseIdentifier: CellID)
        collectionView!.backgroundColor = .white
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Request data from server
        catagory = ProductCategoryViewController.CatagoryID
        if catagory == "Custom" {
            self.getProductInCatagoryCustom(token: tokenID!)
            indexfinish = 0
            
            guard navigationItem.rightBarButtonItems!.count > 1 else {return}
            navigationItem.rightBarButtonItems?.removeLast()

        }else{
            self.getProductInCatagory(token: tokenID!, catagoryID: catagory)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return InCatagoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! ProductInCategoryViewCell
                
        if ImageProduct[indexPath.row].size.width == 0{
            cell.viewload.isHidden = false
        }else{
            cell.viewload.isHidden = true
            cell.CellImage.image = ImageProduct[indexPath.row]
        }
        
        cell.isEditing = EditStatus
        cell.ProductNamelable.text = InCatagoryData[indexPath.row]["ProductName"]
        cell.deleteProductButton.addTarget(self, action: #selector(Deleteimage), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let itemWidth: CGFloat = (view.frame.size.width - 60) / 3
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if catagory == "Custom"{
            if !EditStatus{
            
                ProductPhotolibraryViewController.ProductSelect = InCatagoryData[indexPath.row]
                
                let ViewController = ProductViewAndEditViewController()
                ViewController.SectionPush = "Custom"
                navigationController?.pushViewController(ViewController, animated: true)
            }
        }
    }
    
    @objc func loadList(notification: NSNotification) {
        // Request data from server
        indexfinish = 0
        catagory = ProductCategoryViewController.CatagoryID
        self.getProductInCatagory(token: tokenID!, catagoryID: catagory)
    }
    
    @objc func editTapped(sender: UIBarButtonItem){
        if EditStatus{
            sender.title = "Edit"
            EditStatus = false
           
            if catagory != "Custom"{
                navigationItem.rightBarButtonItems?.last?.isEnabled = true
            }
        }else{
            sender.title = "Done"
            EditStatus = true
            
            if catagory != "Custom"{
                navigationItem.rightBarButtonItems?.last?.isEnabled = false
            }
        }
        collectionView!.reloadData()

    }
    
    @objc func addTapped(){
        
        let CategoryAddProduct = ProductCategoryAddProductViewController()
        CategoryAddProduct.ProductInCategoryData = InCatagoryData
        let nav = UINavigationController(rootViewController: CategoryAddProduct)
        nav.modalPresentationStyle = .automatic
        present(nav, animated: true, completion: nil)
        
    }
    
    @objc func Deleteimage(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.collectionView)
        let indexPath = self.collectionView!.indexPathForItem(at: point)

        let cell = collectionView!.cellForItem(at: indexPath!) as? ProductInCategoryViewCell
        let thisProduct = cell?.ProductNamelable.text
        
        let alert = UIAlertController(title: "Do You Want to Delete This Product?", message: thisProduct, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
             
            let product = self.InCatagoryData[indexPath!.row]
            self.InCatagoryData.remove(at: indexPath!.row)
            self.ImageProduct.remove(at: indexPath!.row)
            self.collectionView!.deleteItems(at: [indexPath!])
                        
            if self.catagory == "Custom" {
    
                self.delProduct(token: self.tokenID!, productID: product["idProduct"]!)
                
            }else{
                self.delProductInCatagory(token: self.tokenID!, productID: Int(product["Product_idProduct"]!)!, catagoryID: self.catagory)
                
                
                let catagoryID = ProductCategoryViewController.CatagoryID
                let Description = ProductCategoryViewController.NameCatagory
                
                //delete image of category when no product in category
                if self.InCatagoryData.count == 0 {
                    let image = ""
                    self.editCatagory(token: self.tokenID!, catagoryID: catagoryID, Description: Description, Image:image)
                }
                
                //Change image of category when delete product No. 1
                if indexPath?.row == 0 && self.InCatagoryData.count > 0{
                    let image = self.InCatagoryData[indexPath!.row]["ProductImage"]!
                    self.editCatagory(token: self.tokenID!, catagoryID: catagoryID, Description: Description, Image:image)
                }
                
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }
        
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getProductInCatagory(token:String,catagoryID:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminGetProductinCategory()
        let parameters = ["id":catagoryID]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.InCatagoryData = JSON!["results"] as! [[String : String]]
                    self.ImageProduct = Array(repeating: UIImage(), count: self.InCatagoryData.count)
                    
                    for i in 0..<self.InCatagoryData.count {
                        
                        let indexPath = IndexPath(row: i, section: 0)
                                                
                        if self.InCatagoryData[indexPath.row]["ProductImage"]! != "" {
                            
                            self.DownloadimageProduct(token: self.tokenID!, path: self.InCatagoryData[indexPath.row]["ProductImage"]!, indexPath: indexPath)
                        }

                    }
                    
                    //insert image category
                    if self.InCatagoryData.count > 0{
                        if ProductCategoryViewController.imageCatagory == ""{
                            let catagoryID = ProductCategoryViewController.CatagoryID
                            let Description = ProductCategoryViewController.NameCatagory
                            let image = self.InCatagoryData[0]["ProductImage"]
                            self.editCatagory(token: self.tokenID!, catagoryID: catagoryID, Description: Description, Image:image!)
                        }
                    }
                    
                    self.collectionView!.reloadData()
                    // Close loader
                    self.Show_Loader()
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
            
        })
    }
    
    func getProductInCatagoryCustom(token:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminGetProductCustom()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.InCatagoryData = JSON!["results"] as! [[String : String]]
                    self.ImageProduct = Array(repeating: UIImage(), count: self.InCatagoryData.count)
                    
                    for i in 0..<self.InCatagoryData.count {
                        
                        let indexPath = IndexPath(row: i, section: 0)
                                                
                        if self.InCatagoryData[indexPath.row]["ProductImage"]! != "" {
                            
                            self.DownloadimageProduct(token: self.tokenID!, path: self.InCatagoryData[indexPath.row]["ProductImage"]!, indexPath: indexPath)
                        }

                    }
                    
                    self.collectionView!.reloadData()
                    // Close loader
                    self.Show_Loader()
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
            
        })
    }
    
    func DownloadimageProduct(token:String ,path:String ,indexPath:IndexPath){
        guard path != "" else {return}
        
        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let parameter = ["bucket":"arforsalesimageresize", "path": path]
        let Url = DataSource.Url_DownloadImage()

        AF.download(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
                        
            switch response.result {
            case .success(let value) :
                if let json = value as? [String : Any] {
                    
                    let Body = json["Body"] as? [String : Any]
                    
                    guard Body != nil else {
                        self.DownloadimageProduct(token: token, path: path, indexPath: indexPath)
                        return
                    }
                    
                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let data: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
        
                    self.ImageProduct[indexPath.row] = UIImage(data: data as Data)!
                    self.indexfinish = self.indexfinish + 1
                    
                    if self.indexfinish == self.InCatagoryData.count{
                        self.collectionView?.reloadData()
                    }
                
                }
            case .failure(_):
                break
                
            }
        }
    }
    
    func delProductInCatagory(token:String,productID:Int,catagoryID:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminDelProductinCategory()
        let parameters = ["ProductID":[productID],"CategoryID":catagoryID] as [String : Any]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    // Close loader
                    self.Show_Loader()
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
        
    func editCatagory(token:String,catagoryID:String,Description:String,Image:String){
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminEditCategory()
        let parameters = ["id":catagoryID,"Description":Description,"Image":Image]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                  
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func delProduct(token:String,productID:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminDelProduct()
        let parameters = ["id":productID]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    // Close loader
                    self.Show_Loader()
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func AnimationViewLoadAnchor(){
        
        // ratio
        let ratio = self.view.frame.width / 375.0
        
        // View Loader -----------------------------------------------
        view.addSubview(view_Blur)
        view_Blur.anchor(view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        // view loader -----------------------------------------------
        view_Blur.addSubview(view_loader)
        view_loader.anchorCenter(view_Blur.centerXAnchor, AxisY: view_Blur.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        view_loader.layer.cornerRadius = 20 * ratio
        
        // Loader -----------------------------------------------
        view_loader.addSubview(Loader)
        Loader.anchor(view_loader.topAnchor, left: view_loader.leftAnchor, bottom: view_loader.bottomAnchor, right: view_loader.rightAnchor, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 5 * ratio, rightConstant: 5 * ratio, widthConstant: 90 * ratio, heightConstant: 90 * ratio)
    }
    
    // Func Show Loader
    func Show_Loader() {
        
        if view_Blur.alpha == 0 {
            UIView.animate(withDuration: 0.5) {
                self.view_Blur.alpha = 1
                self.Loader.startAnimating()
            }
        }
        else {
            UIView.animate(withDuration: 0.5) {
                self.view_Blur.alpha = 0
                self.Loader.stopAnimating()
            }
        }
        
    }
    
}
        



