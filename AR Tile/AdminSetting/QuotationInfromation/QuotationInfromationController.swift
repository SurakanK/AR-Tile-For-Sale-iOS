//
//  QuotationInfromationController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 19/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class QuotationInfromationController: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextViewDelegate{
    let tokenID = LoginPageController.DataLogin?.Token_Id

    weak var tableView : UITableView?

    private var CellID = "cell"
    private var HeaderID = "Header"
    
    private var SwitchRemarkHeader: Bool = false
    private var SwitchRemarkProduct: Bool = false

    static var QuotationData = [[String : Any]]()
    static var imageSignature = UIImage()

    private var ShowLogo = 0
    private var RemarkHeader = ""
    private var RemarkBottom = ""
    private var Approveby = ""
    private var ApprovebySign = ""
    private var TaxID = ""
    private var vat = 0
    
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
        navigationItem.title = "Quotation"
        navigationController?.navigationBar.barTintColor = .BlueLight
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 20)]
        
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
        tableView!.register(QuotationTableViewCell.self, forCellReuseIdentifier: CellID)
        tableView!.register(QuotationHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderID)
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getQuotationSetting(token: tokenID!)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        editQuotationSetting(token: tokenID!, ShowLogo: String(ShowLogo), RemarkHeader: RemarkHeader, TaxID: TaxID, vat: String(vat), RemarkBottom: RemarkBottom, Approveby: Approveby, ApprovebySign: ApprovebySign)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0{
            return 3
        }else if section == 1{
            return 2
        }else{
            return 1
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0{
            if indexPath.row == 0{
                return 50
            }else if indexPath.row == 1{
                if SwitchRemarkHeader == true{
                    return 150
                }else{
                    return 50
                }
            }else{
                return 50
            }
        }else if indexPath.section == 1{

            if indexPath.row == 1{
                if SwitchRemarkProduct == true{
                    return 150
                }else{
                    return 50
                }
            }else{
                return 50
            }

        }else{
            return 50
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! QuotationTableViewCell
        
        cell.TextLabel.isHidden = true
        cell.imageNext.isHidden = true
        cell.textField.isHidden = true
        cell.textClearButton.isHidden = true
        cell.SwitchUI.isHidden = true
        cell.TextRemark.isHidden = true
        cell.remarktitle.isHidden = true
        cell.line.isHidden = true
        
        cell.TextRemark.delegate = self
        
        if indexPath.section == 0{
            
            if indexPath.row == 0{
                cell.SwitchUI.isHidden = false
                cell.titleTextLabel.isHidden = false
                cell.titleTextLabel.text = "Company logo"
                
                cell.SwitchUI.addTarget(self, action: #selector(RemarkSwitchValueChanged), for: .valueChanged)

                cell.SwitchUI.isOn = ShowLogo.boolValue
                
                return cell
            }else if indexPath.row == 1{
                cell.SwitchUI.isHidden = false
                cell.titleTextLabel.isHidden = false
            
                cell.titleTextLabel.text = "Remark header"
                
                cell.SwitchUI.addTarget(self, action: #selector(RemarkSwitchValueChanged), for: .valueChanged)
                
                cell.SwitchUI.isOn = SwitchRemarkHeader

                if SwitchRemarkHeader == true{
                    cell.TextRemark.text = RemarkHeader
                    
                    cell.TextRemark.isHidden = false
                    cell.remarktitle.isHidden = false
                    cell.line.isHidden = false
                    
                }else{
                    cell.remarktitle.isHidden = true
                    cell.TextRemark.isHidden = true
                    cell.line.isHidden = true

                }
    
                return cell
            }else{
                cell.imageNext.isHidden = false
                cell.titleTextLabel.isHidden = false
                cell.TextLabel.isHidden = false
                
                cell.titleTextLabel.text = "Tax ID"
                cell.TextLabel.text = TaxID
                return cell
            }
            
        }else if indexPath.section == 1{
            
            if indexPath.row == 0{
                cell.imageNext.isHidden = false
                cell.titleTextLabel.isHidden = false
                cell.TextLabel.isHidden = false

                cell.titleTextLabel.text = "VAT"
                cell.TextLabel.text = String(vat) + "%"
                return cell

            }else{
                cell.titleTextLabel.isHidden = false
                cell.SwitchUI.isHidden = false

                cell.titleTextLabel.text = "Remark Product"
        
                cell.SwitchUI.addTarget(self, action: #selector(RemarkSwitchValueChanged), for: .valueChanged)
                
                cell.SwitchUI.isOn = SwitchRemarkProduct

                if SwitchRemarkProduct == true{
                    cell.TextRemark.text = RemarkBottom
                    
                    cell.TextRemark.isHidden = false
                    cell.remarktitle.isHidden = false
                    cell.line.isHidden = false
                    
                }else{
                    cell.remarktitle.isHidden = true
                    cell.TextRemark.isHidden = true
                    cell.line.isHidden = true

                }
                
                return cell
            }
            
        }else{
           
            cell.imageNext.isHidden = false
            cell.titleTextLabel.isHidden = false
            cell.TextLabel.isHidden = false

            cell.titleTextLabel.text = "Approve By"
                
            if Approveby != ""{
                cell.TextLabel.text = Approveby
            }else{
                cell.TextLabel.text = "Sale"
            }
            
            return cell
            
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        view.endEditing(true)
        
        if indexPath.section == 0{
            
            if indexPath.row == 0{
                
            }else if indexPath.row == 1{
                
            }else{
                let TexIDController = QuotatinoTaxIDViewController()
                navigationController?.pushViewController(TexIDController, animated: true)
            }
            
        }else if indexPath.section == 1{
            
            if indexPath.row == 0{
                let VATController = QuotatinoVATViewController()
                navigationController?.pushViewController(VATController, animated: true)
            }
                                    
        }else{
            if indexPath.row == 0{
                let ApprovedController = QuotatinoApprovedViewController()
                navigationController?.pushViewController(ApprovedController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 50
        }else if section == 1{
            return 50
        }else{
            return 50
        }
    }
       
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderID) as! QuotationHeaderViewCell
        
        if section == 0{
            header.HeaderTextLabel.text = "Header"
        }else if section == 1{
            header.HeaderTextLabel.text = "Product"
        }else if section == 2{
            header.HeaderTextLabel.text = "Approved"
        }
    
                   
        return header
    }
    
    
    
    @objc func RemarkSwitchValueChanged(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        let cell = tableView!.cellForRow(at: indexPath!) as! QuotationTableViewCell
        
        if indexPath?.section == 0{
            if indexPath?.row == 1{
                
                SwitchRemarkHeader = cell.SwitchUI.isOn
            
                if SwitchRemarkHeader == false{
                    RemarkHeader = ""
                }
                
                self.tableView!.reloadRows(at: [indexPath!], with: .automatic)
            }else{
                ShowLogo = cell.SwitchUI.isOn.intValue
            }
            
        }else if indexPath?.section == 1{
            if indexPath?.row == 1{
                
                SwitchRemarkProduct = cell.SwitchUI.isOn
                
                if SwitchRemarkProduct == false{
                    RemarkBottom = ""
                }
                
                self.tableView!.reloadRows(at: [indexPath!], with: .fade)
            }
        }

        
       
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let point : CGPoint = textView.convert(textView.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)

        switch indexPath?.section {
        case 0:
            RemarkHeader = textView.text
        case 1:
            RemarkBottom = textView.text
        default:break
        }

    }
    
    func getQuotationSetting(token:String){
        
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]

        let Url = DataSource.Url_adminGetAccountQuotation()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                let JSON = value as? [String : Any]
                
                let view = QuotationInfromationController.self

                if JSON!["results"] != nil{
                    
                    view.self.QuotationData = JSON!["results"] as! [[String : Any]]
                    self.ShowLogo = view.self.QuotationData[0]["ShowLogo"] as! Int
                    self.vat = view.self.QuotationData[0]["vat"] as! Int
                    self.RemarkHeader = view.self.QuotationData[0]["RemarkHeader"] as! String
                    self.RemarkBottom = view.self.QuotationData[0]["RemarkBottom"] as! String
                    self.TaxID = view.self.QuotationData[0]["TaxID"] as! String
                    self.Approveby = view.self.QuotationData[0]["Approveby"] as! String
                    self.ApprovebySign = view.self.QuotationData[0]["ApprovebySign"] as! String
                    
                    
                    if self.RemarkHeader != ""{
                        self.SwitchRemarkHeader = true
                    }else{
                        self.SwitchRemarkHeader = false
                    }
                    
                    if self.RemarkBottom != ""{
                        self.SwitchRemarkProduct = true
                    }else{
                        self.SwitchRemarkProduct = false
                    }
                    
                    if self.Approveby != ""{
                        QuotatinoApprovedViewController.SwitchApproved = false
                        self.DownloadimageSignature(token: self.tokenID!, path: self.ApprovebySign)

                    }else{
                        QuotatinoApprovedViewController.SwitchApproved = true
                        // Close loader
                        self.Show_Loader()
                    }
                                     
                    self.tableView?.reloadData()

                }
    
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
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
                    
                }

            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
 
    func DownloadimageSignature(token:String ,path:String){
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
                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let datos: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
                    
                    QuotationInfromationController.imageSignature = UIImage(data: datos as Data)!
                    
                    // Close loader
                    self.Show_Loader()
                    
                }
            case .failure(_):
                break
                
            }
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

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

extension Int {
    var boolValue: Bool {
        return self != 0
    }
}
