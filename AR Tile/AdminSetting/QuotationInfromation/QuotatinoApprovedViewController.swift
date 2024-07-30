//
//  QuotatinoApprovedViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 5/4/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class QuotatinoApprovedViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
       
    weak var tableView : UITableView?

    private var CellID = "cell"
    private var HeaderID = "Header"
    
    private var Approveby = ""
    
    static var SwitchApproved: Bool = false

    let tokenID = LoginPageController.DataLogin?.Token_Id

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
        navigationItem.title = "Approved"
        navigationController?.navigationBar.barTintColor = .BlueLight
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 20)]
        
        let ConfirmNavigationButton = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(ConfirmButton))
        navigationItem.rightBarButtonItem = ConfirmNavigationButton
        
        // ConfigRegister Tableview cell,header,footer
        let table =  UITableView(frame: .zero, style: .grouped)
        tableView = table
        tableView!.delegate = self
        tableView!.dataSource = self
               
               
        //set layout viewController
        view.addSubview(tableView!)
        tableView!.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
               
        // ConfigRegister Tableview cell,header,footer
        tableView!.tableFooterView = UIView()
        tableView!.register(QuotationApprovedViewCell.self, forCellReuseIdentifier: CellID)
        tableView!.register(QuotationHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderID)
       
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
        let Data = QuotationInfromationController.QuotationData[0]
        Approveby = Data["Approveby"] as! String
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView?.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if QuotatinoApprovedViewController.SwitchApproved == true{
            return 1
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            return 50
        }else{
            return 300
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! QuotationApprovedViewCell
       
        cell.selectionStyle = .none
        cell.SwitchUI.isHidden = true
        cell.titleTextLabel.isHidden = true
        cell.titleTextLabel.isHidden = true
        cell.namefield.isHidden = true
        cell.nametitle.isHidden = true
        cell.textClearButton.isHidden = true
        cell.imageAutograph.isHidden = true
        cell.autographButton.isHidden = true
        
        if indexPath.section == 0{
            
            cell.titleTextLabel.isHidden = false
            cell.SwitchUI.isHidden = false
        
            cell.titleTextLabel.text = "Approved By Sale"
            cell.SwitchUI.isOn = QuotatinoApprovedViewController.SwitchApproved
            cell.SwitchUI.addTarget(self, action: #selector(RemarkSwitchValueChanged), for: .valueChanged)
            
        }else if indexPath.section == 1{
            
            cell.titleTextLabel.isHidden = false
            cell.namefield.isHidden = false
            cell.nametitle.isHidden = false
            cell.imageAutograph.isHidden = false
            cell.autographButton.isHidden = false

            cell.titleTextLabel.text = "Approved By"
            
            cell.namefield.text = Approveby

            cell.imageAutograph.image = QuotationInfromationController.imageSignature

            cell.autographButton.addTarget(self, action: #selector(autographhandleButton), for: .touchUpInside)
            cell.textClearButton.addTarget(self, action: #selector(textClearhandleButton), for: .touchUpInside)
            cell.namefield.addTarget(self, action: #selector(textfieldChange), for: .editingChanged)
            cell.namefield.addTarget(self, action: #selector(textfieldDidEnd), for: .editingDidEnd)
            cell.namefield.addTarget(self, action: #selector(textfieldDidBegin), for: .editingDidBegin)
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 50
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderID) as! QuotationHeaderViewCell
        if section == 0{
            header.HeaderTextLabel.text = "Approved By"
        }
        return header
    }
    
    @objc func RemarkSwitchValueChanged(sender: AnyObject){
        let cell: QuotationApprovedViewCell = self.tableView!.cellForRow(at: IndexPath(row: 0, section: 0)) as! QuotationApprovedViewCell
        
        let view = QuotatinoApprovedViewController.self
    
        view.SwitchApproved = cell.SwitchUI.isOn
        tableView?.reloadData()
        
    }
    
    @objc func autographhandleButton(){
        let AutographController = QuotationAutographViewController()
        navigationController?.pushViewController(AutographController, animated: false)
    }
    
    @objc func textClearhandleButton(){
        let index = IndexPath(row: 0, section: 1)
        let cell: QuotationApprovedViewCell = self.tableView!.cellForRow(at: index) as! QuotationApprovedViewCell
        
        cell.namefield.text = ""
        Approveby = ""
        
        cell.textClearButton.isHidden = true
        
    }
    
    @objc func textfieldChange(){
        let index = IndexPath(row: 0, section: 1)
        let cell: QuotationApprovedViewCell = self.tableView!.cellForRow(at: index) as! QuotationApprovedViewCell
        
        let IndexText = cell.namefield.text?.count
        
        Approveby = cell.namefield.text!
        
        if IndexText! > 0 {
            cell.textClearButton.isHidden = false
        }else{
            cell.textClearButton.isHidden = true
        }
    }
    
    @objc func textfieldDidEnd(){
        let index = IndexPath(row: 0, section: 1)
        let cell: QuotationApprovedViewCell = self.tableView!.cellForRow(at: index) as! QuotationApprovedViewCell
         cell.textClearButton.isHidden = true
     }
     
    @objc func textfieldDidBegin(){
         let index = IndexPath(row: 0, section: 1)
         let cell: QuotationApprovedViewCell = self.tableView!.cellForRow(at: index) as! QuotationApprovedViewCell
         
         let IndexText = cell.namefield.text?.count
         
         if IndexText! > 0 {
             cell.textClearButton.isHidden = false
         }else{
             cell.textClearButton.isHidden = true
         }
    }
    
    @objc func ConfirmButton(){
        
        let cell2: QuotationApprovedViewCell = self.tableView!.cellForRow(at: IndexPath(row: 0, section: 0)) as! QuotationApprovedViewCell
        
        if cell2.SwitchUI.isOn == true{
            Approveby = ""
            QuotationInfromationController.imageSignature = UIImage(color: .white, size: CGSize(width: 1, height: 1))!
        }else{
            if Approveby == ""{
                QuotationInfromationController.imageSignature = UIImage(color: .white, size: CGSize(width: 1, height: 1))!
            }
        }
                
        UploadimageSignature(token: tokenID!, image: QuotationInfromationController.imageSignature)
                    
    }
    
    func editQuotationSetting(token:String, ShowLogo:String, RemarkHeader:String, TaxID:String, vat:String,
                              RemarkBottom:String, Approveby:String, ApprovebySign:String){
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminEditAccountQuotation()
        
        let parameter = ["ShowLogo":ShowLogo, "RemarkHeader":RemarkHeader, "TaxID":TaxID, "vat":vat, "RemarkBottom":RemarkBottom, "Approveby":Approveby, "ApprovebySign":ApprovebySign]
     
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
    
    func UploadimageSignature(token:String ,image:UIImage){
        
        // Show Loader
        Show_Loader()
        
        var image = image
        if image.size.width == 0{
            image = UIImage(color: .white, size: CGSize(width: 1, height: 1))!
        }
        
        let base64Image = image.toBase64()
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let parameter = ["path":"accountsetting/approveSign.jpg","bucket":"arforsalesfullimage","image":base64Image]
        let Url = DataSource.Url_ImageUploadImage()
        
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
                
                switch response.result{
                case .success(let value):
                    print(value)
                    
                    let JSON = value as? [String : Any]
                    
                    if JSON!["Key"] != nil{
                        
                        let ApprovebySign = JSON!["Key"] as? String
                        
                        let data = QuotationInfromationController.QuotationData[0]
                        self.editQuotationSetting(token: self.tokenID!, ShowLogo: String(data["ShowLogo"] as! Int), RemarkHeader: data["RemarkHeader"] as! String, TaxID: data["TaxID"] as! String, vat: String(data["vat"] as! Int), RemarkBottom: data["RemarkBottom"] as! String, Approveby: self.Approveby, ApprovebySign: ApprovebySign!)
                    }
        
                case .failure(_):
                    
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

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
}


