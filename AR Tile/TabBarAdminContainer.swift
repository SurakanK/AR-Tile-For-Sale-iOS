//
//  TabBarAdminContainer.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 11/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire

class TabBarAdminContainer : UIViewController {
    
    // Ratio
    lazy var ratio = view.frame.width / 375
    
    // Parameter of Date Mode (All(Year), Month, Year)
    static var ModeDate : String = "Month"
    
    // Parameter of SideMenu Page
    var SideMenuPage : SideMenuAdminController!
    static var ShouldExpandedSideMenu : Bool = false
    // Parameter of FilterDate Page
    var FilterDatePage : FilterDatePageController!
    static var ShouldExpendedFilterDate : Bool = false
    // Parameter of TabbarAdmin Page
    var TabbarAdminPage : TabBarAdmin!
    var CenterOfTabBarAdmin : UIViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ConfigNavigation Bar
        // Navigation Layout
        UINavigationBar.appearance().barTintColor = .BlueDeep
        UINavigationBar.appearance().tintColor = UIColor.whiteAlpha(alpha: 0.8)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsBold(size: 25)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.MitrRegular(size: 15),NSAttributedString.Key.foregroundColor : UIColor.whiteAlpha(alpha: 0.9)], for: .normal)
        UINavigationBar.appearance().isTranslucent = false

        
        // Config TabbarAdminPage
        ConfigTabBarAdminPage()
        // Config SideMenuPage
        ConfigSideMenuAdminPage()
        // Config FilterDatePage
        ConfigFilterDateAdmin()
        
        if view.subviews.first == FilterDatePage.view{
            print("Filter")
        }
        if view.subviews.first == SideMenuPage.view {
            print("SideMenu")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.isNavigationBarHidden == false {
            navigationController?.isNavigationBarHidden = true
        }

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: Config Side Menu -------------------------------------------
    func ConfigTabBarAdminPage(){
        
        TabbarAdminPage = TabBarAdmin()
        TabbarAdminPage.DelegateTabBarAdmin = self
        CenterOfTabBarAdmin = UINavigationController(rootViewController: TabbarAdminPage)
        view.addSubview(CenterOfTabBarAdmin.view)
        addChild(CenterOfTabBarAdmin)
        CenterOfTabBarAdmin.didMove(toParent: self)
    }
    // Func Config SideMenu
    func ConfigSideMenuAdminPage() {
        if SideMenuPage == nil {
            SideMenuPage = SideMenuAdminController()
            SideMenuPage.Delegate = self
            view.insertSubview(SideMenuPage.view, at: 0)
            addChild(SideMenuPage)
            SideMenuPage.didMove(toParent: self)
        }
    }
    
    // Func Config FilterDate
    func ConfigFilterDateAdmin(){
        if FilterDatePage == nil {
            FilterDatePage = FilterDatePageController()
            FilterDatePage.Delegate = self
            view.insertSubview(FilterDatePage.view, at: 1)
            addChild(FilterDatePage)
            FilterDatePage.didMove(toParent: self)
        }
    }
    
    // Func Expand Side Menu Page
    func ExpandedSideMenuAdmin(ShouldExpanded : Bool, SideMenuOption : SideMenuAdminOption?){
        
        if ShouldExpanded {
            
            // Udate Data in Side Menu Admin Page
            SideMenuPage.Update_Data()
            
            //Show Menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.CenterOfTabBarAdmin.view.frame.origin.x = self.CenterOfTabBarAdmin.view.frame.width - (50 * self.ratio)
            }, completion: nil)
        }
        else{
            //Close Menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.CenterOfTabBarAdmin.view.frame.origin.x = 0
            }, completion: nil)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.CenterOfTabBarAdmin.view.frame.origin.x = 0
            }) { (_) in
                guard let SideMenuOption = SideMenuOption else {return}
                self.didSelectTableSideMenu(SideMenuOption: SideMenuOption)
            }
            
        }
    }
    
    // Func Expend Filter Date Page
    func ExpandedFilterDateAdmin(ShouldExpanded : Bool) {
        
        if ShouldExpanded {
            //Show Menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.CenterOfTabBarAdmin.view.frame.origin.x -= self.CenterOfTabBarAdmin.view.frame.width - (50 * self.ratio)
            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.CenterOfTabBarAdmin.view.frame.origin.x = 0
            }) { (_) in
                
            }
        }
        
    }
    
    // -----------------------------------------------
    
    // Func Table View in Side Menu Select item
    func didSelectTableSideMenu(SideMenuOption : SideMenuAdminOption){
        switch SideMenuOption {
        case .General :
           
            navigationController?.isNavigationBarHidden = false
            navigationController?.pushViewController(GeneralSetting(style: .grouped), animated: true)
            
            print("General")
        case .Account :
            
            navigationController?.isNavigationBarHidden = false
            navigationController?.pushViewController(ManageAccountViewController(), animated: true)
            
            print("Account")
        case .Product :
            navigationController?.isNavigationBarHidden = false
            navigationController?.pushViewController(ProductViewController(style: .grouped), animated: true)
            
            print("Product")
        case .Customer :
            navigationController?.isNavigationBarHidden = false
            let ViewController = CustomerListViewController()
            ViewController.MoveViewController = "Admin"
            navigationController?.pushViewController(ViewController, animated: true)
            
            print("Customer")
        case .Quotation :
            
            navigationController?.isNavigationBarHidden = false
            let ViewController = ManageQuotationController()
            // Change State Type Use Page
            ViewController.Sale_Use = false
            
            navigationController?.pushViewController(ViewController, animated: true)
        case .Export :
            navigationController?.isNavigationBarHidden = false
            let ViewController = ExportDataPageController()
            navigationController?.pushViewController(ViewController, animated: true)
            
        case .Signout :
            // Show Alert Sign Out
            let alert = UIAlertController(title: "Sign Out", message: "You want to Sign Out", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive,handler: {action in
                self.TabbarAdminPage.BGBlur.isHidden = true
            }))
            
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler:{ action in
                // Reset Username and Password from Directory Application
                let Filename : [String] = ["StateKeepMe.txt", "Certificate.txt", "Username.txt", "Password.txt"]
                // Clear Data in Directory
                self.SaveData_ToDoc(FileName: Filename[0], Data: "false")
                //self.SaveData_ToDoc(FileName: Filename[1], Data: "Admin")
                //self.SaveData_ToDoc(FileName: Filename[2], Data: "")
                //self.SaveData_ToDoc(FileName: Filename[3], Data: "")
                // sign Out Back to Login page
                self.navigationController?.popViewController(animated: true)
            }))
            
            // Set Attribute Alert
            alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
            alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Func Document
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    // Save Data to Directory
    func SaveData_ToDoc(FileName : String, Data : String){
        let url = self.getDocumentsDirectory().appendingPathComponent(FileName)

        do {
            try Data.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    // Read Data From Directory
    func ReadData_FromDoc(FileName : String) -> String {
        let url = self.getDocumentsDirectory().appendingPathComponent(FileName)

        do {
            let input = try String(contentsOf: url)
            return input
        } catch {
            print(error.localizedDescription)
            return "Filename wrong"
        }
    }
    
    
}

extension TabBarAdminContainer : TabBarAdminDelegate  {
    
    func Request_Data(Date: [String : String], Type: String) {
        
        var Url : String = DataSource.Url_GetQuotationListAdmin()
        if Type == "Quotation" {
            Url = DataSource.Url_GetQuotationListAdmin()
        }
        else if Type == "TopSale" {
            Url = DataSource.Url_GetTopSalesAdmin()
        }
        else if Type == "TopProduct" {
            Url = DataSource.Url_GetTopProductAdmin()
        }
        else if Type == "CustomerType" {
            Url = DataSource.Url_GetCustomerType()
        }
        else if Type == "CustomerChanel" {
            Url = DataSource.Url_GetCustomerChanel()
        }
        
        // Record Date to DateMonitor TabbarAdmin
        TabBarAdmin.DateMonitor_Request = Date
        // Request All Data Monitor
        TabbarAdminPage.Request_AllDataMonitor(Url: Url, Date: Date, TypeData: Type)
        
    }
    
    func ToggleSideMenu(forSideMenuOption SideMenuOption: SideMenuAdminOption?) {
        // exchange index of Subview
        if view.subviews.first == SideMenuPage.view {
            view.exchangeSubview(at: 0, withSubviewAt: 1)
        }
        
        /*if !ShouldExpandedSideMenu {
            ConfigSideMenuAdminPage()
        }*/
               
        TabBarAdminContainer.ShouldExpandedSideMenu = !TabBarAdminContainer.ShouldExpandedSideMenu
        ExpandedSideMenuAdmin(ShouldExpanded: TabBarAdminContainer.ShouldExpandedSideMenu, SideMenuOption: SideMenuOption)
               
    }
    
    func ToggleFilterDate() {
        
        // exchange index of Subview
        if view.subviews.first == FilterDatePage.view {
            view.exchangeSubview(at: 0, withSubviewAt: 1)
        }
        
        // Close BGBlur
        self.TabbarAdminPage.BGBlur.isHidden = TabBarAdminContainer.ShouldExpendedFilterDate
        
        TabBarAdminContainer.ShouldExpendedFilterDate = !TabBarAdminContainer.ShouldExpendedFilterDate
        ExpandedFilterDateAdmin(ShouldExpanded: TabBarAdminContainer.ShouldExpendedFilterDate)
        
        
    }
    
    
}
