//
//  TabBarUserController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 29/3/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire

class TabBarUserController : UITabBarController, UITabBarControllerDelegate  {
    
    // MARK: Parameter
    // Delegate Func in TabBarContainer
    var DelegateTabBarUser : TabBarUserDelegate?
    
    // Type Image Download
    var Im_DownloadType : [String] = ["Sale", "Company", "Sign", "ApproveSign"]
    
    // Main Data Detail Seller
    static var DataSeller : DataDetailSeller?
    
    // ShopCart Product
    static var ProductCart = [[String : Any]]()
    
    // Parameter State of Side Menu
    var State_SideMenu : Bool = false
    
    
    // ratio of Page
    lazy var ratio : CGFloat = self.view.frame.width / 375
    
    // View Blur
    var BGBlur : UIVisualEffectView = {
        let Blur = UIVisualEffectView(frame: UIScreen.main.bounds)
        let BlurEffect = UIBlurEffect(style: .dark)
        Blur.effect = BlurEffect
        Blur.alpha = 0.7
        
        return Blur
    }()
    
    // MARK: Func Layout
    func Layout_Page(){
        
        
        // TabBar Layout
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.tintColor = UIColor.BlackAlpha(alpha: 0.8)
        tabBar.unselectedItemTintColor = UIColor.BlackAlpha(alpha: 0.2)
        
        // Config Delegate Catagory Page
        let PageCatagory = CatagoryPageController()
        PageCatagory.DelegateTabbarTool = self
        
        let CatagoryPage = tabBarNavigation(unselectedImage: #imageLiteral(resourceName: "tiles N25"), selectdImage: #imageLiteral(resourceName: "tiles 75").withRenderingMode(.alwaysOriginal), title: "Catagory", badgeValue: nil, rootViewController: PageCatagory)
        
        // Config Delegate Cart Page
        let SalesCartPage = SaleShopCartViewController()
        SalesCartPage.DelegateTabbarTool = self
        
        let CartPage = tabBarNavigation(unselectedImage: #imageLiteral(resourceName: "shopping-cart N25"), selectdImage: #imageLiteral(resourceName: "shopping-cart").withRenderingMode(.alwaysOriginal), title: "Shop Cart", badgeValue: nil, rootViewController: SalesCartPage)
        
        view.addSubview(BGBlur)
        BGBlur.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        BGBlur.isHidden = true
        
        
        
        viewControllers = [CatagoryPage, CartPage]
        // --------------------
        
        // Navigation Bar Layout
        navigationItem.title = "Category"
        
        let Btn_Menu = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(Event_Menu_Click))
        Btn_Menu.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = Btn_Menu
        // --------------------
        
    }
    
    // MARK: Func Config
    func Config_Page(){
        
        // Delegate TabBar
        self.delegate = self
        
        // Add Method Swipe (Left, Right)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        // Add Method Tap BG Blur
        let Tap = UITapGestureRecognizer(target: self, action: #selector(TapBGBlur))
        self.BGBlur.addGestureRecognizer(Tap)
        
    }
    
    // MARK: Event Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element Page
        Layout_Page()
        // Config Element Page
        Config_Page()
        
        view.layoutIfNeeded()
        
        //NotificationCenter function Move Tabbar To first Page
        NotificationCenter.default.addObserver(self, selector: #selector(MoveTabbarTofirstPage(notification:)), name: NSNotification.Name(rawValue: "MoveTabbarTofirstPage"), object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // BGBlur
        BGBlur.isHidden = true
        // Get Detail Seller
        State_SideMenu = false
        Server_SendDataLogin(TokenId: LoginPageController.DataLogin?.Token_Id, Url: DataSource.Url_GetDetailSeller())
        
        //self.navigationController?.pushViewController(ProductListPageController(), animated: true)
    }
    
    // MARK: Func TabBar
    
    // Create Tabbar and Navigation to Page Target
    fileprivate func tabBarNavigation(unselectedImage: UIImage?, selectdImage: UIImage?, title: String?, badgeValue: String?, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.isNavigationBarHidden = true
        
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectdImage
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        navController.tabBarItem.title = title
        let attributes = [NSAttributedString.Key.font: UIFont.PoppinsRegular(size: 10)]
        navController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        
        // Set Badge Value of Element
        navController.tabBarItem.setBadgeTextAttributes([NSAttributedString.Key.font : UIFont.MitrRegular(size: 10 * ratio)], for: .normal)
        navController.tabBarItem.badgeColor = .systemRed
        navController.tabBarItem.badgeValue = badgeValue
        
        return navController
    }
    
    // Func Should Tab Select
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let indexSelect = viewControllers?.lastIndex(of: viewController)
        
        if indexSelect == 0 {
            navigationItem.title = "Category"
            navigationController?.navigationBar.barTintColor = .BlueDeep
            navigationItem.rightBarButtonItem = nil
        }
        else if indexSelect == 1{
            navigationItem.title = "Shop Cart"
            navigationController?.navigationBar.barTintColor = .BlueDeep
            
            let Btn_ClearShop = UIBarButtonItem(image: #imageLiteral(resourceName: "Clear_Shopcart").withRenderingMode(.alwaysTemplate),
                                                   style: .plain, target: self,
                                                   action: #selector(Event_Clear_ShopCart))
            
            navigationItem.rightBarButtonItem = Btn_ClearShop
        }
        
        return true
    }
    
    // MARK: Func of Page
    
    // Func Update badgeValue Tabbar Num of Product Cart
    func Update_BadgeValueTabbar(Num : Int){
        
        // Check Num
        if Num <= 0 {
            tabBar.items![1].badgeValue = nil
        }
        else {
            tabBar.items![1].badgeValue = String(Num)
        }
        
    }
    
    // Func Push to another Page from TabbarUserController
    func Push_ToNextPage(RootView : UIViewController){
        
        //let nav = UINavigationController(rootViewController: RootView)
        self.navigationController?.pushViewController(RootView, animated: true)
        
    }
    
    
    // Func Button Bar Menu Click
    @objc func Event_Menu_Click(){
        // Chage alpha Blur
        if TabBarUserContainer.ShouldExpandedSideMenu == false {
            BGBlur.isHidden = false
        }else{
            BGBlur.isHidden = true
        }
        // Check State of Slide Menu Before Show Slide Menu
        guard State_SideMenu == true else {
            return
        }
        
        DelegateTabBarUser?.ToggleSideMenu(Command: "")
    }
    
    @objc func Event_Clear_ShopCart(){
        NotificationCenter.default.post(name: NSNotification.Name("ClearShopCart"), object: nil)
    }
    
    // MARK: Func Send Data to Server and Verify Data Receive
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
                    
                    let result =  json["results"] as? [[String : Any]]
                    let data = result?.first //เพราะเมงส่งมาเป็น Array ฝั่ง Admin ไม่ได้เป็นแบบนี้ ไอ้เหี้ยมด
                    
                    // Filter Data Response
                    let Seller_Name = data!["Fullname"] as! String
                    let Seller_Id = data!["SalesEmployeeID"] as! String
                    let Quo_InPro = data!["QuotationInprogress"] as! Int
                    let Quo_Reject = data!["QuotationRejected"] as! Int
                    let Quo_Com = data!["QuotationCompleted"] as! Int
                    
                    // Check Nil of Data Total Sales
                    var TotalSales : Double = 0
                    if (data!["TotalSales"] as? Double) != nil {
                        TotalSales = data!["TotalSales"] as! Double
                    }

                    // Check Data Image Sales != ""
                    if (data!["SalesImage"] as! String) != ""  {
                        // Download Image Seller
                        self.Download_Image(Url: DataSource.Url_DownloadImage(), Key: data!["SalesImage"] as! String, Token: TokenId, ImageType: self.Im_DownloadType[0])
                        
                    }
                    
                    // Target Sale
                    let Target_Sale = data!["SalesTarget"] as? Double
                    
                    // Sale tel
                    let Sale_Tel = data!["SalesTel"] as! String
                    
                    // Sale Email
                    let Sale_Email = data!["SalesEmail"] as! String
                    
                    
                    // CompanyName ************
                    let CompanyName = data!["CompanyName"] as! String
                    
                    // Company Address
                    let Company_Address = data!["CompanyAddress"] as! String
                    
                    // Company Tel
                    let Company_Tel = data!["CompanyTel"] as! String
                    
                    // Company Fax
                    let Company_Fax = data!["CompanyFax"] as! String
                    
                    // Company Web
                    let Company_Web = data!["CompanyWebsite"] as! String
                    
                    // Image Company
                    if data!["CompanyImage"] as! String != "" {
                        
                        // Download Image Company
                        self.Download_Image(Url: DataSource.Url_DownloadImage(), Key: data!["CompanyImage"] as! String, Token: TokenId, ImageType: self.Im_DownloadType[1])
                        
                    }
                    
                    // Image Sign Sale Download
                    if data!["SalesSignImage"] as! String != "" {
                        
                        // Download Image Sign Sale
                        self.Download_Image(Url: DataSource.Url_DownloadImage(), Key: data!["SalesSignImage"] as! String, Token: TokenId, ImageType: self.Im_DownloadType[2])
                        
                    }
                    
                    // Image Approve Sign
                    if data!["QSapprovebySign"] as! String != "" {
                        
                        // Download Image Sign Approve
                        self.Download_Image(Url: DataSource.Url_DownloadImage(), Key: data!["QSapprovebySign"] as! String, Token: TokenId, ImageType: self.Im_DownloadType[3])
                        
                    }
                    // Name Approve
                    let Name_Appove = data!["QSapproveby"] as! String
                    
                    // Quotation Settting Section
                    // Quotation Set Show Logo
                    let QS_ShowLogo = data!["QSshowLogo"] as! Int
                    // Quotation Set tax Id
                    let QS_TaxId = data!["QStaxid"] as! String
                    // Quotation Vat
                    let QS_vat = data!["QSvat"] as? Double
                    // Quotation Mark Bottom
                    let QS_MarkBottom = data!["QSremarkbottom"] as! String
                    
                    
                    
                    // Record Detail Seller
                    TabBarUserController.DataSeller = DataDetailSeller(ComponyName: CompanyName, CompanyImage: #imageLiteral(resourceName: "company"), Company_Adress: Company_Address, Company_Tel: Company_Tel, Company_Fax: Company_Fax, Company_Web: Company_Web, SignSale: nil, Approve: nil, Approve_Name: Name_Appove, NameSeller: Seller_Name, Seller_Id: Seller_Id, Image_Seller: #imageLiteral(resourceName: "saleAccount"), Sale_Target: Target_Sale ?? 0, Sale_Tel : Sale_Tel, Sale_Email: Sale_Email,Quo_InPro: Quo_InPro, Quo_Reject: Quo_Reject, Quo_Complete: Quo_Com, TotalSales: TotalSales, QS_ShowLogo: QS_ShowLogo, QS_TaxId: QS_TaxId, QS_vat: QS_vat ?? 0, QS_MarkBottom: QS_MarkBottom, TokenId: TokenId)
                    
                    
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check your internet.")
                break
            }
            
        }
        
        
    }
    
