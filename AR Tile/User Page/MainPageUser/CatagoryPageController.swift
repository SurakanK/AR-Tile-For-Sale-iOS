//
//  CatagoryPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 29/3/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//
import UIKit
import Alamofire

private var IdCell = "CollecitonCell_Catagory"

class CatagoryPageController : UIViewController {
    
    // MARK: Parameter
    
    var Collection_Catagory : UICollectionView!
    
    var DataCatagory = [[String : Any]]()
    
    var DataImage : [UIImage] = []
    
    // Num of Check Download Image Catagory Complete
    var Num_CheckDownload : Int = 0
    
    // Delegate TabbarTool
    var DelegateTabbarTool : TabbarToolDelegate?
    
    
    // MARK: Layout
    func Layout_Page() {
        view.backgroundColor = .systemGray6
        
        // Layout Collection Catagory Page
        let Collection_Catagory = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        view.addSubview(Collection_Catagory)
        Collection_Catagory.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Collection_Catagory.alwaysBounceVertical = true
        Collection_Catagory.backgroundColor = .clear
        
        
        self.Collection_Catagory = Collection_Catagory
        
    }
    
    // MARK: Config
    func Config_Page(){
        
        // Config Collection Catagory
        self.Collection_Catagory.delegate = self
        self.Collection_Catagory.dataSource = self
        self.Collection_Catagory.register(CollecitonCell_Catagory.self, forCellWithReuseIdentifier: IdCell)

        
        
        
    }
    
    // MARK: Func life Cycle Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element in Page
        Layout_Page()
        // Config Element in Page
        Config_Page()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Show Title of Back Button
        self.navigationItem.title = "Catagory"
        
        // Reset Data Before request
        DataCatagory.removeAll()
        DataImage.removeAll()
        Num_CheckDownload = 0
        
        Collection_Catagory.reloadData()
        
        // Request Data Catagory
        self.Server_SendDataLogin(TokenId: LoginPageController.DataLogin?.Token_Id, Url: DataSource.Url_GetCatagory())
        
        
        
    }
    
    // MARK : Request data From Server
    func Server_SendDataLogin(TokenId : String! ,Url : String!) {
        
        let Header : HTTPHeaders = [HTTPHeader.authorization(bearerToken: TokenId), HTTPHeader.contentType("application/json")]
        
        AF.sessionConfiguration.timeoutIntervalForRequest = 1
        AF.request(Url, method : .post, headers: Header).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                if let json = value as? [String : Any] {
                    
                    // Check Response Error
                    guard json["results"] != nil else {
                        let errormesaage = json["message"] as! String
                        print(errormesaage)
                        return
                    }
                    
                    // Manage Data response
                    let dataArray = json["results"] as? [[String : Any]]
                    self.DataCatagory = dataArray!
                    
                    // Download Image Catagory
                    for count in 0...(self.DataCatagory.count - 1) {
                        // Add Image to Array for Download Image response
                        self.DataImage.append(#imageLiteral(resourceName: "Icon-Tile"))
                        // data
                        let data = dataArray![count]
                        
                        self.Download_Image(Url: DataSource.Url_DownloadImage(), Key: data["CategoryImage"] as! String, Token: TokenId, count: count)
                    }
                    
               
                    
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Item Catagory InComplete")
                break
            }
            
        }
        
        
    }
    
    // MARK: Download Image Catagory
    func Download_Image(Url : String, Key : String, Token : String, count : Int){
        
        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: LoginPageController.DataLogin!.Token_Id), .contentType("application/json")]
        let parameter = ["bucket":"arforsalesimageresize", "path": Key]
        AF.download(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value) :
                if let json = value as? [String : Any] {
                    
                    let Body = json["Body"] as? [String : Any]
                    
                    // Convert Data Buffer to UIImage
                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let datos: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
                    let image = UIImage(data: datos as Data)
                    
                    
                    self.DataImage[count] = image!
                    
                    // Stack Image Catagory Download
                    self.Num_CheckDownload += 1
                    
                    if self.Num_CheckDownload == self.DataCatagory.count {
                        
                        self.Collection_Catagory.reloadData()
     
                    }
                    
                }
            case .failure(_):
                
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Image of Item Catagory InComplete")
                
                break
            }
        }
        
        
    }
    
    // MARK: Alert Box
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Func of Page
    
    
}

// Extention
extension CatagoryPageController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if Num_CheckDownload == 0 {
            return 10
        }
        else {
            return DataCatagory.count + 1
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell, for: indexPath) as! CollecitonCell_Catagory
        
        
        if Num_CheckDownload == 0 {
            cell.Image_Catagory.showAnimatedSkeleton()
            cell.Lb_Catagory.showAnimatedSkeleton()
            cell.Lb_NumProduct.showAnimatedSkeleton()
        }
        else {
            // Hide Skeleton Loader
            cell.Image_Catagory.hideSkeleton()
            cell.Lb_Catagory.hideSkeleton()
            cell.Lb_NumProduct.hideSkeleton()
            
            // Check index if == Data.count is Catagory Custom Tile
            if indexPath.row == DataCatagory.count {
                
                cell.Lb_Catagory.text = "Custom Tile"
                cell.Lb_NumProduct.text = "10 Product"
                cell.Image_Download = #imageLiteral(resourceName: "Icon-Tile")
                
            }else {
                let data = DataCatagory[indexPath.row]
                
                // Show Name of Catagory
                cell.Lb_Catagory.text = (data["CategoryDescription"] as! String)
                
                // Show Num of Product
                if (data["Quantity"] as? Int) != nil {
                    cell.Lb_NumProduct.text = String(data["Quantity"] as! Int) + " Product"
                }
                else {
                    cell.Lb_NumProduct.text = "0 Product"
                }
                
                // Show Image Catagory
                cell.Image_Download = DataImage[indexPath.row]
            }
            
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Check Download Data Complete ?
        if DataCatagory.count != 0 && Num_CheckDownload == DataCatagory.count {
            
            // Check User Choose Catagory Custom Tile
            if indexPath.row == DataCatagory.count {
                
                let cell = collectionView.cellForItem(at: indexPath) as! CollecitonCell_Catagory
                
                let ProductList = ProductListPageController()
                ProductList.Name_Page = cell.Lb_Catagory.text!
                
                // Pass Data for Change State for Download Catagory
                ProductList.State_CustomTile = true
                
                DelegateTabbarTool?.Push_PageTo(RootView: ProductList)
                
            }else {
                
                let cell = collectionView.cellForItem(at: indexPath) as! CollecitonCell_Catagory
                
                let data = DataCatagory[indexPath.row]
                
                let ProductList = ProductListPageController()
                ProductList.Name_Page = cell.Lb_Catagory.text!
                
                // Pass Id Catagory
                ProductList.Id_Catagory = String(data["idCategory"] as! Int)
                
                
                DelegateTabbarTool?.Push_PageTo(RootView: ProductList)
            }
            
            /*let Next_Page = UINavigationController(rootViewController: ProductList)
            Next_Page.modalPresentationStyle = .fullScreen
            
            self.navigationController?.show(Next_Page, sender: nil)*/
            //self.show(Next_Page, sender: nil)
            
            //self.present(Next_Page, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
    
    
}

extension CatagoryPageController : UICollectionViewDelegateFlowLayout {
    // UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio = view.frame.width / 375
        return CGSize(width: collectionView.bounds.width - (20 * ratio), height: 75 * ratio)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let ratio = view.frame.width / 375
        return UIEdgeInsets(top: 10 * ratio, left: 10 * ratio, bottom: 10 * ratio, right: 10 * ratio) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Space Vertical of cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}

