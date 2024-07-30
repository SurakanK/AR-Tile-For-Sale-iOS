//
//  EmailandWebsiteViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 20/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class EmailandWebsiteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
       
    let tokenID = LoginPageController.DataLogin?.Token_Id

    weak var tableView : UITableView?

    private var CellID = "cell"
    private var HeaderID = "Header"

    var TextEmail : String = ""
    var TextWebsite : String = ""

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
        navigationItem.title = "Email and Website"
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
        if CompanyInfromationController.self.CompanyData.count > 0{
            let data = CompanyInfromationController.self.CompanyData
            TextEmail = data[0]["CompanyEmail"]!
            TextWebsite = data[0]["CompanyWebsite"]!
        }else{
            TextEmail = ""
            TextWebsite = ""
        }
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 2
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
            placeholder = "company email address"
            cell.textField.text = TextEmail
            cell.textField.keyboardType = .emailAddress
        case 1:
            placeholder = "company website"
            cell.textField.text = TextWebsite
            cell.textField.keyboardType = .webSearch
            cell.textField.autocapitalizationType = .none
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
       
        if section == 0{
            header.HeaderTextLabel.text = "Email Address"
        }else{
            header.HeaderTextLabel.text = "Website"
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
              TextEmail = textfieldChange(IndexPhath: indexPath!)
          case 1:
              TextWebsite = textfieldChange(IndexPhath: indexPath!)
          default:break
          }
      }
      
      @objc func TextFieldDidEnd(sender: AnyObject){
          let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
          let indexPath = self.tableView!.indexPathForRow(at: point)
          
          switch indexPath?.section {
          case 0:
              TextEmail = textfieldDidEnd(IndexPhath: indexPath!)
          case 1:
              TextWebsite = textfieldDidEnd(IndexPhath: indexPath!)
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
            if TextEmail != "" && TextWebsite != "" && isValidEmail(email: TextEmail){
                navigationItem.rightBarButtonItem?.isEnabled = true
            }else{
                navigationItem.rightBarButtonItem?.isEnabled = false
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
                  text = TextEmail
              case 1:
                  text = TextWebsite
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
                  text = TextEmail
              case 1:
                  text = TextWebsite
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
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
      }
    
     func isValidWeb (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
     @objc func ConfirmButton(){
         
        let data = CompanyInfromationController.self.CompanyData[0]
              
        editCompanySetting(token: tokenID!, name: data["CompanyName"]! , tel: data["CompanyTel"]! , fax: data["CompanyFax"]!, address: data["CompanyAddress"]! , email: TextEmail, website: TextWebsite, Image: data["CompanyImage"]!)
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
