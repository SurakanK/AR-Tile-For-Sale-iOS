//
//  TabBarUserContainer.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 27/3/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class TabBarUserContainer : UIViewController, UINavigationControllerDelegate {
    
    // MARK: Parameter
    // Parameter of SideMenu Page
    var SideMenuPage : SideMenuUserController!
    var TabBarUserPage : TabBarUserController!
    var CenterOfTabBarUser : UIViewController!
    static var ShouldExpandedSideMenu : Bool = false
    
    // MARK: Func Layout
    func Layout_Page(){
        
        
        view.backgroundColor = UIColor.CreamLight
        
        // ConfigNavigation Bar
        // Navigation Layout
        UINavigationBar.appearance().barTintColor = .BlueDeep
        UINavigationBar.appearance().tintColor = UIColor.whiteAlpha(alpha: 0.8)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsBold(size: 25)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.MitrRegular(size: 15),NSAttributedString.Key.foregroundColor : UIColor.whiteAlpha(alpha: 0.9)], for: .normal)
        UINavigationBar.appearance().isTranslucent = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: Func Config
    func Config_Page(){
        
        // Config TabbarUserPage
        ConfigTabBarUserPage()
        
    }
    
    
    // MARK: Event Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element Page
        Layout_Page()
        // Config Element Page
        Config_Page()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.isNavigationBarHidden == false {
            navigationController?.isNavigationBarHidden = true
        }
    }
    
    // MARK: Config Side Menu
    func ConfigTabBarUserPage(){
        
        TabBarUserPage = TabBarUserController()
        TabBarUserPage.DelegateTabBarUser = self
        CenterOfTabBarUser = UINavigationController(rootViewController: TabBarUserPage)
        view.addSubview(CenterOfTabBarUser.view)
        addChild(CenterOfTabBarUser)
        CenterOfTabBarUser.didMove(toParent: self)
    }
    // Func Config SideMenu
    func ConfigSideMenuUserPage() {
        if SideMenuPage == nil {
            SideMenuPage = SideMenuUserController()
            SideMenuPage.Delegate = self
            view.insertSubview(SideMenuPage.view, at: 0)
            addChild(SideMenuPage)
            SideMenuPage.didMove(toParent: self)
        }
    }
    
    // Func Expand Side Menu
    func ExpandedSideMenuAdmin(ShouldExpanded : Bool, Command : String?){
        
        if ShouldExpanded {
            
            // Update Data Seller in SideMenu User Page
            SideMenuPage.Update_DataSeller()
            
            //Show Menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.CenterOfTabBarUser.view.frame.origin.x = self.CenterOfTabBarUser.view.frame.width - 50
            }, completion: nil)
        }
        else{
            //Close Menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.CenterOfTabBarUser.view.frame.origin.x = 0
            }, completion: nil)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.CenterOfTabBarUser.view.frame.origin.x = 0
            }) { (_) in
                guard let Command = Command else {return}
                self.didSelectTableSideMenu(Command: Command)
            }
            
        }
    }
    
    // Func Table View in Side Menu Select item
    func didSelectTableSideMenu(Command : String){
        switch Command {
        case "Manage Quotation" :
            self.navigationController?.pushViewController(ManageQuotationController(), animated: true)
            
        case "SignOut" :
            // Show Alert Sign Out
            let alert = UIAlertController(title: "Sign Out", message: "You want to Sign Out", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive,handler: {action in
                self.TabBarUserPage.BGBlur.isHidden = true
            }))
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler:{ action in
                // Reset Username and Password from Directory Application
                let Filename : [String] = ["StateKeepMe.txt", "Certificate.txt", "Username.txt", "Password.txt"]
                // Clear Data in Directory
                self.SaveData_ToDoc(FileName: Filename[0], Data: "false")
                self.navigationController?.popViewController(animated: true)
            }))
            // Set Attribute Alert
            alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
            alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
            self.present(alert, animated: true, completion: nil)
        default:
            break
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

// MARK: Extention Page
// Delegate TabarUserPage and SideMenu Page
extension TabBarUserContainer : TabBarUserDelegate  {
    
    func ToggleSideMenu(Command : String?) {
        
        if !TabBarUserContainer.ShouldExpandedSideMenu {
            ConfigSideMenuUserPage()
        }
               
        TabBarUserContainer.ShouldExpandedSideMenu = !TabBarUserContainer.ShouldExpandedSideMenu
        ExpandedSideMenuAdmin(ShouldExpanded: TabBarUserContainer.ShouldExpandedSideMenu, Command: Command)
               
    }
    
    
    
}
