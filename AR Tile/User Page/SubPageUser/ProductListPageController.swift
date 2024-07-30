//
//  ProductListPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 3/4/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import UIDropDown
import SkeletonView
import Alamofire

// Id Cell Product
private var IdCellHori = "CollecitonCell_ProductHorizon"
private var IdCellVerti = "CollecitonCell_ProductVertical"

class ProductListPageController : UIViewController {
    
    // MARK: Parameter
    var Name_Page : String = ""
    
    // Parameter Id Catagory
    var Id_Catagory : String!
    
    // Parameter State Catagory
    var State_CustomTile : Bool = false
    
    // Data Product
    var DataPro_Download = [[String : Any]]()
    var DataImage_Download : [UIImage] = []
    
    // Data For Search
    var DataSearch = [[String : Any]]()
    
    // DataSearch and Sort
    var DataSearchSort = [[String : Any]]()
    
    // Num Dowmnload Image
    var Num_DownloadImage : Int = 0
    
    // Data of Sort By
    var DataSource_SortBy : [String] = ["ราคา(น้อยไปมาก)", "ราคา(มากไปน้อย)", "สินค้าขายดี"]
    
    // State of Sty CollectionView
    var State_Sty : String = "Horizontal"
    
    // Delgate tabbar Tool
    var DelegateTabbarTool : TabbarToolDelegate?
    
    // SeachBar
    let SearchController = UISearchController(searchResultsController: nil)
    
