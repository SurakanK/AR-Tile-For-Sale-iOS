//
//  CompanyNameViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 20/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class CompanyNameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    let tokenID = LoginPageController.DataLogin?.Token_Id

    weak var tableView : UITableView?
    
    private var CellID = "cell"
    private var HeaderID = "Header"
    
    var TextCompanyName : String = ""
    
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
        navigationItem.title = "Company Name"
        navigationController?.navigationBar.barTintColor = .BlueLight
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 20)]
        
        let ConfirmNavigationButton = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(ConfirmButton))
        navigationItem.rightBarButtonItem = ConfirmNavigationButton
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // ConfigRegister Tableview cell,header
        let table =  UITableView(frame: .zero, style: .grouped)
        tableView = table
        tableView!.separatorStyle = .none
        tableView!.delegate = self
        tableView!.dataSource = self
        
        //set layout viewController
        view.addSubview(tableView!)
        tableView!.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
        // ConfigRegister Tableview cell,header
        tableView!.tableFooterView = UIView()
        tableView!.register(CompanyTableViewCell.self, forCellReuseIdentifier: CellID)
        tableView!.register(CompanyHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderID)
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
        // manage Data to textfield
        if CompanyInfromationController.self.CompanyData.count > 0{
            let data = CompanyInfromationController.self.CompanyData
            TextCompanyName = data[0]["CompanyName"]!
        }else{
            TextCompanyName = ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! CompanyTableViewCell
    
        cell.textField.isHidden = false
        cell.textField.text = TextCompanyName
        cell.textClearButton.addTarget(self, action: #selector(textClearhandleButton), for: .touchUpInside)
        cell.textField.addTarget(self, action: #selector(textfieldChange), for: .editingChanged)
        cell.textField.addTarget(self, action: #selector(textfieldDidEnd), for: .editingDidEnd)
        cell.textField.addTarget(self, action: #selector(textfieldDidBegin), for: .editingDidBegin)
        cell.textField.placeholder = "Company Name"
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
        header.HeaderTextLabel.text = "Name"
        return header
    }
    
    @objc func textClearhandleButton(){
        let index = IndexPath(row: 0, section: 0)
        let cell: CompanyTableViewCell = self.tableView!.cellForRow(at: index) as! CompanyTableViewCell
        
        cell.textField.text = ""
        cell.textClearButton.isHidden = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func textfieldChange(){
        let index = IndexPath(row: 0, section: 0)
        let cell: CompanyTableViewCell = self.tableView!.cellForRow(at: index) as! CompanyTableViewCell
        
        let IndexText = cell.textField.text?.count
        
        if IndexText! > 0 {
            navigationItem.rightBarButtonItem?.isEnabled = true
            cell.textClearButton.isHidden = false
        }else{
            navigationItem.rightBarButtonItem?.isEnabled = false
            cell.textClearButton.isHidden = true
        }
    }
    
    @objc func textfieldDidEnd(){
         let index = IndexPath(row: 0, section: 0)
        let cell: CompanyTableViewCell = self.tableView!.cellForRow(at: index) as! CompanyTableViewCell
         cell.textClearButton.isHidden = true
     }
     
    @objc func textfieldDidBegin(){
         let index = IndexPath(row: 0, section: 0)
        let cell: CompanyTableViewCell = self.tableView!.cellForRow(at: index) as! CompanyTableViewCell
         
         let IndexText = cell.textField.text?.count
         
         if IndexText! > 0 {
             cell.textClearButton.isHidden = false
         }else{
             cell.textClearButton.isHidden = true
         }
    }
    
    @objc func ConfirmButton(){
        let cell: CompanyTableViewCell = self.tableView!.cellForRow(at: IndexPath(row: 0, section: 0)) as! CompanyTableViewCell
        
        TextCompanyName = cell.textField.text!
        
        let data = CompanyInfromationController.self.CompanyData[0]
           
        editCompanySetting(token: tokenID!, name: TextCompanyName, tel: data["CompanyTel"]!, fax: data["CompanyFax"]!, address: data["CompanyAddress"]!, email: data["CompanyEmail"]!, website: data["CompanyWebsite"]!, Image:data["CompanyImage"]!)
  
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
                
                let JSON = value as? [String : Any]
                if JSON!["results"] != nil{
    
                    // Close loader
                    self.Show_Loader()
                    
                    self.navigationController?.popViewController(animated: true)
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
