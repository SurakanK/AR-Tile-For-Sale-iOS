//
//  CompanyInfromationController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 19/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class CompanyInfromationController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    let tokenID = LoginPageController.DataLogin?.Token_Id

    weak var tableView : UITableView?

    private var CellID = "cell"
    private var HeaderID = "Header"
    private var FooterID = "Footer"
    
    static var name = ""
    static var address = ""
    static var phoneandfax = ""
    static var emailandwebsite = ""
    
    static var CompanyData = [[String : String]]()

    private var imageLogo = UIImage()
    
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
        navigationItem.title = "Company Information"
        navigationController?.navigationBar.barTintColor = .BlueLight
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 20)]
        
        // ConfigRegister Tableview cell,header,footer
        let table =  UITableView(frame: .zero, style: .grouped)
        tableView = table
        tableView!.rowHeight = UITableView.automaticDimension
        tableView!.delegate = self
        tableView!.dataSource = self
        
        
        //set layout viewController
        view.addSubview(tableView!)
        tableView!.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // ConfigRegister Tableview cell,header,footer
        tableView!.tableFooterView = UIView()
        tableView!.register(CompanyTableViewCell.self, forCellReuseIdentifier: CellID)
        tableView!.register(CompanyHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderID)
        tableView!.register(CompanyfooterViewCell.self, forHeaderFooterViewReuseIdentifier: FooterID)
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCompanySetting(token: tokenID!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 2
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! CompanyTableViewCell
        
        if indexPath.section == 0
        {
            if indexPath.row == 0{
                cell.viewimageLogoCompany.isHidden = false
                cell.imageLogoCompany.isHidden = false
                cell.CameraButton.isHidden = false
                cell.backgroundColor = UIColor.rgb(red: 88, green: 148, blue: 156)
                cell.CameraButton.addTarget(self, action: #selector(CamerahandleButton), for: .touchUpInside)
                
                print(imageLogo.size)
                
                if imageLogo.size.width > 0{
                    cell.imageLogoCompany.image = imageLogo
                }
                
            }
            
        }else if indexPath.section == 1{
                
                cell.titleTextLabel.isHidden = false
                cell.headTextLable.isHidden = false
                cell.imageNext.isHidden = false

                cell.titleTextLabel.textColor = UIColor.BlackAlpha(alpha: 0.5)
                
                if indexPath.row == 0{
                    cell.headTextLable.text = "company Name"
                    cell.titleTextLabel.text = CompanyInfromationController.name
        
                }else if indexPath.row == 1{
                    cell.headTextLable.text = "company address"
                    
                    let addressfull = CompanyInfromationController.address
                    let addressArr = addressfull.split(separator: "$")
                    var address = String()
                    
                    for i in 0..<addressArr.count {
                        address = address + addressArr[i] + " "
                    }
                    
                    cell.titleTextLabel.text = address
                    
                }
            
        }else if indexPath.section == 2{
            
                cell.titleTextLabel.isHidden = false
                cell.headTextLable.isHidden = false
                cell.imageNext.isHidden = false

                cell.titleTextLabel.textColor = UIColor.BlackAlpha(alpha: 0.5)
            
            if indexPath.row == 0{
                    cell.headTextLable.text = "Phone and fax number"
                    cell.titleTextLabel.text = CompanyInfromationController.phoneandfax
        
                }else if indexPath.row == 1{
                    cell.headTextLable.text = "Email and Website"
                    cell.titleTextLabel.text = CompanyInfromationController.emailandwebsite
                }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1{
            if indexPath.row == 0{
                let CompanyNameController = CompanyNameViewController()
                navigationController?.pushViewController(CompanyNameController, animated: true)
                
            }else if indexPath.row == 1{
                let CompanyAddressController = CompanyAddressViewController()
                navigationController?.pushViewController(CompanyAddressController, animated: true)
                
            }
            
        }else if indexPath.section == 2{
           
            if indexPath.row == 0{
                let PhoneNumberController = PhoneandFaxNumberViewController()
                navigationController?.pushViewController(PhoneNumberController, animated: true)
                
            }else if indexPath.row == 1{
                let EmailAddressController = EmailandWebsiteViewController()
                navigationController?.pushViewController(EmailAddressController, animated: true)
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0{
            return 240
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 0
        }else{
            return 50
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 30
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderID) as! CompanyHeaderViewCell
        
        if section == 0 {
            header.HeaderTextLabel.text = ""
        }else if section == 1{
            header.HeaderTextLabel.text = "Company"
        }else{
            header.HeaderTextLabel.text = "Contact"
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let  footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterID) as! CompanyfooterViewCell
        
        if section == 0 {
            footer.FooterTextLabel.text = "import company logo to use in the quotation"
        }else{
            footer.FooterTextLabel.text = ""
        }
        
         return footer
    }
    
    @objc func CamerahandleButton(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source your company logo", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in }))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let cell: CompanyTableViewCell = self.tableView!.cellForRow(at: IndexPath(row: 0, section: 0)) as! CompanyTableViewCell
        
        var image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //Image Resize
        if image.size.width > CGFloat(1000) || image.size.height > CGFloat(1000){
            image = image.resizeImage(targetSize: CGSize(width: 300, height: 300))
        }
        
        cell.imageLogoCompany.image = image
        
        UploadimageCompanylogo(token: tokenID!, image: image)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getCompanySetting(token:String){
        
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]

        let Url = DataSource.Url_GetAccountSetting()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                let JSON = value as? [String : Any]

                let view = CompanyInfromationController.self
                
                if JSON!["results"] != nil{
                   
                    view.self.CompanyData = JSON!["results"] as! [[String : String]]
            
                    if view.self.CompanyData[0]["CompanyName"]! != ""{
                        view.self.name = view.self.CompanyData[0]["CompanyName"]!
                    }else{
                        view.self.name = "Not set up"
                    }
                    
                    if view.self.CompanyData[0]["CompanyAddress"]! != ""{
                        view.self.address = view.self.CompanyData[0]["CompanyAddress"]!
                    }else{
                        view.self.address = "Not set up"
                    }
                    
                    if view.self.CompanyData[0]["CompanyTel"]! != "" || view.self.CompanyData[0]["CompanyFax"]! != ""{
                        let CompanyTel = view.self.CompanyData[0]["CompanyTel"]!
                        let CompanyFax = view.self.CompanyData[0]["CompanyFax"]!
                        view.self.phoneandfax = "Phone : " + CompanyTel + " Fax : " + CompanyFax
                        
                    }else{
                        view.self.phoneandfax = "Not set up"
                    }
                    
                    if view.self.CompanyData[0]["CompanyEmail"]! != "" || view.self.CompanyData[0]["CompanyWebsite"]! != ""{
                        let CompanyEmail = view.self.CompanyData[0]["CompanyEmail"]!
                        let CompanyWebsite = view.self.CompanyData[0]["CompanyWebsite"]!
                        view.self.emailandwebsite = "Email : " + CompanyEmail + " Website : " + CompanyWebsite
                        
                    }else{
                        view.self.emailandwebsite = "Not set up"
                    }
                    
                    self.DownloadimageLogo(token: self.tokenID!, path:view.self.CompanyData[0]["CompanyImage"]!)

                }
                
                self.tableView?.reloadData()
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func UploadimageCompanylogo(token:String ,image:UIImage){
              
        // Show Loader
        Show_Loader()
        
        var image = image
        if image.size.width == 0{
            image = UIImage(color: .white, size: CGSize(width: 1, height: 1))!
        }
        
        let base64Image = image.toBase64()
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let parameter = ["path":"accountsetting/logo.jpg","bucket":"arforsalesfullimage","image":base64Image]
        let Url = DataSource.Url_ImageUploadImage()
        
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
                
                switch response.result{
                case .success(let value):
                    print(value)
                    
                    let JSON = value as? [String : Any]
                    
                    if JSON!["Key"] != nil{
                        
                        let path = JSON!["Key"] as! String
                                         
                        let view = CompanyInfromationController.self

                        self.editCompanySetting(token: self.tokenID!,
                                            name: view.self.CompanyData[0]["CompanyName"]!,
                                            tel: view.self.CompanyData[0]["CompanyTel"]!,
                                            fax: view.self.CompanyData[0]["CompanyFax"]!,
                                            address: view.self.CompanyData[0]["CompanyAddress"]!,
                                            email: view.self.CompanyData[0]["CompanyEmail"]!,
                                            website: view.self.CompanyData[0]["CompanyWebsite"]!,
                                            Image:path)
                    }
        
                case .failure(_):
                    
                    break
                }
            })
    }
    
    func DownloadimageLogo(token:String , path:String){
        
        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let parameter = ["bucket":"arforsalesfullimage", "path": path]
        let Url = DataSource.Url_DownloadImage()
        
        AF.download(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value) :
                if let json = value as? [String : Any] {
                    
                    let Body = json["Body"] as? [String : Any]
                    
                    guard Body != nil else {
                        //Close loader
                        self.Show_Loader()
                        return
                    }
                    
                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let datos: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
                    
                    self.imageLogo = UIImage(data: datos as Data)!
                                        
                    self.tableView?.reloadData()
                    
                    //Close loader
                    self.Show_Loader()

                }
            case .failure(_):
                break
                
            }
        }
        
        
    }
    
    func editCompanySetting(token:String,name:String,tel:String,
                       fax:String,address:String,email:String,
                       website:String,Image:String){
        
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
