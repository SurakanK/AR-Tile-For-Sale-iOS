//
//  SideMenuAdminController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 10/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Pastel

private let reuseIdentify = "TablecellSideMenuOption_AdminTableViewCell"

class SideMenuAdminController : UIViewController{
    
    // ratio
    lazy var ratio = view.frame.width / 375
    
    
    // Image Logo Company
    lazy var Im_LogoCompany : UIImageView = {
        let image = UIImageView()
        
        image.image = #imageLiteral(resourceName: "company").imageWithInsets(insets: UIEdgeInsets(top: 50 * ratio, left: 50 * ratio, bottom: 50 * ratio, right: 50 * ratio))
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = (100 * ratio)/2
        image.layer.masksToBounds = true
        image.backgroundColor = .whiteAlpha(alpha: 0.8)
        
        return image
    }()
    // Image BG
    var Im_BG : UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = #imageLiteral(resourceName: "TileBG1")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.alpha = 0.5
        return image
    }()
    
    // Label of Companyname
    lazy var Lb_Company : UILabel = {
        let label = UILabel()
        label.text = "The Three Touch Asia Pacific"
        label.font = UIFont.PoppinsBold(size: 20 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.8)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // Label Name Admin
    lazy var Lb_NameAdmin : UILabel = {
        let label = UILabel()
        label.text = "นาย พัทธนันท์ ปุ่นน้ำใส"
        label.font = UIFont.MitrMedium(size: 20 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.8)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // Label Admin
    lazy var Lb_Admin : UILabel = {
        let label = UILabel()
        label.text = "Admin"
        label.font = UIFont.PoppinsRegular(size: 17 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.8)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // Detail Package (User, Product, Package)
    // User View
    var UserView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.8).cgColor
        view.layer.borderWidth = 2
        return view
    }()
    // Label HeaderUser
    lazy var Lb_HUser : UILabel = {
        let label = UILabel()
        label.text = "User"
        label.font = UIFont.PoppinsRegular(size: 15 * ratio)
        label.textAlignment = .center
        label.textColor = .whiteAlpha(alpha: 0.8)
        return label
    }()
    // Label Quantity User
    lazy var Lb_NumUser : UILabel = {
        let label = UILabel()
        label.text = "2/10"
        label.font = UIFont.PoppinsMedium(size: 20 * ratio)
        label.textAlignment = .center
        label.textColor = .whiteAlpha(alpha: 0.9)
        
        
        return label
    }()
    // Label Unit User
    lazy var Lb_UnitUser : UILabel = {
        let label = UILabel()
        label.text = "Person"
        label.font = UIFont.PoppinsRegular(size: 15 * ratio)
        label.textAlignment = .center
        label.textColor = .whiteAlpha(alpha: 0.8)
        return label
    }()
    // --------------------
    // Product View
    var ProductView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.8).cgColor
        view.layer.borderWidth = 2
        return view
    }()
    // Label Header Product
    lazy var Lb_HProduct : UILabel = {
        let label = UILabel()
        label.text = "Product"
        label.font = UIFont.PoppinsRegular(size: 15 * ratio)
        label.textAlignment = .center
        label.textColor = .whiteAlpha(alpha: 0.8)
        return label
    }()
    // Label Quantity Product
    lazy var Lb_NumProduct : UILabel = {
        let label = UILabel()
        label.text = "50"
        label.font = UIFont.PoppinsMedium(size: 20 * ratio)
        label.textAlignment = .center
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // Label Unit Product
    lazy var Lb_UnitProduct : UILabel = {
        let label = UILabel()
        label.text = "Item"
        label.font = UIFont.PoppinsRegular(size: 15 * ratio)
        label.textAlignment = .center
        label.textColor = .whiteAlpha(alpha: 0.8)
        return label
    }()
    // --------------------
    // Package View
    var PackageView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.8).cgColor
        view.layer.borderWidth = 2
        return view
    }()
    // Label Header Package
    lazy var Lb_HPackage : UILabel = {
        let label = UILabel()
        label.text = "Package"
        label.font = UIFont.PoppinsRegular(size: 15 * ratio)
        label.textAlignment = .center
        label.textColor = .whiteAlpha(alpha: 0.8)
        return label
    }()
    // Icon Package
    var Im_Package : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "standard").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    // Label Unit Package
    lazy var Lb_UnitPackage : UILabel = {
        let label = UILabel()
        label.text = "Standard"
        label.font = UIFont.PoppinsRegular(size: 15 * ratio)
        label.textAlignment = .center
        label.textColor = .whiteAlpha(alpha: 0.8)
        return label
    }()
    // --------------------
    // --------------------------------------
    // Func Config TableView
    var TableView_Admin : UITableView!
    var Delegate : TabBarAdminDelegate?
    func Config_TableView(){
        TableView_Admin = UITableView()
        TableView_Admin.delegate = self
        TableView_Admin.dataSource = self
        
        TableView_Admin.register(TablecellSideMenuOption_AdminTableViewCell.self, forCellReuseIdentifier: reuseIdentify)
        
        TableView_Admin.backgroundColor = .clear
        TableView_Admin.separatorStyle = .none
        TableView_Admin.alwaysBounceVertical = false
        
        
    }
    // --------------------------------------
    
    
    func Layout_Page(){
        
        // Image BG of View
        view.insertSubview(Im_BG, at: 0)
        
        // Set Attribute View
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.9).cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        
        // Set Pastel View
        let pastelView = PastelView(frame: view.bounds)
        // add to Layer of View
        self.view.insertSubview(pastelView, at: 1)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight

        // Custom Duration
        pastelView.animationDuration = 1.0

        // Custom Color
        pastelView.setColors([UIColor.BlueLight, UIColor.BlueDeep])
        
        pastelView.alpha = 1
        pastelView.startAnimation()
        // ------------------------------------------
        
        // Label Companyname
        self.view.addSubview(Lb_Company)
        Lb_Company.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 60 * ratio, widthConstant: 0, heightConstant: 0)
        // ------------------------------------------
        
        // Image Logo
        self.view.addSubview(Im_LogoCompany)
        Im_LogoCompany.anchor(Lb_Company.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100 * ratio, heightConstant: 100 * ratio)
        Im_LogoCompany.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -25 * ratio).isActive = true
        // ------------------------------------------
        
        // StackView Detail Package
        let StackView = UIStackView(arrangedSubviews: [UserView,ProductView,PackageView])
        StackView.axis = .horizontal
        StackView.spacing = 10 * ratio
        StackView.distribution = .fillEqually
        self.view.addSubview(StackView)
        
        StackView.anchor(Im_LogoCompany.bottomAnchor, left: Lb_Company.leftAnchor, bottom: nil, right: Lb_Company.rightAnchor, topConstant: 20 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100 * ratio)
        // ------------------------------------------
        
        /// User View
        // Label Header Detail User
        UserView.addSubview(Lb_HUser)
        Lb_HUser.anchor(UserView.topAnchor, left: UserView.leftAnchor, bottom: nil, right: UserView.rightAnchor, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        // --------------------
        // Label Number User
        UserView.addSubview(Lb_NumUser)
        Lb_NumUser.anchorCenter(UserView.centerXAnchor, AxisY: UserView.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        // --------------------
        // Label Unit User
        UserView.addSubview(Lb_UnitUser)
        Lb_UnitUser.anchor(nil, left: Lb_HUser.leftAnchor, bottom: UserView.bottomAnchor, right: Lb_HUser.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // ------------------------------------------
        
        /// Product View
        // Label Header Product
        ProductView.addSubview(Lb_HProduct)
        Lb_HProduct.anchor(ProductView.topAnchor, left: ProductView.leftAnchor, bottom: nil, right: ProductView.rightAnchor, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        // --------------------
        // Label Number Product
        ProductView.addSubview(Lb_NumProduct)
        Lb_NumProduct.anchorCenter(ProductView.centerXAnchor, AxisY: ProductView.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        // --------------------
        // Label Unit User
        ProductView.addSubview(Lb_UnitProduct)
        Lb_UnitProduct.anchor(nil, left: Lb_HProduct.leftAnchor, bottom: ProductView.bottomAnchor, right: Lb_HProduct.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // ------------------------------------------
        
        /// Package View
        // Label Header Product
        PackageView.addSubview(Lb_HPackage)
        Lb_HPackage.anchor(PackageView.topAnchor, left: PackageView.leftAnchor, bottom: nil, right: PackageView.rightAnchor, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        // --------------------
        // Icon Package
        PackageView.addSubview(Im_Package)
        Im_Package.anchorCenter(PackageView.centerXAnchor, AxisY: PackageView.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 32 * ratio, heightConstant: 32 * ratio)
        // --------------------
        // Label Unit User
        PackageView.addSubview(Lb_UnitPackage)
        Lb_UnitPackage.anchor(nil, left: Lb_HPackage.leftAnchor, bottom: PackageView.bottomAnchor, right: Lb_HPackage.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // ------------------------------------------
        
        // TableView Admin
        self.view.addSubview(TableView_Admin)
        
        TableView_Admin.anchor(StackView.bottomAnchor, left: Lb_Company.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: Lb_Company.rightAnchor, topConstant: 20 * ratio, leftConstant: 0, bottomConstant: 20 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.layoutIfNeeded()
        print(TableView_Admin.frame.width)
        
        // ------------------------------------------
        
        
    }
    
    // Func Config Element in Side Menu Page
    func Configulation(){
        
        // Config Table View
        Config_TableView()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config Element in Page
        Configulation()
        
        // Layout Page
        Layout_Page()
        
    }
    
    // MARK: Func Update Date
    func Update_Data(){
        
        LoginPageController.DataLogin?.Package = "Premium"
        
        // Config Data Initail
        Lb_Company.text = LoginPageController.DataLogin?.CompanyName
        
        Im_LogoCompany.image = LoginPageController.DataLogin?.Logo.imageWithInsets(insets: UIEdgeInsets(top: 80 * ratio, left: 80 * ratio, bottom: 80 * ratio, right: 80 * ratio))
        
        Lb_NumUser.text =  "\(String(LoginPageController.DataLogin!.SaleQuan))/\(String(LoginPageController.DataLogin!.SaleMax))"
        Lb_NumProduct.text = "\(String(LoginPageController.DataLogin!.ProductQuan))/\(String(LoginPageController.DataLogin!.ProductMax))"
        
        if LoginPageController.DataLogin?.Package == "Premium" {
            Im_Package.image = #imageLiteral(resourceName: "crown").withRenderingMode(.alwaysTemplate)
            Lb_UnitPackage.text = "Premium"
        }
        
        
    }
    
    
}

// Extention Table
extension SideMenuAdminController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 // 7 item in Tableview
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentify , for: indexPath) as! TablecellSideMenuOption_AdminTableViewCell
        let SideMenuOption = SideMenuAdminOption(rawValue: indexPath.row)
        cell.Icon.image = SideMenuOption?.image
        cell.label_func.text = SideMenuOption?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SideMenuOption = SideMenuAdminOption(rawValue: indexPath.row)
        Delegate?.ToggleSideMenu(forSideMenuOption: SideMenuOption)
    }
    
}