    // MARK: Func Download Image Seller
    func Download_Image(Url : String, Key : String, Token : String, ImageType : String){
        
        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: LoginPageController.DataLogin!.Token_Id), .contentType("application/json")]
        let parameter = ["bucket":"arforsalesfullimage", "path": Key]
        AF.download(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value) :
                if let json = value as? [String : Any] {
                    
                    let Body = json["Body"] as? [String : Any]
                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let datos: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
                    
                    switch ImageType {
                    case self.Im_DownloadType[0]:
                        TabBarUserController.DataSeller?.Image_Seller = UIImage(data: datos as Data)!
                        self.State_SideMenu = true
                        
                    case self.Im_DownloadType[1] :
                        TabBarUserController.DataSeller?.CompanyImage = UIImage(data: datos as Data)!
                        
                    case self.Im_DownloadType[2] :
                        TabBarUserController.DataSeller?.SignSale = UIImage(data: datos as Data)!
                        
                    case self.Im_DownloadType[3] :
                        TabBarUserController.DataSeller?.Approve = UIImage(data: datos as Data)!
                    
                    default:
                        break
                    }

                    
                }
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check your internet.")
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
    
    // MARK: Function Swipe Tabbar
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.selectedIndex) < 1 { // set your total tabs here
                // Check Side Menu Open
                if (TabBarUserContainer.ShouldExpandedSideMenu == true) {
                    DelegateTabBarUser?.ToggleSideMenu(Command: nil)
                }else {
                    self.selectedIndex += 1
                }
            }
        } else if gesture.direction == .right {
            if (self.selectedIndex) > 0 {
                self.selectedIndex -= 1
            }
            // Open SideMenu
            else {
                DelegateTabBarUser?.ToggleSideMenu(Command: nil)
            }
        }
        
        // Change and Check Tilte Navigation When Tabbar Change
        let indexSelect = self.selectedIndex
        if indexSelect == 0 {
            navigationItem.title = "Overall Sales"
            navigationController?.navigationBar.barTintColor = .BlueDeep
        }
        else if indexSelect == 1{
            navigationItem.title = "Sale Report"
            navigationController?.navigationBar.barTintColor = .BlueDeep
            
        }
        else if indexSelect == 2 {
            navigationItem.title = "Customer Report"
            navigationController?.navigationBar.barTintColor = .BlueDeep
        }
        
        // Chage alpha Blur for Side Menu Open
        if TabBarUserContainer.ShouldExpandedSideMenu == true {
            BGBlur.isHidden = false
        }else{
            BGBlur.isHidden = true
        }
        
    }
    
    // MARK: Func Tap BGBlur
    @objc func TapBGBlur(_ gesture : UITapGestureRecognizer){
        
        if(TabBarUserContainer.ShouldExpandedSideMenu == true) {
            BGBlur.isHidden = true
            DelegateTabBarUser?.ToggleSideMenu(Command: nil)
        }
        
    }
    
    @objc func MoveTabbarTofirstPage(notification: NSNotification) {
        self.selectedIndex = 0
    }
    
    
    
}

