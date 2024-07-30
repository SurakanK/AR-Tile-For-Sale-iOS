//
//  CompanyAddressViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 20/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class CompanyAddressViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    let tokenID = LoginPageController.DataLogin?.Token_Id

    weak var tableView : UITableView?

    private var CellID = "cell"
    private var HeaderID = "Header"
    
    var TextStreet : String = ""
    var TextZipcode : String = ""
    var TextCity : String = ""
    var TextSub : String = ""
    var TextRoad : String = ""
    
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
                
        // ConfigNavigation Bar
        navigationItem.title = "Company Address"
        navigationController?.navigationBar.barTintColor = .BlueLight
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 20)]
        
        let ConfirmNavigationButton = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(ConfirmButton))
        navigationItem.rightBarButtonItem = ConfirmNavigationButton
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        
        // ConfigRegister Tableview cell,header,footer
        let table =  UITableView(frame: .zero, style: .grouped)
        tableView = table
        tableView!.rowHeight = UITableView.automaticDimension
        tableView!.separatorStyle = .none
        tableView!.delegate = self
        tableView!.dataSource = self
        
        //set layout viewController
        view.addSubview(tableView!)
        tableView!.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // ConfigRegister Tableview cell,header,footer
        tableView!.tableFooterView = UIView()
        tableView!.register(CompanyTableViewCell.self, forCellReuseIdentifier: CellID)
        tableView!.register(CompanyHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderID)

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.delegate = self as? UIGestureRecognizerDelegate
        tableView?.addGestureRecognizer(tapRecognizer)
        
        // manage Data to textfield
        let addressfull = CompanyInfromationController.address
        let addressArr = addressfull.split(separator: "$")
        
        if addressArr.count > 1{
            TextStreet = String(addressArr[0])
            TextRoad = String(addressArr[1])
            TextSub = String(addressArr[2])
            TextCity = String(addressArr[3])
            TextZipcode = String(addressArr[4])
        }else{
            TextStreet = ""
            TextRoad = ""
            TextSub = ""
            TextCity = ""
            TextZipcode = ""
        }
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
    }
    
       
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! CompanyTableViewCell
    
        cell.textField.isHidden = false
        
        var placeholder : String = ""
        switch indexPath.section {
        case 0:
            placeholder = "street and No"
            cell.textField.text = TextStreet
        case 1:
            placeholder = "lane / road"
            cell.textField.text = TextRoad
        case 2:
            placeholder = "sub-district / sub-area"
            cell.textField.text = TextSub
        case 3:
            placeholder = "city"
            cell.textField.text = TextCity
        case 4:
            placeholder = "zip code"
            cell.textField.text = TextZipcode
            cell.textField.keyboardType = .numberPad
        default:break
        }
        
        cell.textField.placeholder = placeholder
        cell.textClearButton.addTarget(self, action: #selector(TextClearButton), for: .touchUpInside)
        cell.textField.addTarget(self, action: #selector(TextFieldChange), for: .editingChanged)
        cell.textField.addTarget(self, action: #selector(TextFieldDidEnd), for: .editingDidEnd)
        cell.textField.addTarget(self, action: #selector(TextFieldDidBegin), for: .editingDidBegin)
        cell.textField.addTarget(self, action: #selector(TextFieldCheck), for: .editingChanged)        
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderID) as! CompanyHeaderViewCell
        
        switch section {
        case 0:
            header.HeaderTextLabel.text = "Street / No"
        case 1:
            header.HeaderTextLabel.text = "Lane / Road"
        case 2:
            header.HeaderTextLabel.text = "Sub-district / Sub-area"
        case 3:
            header.HeaderTextLabel.text = "City"
        case 4:
            header.HeaderTextLabel.text = "Zip code"
        default:break
        }
        
        return header
    }
    
    @objc func TextClearButton(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        clearButton(IndexPhath: indexPath!)
        
    }
    
    @objc func TextFieldChange(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        
        switch indexPath?.section {
        case 0:
            TextStreet = textfieldChange(IndexPhath: indexPath!)
        case 1:
            TextRoad = textfieldChange(IndexPhath: indexPath!)
        case 2:
            TextSub = textfieldChange(IndexPhath: indexPath!)
        case 3:
            TextCity = textfieldChange(IndexPhath: indexPath!)
        case 4:
            TextZipcode = textfieldChange(IndexPhath: indexPath!)
        default:break
        }
        
    }
    
    @objc func TextFieldDidEnd(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        
        switch indexPath?.section {
        case 0:
            TextStreet = textfieldDidEnd(IndexPhath: indexPath!)
        case 1:
            TextRoad = textfieldDidEnd(IndexPhath: indexPath!)
        case 2:
            TextSub = textfieldDidEnd(IndexPhath: indexPath!)
        case 3:
            TextCity = textfieldDidEnd(IndexPhath: indexPath!)
        case 4:
            TextZipcode = textfieldDidEnd(IndexPhath: indexPath!)
        default:break
        }
        
    }
    
    @objc func TextFieldDidBegin(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        
        textfieldDidBegin(IndexPhath: indexPath!)
        
    }
    
    @objc func TextFieldCheck(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        
        guard (tableView!.cellForRow(at: indexPath!) != nil) else { return }

        let cell = self.tableView!.cellForRow(at: indexPath!) as! CompanyTableViewCell
        let IndexText = cell.textField.text?.count
        
        if IndexText! > 0 {
            if TextStreet != "" && TextRoad != "" && TextSub != "" && TextCity != "" && TextZipcode != "" {
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }else{
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func textfieldChange(IndexPhath: IndexPath) -> String{
       
        guard (tableView!.cellForRow(at: IndexPhath) != nil) else {
            
            var text = String()
            switch IndexPhath.section {
            case 0:
                text = TextStreet
            case 1:
                text = TextRoad
            case 2:
                text = TextSub
            case 3:
                text = TextCity
            case 4:
                text = TextZipcode
            default:break
            }
            
            return text
            
        }

        let cell = self.tableView!.cellForRow(at: IndexPhath) as! CompanyTableViewCell
        let IndexText = cell.textField.text?.count
        
        if IndexText! > 0 {
            cell.textClearButton.isHidden = false
        }else{
            cell.textClearButton.isHidden = true
        }
        
        let text = cell.textField.text
        return text!
    }
    
    func textfieldDidEnd(IndexPhath: IndexPath) -> String{
        
        guard (tableView!.cellForRow(at: IndexPhath) != nil) else {
            
            var text = String()
            switch IndexPhath.section {
            case 0:
                text = TextStreet
            case 1:
                text = TextRoad
            case 2:
                text = TextSub
            case 3:
                text = TextCity
            case 4:
                text = TextZipcode
            default:break
            }
            
            return text
        }
        
        let cell = self.tableView!.cellForRow(at: IndexPhath) as! CompanyTableViewCell
        cell.textClearButton.isHidden = true
        
        let text = cell.textField.text
        return text!
    }
    
    func textfieldDidBegin(IndexPhath: IndexPath){
        
        guard (tableView!.cellForRow(at: IndexPhath) != nil) else { return }

        let cell = self.tableView!.cellForRow(at: IndexPhath) as! CompanyTableViewCell
        let IndexText = cell.textField.text?.count
        
        if IndexText! > 0 {
            cell.textClearButton.isHidden = false
        }else{
            cell.textClearButton.isHidden = true
        }
    }
    
    func clearButton(IndexPhath: IndexPath){
        let cell = self.tableView!.cellForRow(at: IndexPhath) as! CompanyTableViewCell

        cell.textField.text = ""
        cell.textClearButton.isHidden = true
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func ConfirmButton(){
        
        let data = CompanyInfromationController.self.CompanyData[0]
        let address = TextStreet + "$" + TextRoad + "$" + TextSub + "$" + TextCity + "$" + TextZipcode
        print(address)
        
        editCompanySetting(token: tokenID!, name: data["CompanyName"]!, tel: data["CompanyTel"]!, fax: data["CompanyFax"]!, address: address, email: data["CompanyEmail"]!, website: data["CompanyWebsite"]!, Image: data["CompanyImage"]!)
    }
    
    func Create_AlertMessage(Title : String!, Message : String!){
           let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           
           // Set Attribute Alert
           alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
           alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
           
           self.present(alert, animated: true, completion: nil)
    }
    
    func editCompanySetting(token:String,name:String,tel:String,
                       fax:String,address:String,email:String,
                       website:String,Image:String){

        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_EditAccountSetting()
        
        let parameter = ["Name":name,"Tel":tel,"Fax":fax,
                         "Address":address,"Email":email,"Website":website, "Image":Image]
        
        AF.request(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                print(value)
                
                let JSON = value as? [String : Any]
                if JSON!["results"] != nil{
    
                    // Close loader
                    self.Show_Loader()
                    
                    self.navigationController?.popViewController(animated: true)
                }

                print(value)
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
