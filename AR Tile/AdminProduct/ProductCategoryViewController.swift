//
//  ProductHomeViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 28/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//


import UIKit
import Alamofire
import NVActivityIndicatorView

class ProductCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let tokenID = LoginPageController.DataLogin?.Token_Id

    weak var tableView : UITableView?

    var ImageCategory = [UIImage()]
    var indexfinish = 0
    
    private var CellID = "Cell"
    
    static var CatagoryID = String()
    static var NameCatagory = String()
    static var imageCatagory = String()

    var CatagoryData = [[String:String]]()
    
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
        navigationItem.title = "Category"
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
        
        let ConfirmNavigationButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddGroup))
        navigationItem.rightBarButtonItem = ConfirmNavigationButton
        navigationItem.rightBarButtonItem?.isEnabled = true
        
               
        // ConfigRegister Tableview cell,header,footer
        let table =  UITableView(frame: .zero, style: .grouped)
        tableView = table
        tableView!.rowHeight = UITableView.automaticDimension
        tableView!.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        tableView!.separatorStyle = .none
        tableView!.register(ProductCategoryViewCell.self, forCellReuseIdentifier: CellID)
        tableView!.delegate = self
        tableView!.dataSource = self
        
        
        //set layout viewController
        view.addSubview(tableView!)
        tableView!.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Request data from server
        self.getCatagory(token: tokenID!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CatagoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! ProductCategoryViewCell

        if ImageCategory[indexPath.row].size.width != 0{
            cell.imageCategory.image = ImageCategory[indexPath.row]
        }
    
        let Catagory = CatagoryData[indexPath.row]["CategoryDescription"]
        cell.NameGroupLable.text = Catagory
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ProductLookController = ProductInCategoryViewController()
        navigationController?.pushViewController(ProductLookController, animated: true)
        
        ProductCategoryViewController.NameCatagory = CatagoryData[indexPath.row]["CategoryDescription"]!
        ProductCategoryViewController.CatagoryID = CatagoryData[indexPath.row]["idCategory"]!
        ProductCategoryViewController.imageCatagory = CatagoryData[indexPath.row]["CategoryImage"]!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
              
        
        let delete = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in

            let Catagory = self.CatagoryData[indexPath.row]["CategoryDescription"]
            let alert = UIAlertController(title: "Do You Want to Delete This Category?", message: Catagory, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
                 
                let id = self.CatagoryData[indexPath.row]["idCategory"]
                self.delCatagory(token: self.tokenID!, catagoryID: id!)
                           
                self.tableView!.setEditing(false, animated: true)
                self.CatagoryData.remove(at: indexPath.row)
                self.tableView!.deleteRows(at: [indexPath], with: .automatic)
               
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            completionHandler(true)
        }
              
        let edit = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            
            let NameCatagory = self.CatagoryData[indexPath.row]["CategoryDescription"]
            let PathImage = self.CatagoryData[indexPath.row]["CategoryImage"]

            var alert = UIAlertController(title: "creat category", message: "please name your category.", preferredStyle: UIAlertController.Style.alert)
            
            alert.setTitlet(font: UIFont.MitrMedium(size: 20), color: .BlueLight)
            alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.5))
            
            alert.addTextField {(textField: UITextField!) in
                textField.text = NameCatagory
            }
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
            
                guard let text = alert.textFields![0].text else { return }
                if text.count > 0 && text != "Custom Tile"{
                    let id = self.CatagoryData[indexPath.row]["idCategory"]
                    self.editCatagory(token: self.tokenID!, catagoryID: id!, Description: text, Image: PathImage!)
    
                }else{
                     if text == "Custom Tile"{
                        alert = UIAlertController(title: "amiss", message: "This name cannot be used.", preferredStyle: UIAlertController.Style.alert)
                     }else{
                        alert = UIAlertController(title: "amiss", message: "No filling.", preferredStyle: UIAlertController.Style.alert)
                     }
                     
                     alert.setTitlet(font: UIFont.MitrMedium(size: 20), color: .red)
                     alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.5))
                     alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
                     self.present(alert, animated: true, completion: nil)
                }
                
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
                  
            completionHandler(true)
        }
              
        delete.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        delete.image = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40)).image { _ in
               #imageLiteral(resourceName: "remove").withTintColor(UIColor.rgb(red: 255, green: 105, blue: 97)).draw(in: CGRect(x: 0, y: 0, width: 40, height: 40))}
           
        edit.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        edit.image = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40)).image { _ in
           #imageLiteral(resourceName: "gear").withTintColor(UIColor.rgb(red: 97, green: 168, blue: 255)).draw(in: CGRect(x: 0, y: 0, width: 40, height: 40))}
                      
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
           
        return configuration
              
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1{
            return false
        }
        return true
    }
    
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func AddGroup(){
        var alert = UIAlertController(title: "creat category", message: "please name your category.", preferredStyle: UIAlertController.Style.alert)
        
        alert.setTitlet(font: UIFont.MitrMedium(size: 20), color: .BlueLight)
        alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.5))
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
        
            guard let text = alert.textFields![0].text else { return }
            if text.count > 0 && text != "Custom Tile"{
                self.insertCatagory(token: self.tokenID!, Description: text, Image: "")
            }else{
                if text == "Custom Tile"{
                    alert = UIAlertController(title: "amiss", message: "This name cannot be used.", preferredStyle: UIAlertController.Style.alert)
                }else{
                    alert = UIAlertController(title: "amiss", message: "No filling.", preferredStyle: UIAlertController.Style.alert)
                }
                
                alert.setTitlet(font: UIFont.MitrMedium(size: 20), color: .red)
                alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.5))
                alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func insertCatagory(token:String,Description:String,Image:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminInsertCategoryy()
        let parameters = ["Description":Description,"Image":Image]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    // Close loader
                    self.Show_Loader()
                    
                    self.getCatagory(token: self.tokenID!)
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func getCatagory(token:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminGetCategory()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.CatagoryData = JSON!["results"] as! [[String : String]]
                    self.ImageCategory = Array(repeating: UIImage(), count: self.CatagoryData.count)
                    
                    for i in 0..<self.CatagoryData.count {
                        
                        let indexPath = IndexPath(row: i, section: 0)
                                                
                        if self.CatagoryData[indexPath.row]["CategoryImage"]! != "" {
                            
                            self.DownloadimageProduct(token: self.tokenID!, path: self.CatagoryData[indexPath.row]["CategoryImage"]!, indexPath: indexPath)
                            
                        }else{
                            self.indexfinish = self.indexfinish + 1
                            self.ImageCategory[i] = UIImage(color: .whiteAlpha(alpha: 0.1), size: CGSize(width: 1, height: 1))!
                            
                            if self.indexfinish == self.CatagoryData.count - 1{
                                self.indexfinish = 0
                                self.tableView!.reloadData()
                            }
                        }

                    }
                    
                    //Creat Custom Category
                    let CatagoryCoustomData = ["idCategory":"Custom","CategoryDescription":"Custom Tile","CategoryImage":"nil"]
                    self.CatagoryData.append(CatagoryCoustomData)
                    self.ImageCategory.append(#imageLiteral(resourceName: "Icon-Tile"))
                    
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
    
    func DownloadimageProduct(token:String ,path:String ,indexPath:IndexPath){
        guard path != "" else { return }
    
        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let parameter = ["bucket":"arforsalesfullimage", "path": path]
        let Url = DataSource.Url_DownloadImage()

        AF.download(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value) :
                if let json = value as? [String : Any] {
                    
                    let Body = json["Body"] as? [String : Any]
                    
                    guard Body != nil else {return}

                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let data: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
        
                    self.ImageCategory[indexPath.row] = UIImage(data: data as Data)!
                    self.indexfinish = self.indexfinish + 1
                    
                    print(self.indexfinish)
                    if self.indexfinish == self.CatagoryData.count - 1{
                        self.indexfinish = 0
                        self.tableView!.reloadData()
                    }
                
                }
            case .failure(_):
                break
                
            }
        }
    }
    
    func delCatagory(token:String,catagoryID:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminDelCategory()
        let parameters = ["id":catagoryID]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    // Close loader
                    self.Show_Loader()
                    
                    self.getCatagory(token: self.tokenID!)
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func editCatagory(token:String,catagoryID:String,Description:String,Image:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminEditCategory()
        let parameters = ["id":catagoryID,"Description":Description,"Image":Image]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    // Close loader
                    self.Show_Loader()
                    
                    self.getCatagory(token: self.tokenID!)
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
