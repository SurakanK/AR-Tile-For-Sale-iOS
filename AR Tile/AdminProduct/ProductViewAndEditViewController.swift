//
//  ProductViewAndEditViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 1/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ProductViewAndEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UITextViewDelegate{
    
    let tokenID = LoginPageController.DataLogin?.Token_Id

    weak var tableView : UITableView?

    private var CellID = "Cell"
    private var EditStatus : Bool = false

    var SectionPush = String()
    
    var textname = String()
    var textdescription = String()
    var textprice = String()
    var textwidth = String()
    var textheight = String()
    var textpattern = Int()
    var textremark = String()
    
    var imageProduct = UIImage()
    
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
                
        navigationItem.title = ProductPhotolibraryViewController.ProductSelect["ProductName"]
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
                
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItems = [edit]

        // ConfigRegister Tableview cell,header,footer
        let table =  UITableView(frame: .zero, style: .grouped)
        tableView = table
        tableView!.tableFooterView = UIView()
        tableView!.rowHeight = UITableView.automaticDimension
        tableView!.separatorStyle = .none
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.register(ProductViewAndEditViewCell.self, forCellReuseIdentifier: CellID)
        
        //set layout viewController
        view.addSubview(tableView!)
        
        tableView!.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        
        let ProductDetails = ProductPhotolibraryViewController.ProductSelect
        textname = ProductDetails["ProductName"]!
        textdescription = ProductDetails["ProductDescription"]!
        textremark = ProductDetails["ProductRemark"]!
        textprice = ProductDetails["ProductPrice"]!
        textwidth = ProductDetails["ProductWidth"]!
        textheight = ProductDetails["ProductHeight"]!
        textpattern = Int(ProductDetails["ProductPattern"]!)!
        
        DownloadimageProduct(token: tokenID!, path: ProductDetails["ProductImage"]!)

        //Set anchor Animation Load
        AnimationViewLoadAnchor()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 2
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            let Hight = view.bounds.width
            return Hight
        }else{
            if indexPath.row == 4{
                return 120
            }else if indexPath.row == 5{
                return 120
            }else{
                return 90
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! ProductViewAndEditViewCell
        
        cell.selectionStyle = .none
        cell.productImage.isHidden = true
        cell.textField.isHidden = true
        cell.texttitel.isHidden = true
        cell.viewPrice.isHidden = true
        cell.TilePatterntitle.isHidden = true
        cell.SegmenControl.isHidden = true
        cell.Descriptiontitle.isHidden = true
        cell.TextDescription.isHidden = true
        cell.Remarktitel.isHidden = true
        cell.TextRemark.isHidden = true
        
        if EditStatus {
            cell.textField.isEnabled = true
            cell.PriceWidthField.isEnabled = true
            cell.PriceHeighField.isEnabled = true
            cell.TextDescription.isEditable = true
            cell.TextRemark.isEditable = true
            cell.SegmenControl.isUserInteractionEnabled = true

            cell.textField.layer.borderColor = UIColor.BlueDeep.cgColor
            cell.PriceWidthField.layer.borderColor = UIColor.BlueDeep.cgColor
            cell.PriceHeighField.layer.borderColor = UIColor.BlueDeep.cgColor
            cell.TextDescription.layer.borderColor = UIColor.BlueDeep.cgColor
            cell.TextRemark.layer.borderColor = UIColor.BlueDeep.cgColor
            
            cell.textField.textColor = UIColor.BlackAlpha(alpha: 0.8)
            cell.PriceWidthField.textColor = UIColor.BlackAlpha(alpha: 0.8)
            cell.PriceHeighField.textColor = UIColor.BlackAlpha(alpha: 0.8)
            cell.TextDescription.textColor = UIColor.BlackAlpha(alpha: 0.8)
            cell.TextRemark.textColor = UIColor.BlackAlpha(alpha: 0.8)
            
            cell.textField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
            cell.PriceWidthField.addTarget(self, action: #selector(WidthFieldChange), for: .editingChanged)
            cell.PriceHeighField.addTarget(self, action: #selector(HeighFieldChange), for: .editingChanged)
            
            cell.TextDescription.delegate = self
            cell.TextRemark.delegate = self
            
            cell.SegmenControl.didSelectItemWith = { (Index,text) -> () in
                self.textpattern = Index
            }
            
        }else{
            cell.textField.isEnabled = false
            cell.PriceWidthField.isEnabled = false
            cell.PriceHeighField.isEnabled = false
            cell.TextDescription.isEditable = false
            cell.TextDescription.isSelectable = false
            cell.TextRemark.isEditable = false
            cell.TextRemark.isSelectable = false

            cell.SegmenControl.isUserInteractionEnabled = false

            cell.textField.layer.borderColor = UIColor.BlackAlpha(alpha: 0.3).cgColor
            cell.PriceWidthField.layer.borderColor = UIColor.BlackAlpha(alpha: 0.3).cgColor
            cell.PriceHeighField.layer.borderColor = UIColor.BlackAlpha(alpha: 0.3).cgColor
            cell.TextDescription.layer.borderColor = UIColor.BlackAlpha(alpha: 0.3).cgColor
            cell.TextRemark.layer.borderColor = UIColor.BlackAlpha(alpha: 0.3).cgColor
            
            cell.textField.textColor = UIColor.BlackAlpha(alpha: 0.5)
            cell.PriceWidthField.textColor = UIColor.BlackAlpha(alpha: 0.5)
            cell.PriceHeighField.textColor = UIColor.BlackAlpha(alpha: 0.5)
            cell.TextDescription.textColor = UIColor.BlackAlpha(alpha: 0.5)
            cell.TextRemark.textColor = UIColor.BlackAlpha(alpha: 0.5)
        }
        
        if indexPath.section == 0{
            cell.productImage.isHidden = false
            cell.productImage.image = imageProduct
        }else{
            if indexPath.row == 0{
                cell.textField.isHidden = false
                cell.texttitel.isHidden = false
                cell.texttitel.text = "Product Name"
                cell.textField.placeholder = "Product Name"
                cell.textField.keyboardType = .default
                cell.textField.text = textname
            }else if indexPath.row == 1{
                cell.textField.isHidden = false
                cell.texttitel.isHidden = false
                cell.texttitel.text = "Price Product"
                cell.textField.placeholder = "Price Product"
                cell.textField.keyboardType = .decimalPad
                cell.textField.text = textprice
            }else if indexPath.row == 2{
                cell.texttitel.isHidden = false
                cell.viewPrice.isHidden = false
                cell.texttitel.text = "Size Product"
                cell.PriceWidthField.text = textwidth
                cell.PriceHeighField.text = textheight
            }else if indexPath.row == 3{
                cell.TilePatterntitle.isHidden = false
                cell.SegmenControl.isHidden = false
                cell.SegmenControl.selectItemAt(index: textpattern)
            }else if indexPath.row == 4{
                cell.Descriptiontitle.isHidden = false
                cell.TextDescription.isHidden = false
                cell.TextDescription.text = textdescription
            }else{
                cell.Remarktitel.isHidden = false
                cell.TextRemark.isHidden = false
                cell.TextRemark.text = textremark
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    @objc func textFieldChange(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        
        if indexPath?.row == 0{
            textname = sender.text
        }else{
            textprice = sender.text
        }
    }
    
    @objc func WidthFieldChange(sender: AnyObject){
        textwidth = sender.text
    }
    
    @objc func HeighFieldChange(sender: AnyObject){
        textheight = sender.text
    }
        
    func textViewDidChange(_ textView: UITextView) {
        let point : CGPoint = textView.convert(textView.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
                
        if indexPath?.row == 4{
            textdescription = textView.text
        }else{
            textremark = textView.text
        }
    }
    
    
    @objc func editTapped(sender: UIBarButtonItem){
        if EditStatus{
            
            let ProductDetails = ProductPhotolibraryViewController.ProductSelect
            
            var id = String()
            if SectionPush == "Custom"{
                id = ProductDetails["idProduct"]!
            }else{
                id = ProductDetails["idProduct"]!
            }
            
            let image = ProductDetails["ProductImage"]!
            let name = textname
            let description = textdescription
            let remark = textremark
            let price = textprice
            let width = textwidth
            let height = textheight
            let pattern = String(textpattern)
            
            
            self.editProduct(token: tokenID!, id: id, name: name, description: description, price: price, image: image, width: width, height: height, pattern: pattern, remark: remark)
            
            navigationItem.title = name
            
            sender.title = "Edit"
            EditStatus = false
            tableView!.reloadData()
        }else{
            
            sender.title = "Done"
            EditStatus = true
            tableView!.reloadData()
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
    
    func editProduct(token:String,id:String,name:String,description:String,price:String,
                     image:String,width:String,height:String,pattern:String,remark:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminEditProduct()
        let parameters = ["id":id,"Name":name,"Description":description,"Price":price,
                          "Image":image,"Width":width,"Height":height,"Pattern":pattern,"Remark":remark]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
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
    
    func DownloadimageProduct(token:String ,path:String){
        guard path != "" else {return}
        // Show Loader
        Show_Loader()
        
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
        
                    self.imageProduct = UIImage(data: data as Data)!
                
                    // Close loader
                    self.Show_Loader()
                    self.tableView!.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
                }
            case .failure(_):
                break
                
            }
        }
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