// extention TabbarToolDelegate
extension TabBarUserController : TabbarToolDelegate {

    
    func Update_BadgeValue(Num: Int?) {
        
        self.Update_BadgeValueTabbar(Num: Num!)

    }
    
    func Push_PageTo(RootView: UIViewController?) {
        
        // If Page ProductList
        if let Page = RootView as? ProductListPageController {
            
            Page.DelegateTabbarTool = self
            self.Push_ToNextPage(RootView: Page)
        }
        // Another Page
        else {
            self.Push_ToNextPage(RootView: RootView!)
        }
    
        
        
    }
    
    func Delegate_Page(RootView: UIViewController?) {
        
        // If page Product Detail
        if let Page = RootView as? ProductDetailPageController {
            
            Page.DelegateTabbarTool = self
            
        }
        
    }
    
    func Goto_CartPage(){
        
        // Select Index tabbar 1 (Cart Page)
        self.selectedIndex = 1
        self.navigationItem.title = "Shop Cart"
        
        let Btn_ClearShop = UIBarButtonItem(image: #imageLiteral(resourceName: "Clear_Shopcart").withRenderingMode(.alwaysTemplate),
                                               style: .plain, target: self,
                                               action: #selector(Event_Clear_ShopCart))
        
        navigationItem.rightBarButtonItem = Btn_ClearShop
    }
    
}

