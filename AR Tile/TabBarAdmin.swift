//
//  TabBarAdmin.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 8/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire

class TabBarAdmin : UITabBarController, UITabBarControllerDelegate {
    
    // ratio
    lazy var ratio = view.frame.width / 375
    
    // Parameter of SubPage (OverallPage, TopSalesPage, CustomerPage)
    var OverallPage : OverallMonitorPageController!
    var TopSalePage : TopSaleMonitorPageController!
    var CustomerPage : CustomerMonitorPageController!
    
    // Delegate Func in TabBarContainer
    var DelegateTabBarAdmin : TabBarAdminDelegate?
    
    // Parameter Date Request
    static var DateMonitor_Request : [String : String]!
    // Parameter Text Date Request
    static var TxtDate_Request : String!
    
    // View Blur
    // View Blur of IMage BG
    var BGBlur : UIVisualEffectView = {
        let Blur = UIVisualEffectView(frame: UIScreen.main.bounds)
        let BlurEffect = UIBlurEffect(style: .dark)
        Blur.effect = BlurEffect
        Blur.alpha = 0.7
        
        return Blur
    }()
    
    // Section View Date Show------
    // View Date
    var View_Date : UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 1)
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // Label Date
    lazy var Lb_Date : UILabel = {
        let label = UILabel()
        label.text = "Date: 1/05/20 - 31/05/21"
        label.font = UIFont.MitrMedium(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // -----------------------------
    
    // MARK : Func For Layout UI
    func Layout_Page(){
        
        // TabBar Layout
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.tintColor = UIColor.BlackAlpha(alpha: 0.8)
        tabBar.unselectedItemTintColor = UIColor.BlackAlpha(alpha: 0.2)
        
        OverallPage = OverallMonitorPageController()
        OverallPage.Delegate_DateShow = self
        let MainMonitorPage = tabBarNavigation(unselectedImage: #imageLiteral(resourceName: "MonitorSale"), selectdImage: #imageLiteral(resourceName: "discount 25").withRenderingMode(.alwaysOriginal), title: "Sales Company", badgeValue: nil, rootViewController: OverallPage)
        
        TopSalePage = TopSaleMonitorPageController()
        
        let TopSaleMonitorPage = tabBarNavigation(unselectedImage: #imageLiteral(resourceName: "salesman2"), selectdImage: #imageLiteral(resourceName: "worker 25").withRenderingMode(.alwaysOriginal), title: "Sale Report", badgeValue: nil, rootViewController: TopSalePage)
        
        CustomerPage = CustomerMonitorPageController()
        
        let CustomerMonitorPage = tabBarNavigation(unselectedImage: #imageLiteral(resourceName: "bill N 25"), selectdImage: #imageLiteral(resourceName: "bill 75").withRenderingMode(.alwaysOriginal), title: "Customer Report", badgeValue: nil, rootViewController: CustomerPage)
        
        viewControllers = [MainMonitorPage, TopSaleMonitorPage, CustomerMonitorPage]
        // --------------------
        
        // Navigation Bar Layout
        navigationItem.title = "Overall Sales"
        
        // Button Navigation Bar Side Menu
        let Btn_Menu = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(Event_Menu_Click))
        Btn_Menu.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = Btn_Menu
        
        // Button Navigation Bar Filter Date
        let Btn_FilterDate = UIBarButtonItem(image: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(Event_FilterDate))
        Btn_FilterDate.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
        navigationItem.rightBarButtonItem = Btn_FilterDate
        
        // --------------------
        
        // View Blur
        view.insertSubview(BGBlur, at: 5)
        BGBlur.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        BGBlur.isHidden = true
        // --------------------
        
        // Section View Date
        // View Date
        view.addSubview(View_Date)
        View_Date.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 45 * ratio)
        // Label Date
        View_Date.addSubview(Lb_Date)
        Lb_Date.anchorCenter(nil, AxisY: View_Date.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Date.anchor(nil, left: View_Date.leftAnchor, bottom: nil, right: View_Date.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    
    fileprivate func tabBarNavigation(unselectedImage: UIImage?, selectdImage: UIImage?, title: String?, badgeValue: String?, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.isNavigationBarHidden = true
        
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectdImage
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        navController.tabBarItem.title = title
        let attributes = [NSAttributedString.Key.font: UIFont.PoppinsRegular(size: 10)]
        navController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        
        navController.tabBarItem.badgeColor = .red
        navController.tabBarItem.badgeValue = badgeValue
        
        return navController
    }
    
    // Func Should Tab Select
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let indexSelect = viewControllers?.lastIndex(of: viewController)
        
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
        
        return true
    }
    
    // Function Control Animation Tabbar Change
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
    
    // --------------------------------------------------------------------------------------
    
    // MARK: Func Config Page
    func Config_Page(){
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy"
        formatter.calendar = Calendar(identifier: .gregorian)
        
        // Config Date
        var DateStart = "2000" // since year 2000
        var DateEnd = formatter.string(from: date) // Current Year
        
        DateStart = "\(DateStart)-01"
        DateEnd = "\(DateEnd)-12"
        
        // Record Date
        let Date_Initail : [String : String] = ["Start" : DateStart, "End" : DateEnd]
        TabBarAdmin.DateMonitor_Request = Date_Initail
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate Tabbar
        self.delegate = self
        
        // Layout UI Page
        Layout_Page()
        // Configm UI Page
        Config_Page()
        
        view.layoutIfNeeded()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Hidden BG Blur
        BGBlur.isHidden = true
        
        // Request Detail of Company
        Server_SendDataLogin(TokenId: LoginPageController.DataLogin?.Token_Id, Url: DataSource.Url_GetCompany())
        
        // Request All Data for Monitor
        let TypeData = ["Quotation", "TopProduct", "TopSale", "CustomerType", "CustomerChanel"]
        let Url = [DataSource.Url_GetQuotationListAdmin(), DataSource.Url_GetTopProductAdmin(), DataSource.Url_GetTopSalesAdmin(), DataSource.Url_GetCustomerType(), DataSource.Url_GetCustomerChanel()]
        for count in 0...(TypeData.count - 1) {
            
            Request_AllDataMonitor(Url: Url[count], Date: TabBarAdmin.DateMonitor_Request, TypeData: TypeData[count])
            
        }
        
        
        
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
                    
                    // Record Data Response
                    let data = json["results"] as? [String : Any]
                    // Company
                    let NameCom = data!["CompanyName"] as! String
                    // Logo Company
                    let Logo_Company = data!["CompanyImage"] as! String
                    print(Logo_Company)
                    // Download Image if Data Logo Company != ""
                    if Logo_Company != "" {
                        self.Download_Image(Url: DataSource.Url_DownloadImage(), Key: Logo_Company)
                    }
                    // Email Company
                    let CompanyEmail = data!["CompanyEmail"] as! String
                    
                    // Sales
                    let SaleQuan = data!["SalesCount"] as! Int
                    let SaleMax = data!["Companysales"] as! Int
                    // Product Normal
                    let ProQuan = data!["ProductCount"] as! Int
                    let ProMax = data!["CompanyProduct"] as! Int
                    // Product Custom
                    let ProCusQuan = data!["ProductCustomCount"] as! Int
                    let ProCusMax = data!["CompanyProductCustom"] as! Int
                    // Package
                    let Package = data!["packageName"] as! String
                    
                    LoginPageController.DataLogin = DataUser(AdminUse: true, CompanyName: NameCom, Logo: #imageLiteral(resourceName: "Logo TheThreeTouch"), CompanyEmail: CompanyEmail, SaleQuan: String(SaleQuan), SaleMax: String(SaleMax), ProductQuan: String(ProQuan), ProductMax: String(ProMax), ProductCustomQuan: String(ProCusQuan), ProductCustomMax: String(ProCusMax), Package: Package, Token_Id: TokenId)
                    
                    
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                break
            }
            
        }
        
        
    }
    
    // MARK: Func Get All Data Monitor
    public func Request_AllDataMonitor(Url : String ,Date : [String : String], TypeData : String){
        
        let parameter = Date
        let Header : HTTPHeaders = [.authorization(bearerToken: LoginPageController.DataLogin!.Token_Id), .contentType("application/json")]
        
        AF.request(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success(let value) :
                //print(value)
                let json = value as? [String : Any]

                // Check error Request
                guard json!["results"] != nil else {
                    let errormessage = json!["message"] as! String
                    self.Create_AlertMessage(Title: "Error", Message: errormessage)
                    return
                }
                
                // Manage Data Response
                let data = json!["results"] as? [[String : Any]]
                // Check Type of Data Request Before Pass Data to Monitor Page
                if TypeData == "Quotation" {
                    
                    // Pass Data
                    self.OverallPage.Data_Quotation = data
                    // Change State for Update UI and Data
                    self.OverallPage.StateUpdate_Overall = true
                    
                }
                else if TypeData == "TopProduct" {
                    
                    // Clear Data_Image Top Product
                    self.OverallPage.Data_TopProduct?.removeAll()
                    self.OverallPage.Collection_TopPro.reloadData()
                    
                    // Pass Data
                    self.OverallPage.Data_TopProduct = data
                    // Change State for Update UI and Data
                    self.OverallPage.StateUpdate_TopProduct = true
                    
                }
                else if TypeData == "TopSale" {
                    
                    // Pass Data
                    self.TopSalePage.Data_TopSale = data
                    // Change State for Update UI and Data
                    self.TopSalePage.StateUpdate_TopSale = true
                    
                }
                else if TypeData == "CustomerType" {
                    // Pass Data
                    self.CustomerPage.Data_CustomerType = data
                    // Change State for Update UI and Data
                    self.CustomerPage.StateUpdate_CustomerType = true
                    
                }
                else if  TypeData == "CustomerChanel" {
                    
                    // Pass Data
                    self.CustomerPage.Data_CustomerChanel = data
                    // Change State for Update UI and Data
                    self.CustomerPage.StateUpdate_CustomerChanel = true
                    
                }
                
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                break
            }
            
            
        })
        
        
    }
    
    //MARK: Func Download Image Logo Company
    func Download_Image(Url : String, Key : String){
        
        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: LoginPageController.DataLogin!.Token_Id), .contentType("application/json")]
        let parameter = ["bucket":"arforsalesfullimage", "path": Key]
        AF.download(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
               
            switch response.result {
            case .success(let value) :
                if let json = value as? [String : Any] {
                    let Body = json["Body"] as? [String : Any]
                    
                    // Not Download Image
                    guard Body != nil else {
                        self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Image of Product InComplete")
                        return
                    }
                       
                    // Convert Data Buffer to UIImage
                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let datos: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
                    let image = UIImage(data: datos as Data)
                    
                    // Record Image Logo Company
                    LoginPageController.DataLogin?.Logo = image!
                    
                }
            case .failure(_):
                   
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Image of Product InComplete")
                   
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
    
    
    //MARK: Func Button in Page
    // Func Button Bar Menu Click
    @objc func Event_Menu_Click(){
        // Chage alpha Blur
        if TabBarAdminContainer.ShouldExpandedSideMenu == false {
            BGBlur.isHidden = false
        }else{
            BGBlur.isHidden = true
        }
        
        DelegateTabBarAdmin?.ToggleSideMenu(forSideMenuOption: nil)
    }
    
    @objc func Event_FilterDate(){
        
        // Chage alpha Blur
        if TabBarAdminContainer.ShouldExpendedFilterDate == false {
            BGBlur.isHidden = false
        }else{
            BGBlur.isHidden = true
        }
        
        
        DelegateTabBarAdmin?.ToggleFilterDate()
        
    }
    
    // MARK: Function Swipe Tabbar
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.selectedIndex) < 2 { // set your total tabs here
                // Check Side Menu Open
                if (TabBarAdminContainer.ShouldExpandedSideMenu == true) {
                    DelegateTabBarAdmin?.ToggleSideMenu(forSideMenuOption: nil)
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
                DelegateTabBarAdmin?.ToggleSideMenu(forSideMenuOption: nil)
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
        if TabBarAdminContainer.ShouldExpandedSideMenu == true {
            BGBlur.isHidden = false
        }else{
            BGBlur.isHidden = true
        }
        
    }
    
    // MARK: Func Tap BGBlur
    @objc func TapBGBlur(_ gesture : UITapGestureRecognizer){
        
        if(TabBarAdminContainer.ShouldExpandedSideMenu == true) {
            BGBlur.isHidden = true
            DelegateTabBarAdmin?.ToggleSideMenu(forSideMenuOption: nil)
        }
        if(TabBarAdminContainer.ShouldExpendedFilterDate == true){
            BGBlur.isHidden = true
            DelegateTabBarAdmin?.ToggleFilterDate()
        }
        
    }


}

// MARK: Extension
// Extention Delegate Show Date in Page
extension TabBarAdmin : DateShowAdminDelegate {
    
    
    func UpdateOverallSale_SubPage(TotalSales: Double) {
        
        //TopSalePage.Overall_Sale = TotalSales
        
    }
    

    func PassDate_Show(DateStart: String, DateEnd: String) {
        
        // Update Date Monitor (Show)
        Lb_Date.text = "Date: \(DateStart) To \(DateEnd)"
        // Update Txt Date Request
        TabBarAdmin.TxtDate_Request = "Date: \(DateStart) To \(DateEnd)"
        
    }
    
    
}

