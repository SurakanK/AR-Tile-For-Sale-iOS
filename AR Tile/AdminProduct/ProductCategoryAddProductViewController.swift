//
//  ProductCategoryAddProductViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 7/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Alamofire
import NVActivityIndicatorView

class ProductCategoryAddProductViewController: UIViewController, UICollectionViewDelegateFlowLayout , UINavigationControllerDelegate ,UICollectionViewDelegate,UICollectionViewDataSource {

    let tokenID = LoginPageController.DataLogin?.Token_Id

    private var CellID = "Cell"
    private var searching = false
       
    var ProductInCategoryData = [[String : String]]()
    
    var ImageProduct = [UIImage()]
    var indexfinish = 0
    
    var Productsearch = [[String:String]]()
    var ProductData = [[String:String]]()
    var productHighligh = [Int]()
    var indexHighligh = [Int]()
    var Highligh = [Bool]()
    
    weak var collectionView : UICollectionView?

    let SearchController = UISearchController(searchResultsController: nil)
    
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
         
        // Request data from server
        self.getProduct(token: tokenID!)
        
        // ConfigNavigation Bar
        navigationItem.title = "All Product"
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
                        
        let Done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoneTapped))
        let Cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelTapped))
        
        navigationItem.rightBarButtonItem = Done
        navigationItem.leftBarButtonItem = Cancel
        
        //config cearch controller
        SearchController.searchResultsUpdater = self
        SearchController.searchBar.delegate = self
        SearchController.searchBar.searchBarStyle = .minimal
        SearchController.obscuresBackgroundDuringPresentation = false
        SearchController.searchBar.searchTextField.backgroundColor = .white
        SearchController.searchBar.tintColor = .white
        SearchController.searchBar.placeholder = "search your product"
        SearchController.searchBar.searchTextField.font = UIFont.MitrLight(size: 18)
        SearchController.searchBar.searchTextField.textColor = .BlackAlpha(alpha: 0.8)
        
        navigationItem.searchController = SearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DismissKeyBoardSearchBar))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
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
        
        //config collection view
        collectionView!.register(ProductPhotolibraryViewCell.self, forCellWithReuseIdentifier: CellID)
        collectionView!.backgroundColor = .white
        collectionView!.delegate = self
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
    }
    
    @objc func DismissKeyBoardSearchBar(){
        self.SearchController.searchBar.endEditing(true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searching{
            Highligh = [Bool](repeating: true, count: Productsearch.count)
            return Productsearch.count
        }else{
            Highligh = [Bool](repeating: true, count: ProductData.count)
            return ProductData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! ProductPhotolibraryViewCell
        
        if ImageProduct[indexPath.row].size.width == 0{
            cell.viewload.isHidden = false
        }else{
            cell.viewload.isHidden = true
            cell.CellImage.image = ImageProduct[indexPath.row]
        }
        
        if searching{
            
            cell.ProductNamelable.text = Productsearch[indexPath.row]["ProductName"]
            
        }else{
            
            cell.ProductNamelable.text = ProductData[indexPath.row]["ProductName"]
            
            if Highligh[indexPath.row] == false{
                cell.CellImage.layer.borderWidth = 5
            }else{
                cell.CellImage.layer.borderWidth = 0
            }


        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProductPhotolibraryViewCell
      
        let id : String
        
        if searching{
            id = Productsearch[indexPath.row]["idProduct"]!

        }else{
            id = ProductData[indexPath.row]["idProduct"]!
        }
        
        if Highligh[indexPath.row] == true{
            
            Highligh[indexPath.row] = false
            cell.CellImage.layer.borderWidth = 5
            productHighligh.append(Int(id)!)
            
        }else{
            
            Highligh[indexPath.row] = true
            cell.CellImage.layer.borderWidth = 0
            let indexdata = productHighligh.firstIndex(where: {$0 == Int(id)!})
            
            productHighligh.remove(at: indexdata!)

        }
             
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
    
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func DoneTapped(){
                
        //sub data product id in category
        var ProductIDInCategory = [Int]()
        for index in 0..<ProductInCategoryData.count{
            let ProductID = ProductInCategoryData[index]["Product_idProduct"]
            ProductIDInCategory.append(Int(ProductID!)!)
        }
        
        //remove duplicate product
        var indexDup = [Int]()
        for index in 0..<ProductIDInCategory.count{
            let index0f = productHighligh.firstIndex(of: ProductIDInCategory[index])
            
            if index0f != nil{
                productHighligh.remove(at: index0f!)
                Highligh[index] = true

                indexDup.append(index0f!)
            }
        }
        
        if productHighligh.count > 0{
            
            var message = ""
            if indexDup.count > 0 {
                message = "you want to add product to category?\nsome product you already have in category"
            }else{
                message = "you want to add product to category?"
            }
            
            let alert = UIAlertController(title: "add product in category", message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.setTitlet(font: UIFont.MitrMedium(size: 20), color: .BlueLight)
            alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.5))
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
                let catagory = ProductCategoryViewController.CatagoryID
                self.insertProductInCat(token: self.tokenID!, productID: self.productHighligh, categoryID: catagory)
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            let message = "Please select product or you already have this product in category."
            let alert = UIAlertController(title: "amiss", message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.setTitlet(font: UIFont.MitrMedium(size: 20), color: .systemRed)
            alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.5))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (acton) in
                self.productHighligh.removeAll()
                self.Highligh.removeAll()
                self.collectionView?.reloadData()

            }))

            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func getProduct(token:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminGetProduct()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.ProductData = JSON!["results"] as! [[String : String]]
                    self.ImageProduct = Array(repeating: UIImage(), count: self.ProductData.count)
                    
                    for i in 0..<self.ProductData.count {
                        
                        let indexPath = IndexPath(row: i, section: 0)
                                                
                        if self.ProductData[indexPath.row]["ProductImage"]! != "" {
                            
                            self.DownloadimageProduct(token: self.tokenID!, path: self.ProductData[indexPath.row]["ProductImage"]!, indexPath: indexPath)
                            
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
    
    @objc func CancelTapped(){
        self.dismiss(animated: true, completion: nil)
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
                    
                    guard Body != nil else {return}

                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let data: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
        
                    self.ImageProduct[indexPath.row] = UIImage(data: data as Data)!
                    self.indexfinish = self.indexfinish + 1
                    
                    if self.indexfinish == self.ProductData.count{
                        self.collectionView?.reloadData()
                    }
                
                }
            case .failure(_):
                break
                
            }
        }
    }
    
    func insertProductInCat(token:String,productID:[Int],categoryID:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminInsertProductinCategory()
        let parameters = ["ProductID":productID,"CategoryID":categoryID] as [String : Any]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    // Close loader
                    self.Show_Loader()
                    
                    self.dismiss(animated: true, completion: nil)
                    self.dismiss(animated: true, completion: nil)
                    
                    NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
                    
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

//MARK: Event SearchBar
extension ProductCategoryAddProductViewController: UISearchBarDelegate , UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
           
           let searchText = searchController.searchBar.text
           
           if searchText!.count > 0{
                Productsearch = ProductData.filter({$0["ProductName"]!.lowercased().prefix(searchText!.count) == searchText!.lowercased()})
                searching = true
                collectionView!.reloadData()
           }else{
                searching = false
                collectionView!.reloadData()
           }

       }
           
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchBar.text = ""
           searching = false
        collectionView!.reloadData()
       }
}
