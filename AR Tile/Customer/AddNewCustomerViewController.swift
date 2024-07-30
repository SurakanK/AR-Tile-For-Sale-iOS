//
//  AddNewCustomerViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 25/5/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import UIDropDown
import Alamofire
import NVActivityIndicatorView

class AddNewCustomerViewController: UIViewController {
    
    let tokenID = LoginPageController.DataLogin?.Token_Id

    var MoveViewController = ""
    var DataCustomerDetail = [String : Any]()

    var DataCustomerGrade = ""
    var DataCustomerType = ""
    var DataCustomerRecommendedby = ""
    
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
    
    //Element Main
    var ScrollView : UIScrollView = {
        let Scroll = UIScrollView()
        return Scroll
    }()
    
    //Element Coustomer Company infomation
    let textFieldCustomerType: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Customer Type", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.3
        textField.isEnabled = false
        return textField
    }()
    
    let DropDownCustomerType: UIDropDown = {
        let DropDownSort = UIDropDown(frame: CGRect(x: 0, y: 0, width: 345, height: 35))
        let DataSort = ["ลูกค้าทั่วไป","วิศวกร","สถาปนิก","ผู้รับเหมา","เจ้าของกิจการ"]
        DropDownSort.options = DataSort
        DropDownSort.optionsFont = "Mitr-Regular"
        DropDownSort.optionsSize = 18
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = 50
        DropDownSort.tableHeight = 50 * CGFloat(DataSort.count)
        DropDownSort.borderWidth = 0
        
        return DropDownSort
    }()
    
    let textFieldCompanyName: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "FullName or Company name", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    let textFieldAddress: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Address", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    let textFieldCountyORPefecture: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "County or District", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    let textFieldZoneORDistrict: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Zone or District", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    let textFieldProvince: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Province", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    let textFieldZipCode: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Zip Code", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    let textFieldChannelsCustomers: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Channels to get customers", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.3
        textField.isEnabled = false
        return textField
    }()
    
    let DropDownChannelsCustomers: UIDropDown = {
        let DropDownSort = UIDropDown(frame: CGRect(x: 0, y: 0, width: 345, height: 35))
        let DataSort = ["วิ่งไซด์งาน","การแนะนำ","วางเสปค","Internet"]
        DropDownSort.options = DataSort
        DropDownSort.optionsFont = "Mitr-Regular"
        DropDownSort.optionsSize = 18
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = 50
        DropDownSort.tableHeight = 50 * CGFloat(DataSort.count)
        DropDownSort.borderWidth = 0
        return DropDownSort
    }()
    
    //Element Coustomer Contract
    let viewContract: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlueDeep.withAlphaComponent(0.15)
        return view
    }()
    
    let labelContract: UILabel = {
        let label = UILabel()
        label.text = "Contract"
        label.textColor = .black
        label.font = UIFont.MitrMedium(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let labelContractmessage: UILabel = {
        let label = UILabel()
        label.text = "(*No need to fill in all)"
        label.textColor = .systemRed
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let textFieldContractName: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        return textField
    }()
    
    let textFieldContractPhone: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Phone", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        return textField
    }()
    
    let textFieldContractEmail: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        return textField
    }()
    
    let textFieldContractIDLine: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "ID Line", attributes: [NSAttributedString.Key.font: UIFont.MitrRegular(size: 18) , NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.25)])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.MitrRegular(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        return textField
    }()
    
    //Element Class Customer
    let viewClassCustomer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlueDeep.withAlphaComponent(0.15)
        return view
    }()
    
    let labelClassCustomer: UILabel = {
        let label = UILabel()
        label.text = "Class Customer"
        label.textColor = .black
        label.font = UIFont.MitrMedium(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let buttonGrade_A: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("A", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 25)
        button.tag = 1
        button.addTarget(self, action: #selector(CustomerGradeSelect), for: .touchUpInside)
        return button
    }()
    
    let buttonGrade_B: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("B", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 25)
        button.tag = 2
        button.addTarget(self, action: #selector(CustomerGradeSelect), for: .touchUpInside)
        return button
    }()
    
    let buttonGrade_C: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("C", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 25)
        button.tag = 3
        button.addTarget(self, action: #selector(CustomerGradeSelect), for: .touchUpInside)
        return button
    }()
    
    //Element Button Submit
    let buttonSubmit: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 5
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationSetting()
        ElementSetting()
        DropDownEvent()
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
        view.backgroundColor = .systemGray6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        switch MoveViewController {
        case "Admin":
            EditCustomer()
        case "SaleEdit":
            EditCustomer()
        case "SaleAdd":
            print("Sale Add Customer")
        default:
            print("MoveViewController")
        }
        
    }
    
    func NavigationSetting(){
        
        navigationItem.title = "Add Customer"
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
    
    }
    
    func ElementSetting(){
        
        view.addSubview(ScrollView)
        ScrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        ScrollView.contentOffset.x = 0
        
        //Setting Element Coustomer Company infomation
        ScrollView.addSubview(textFieldCustomerType)
        ScrollView.addSubview(textFieldCompanyName)
        ScrollView.addSubview(textFieldAddress)
        ScrollView.addSubview(textFieldCountyORPefecture)
        ScrollView.addSubview(textFieldZoneORDistrict)
        ScrollView.addSubview(textFieldProvince)
        ScrollView.addSubview(textFieldZipCode)
        ScrollView.addSubview(textFieldChannelsCustomers)
        
        textFieldCustomerType.anchor(ScrollView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 45)
        
        textFieldCompanyName.anchor(textFieldCustomerType.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 45)
        
        textFieldAddress.anchor(textFieldCompanyName.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 45)
        
        textFieldCountyORPefecture.anchor(textFieldAddress.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 172.5, heightConstant: 45)
        
        textFieldZoneORDistrict.anchor(textFieldCountyORPefecture.topAnchor, left: textFieldCountyORPefecture.rightAnchor, bottom: textFieldCountyORPefecture.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        textFieldProvince.anchor(textFieldCountyORPefecture.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 172.5, heightConstant: 45)
        
        textFieldZipCode.anchor(textFieldProvince.topAnchor, left: textFieldProvince.rightAnchor, bottom: textFieldProvince.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        textFieldChannelsCustomers.anchor(textFieldZipCode.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 45)
        
        //Setting Element Coustomer Contract
        ScrollView.addSubview(viewContract)
        viewContract.addSubview(labelContract)
        viewContract.addSubview(labelContractmessage)
        viewContract.addSubview(textFieldContractName)
        viewContract.addSubview(textFieldContractPhone)
        viewContract.addSubview(textFieldContractEmail)
        viewContract.addSubview(textFieldContractIDLine)

        viewContract.anchor(textFieldChannelsCustomers.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelContract.anchor(viewContract.topAnchor, left: viewContract.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        labelContractmessage.anchor(labelContract.topAnchor, left: labelContract.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        textFieldContractName.anchor(labelContract.bottomAnchor, left: viewContract.leftAnchor, bottom: nil, right: viewContract.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 45)
        
        textFieldContractPhone.anchor(textFieldContractName.bottomAnchor, left: textFieldContractName.leftAnchor, bottom: nil, right: textFieldContractName.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 45)
        
        textFieldContractEmail.anchor(textFieldContractPhone.bottomAnchor, left: textFieldContractName.leftAnchor, bottom: nil, right: textFieldContractName.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 45)
        
        textFieldContractIDLine.anchor(textFieldContractEmail.bottomAnchor, left: textFieldContractName.leftAnchor, bottom: viewContract.bottomAnchor, right: textFieldContractName.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 45)// Bottom anchor viewContract
        
        //Setting Element Class Customer
        ScrollView.addSubview(viewClassCustomer)
        viewClassCustomer.addSubview(labelClassCustomer)
        viewClassCustomer.addSubview(buttonGrade_B)
        viewClassCustomer.addSubview(buttonGrade_A)
        viewClassCustomer.addSubview(buttonGrade_C)

        viewClassCustomer.anchor(viewContract.bottomAnchor, left: viewContract.leftAnchor, bottom: nil, right: viewContract.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
        labelClassCustomer.anchor(viewClassCustomer.topAnchor, left: viewClassCustomer.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        buttonGrade_B.anchorCenter(viewClassCustomer.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        buttonGrade_B.anchor(labelClassCustomer.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        buttonGrade_A.anchor(buttonGrade_B.topAnchor, left: nil, bottom: nil, right: buttonGrade_B.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 40, heightConstant: 40)
        
        buttonGrade_C.anchor(buttonGrade_B.topAnchor, left: buttonGrade_B.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        //Seting Element DropDown
        ScrollView.addSubview(DropDownCustomerType)
        ScrollView.addSubview(DropDownChannelsCustomers)
        
        DropDownCustomerType.anchor(textFieldCustomerType.topAnchor, left: textFieldCustomerType.leftAnchor, bottom: textFieldCustomerType.bottomAnchor, right: textFieldCustomerType.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        DropDownChannelsCustomers.anchor(textFieldChannelsCustomers.topAnchor, left: textFieldChannelsCustomers.leftAnchor, bottom: textFieldChannelsCustomers.bottomAnchor, right: textFieldChannelsCustomers.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        //Setting Element Button Submit
        ScrollView.addSubview(buttonSubmit)
        
        buttonSubmit.anchor(viewClassCustomer.bottomAnchor, left: viewClassCustomer.leftAnchor, bottom: ScrollView.bottomAnchor, right: viewClassCustomer.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 45)

        ScrollView.contentSize = viewClassCustomer.bounds.size
        
        
    }
    
    func EditCustomer(){
        
        let CompanyName = DataCustomerDetail["CustomerCompanyName"] as? String
        let CustomerType = DataCustomerDetail["CustomerType"] as? String
        let CompanyAddress = DataCustomerDetail["CustomerCompanyAddress"] as? String
        let ContactName = DataCustomerDetail["CustomerContactName"] as? String
        let ContactTel = DataCustomerDetail["CustomerContactTel"] as? String
        let ContactEmail = DataCustomerDetail["CustomerContactEmail"] as? String
        let ContactLine = DataCustomerDetail["CustomerContactLine"] as? String
        let Recommendedby = DataCustomerDetail["CustomerRecommendedby"] as? String
        let CustomerGrade = DataCustomerDetail["CustomerGrade"] as? String
        _ = DataCustomerDetail["TotalSales"] as? Double
        
        textFieldCustomerType.text = ConvertCustomerType(type: CustomerType!)
        DataCustomerType = CustomerType!
        
        textFieldCompanyName.text = CompanyName
        textFieldCompanyName.textColor = UIColor.BlackAlpha(alpha: 0.25)
        textFieldCompanyName.isEnabled = false
        
        let Address = CompanyAddress?.split(separator: "$")
        if Address!.count != 0{
              textFieldAddress.text = String(Address![0])
              textFieldCountyORPefecture.text = String(Address![1])
              textFieldZoneORDistrict.text = String(Address![2])
              textFieldProvince.text = String(Address![3])
              textFieldZipCode.text = String(Address![4])
        }
        
        textFieldChannelsCustomers.text = Recommendedby
        DataCustomerRecommendedby = Recommendedby!
        
        textFieldContractName.text = ContactName
        textFieldContractPhone.text = ContactTel
        textFieldContractEmail.text = ContactEmail
        textFieldContractIDLine.text = ContactLine
        
        DataCustomerGrade = CustomerGrade!
        switch CustomerGrade {
        case "A":
            buttonGrade_A.backgroundColor = .BlueDeep
            buttonGrade_A.setTitleColor(.white, for: .normal)
        case "B":
            buttonGrade_B.backgroundColor = .BlueDeep
            buttonGrade_B.setTitleColor(.white, for: .normal)
        case "C":
            buttonGrade_C.backgroundColor = .BlueDeep
            buttonGrade_C.setTitleColor(.white, for: .normal)
        default:
            print("CustomerGradeSelect")
        }
        
    }
    
    func RevertCustomerType(type : String) -> String{
        switch type {
        case "วิศวกร":
            return "Engineer"
        case "เจ้าของกิจการ":
            return "Owner"
        case "สถาปนิก":
            return "Architect"
        case "ผู้รับเหมา":
            return "Contractor"
        case "ลูกค้าทั่วไป":
            return "General"
        default:
            return type
        }
    }
    
    func ConvertCustomerType(type : String) -> String{
        switch type {
        case "Engineer":
            return "วิศวกร"
        case "Owner":
            return "เจ้าของกิจการ"
        case "Architect":
            return "สถาปนิก"
        case "Contractor":
            return "ผู้รับเหมา"
        case "General":
            return "ลูกค้าทั่วไป"
        default:
            return type
        }
    }
    
    @objc func CustomerGradeSelect(Button: UIButton){
        
        switch Button.tag {
        case 1:
            buttonGrade_A.backgroundColor = .BlueDeep
            buttonGrade_A.setTitleColor(.white, for: .normal)
            DataCustomerGrade = "A"

            buttonGrade_B.backgroundColor = .white
            buttonGrade_B.setTitleColor(.BlueDeep, for: .normal)
            buttonGrade_C.backgroundColor = .white
            buttonGrade_C.setTitleColor(.BlueDeep, for: .normal)
        case 2:
            buttonGrade_B.backgroundColor = .BlueDeep
            buttonGrade_B.setTitleColor(.white, for: .normal)
            DataCustomerGrade = "B"

            buttonGrade_A.backgroundColor = .white
            buttonGrade_A.setTitleColor(.BlueDeep, for: .normal)
            buttonGrade_C.backgroundColor = .white
            buttonGrade_C.setTitleColor(.BlueDeep, for: .normal)
        case 3:
            buttonGrade_C.backgroundColor = .BlueDeep
            buttonGrade_C.setTitleColor(.white, for: .normal)
            DataCustomerGrade = "C"

            buttonGrade_A.backgroundColor = .white
            buttonGrade_A.setTitleColor(.BlueDeep, for: .normal)
            buttonGrade_B.backgroundColor = .white
            buttonGrade_B.setTitleColor(.BlueDeep, for: .normal)
        default:
            print("CustomerGradeSelect")
        }

    }
    
    func DropDownEvent(){
        DropDownCustomerType.didSelect { (Text, index) in
            self.textFieldCustomerType.text = Text
            self.DataCustomerType = Text
            self.DropDownCustomerType.placeholder = ""
        }
        
        DropDownChannelsCustomers.didSelect { (Text, index) in
            self.textFieldChannelsCustomers.text = Text
            self.DataCustomerRecommendedby = Text
            self.DropDownChannelsCustomers.placeholder = ""
        }
                
    }
    
    @objc func handleSubmit(){
            
        let idCustomer = DataCustomerDetail["idCustomer"] as? Int
        let CompanyName = textFieldCompanyName.text
        let CompanyTel = ""
        let ContactName = textFieldContractName.text
        let ContactTel = textFieldContractPhone.text
        let ContactEmail = textFieldContractEmail.text
        let ContactLine = textFieldContractIDLine.text
        let Type = RevertCustomerType(type: DataCustomerType)
        let Grade = DataCustomerGrade
        let Recommendedby = DataCustomerRecommendedby
        let CustomerHidden = 0
        
        let CompanyAddress = textFieldAddress.text! + "$" + textFieldCountyORPefecture.text! + "$" + textFieldZoneORDistrict.text! + "$" + textFieldProvince.text! + "$" + textFieldZipCode.text! + "$"
        
        switch MoveViewController {
        case "Admin":
            
            AdminEditCustomer(token: tokenID!, idCustomer: idCustomer!, CompanyAddress: CompanyAddress, CompanyTel: CompanyTel, ContactName: ContactName!, ContactTel: ContactTel!, ContactEmail: ContactEmail!, ContactLine: ContactLine!, Type: Type, Grade: Grade, Recommendedby: Recommendedby, CustomerHidden: CustomerHidden)
            
        case "SaleEdit":
            
            SaleEditCustomer(token: tokenID!, idCustomer: idCustomer!, CompanyAddress: CompanyAddress, CompanyTel: CompanyTel, ContactName: ContactName!, ContactTel: ContactTel!, ContactEmail: ContactEmail!, ContactLine: ContactLine!, Type: Type, Grade: Grade, Recommendedby: Recommendedby, CustomerHidden: CustomerHidden)
            
        case "SaleAdd":

            SaleAddCustomer(token: tokenID!, CompanyName: CompanyName!, CompanyAddress: CompanyAddress, CompanyTel: CompanyTel, ContactName: ContactName!, ContactTel: ContactTel!, ContactEmail: ContactEmail!, ContactLine: ContactLine!, Type: Type, Grade: Grade, Recommendedby: Recommendedby, CustomerHidden: CustomerHidden)
            
        default:
            print("AddNewCustomerViewController Send Data to server Error")
        }
        
    }
    
    //Request Data from Server
    func SaleAddCustomer(token:String, CompanyName:String, CompanyAddress:String, CompanyTel:String, ContactName:String, ContactTel:String, ContactEmail:String, ContactLine:String, Type:String, Grade:String, Recommendedby:String, CustomerHidden:Int){
        
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_saleInsertCustomer()
        
        let parameter = ["CustomerCompanyName": CompanyName,
                         "CustomerCompanyAddress": CompanyAddress,
                         "CustomerCompanyTel": CompanyTel,
                         "CustomerContactName": ContactName,
                         "CustomerContactTel": ContactTel,
                         "CustomerContactEmail": ContactEmail,
                         "CustomerContactLine": ContactLine,
                         "CustomerType": Type,
                         "CustomerGrade": Grade,
                         "CustomerRecommendedby": Recommendedby,
                         "CustomerHidden": String(CustomerHidden)]
        
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    NotificationCenter.default.post(name: NSNotification.Name("DataCustomerUpdate"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                    // Close loader
                    self.Show_Loader()
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func AdminEditCustomer(token:String, idCustomer:Int, CompanyAddress:String, CompanyTel:String, ContactName:String, ContactTel:String, ContactEmail:String, ContactLine:String, Type:String, Grade:String, Recommendedby:String, CustomerHidden:Int){
        
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminEditCustomer()
        
        let parameter = ["idCustomer": String(idCustomer),
                         "CustomerCompanyAddress": CompanyAddress,
                         "CustomerCompanyTel": CompanyTel,
                         "CustomerContactName": ContactName,
                         "CustomerContactTel": ContactTel,
                         "CustomerContactEmail": ContactEmail,
                         "CustomerContactLine": ContactLine,
                         "CustomerType": Type,
                         "CustomerGrade": Grade,
                         "CustomerRecommendedby": Recommendedby,
                         "CustomerHidden": String(CustomerHidden)]
        
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    NotificationCenter.default.post(name: NSNotification.Name("DataCustomerUpdate"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                    // Close loader
                    self.Show_Loader()
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func SaleEditCustomer(token:String, idCustomer:Int, CompanyAddress:String, CompanyTel:String, ContactName:String, ContactTel:String, ContactEmail:String, ContactLine:String, Type:String, Grade:String, Recommendedby:String, CustomerHidden:Int){
        
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_saleEditCustomer()
        
        let parameter = ["idCustomer": String(idCustomer),
                         "CustomerCompanyAddress": CompanyAddress,
                         "CustomerCompanyTel": CompanyTel,
                         "CustomerContactName": ContactName,
                         "CustomerContactTel": ContactTel,
                         "CustomerContactEmail": ContactEmail,
                         "CustomerContactLine": ContactLine,
                         "CustomerType": Type,
                         "CustomerGrade": Grade,
                         "CustomerRecommendedby": Recommendedby,
                         "CustomerHidden": String(CustomerHidden)]
        
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    NotificationCenter.default.post(name: NSNotification.Name("DataCustomerUpdate"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                    // Close loader
                    self.Show_Loader()
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
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
