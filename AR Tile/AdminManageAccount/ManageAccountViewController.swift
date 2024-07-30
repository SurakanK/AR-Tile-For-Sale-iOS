//
//  ManageAccountViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 24/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ManageAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tokenID = LoginPageController.DataLogin?.Token_Id

    var indexfinish = 0
    var indexDelImageFinish = 0
    
    weak var tableView : UITableView?
    
    var ImageAccrount = [UIImage()]
    var ImageSegnature = [UIImage()]
    var SalesData = [[String:String]]()
    
    static var SaleAccount = [String]()
    static var Sales = [String:String]()
    
    private var CellID = "Cell"
    
    // add title index number of account
    let titleIndexProduct: UILabel = {
        let label = UILabel()
        label.text = "product"
        label.textColor = .lightGray
        label.font = UIFont.MitrLight(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
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
         
        
        // ConfigViewController
        view.backgroundColor = UIColor.rgb(red: 237, green: 237, blue: 237)
        
        // ConfigNavigation Bar
        navigationItem.title = "Mange Account"
        //navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
        
        let ConfirmNavigationButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddAccountSale))
        navigationItem.rightBarButtonItem = ConfirmNavigationButton
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        // ConfigRegister Tableview cell,header,footer
        let table =  UITableView(frame: .zero, style: .grouped)
        tableView = table
        tableView!.tableFooterView = UIView()
        tableView!.rowHeight = UITableView.automaticDimension
        tableView!.backgroundColor = UIColor.rgb(red: 237, green: 237, blue: 237)
        tableView!.separatorStyle = .none
        tableView!.delegate = self
        tableView!.dataSource = self
            
        tableView!.register(ManageAccountViewCell.self, forCellReuseIdentifier: CellID)
               
        //set layout viewController
        view.addSubview(titleIndexProduct)
        view.addSubview(tableView!)
        
        titleIndexProduct.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        tableView!.anchor(titleIndexProduct.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        //Set anchor Animation Load
        AnimationViewLoadAnchor()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Request data from server
        self.getSales(token: tokenID!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        //print title lable index product
        let maxAccount = LoginPageController.DataLogin?.SaleMax
        titleIndexProduct.text =  "Account " + String(SalesData.count) + " in " + maxAccount!
        
        return SalesData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! ManageAccountViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.rgb(red: 237, green: 237, blue: 237)
        
        cell.SaleName.text! = "ชื่อ-สกุล : " + SalesData[indexPath.row]["SalesFullname"]!
        cell.SalePhoneNumber.text = "เบอร์โทรศัพ : " + SalesData[indexPath.row]["SalesTel"]!
        cell.SaleEmail.text = "Email : " + SalesData[indexPath.row]["SalesEmail"]!
        cell.SaleEmployeeID.text = "รหัสพนักงาน : " + SalesData[indexPath.row]["SalesEmployeeID"]!
        cell.SaleAccountID.text = "ชื่อผู้ใช้ : " + SalesData[indexPath.row]["SalesUsername"]!
        cell.SaleAccountPassword.text = "รหัสผ่าน : ######"
        cell.imageSaleAccont.image = ImageAccrount[indexPath.row]
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           
        let delete = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
                        
            
            let alert = UIAlertController(title: "Delete", message: "Do You Want to Delete This sale?.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
                
                let username = self.SalesData[indexPath.row]["SalesUsername"]
                let pathimageAccrount = self.SalesData[indexPath.row]["SalesImage"]
                let pathimageSegnature = self.SalesData[indexPath.row]["SalesSignImage"]

                self.delsales(token: self.tokenID!, username: username!, pathimageAccrount: pathimageAccrount!, pathimageSegnature: pathimageSegnature!)
                
                tableView.setEditing(false, animated: true)
                self.SalesData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            completionHandler(true)
        }
           
        let edit = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
                    
            let actionSheet = UIAlertController(title: "Edit Sale", message: "edit personal information or reset password.", preferredStyle: .actionSheet)
                    
            actionSheet.addAction(UIAlertAction(title: "Edit Account", style: .default, handler: { (action: UIAlertAction) in
                
                ManageAccountViewController.Sales = self.SalesData[indexPath.row]
                
                let EditSaleController = ManageEditSaleViewController()
                self.navigationController?.pushViewController(EditSaleController, animated: true)
                        
            }))
                    
            actionSheet.addAction(UIAlertAction(title: "Reset Password", style: .destructive, handler: { (action: UIAlertAction) in
                
                    let username = self.SalesData[indexPath.row]["SalesUsername"]
                    let alert = UIAlertController(title: "Reset Password", message: "reset password sale account \n" + username! , preferredStyle: UIAlertController.Style.alert)
        
                    alert.addTextField { (UITextField) in
                        UITextField.isSecureTextEntry = true
                        UITextField.tag = 0
                        UITextField.delegate = self
                        UITextField.keyboardType = .asciiCapable
                    }
                
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
                        guard let text = alert.textFields![0].text else { return }
                        
                        if text.count > 0{
                            let username = self.SalesData[indexPath.row]["SalesUsername"]
                            self.resetPasswordSale(token: self.tokenID!, username: username!, password: text)
                        }else{
                            self.Create_AlertMessage(Title: "amiss", Message: "No filling.")
                        }

                    }))
        
                    alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)

            }))
                    
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in }))
                    
            self.present(actionSheet, animated: true, completion: nil)
            completionHandler(true)
        }
           
        delete.backgroundColor = UIColor.rgb(red: 237, green: 237, blue: 237)
        delete.image = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40)).image { _ in
            #imageLiteral(resourceName: "remove").withTintColor(UIColor.rgb(red: 255, green: 105, blue: 97)).draw(in: CGRect(x: 0, y: 0, width: 40, height: 40))}
        
        edit.backgroundColor = UIColor.rgb(red: 237, green: 237, blue: 237)
        edit.image = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40)).image { _ in
        #imageLiteral(resourceName: "gear").withTintColor(UIColor.rgb(red: 97, green: 168, blue: 255)).draw(in: CGRect(x: 0, y: 0, width: 40, height: 40))}
                   
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return configuration
           
    }
    
    @objc func AddAccountSale(){

        let maxAccount = LoginPageController.DataLogin?.SaleMax

        if SalesData.count < Int(maxAccount!)!{
            
            for index in 0..<SalesData.count{
                ManageAccountViewController.SaleAccount.append(SalesData[index]["SalesUsername"]!)
            }
                      
            let AddSaleController = ManageAddSaleViewController()
            navigationController?.pushViewController(AddSaleController, animated: true)
            
        }else{
            let message = "account " + String(SalesData.count) + " in " + maxAccount!
            let alert = UIAlertController(title: "you have account maximum", message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)

        }
        
    }
    
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getSales(token:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_GetSales()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.SalesData = JSON!["results"] as! [[String : String]]
                    self.ImageAccrount = Array(repeating: #imageLiteral(resourceName: "saleAccount"), count: self.SalesData.count)
                    self.ImageSegnature = Array(repeating: UIImage(), count: self.SalesData.count)
                    
                    for i in 0..<self.SalesData.count {
                        
                        let indexPath = IndexPath(row: i, section: 0)
                                                
                        if self.SalesData[indexPath.row]["SalesImage"]! != "" {
                            self.DownloadimageAccrount(token: self.tokenID!, path: self.SalesData[indexPath.row]["SalesImage"]!, indexPath: indexPath)
                        }

                    }
                    self.tableView!.reloadData()
                    
                    // Close loader
                    self.Show_Loader()

                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func delsales(token:String,username:String,pathimageAccrount:String,pathimageSegnature:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_Delsales()
        let parameter = ["Username" : username]
        
        AF.request(Url, method: .post,parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    self.delimageimageAccrount(token: token, path: pathimageAccrount)
                    self.delimageimageSegnature(token: token, path: pathimageSegnature)
                }
        
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func resetPasswordSale(token:String,username:String,password:String){
        
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_ResetPasswordSales()
        let parameter = ["Username":username ,"Password":password]
        
        AF.request(Url, method: .post,parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
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
    
    func DownloadimageAccrount(token:String ,path:String ,indexPath:IndexPath){
        guard path != "" else {return}
        
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
                        self.DownloadimageAccrount(token: token, path: path, indexPath: indexPath)
                        return
                    }

                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let data: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
        
                    self.ImageAccrount[indexPath.row] = UIImage(data: data as Data)!
                    self.indexfinish = self.indexfinish + 1
                    print(self.indexfinish)
                    
                    if self.indexfinish == self.SalesData.count{
                        self.tableView!.reloadData()
                        self.indexfinish = 0
                    }
                
                }
            case .failure(_):
                break
                
            }
        }
        
        
    }

    func delimageimageAccrount(token:String,path:String){
        guard path != "" else {return}

        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_ImageDeleteImage()
        
        //SubString name image
        let SubString = path.split{$0 == "/"}.map(String.init)
        let path = "sales/" + SubString.last!
        
        let parameter = ["path":path, "bucket":"arforsalesfullimage"]

        AF.request(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : String]
                
                if JSON!["message"] == "Success" {
                    self.indexDelImageFinish = self.indexDelImageFinish + 1
                    if self.indexDelImageFinish == 2 {
                        // Close loader
                        self.Show_Loader()
                        self.indexDelImageFinish = 0
                    }
                    
                }

            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func delimageimageSegnature(token:String ,path:String){
        guard path != "" else {return}

        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_ImageDeleteImage()
        
        //SubString name image
        let SubString = path.split{$0 == "/"}.map(String.init)
        let path = "sales/" + SubString.last!
        
        let parameter = ["path":path, "bucket":"arforsalesfullimage"]

        AF.request(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : String]
                
                if JSON!["message"] == "Success" {
                    self.indexDelImageFinish = self.indexDelImageFinish + 1
                    if self.indexDelImageFinish == 2 {
                        // Close loader
                        self.Show_Loader()
                        self.indexDelImageFinish = 0
                    }
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

extension ManageAccountViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField.tag {
        case 0://TextAccount TextPassword
            let invalidCharacters = CharacterSet(charactersIn: "1234567890AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz").inverted
            return string.rangeOfCharacter(from: invalidCharacters) == nil
        default: return true
        }
    }
    
}
