//
//  ProductPhotolibraryViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 5/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Alamofire
import NVActivityIndicatorView
import SkeletonView

class ProductPhotolibraryViewController: UIViewController , UICollectionViewDelegateFlowLayout , UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    let tokenID = LoginPageController.DataLogin?.Token_Id

    var indexfinish = 0

    private var CellID = "Cell"
    private var EditStatus : Bool = false
    private var searching = false
    private var row: Int = 0
    
    var ImageProduct = [UIImage()]
    var ProductData = [[String:String]]()
    var Productsearch = [[String:String]]()
    
    
    weak var collectionView : UICollectionView?
    
    static var ProductSelect = [String:String]()
    
    static var PhotosPicker = [UIImage]()
    
    let SearchController = UISearchController(searchResultsController: nil)
    
    
    // add title index number of product
    let titleIndexProduct: UILabel = {
        let label = UILabel()
        label.text = "product"
        label.textColor = .lightGray
        label.font = UIFont.MitrLight(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
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
        //self.getProduct(IP: DataSource.IP(), token: "1")
        
        // ConfigViewController
        view.backgroundColor = .white
        
        // ConfigNavigation Bar
        navigationItem.title = "All Product"
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
                        
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [edit, add]
        
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
        view.addSubview(titleIndexProduct)
        view.addSubview(collection)

        titleIndexProduct.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        collection.anchor(titleIndexProduct.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()

    }
    
    @objc func DismissKeyBoardSearchBar(){
        self.SearchController.searchBar.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Request data from server
        getProduct(token: tokenID!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //print title lable index product
        let maxProduct = LoginPageController.DataLogin?.ProductMax
        titleIndexProduct.text =  "Product " + String(ProductData.count) + " in " + maxProduct!
        
        if searching{
            return Productsearch.count
        }else{
            return ProductData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! ProductPhotolibraryViewCell
        
        if ImageProduct[indexPath.row].size.width == 0{
            cell.viewload.isHidden = false
        }else{
            
            if searching {
                let productID = Productsearch[indexPath.row]["idProduct"]
                let indexSearching = ProductData.firstIndex(where: {$0["idProduct"] == productID})
                cell.viewload.isHidden = true
                cell.CellImage.image = ImageProduct[indexSearching!]
            } else {
                cell.viewload.isHidden = true
                cell.CellImage.image = ImageProduct[indexPath.row]
            }
            
        }

        if searching{

            cell.isEditing = EditStatus
            cell.ProductNamelable.text = Productsearch[indexPath.row]["ProductName"]
            cell.deleteProductButton.addTarget(self, action: #selector(Deleteimage), for: .touchUpInside)
            
            
        }else{
            cell.isEditing = EditStatus
            cell.ProductNamelable.text = ProductData[indexPath.row]["ProductName"]
            cell.deleteProductButton.addTarget(self, action: #selector(Deleteimage), for: .touchUpInside)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !EditStatus{
            
            if searching {
                
                ProductPhotolibraryViewController.ProductSelect = Productsearch[indexPath.row]
                let ViewController = ProductViewAndEditViewController()
                ViewController.SectionPush = "library"
                navigationController?.pushViewController(ViewController, animated: true)
                
            } else {
                
                ProductPhotolibraryViewController.ProductSelect = ProductData[indexPath.row]
                let ViewController = ProductViewAndEditViewController()
                ViewController.SectionPush = "library"
                navigationController?.pushViewController(ViewController, animated: true)
            }
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
    
    
    @objc func editTapped(sender: UIBarButtonItem){
        if EditStatus{
            sender.title = "Edit"
            EditStatus = false
            navigationItem.rightBarButtonItems?.last?.isEnabled = true
        }else{
            sender.title = "Done"
            EditStatus = true
            navigationItem.rightBarButtonItems?.last?.isEnabled = false
        }
        collectionView!.reloadData()

    }
    
    @objc func addTapped(){
        
        let maxProduct = LoginPageController.DataLogin?.ProductMax

        if ProductData.count < Int(maxProduct!)!{
            
            let TLPhotosPicker = TLPhotosPickerViewController(withTLPHAssets: {(assets) in
                
                if assets.count > 0 {
                    
                    ProductPhotolibraryViewController.PhotosPicker.removeAll()
                    
                    if (assets.count + self.ProductData.count) < Int(maxProduct!)!{ //can add all product
                        for i in 0..<assets.count{
                            
                            //Image Resize
                            var image = assets[i].fullResolutionImage
                            if (image?.size.width)! > CGFloat(1000) || (image?.size.height)! > CGFloat(1000){
                                image = image?.resizeImageUpload()
                            }
                            
                            ProductPhotolibraryViewController.PhotosPicker.append(image!)
                            
                        }
                    }else{// can add remaining product
                        let Index_remaining = Int(maxProduct!)! - self.ProductData.count

                        for i in 0..<Index_remaining{
                            
                            //Image Resize
                            var image = assets[i].fullResolutionImage
                            if (image?.size.width)! > CGFloat(1000) || (image?.size.height)! > CGFloat(1000){
                                image = image?.resizeImageUpload()
                            }
                            
                            ProductPhotolibraryViewController.PhotosPicker.append(image!)
                            
                        }
                    }
                    
                    let ProductAddPhoto = ProductAddPhotoViewController()
                    self.navigationController?.pushViewController(ProductAddPhoto, animated: true)
    
                }
               
            }, didCancel: nil)
            
            TLPhotosPicker.configure.allowedVideo = false
            TLPhotosPicker.configure.allowedVideoRecording = false
            
            self.present(TLPhotosPicker, animated: true, completion: nil)
            
        }else{
            let message = "product " + String(ProductData.count) + " in " + maxProduct!
            let alert = UIAlertController(title: "you have products maximum", message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)

        }

    }
    
    @objc func Deleteimage(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.collectionView)
        let indexPath = self.collectionView!.indexPathForItem(at: point)
        let cell = collectionView!.cellForItem(at: indexPath!) as? ProductPhotolibraryViewCell
        let thisProduct = cell?.ProductNamelable.text
        
        let alert = UIAlertController(title: "Do You Want to Delete This Product?", message: thisProduct, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in

            if self.searching{
                
                let id = self.Productsearch[indexPath!.row]["idProduct"]
                let path = self.ProductData[indexPath!.row]["ProductImage"]
                
                self.delProduct(token: self.tokenID!, productID: id!, path: path!)
                
                let index = self.ProductData.indices.filter({self.ProductData[$0]["idProduct"] == id})
                self.ProductData.remove(at: index[0])
                self.ImageProduct.remove(at: indexPath!.row)
                self.Productsearch.remove(at: indexPath!.row)
                self.collectionView!.deleteItems(at: [indexPath!])
                
            }else{
                let id = self.ProductData[indexPath!.row]["idProduct"]
                let path = self.ProductData[indexPath!.row]["ProductImage"]
                
                self.delProduct(token: self.tokenID!, productID: id!, path: path!)
                                
                self.ImageProduct.remove(at: indexPath!.row)
                self.ProductData.remove(at: indexPath!.row)
                self.collectionView!.deleteItems(at: [indexPath!])
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
                    
                    if self.indexfinish == self.ProductData.count{
                        self.collectionView?.reloadData()
                        self.indexfinish = 0
                    }
                
                }
            case .failure(_):
                print(response.result)
                break
                
            }
        }
    }
    
    func delProduct(token:String,productID:String,path:String){
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
                    self.delimageProduct(token: token, path: path)
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func delimageProduct(token:String ,path:String ){
        guard path != "" else {return}

        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_ImageDeleteImage()
        
        //SubString name image
        let SubString = path.split{$0 == "/"}.map(String.init)
        let path = "product/" + SubString.last!
        
        let parameter = ["path":path, "bucket":"arforsalesfullimage"]

        AF.request(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : String]
                
                if JSON!["message"] == "Success" {
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

//MARK: Event SearchBar
extension ProductPhotolibraryViewController: UISearchBarDelegate , UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
           
           let searchText = searchController.searchBar.text
           
           if searchText!.count > 0{
                Productsearch = ProductData.filter({$0["ProductName"]!.lowercased().prefix(searchText!.count) == searchText!.lowercased()})
            print(Productsearch)
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