    // View_SortFilter
    var View_SortFilter : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // Icon Sort by
    var Icon_Sortby : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "sort").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // Label Sort by
    var Lb_Sortby : UILabel = {
        let label = UILabel()
        label.text = "Sort by"
        label.font = UIFont.MitrMedium(size: 18)
        return label
    }()
    
    // View DropDown Sort by
    var View_DropSort : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // Line Section
    var Line_Section : UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.5)
        return view
    }()
    
    // Label Style
    var Lb_Style : UILabel = {
        let label = UILabel()
        label.text = "Style"
        label.font = UIFont.MitrMedium(size: 18)
        return label
    }()
    
    // Btn Style
    var Btn_Style : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "menu2").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.BlueDeep
        button.backgroundColor = .clear
        
        button.addTarget(self, action: #selector(Btn_StyleClick), for: .touchUpInside)
        return button
    }()
    
    // Collection View Product
    var Collection_Product : UICollectionView!
    
    // MARK: Layout
    func Layout_Page(){
        
        // Test
        //Id_Catagory = "1"
        
        
        view.backgroundColor = UIColor.systemGray6
        
        let ratio = view.frame.width / 375
        
        // Set Navigation Bar
        navigationItem.title = Name_Page
        
        /*let Button_back = UIBarButtonItem(image: #imageLiteral(resourceName: "black").withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(Back_CatagoryPage))
        navigationItem.leftBarButtonItem = Button_back*/
        //navigationItem.hidesBackButton = false
        
        
        
        // Search in Navigation Bat
        // SeachBar in NavigationBar
        SearchController.searchResultsUpdater = self
        SearchController.searchBar.delegate = self
        SearchController.searchBar.searchBarStyle = .minimal
        SearchController.obscuresBackgroundDuringPresentation = false
        SearchController.searchBar.searchTextField.backgroundColor = .white
        SearchController.searchBar.tintColor = .white
        
        let TxtField = SearchController.searchBar.value(forKey: "searchField") as? UITextField
        TxtField?.font = UIFont.MitrRegular(size: 15 * ratio)
        TxtField?.backgroundColor = .white
        TxtField?.placeholder = "Search Product"
        
        navigationItem.searchController = SearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        // View SortFilter -------
        view.addSubview(View_SortFilter)
        View_SortFilter.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Icon Sort by
        View_SortFilter.addSubview(Icon_Sortby)
        Icon_Sortby.anchor(View_SortFilter.topAnchor, left: View_SortFilter.leftAnchor, bottom: View_SortFilter.bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 20 * ratio, heightConstant: 20 * ratio)
        
        // Label Sort By
        View_SortFilter.addSubview(Lb_Sortby)
        Lb_Sortby.anchorCenter(nil, AxisY: Icon_Sortby.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Sortby.anchor(nil, left: Icon_Sortby.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Sortby.font = UIFont.MitrMedium(size: 15 * ratio)
        
        // View DropSort
        View_SortFilter.addSubview(View_DropSort)
        View_DropSort.anchor(Lb_Sortby.topAnchor, left: Lb_Sortby.rightAnchor, bottom: Lb_Sortby.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 175 * ratio, heightConstant: 0)
        view.layoutIfNeeded()
        
        // Line Section
        View_SortFilter.addSubview(Line_Section)
        Line_Section.anchor(View_SortFilter.topAnchor, left: View_DropSort.rightAnchor, bottom: View_SortFilter.bottomAnchor, right: nil, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 1 * ratio, heightConstant: 0)
        
        // Lb Style
        View_SortFilter.addSubview(Lb_Style)
        Lb_Style.anchorCenter(nil, AxisY: Icon_Sortby.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Style.anchor(nil, left: Line_Section.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Style.font = UIFont.MitrMedium(size: 15 * ratio)
        
        // Btn Style
        View_SortFilter.addSubview(Btn_Style)
        Btn_Style.anchor(Icon_Sortby.topAnchor, left: nil, bottom: Icon_Sortby.bottomAnchor, right: View_SortFilter.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 20 * ratio, heightConstant: 20 * ratio)
        
        // --------------------------------------
        
        // CollectionView Product
        let Collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(Collection)
        Collection.anchor(View_SortFilter.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Collection.alwaysBounceVertical = true
        Collection.backgroundColor = UIColor.clear
        
        self.Collection_Product = Collection
        
        
        // Setting Drop Down Sort By
        let DropDownSort = UIDropDown(frame: View_DropSort.frame)
        DropDownSort.font = "Mitr-Light"
        DropDownSort.fontSize = (15 * ratio)
        DropDownSort.layer.borderWidth = 0
        DropDownSort.placeholder = DataSource_SortBy[2]
        DropDownSort.options = DataSource_SortBy
        DropDownSort.optionsFont = "Mitr-Light"
        DropDownSort.optionsSize = (15 * ratio)
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = (50 * ratio)
        DropDownSort.tableHeight = CGFloat(50 * DataSource_SortBy.count)
        
        // Func DropDown Item Select
        DropDownSort.didSelect { (Text, index) in
            DropDownSort.placeholder = Text
            
            // Sort Data
            self.DataSearch = self.Sort_Data(SortBy: Text, DataForSort: self.DataSearchSort)
            self.DataSearchSort = self.DataSearch
            self.Collection_Product.reloadData()
        }
        
     
        view.addSubview(DropDownSort)
        
        
    }
    
    // MARK: Config
    func Config_Page(){
        
        self.Collection_Product.delegate = self
        self.Collection_Product.dataSource = self
        self.Collection_Product.register(CollecitonCell_ProductHorizon.self, forCellWithReuseIdentifier: IdCellHori)
        
        // Request Data Product
        Collection_Product.reloadData()
        // Check State Custom Tile
        // Not Custom Tile Catagory
        if State_CustomTile == false {
            Server_SendDataLogin(TokenId: LoginPageController.DataLogin?.Token_Id, Url: DataSource.Url_GetListProduct(), idProduct: Id_Catagory)
        }
        // Custom Tile Catagory
        else {
            Request_DataCustomTile(TokenId: LoginPageController.DataLogin?.Token_Id, Url: DataSource.Url_GetListCustomProduct())
        }
        
        
    }
    
    // MARK: Func Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element Page
        Layout_Page()
        // Config Element Page
        Config_Page()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set Navigation Bar
        navigationItem.title = Name_Page
    }
    
    
    // MARK: Func of Page
    // Button Style Change
    @objc func Btn_StyleClick(){
        
        if State_Sty == "Horizontal" {
            Collection_Product.register(CollecitonCell_ProductVertical.self, forCellWithReuseIdentifier: IdCellVerti)
            
            State_Sty = "Vertical"
            
            Btn_Style.setImage(#imageLiteral(resourceName: "list2").withRenderingMode(.alwaysTemplate), for: .normal)
            
            Collection_Product.reloadData()
            
        }
        else if State_Sty == "Vertical" {
            
            Collection_Product.register(CollecitonCell_ProductHorizon.self, forCellWithReuseIdentifier: IdCellHori)
            
            State_Sty = "Horizontal"
            
            Btn_Style.setImage(#imageLiteral(resourceName: "menu2").withRenderingMode(.alwaysTemplate), for: .normal)
            
            Collection_Product.reloadData()
            
        }
        
        
        
    }
    
    // Back to Catagory Page
    @objc func Back_CatagoryPage(){
        
        // Cancel Request Data
        AF.cancelAllRequests()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Sort Data
    func Sort_Data(SortBy : String, DataForSort : [[String : Any]]) -> [[String : Any]] {
        
        var Data_Sort = DataForSort
        
        // Sort Price (High to Low)
        if SortBy == self.DataSource_SortBy[0] {
            
            Data_Sort = DataForSort.sorted{($0["ProductPrice"] as! Double) <= ($1["ProductPrice"] as! Double)}
            
        }
        // Sort Price Low to Hight
        else if SortBy == self.DataSource_SortBy[1] {
            
            Data_Sort = DataForSort.sorted{($0["ProductPrice"] as! Double) >= ($1["ProductPrice"] as! Double)}
            
        }
        // Sort Data New to Old
        else if SortBy == self.DataSource_SortBy[2] {
            
            // Check Nil if nil = 0
            var Data = DataForSort
            for count in 0...(DataForSort.count - 1){
                
                if (Data[count]["Quantity"] as? Double) == nil {
                    Data[count]["Quantity"] = Double(0)
                }
                
            }
            
            Data_Sort = Data.sorted{($0["Quantity"] as! Double) >= ($1["Quantity"] as! Double)}
            
        }
        
        
        
        return Data_Sort
    }
    
    // MARK : Request data From Server
    func Server_SendDataLogin(TokenId : String! ,Url : String!, idProduct : String) {
        
        let Header : HTTPHeaders = [HTTPHeader.authorization(bearerToken: TokenId), HTTPHeader.contentType("application/json")]
        let parameter = ["id" : idProduct]
        
        AF.sessionConfiguration.timeoutIntervalForRequest = 1
        AF.request(Url, method : .post, parameters: parameter, encoding: JSONEncoding.default , headers: Header).responseJSON { response in
            
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
                    self.DataPro_Download = dataArray!
                    
                    // Download Image Catagory
                    for count in 0...(self.DataPro_Download.count - 1) {
                        // Add Image to Array for Download Image response
                        self.DataImage_Download.append(#imageLiteral(resourceName: "Icon-Tile"))
                        // data
                        let data = dataArray![count]
                        
                        self.Download_Image(Url: DataSource.Url_DownloadImage(), Key: data["ProductImage"] as! String, Token: TokenId, count: count)
                    }
                    
               
                    
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Item Product InComplete")
                break
            }
            
        }
        
        
    }
    
    // MARK: Download Data Catagory Custom Tile
    func Request_DataCustomTile(TokenId : String! ,Url : String!) {
        
        let Header : HTTPHeaders = [HTTPHeader.authorization(bearerToken: TokenId), HTTPHeader.contentType("application/json")]
        
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
                           self.DataPro_Download = dataArray!
                           
                           // Download Image Catagory
                           for count in 0...(self.DataPro_Download.count - 1) {
                               // Add Image to Array for Download Image response
                               self.DataImage_Download.append(#imageLiteral(resourceName: "Icon-Tile"))
                               // data
                               let data = dataArray![count]
                               
                               self.Download_Image(Url: DataSource.Url_DownloadImage(), Key: data["ProductImage"] as! String, Token: TokenId, count: count)
                           }
                           
                      
                           
                       }
                       
                   case .failure(_):
                       self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Item Product InComplete")
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
                    
                    // Record Image to DataPro_Download
                    self.DataPro_Download[count]["Image"] = image
                    
                    // Stack Num of Image Download foe Check State Download Complete
                    self.Num_DownloadImage += 1
                    
                    // if Download Complete
                    if self.Num_DownloadImage == self.DataPro_Download.count {
                        
                        // DataSearchSort Record
                        self.DataSearchSort = self.DataPro_Download
                        
                        // Sort Data
                        self.DataSearch = self.Sort_Data(SortBy: self.DataSource_SortBy[2], DataForSort: self.DataSearchSort)
                        self.DataSearchSort = self.DataSearch
                        
                        
                        //Reload Collection Product
                        self.Collection_Product.reloadData()
                        
                        
                    }
                    
                    
                }
            case .failure(_):
                
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Image of Item Product InComplete")
                
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
    
    
}

// MARK: Extention Page

// Search Bar
extension ProductListPageController : UISearchBarDelegate, UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let Txt_Search = searchController.searchBar.text!
        
        if Txt_Search.count > 0 {
            self.DataSearchSort = DataSearch.filter{($0["ProductName"] as! String).prefix(Txt_Search.count) == Txt_Search}
        }
        
        self.Collection_Product.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    
}

// MARK: Extension

// CollectionView Delegate and DataSource
extension ProductListPageController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if Num_DownloadImage == 0 {
            return 10
        }
        else {
            return DataSearchSort.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if State_Sty == "Horizontal" {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCellHori, for: indexPath) as! CollecitonCell_ProductHorizon
            
            // Check State Download
            // Not Complete
            if Num_DownloadImage <= 0 {
                
                // Show Skeleton loader
                cell.Im_Product.showAnimatedSkeleton()
                cell.Lb_NamePro.showAnimatedSkeleton()
                cell.Lb_PricePro.showAnimatedSkeleton()
                cell.Lb_NumSoldPro.showAnimatedSkeleton()
                
            }
            // Complete
            else {
                
                // Hide Skeleton loader
                cell.Im_Product.hideSkeleton()
                cell.Lb_NamePro.hideSkeleton()
                cell.Lb_PricePro.hideSkeleton()
                cell.Lb_NumSoldPro.hideSkeleton()
                
                let data = DataSearchSort[indexPath.row]
                
                cell.Im_Product.image = (data["Image"] as! UIImage)
                cell.Lb_NamePro.text = (data["ProductName"] as! String)
                cell.Lb_PricePro.text = "฿ " + String(data["ProductPrice"] as! Double).currencyFormatting() + "/m²"
                
                // Check nil Sold out
                if (data["Quantity"] as? Double) != nil {
                    cell.Lb_NumSoldPro.text = "Sold : \(String(data["Quantity"] as! Double).currencyFormatting()) m²"
                }
                else {
                    cell.Lb_NumSoldPro.text = "Sold : 0 m²"
                }
                
                
            }
            
            
            return cell
            
        }
        else {
            
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCellVerti, for: indexPath) as! CollecitonCell_ProductVertical
            
            // Check State Download
            // Not Complete
            if Num_DownloadImage == 0 {
                
                // Show Skeleton loader
                cell.Im_Product.showAnimatedSkeleton()
                cell.Lb_NamePro.showAnimatedSkeleton()
                cell.Lb_PricePro.showAnimatedSkeleton()
                cell.Lb_NumSoldPro.showAnimatedSkeleton()
                
            }
            // Complete
            else {
                
                // Hide Skeleton loader
                cell.Im_Product.hideSkeleton()
                cell.Lb_NamePro.hideSkeleton()
                cell.Lb_PricePro.hideSkeleton()
                cell.Lb_NumSoldPro.hideSkeleton()
                
                let data = DataSearchSort[indexPath.row]
                
                cell.Im_Product.image = (data["Image"] as! UIImage)
                cell.Lb_NamePro.text = (data["ProductName"] as! String)
                cell.Lb_PricePro.text = "฿ " + String(data["ProductPrice"] as! Double).currencyFormatting() + "/m²"
                
                // Check nil Sold out
                if (data["Quantity"] as? Double) != nil {
                    cell.Lb_NumSoldPro.text = "Sold : \(String(data["Quantity"] as! Double).currencyFormatting()) m²"
                }
                else {
                    cell.Lb_NumSoldPro.text = "Sold : 0 m²"
                }
                
                
            }
            
            return cell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        // Check Download Complete Before Select Cell
        guard DataPro_Download.count != 0 && Num_DownloadImage == DataPro_Download.count  else {
            return
        }
        
        // Hide Title of Back Button
        self.navigationItem.title = ""
        
        let data = DataSearchSort[indexPath.row]
        
        if State_Sty == "Horizontal" {
            
            let cell = collectionView.cellForItem(at: indexPath) as! CollecitonCell_ProductHorizon
            
            let NextPage = ProductDetailPageController()
            NextPage.Data_Cross["Name"] = cell.Lb_NamePro.text
            NextPage.Data_Cross["Price"] = cell.Lb_PricePro.text
            NextPage.Data_Cross["NumSold"] = cell.Lb_NumSoldPro.text
            NextPage.Data_Cross["KeyImage"] = (data["ProductImage"] as! String)
            
            // Pass Data Product Detail
            NextPage.DataProductDetail = data
            DelegateTabbarTool?.Delegate_Page(RootView: NextPage)
            
                   
                   self.navigationController?.pushViewController(NextPage, animated: true)

            
        }
        else {
            
            let cell = collectionView.cellForItem(at: indexPath) as! CollecitonCell_ProductVertical
            
            let data = DataSearchSort[indexPath.row]
            
            let NextPage = ProductDetailPageController()
            NextPage.Data_Cross["Name"] = cell.Lb_NamePro.text
            NextPage.Data_Cross["Price"] = cell.Lb_PricePro.text
            NextPage.Data_Cross["NumSold"] = cell.Lb_NumSoldPro.text
            NextPage.Data_Cross["KeyImage"] = String(data["ProductImage"] as! String)
            
            
            // Pass Data Product Detail
            NextPage.DataProductDetail = data
            DelegateTabbarTool?.Delegate_Page(RootView: NextPage)
                   
            self.navigationController?.pushViewController(NextPage, animated: true)
            
        }
        
        
        
    }
    
    
    
    
    
}

// CollecitonView FlowLayout
extension ProductListPageController : UICollectionViewDelegateFlowLayout {
    // UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio = view.frame.width / 375
        
        if State_Sty == "Horizontal" {
            return CGSize(width: collectionView.bounds.width - (20 * ratio), height: 150 * ratio)
        }
        else {
            return CGSize(width: (collectionView.bounds.width - (30 * ratio)) / 2, height: 275 * ratio)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let ratio = view.frame.width / 375
        
        if State_Sty == "Horizontal" {
            return UIEdgeInsets(top: 10 * ratio, left: 10 * ratio, bottom: 10 * ratio, right: 10 * ratio) //.zero
        }
        else {
            return UIEdgeInsets(top: 10 * ratio, left: 10 * ratio, bottom: 10 * ratio, right: 10 * ratio) //.zero
        }
        
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


