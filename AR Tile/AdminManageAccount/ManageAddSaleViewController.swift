//
//  ManageAddSaleViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 27/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ManageAddSaleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    let tokenID = LoginPageController.DataLogin?.Token_Id

    weak var tableView : UITableView?
    
    private var CellID = "Cell"
    
    let imageIcon = [ #imageLiteral(resourceName: "IconAccount"),#imageLiteral(resourceName: "IconAccount"),#imageLiteral(resourceName: "Iconphone"),#imageLiteral(resourceName: "Iconpersonal"),#imageLiteral(resourceName: "Iconpersonal"),#imageLiteral(resourceName: "gear"),#imageLiteral(resourceName: "Iconlock")]
    let textTitel = ["First Name","Last Name","Phone Number","Email Address","Employee ID","Account","Password"]
        
    private var TextFirstName : String = ""
    private var TextLastName : String = ""
    private var TextPhoneNumber : String = ""
    private var TextEmployeeID : String = ""
    private var TextAccount : String = "" 
    private var TextPassword : String = ""
    private var TextEmail : String = ""
    private var TextImage : String = ""
    private var TextSignImage : String = ""
    
    private var imageAccount : UIImage = #imageLiteral(resourceName: "saleAccount")
    static var imageSignImage = UIImage()

    
    let testview: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        view.layer.cornerRadius = 5
        return view
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
         
        ManageAddSaleViewController.imageSignImage = UIImage()
        // ConfigNavigation Bar
        navigationItem.title = "Create Account"
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
        
        let ConfirmNavigationButton = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(CreatAccountSale))
        navigationItem.rightBarButtonItem = ConfirmNavigationButton
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // ConfigRegister Tableview cell,header,footer
        let table =  UITableView(frame: .zero, style: .grouped)
        tableView = table
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.tableFooterView = UIView()
        tableView!.backgroundColor = UIColor.white
        tableView!.separatorStyle = .none
        
        tableView!.register(ManageAddSeleViewCell.self, forCellReuseIdentifier: CellID)
               
        //set layout viewController
        view.addSubview(tableView!)
        tableView!.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if tableView?.numberOfRows(inSection: 0) == 9{
            tableView?.reloadRows(at: [IndexPath(row: 8, section: 0)], with: .automatic)
        }
                

    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 0{
            return 200
        }else if indexPath.row == 8{
            return 200
        }else{
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! ManageAddSeleViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white

        cell.imageAccount.isHidden = true
        cell.CameraButton.isHidden = true
        cell.textClearButton.isHidden = true
        cell.viewTextField.isHidden = true
        cell.viewSignature.isHidden = true

        if indexPath.row == 0{
            cell.imageAccount.isHidden = false
            cell.CameraButton.isHidden = false
            
            cell.imageAccount.image = imageAccount
            cell.CameraButton.addTarget(self, action: #selector(CamerahandleButton), for: .touchUpInside)
            
        }else if indexPath.row == 8{
            cell.viewSignature.isHidden = false
            cell.imageSignature.image = ManageAddSaleViewController.imageSignImage
            cell.SignatureButton.addTarget(self, action: #selector(SignaturehandleButton), for: .touchUpInside)

        }else{
            cell.viewTextField.isHidden = false

            cell.iconTextField.image = imageIcon[indexPath.row - 1].withTintColor(UIColor.lightGray)
            cell.textField.placeholder = textTitel[indexPath.row - 1]
            
            switch indexPath.row {
            case 1:
                cell.textField.text = TextFirstName
            case 2:
                cell.textField.text = TextLastName
            case 3:
                cell.textField.text = TextPhoneNumber
            case 4:
                cell.textField.text = TextEmail
            case 5:
                cell.textField.text = TextEmployeeID
            case 6:
                cell.textField.text = TextAccount
            case 7:
                cell.textField.text = TextPassword
            default:break
            }
            
            cell.textClearButton.addTarget(self, action: #selector(TextClearButton), for: .touchUpInside)
            cell.textField.addTarget(self, action: #selector(TextfieldChange), for: .editingChanged)
            cell.textField.addTarget(self, action: #selector(TextfieldDidEnd), for: .editingDidEnd)
            cell.textField.addTarget(self, action: #selector(TextfieldDidBegin), for: .editingDidBegin)
            cell.textField.addTarget(self, action: #selector(TextFieldCheck), for: .editingChanged)
            
            switch indexPath.row {
            case 3:
                cell.textField.keyboardType = .phonePad
            case 4:
                cell.textField.keyboardType = .emailAddress
            case 6:
                cell.textField.keyboardType = .asciiCapable
            case 7:
                cell.textField.keyboardType = .asciiCapable
            default:
                cell.textField.keyboardType = .default
            }
            
            if indexPath.row == 7{
                cell.textField.isSecureTextEntry = true
            }else{
                cell.textField.isSecureTextEntry = false
            }
            
            cell.textField.delegate = self
            switch indexPath.row {
            case 3: cell.textField.tag = 2 //TextPhoneNumber
            case 4: cell.textField.tag = 3 //TextEmail
            case 5: cell.textField.tag = 0 //TextEmployeeID
            case 6: cell.textField.tag = 4 //TextAccount
            case 7: cell.textField.tag = 4 //TextPassword
            default:break
            }
        
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    func textfieldDidEnd(IndexPhath: IndexPath) -> String{

        guard (tableView!.cellForRow(at: IndexPhath) != nil) else {
            
            var text = String()
            switch IndexPhath.row {
            case 1:
                text = TextFirstName
            case 2:
                text = TextLastName
            case 3:
                text = TextPhoneNumber
            case 4:
                text = TextEmail
            case 5:
                text = TextEmployeeID
            case 6:
                text = TextAccount
            case 7:
                text = TextPassword
            default:
                break
            }
            
            return text
            
        }
        
        let cell = tableView!.cellForRow(at: IndexPhath) as! ManageAddSeleViewCell
        cell.textClearButton.isHidden = true
        
        let text = cell.textField.text
        return text!
    }
   
    func textfieldDidBegin(IndexPhath: IndexPath){
        
        guard (tableView!.cellForRow(at: IndexPhath) != nil) else { return }

        let cell = self.tableView!.cellForRow(at: IndexPhath) as! ManageAddSeleViewCell
        let IndexText = cell.textField.text?.count
       
        if IndexText! > 0 {
            cell.textClearButton.isHidden = false
        }else{
            cell.textClearButton.isHidden = true
        }
    }
   
    func ClearButton(IndexPhath: IndexPath){
        let cell = self.tableView!.cellForRow(at: IndexPhath) as! ManageAddSeleViewCell
        cell.textField.text = ""
        cell.textClearButton.isHidden = true
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    func TextFieldChange(IndexPhath: IndexPath)  -> String{

        guard (tableView!.cellForRow(at: IndexPhath) != nil) else {
            
            var text = String()
            switch IndexPhath.row {
            case 1:
                text = TextFirstName
            case 2:
                text = TextLastName
            case 3:
                text = TextPhoneNumber
            case 4:
                text = TextEmail
            case 5:
                text = TextEmployeeID
            case 6:
                text = TextAccount
            case 7:
                text = TextPassword
            default:
                break
            }
            
            return text
            
        }
        
        let cell = self.tableView!.cellForRow(at: IndexPhath) as! ManageAddSeleViewCell

        let IndexText = cell.textField.text?.count
        if IndexText! > 0 {
             cell.textClearButton.isHidden = false
         }else{
             cell.textClearButton.isHidden = true
         }
                
        let text = cell.textField.text
        return text!
        
    }
    
    
    @objc func TextClearButton(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        ClearButton(IndexPhath: indexPath!)
    }
    
    @objc func TextfieldChange(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)

        switch indexPath?.row {
        case 1:
            TextFirstName = TextFieldChange(IndexPhath: indexPath!)
        case 2:
            TextLastName = TextFieldChange(IndexPhath: indexPath!)
        case 3:
            TextPhoneNumber = TextFieldChange(IndexPhath: indexPath!)
        case 4:
            TextEmail = TextFieldChange(IndexPhath: indexPath!)
        case 5:
            TextEmployeeID = TextFieldChange(IndexPhath: indexPath!)
        case 6:
            TextAccount = TextFieldChange(IndexPhath: indexPath!)
        case 7:
            TextPassword = TextFieldChange(IndexPhath: indexPath!)
        default:
            break
        }
        
    }
    @objc func TextfieldDidEnd(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        
        guard indexPath != nil else {return}
        
        switch indexPath!.row {
        case 1:
            TextFirstName = textfieldDidEnd(IndexPhath: indexPath!)
        case 2:
            TextLastName = textfieldDidEnd(IndexPhath: indexPath!)
        case 3:
            TextPhoneNumber = textfieldDidEnd(IndexPhath: indexPath!)
        case 4:
            TextEmail = textfieldDidEnd(IndexPhath: indexPath!)
        case 5:
            TextEmployeeID = textfieldDidEnd(IndexPhath: indexPath!)
        case 6:
            TextAccount = textfieldDidEnd(IndexPhath: indexPath!)
        case 7:
            TextPassword = textfieldDidEnd(IndexPhath: indexPath!)
        default:
            break
        }
    }
    
    @objc func TextfieldDidBegin(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        
        textfieldDidBegin(IndexPhath: indexPath!)
                
    }
    
    @objc func TextFieldCheck(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        
        guard (tableView!.cellForRow(at: indexPath!) != nil) else { return }

        let cell = self.tableView!.cellForRow(at: indexPath!) as! ManageAddSeleViewCell
        let IndexText = cell.textField.text?.count
        
        if IndexText! > 0 {
            
            if TextFirstName != "" && TextLastName != "" && TextPhoneNumber != "" && TextEmployeeID != "" && TextAccount != "" && TextPassword != ""{
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
            
        }else{
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func CamerahandleButton(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source your company logo", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)

        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in }))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
         
        imageAccount = image
        
        tableView?.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func SignaturehandleButton(){
        let ManageSignatur = ManageSignatureViewController()
        navigationController?.pushViewController(ManageSignatur, animated: false)
    }
    
    @objc func CreatAccountSale(){
        
        if ManageAddSaleViewController.imageSignImage.size.width == 0{
            ManageAddSaleViewController.imageSignImage = UIImage(color: .white, size: CGSize(width: 1, height: 1))!
        }
                
        // check account repeatedly
        let SaleAccount = ManageAccountViewController.SaleAccount
        let index = SaleAccount.indices.filter({SaleAccount[$0] ==  TextAccount.lowercased()})
        
        if index.count == 0{
            //Image Resize
            var image = imageAccount
            if image.size.width > CGFloat(300) || image.size.height > CGFloat(300){
                image = image.resizeImage(targetSize: CGSize(width: 300, height: 300))
            }
            
            UploadimageAccrount(token: tokenID!, image: image)
        }else{
            Create_AlertMessage(Title: "Use another account", Message: "Already have this account")
        }
    }
    
    func UploadimageAccrount(token:String, image:UIImage){
        // Show Loader
        Show_Loader()
        
        var image = image
        if image.size.width == 0{
            image = UIImage(color: .white, size: CGSize(width: 1, height: 1))!
        }
        
        let base64Image = image.toBase64()
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let parameter = ["path":"sales/imageAccrount_" + TextAccount + ".jpg","bucket":"arforsalesfullimage","image":base64Image]
        let Url = DataSource.Url_ImageUploadImage()
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
                
                switch response.result{
                case .success(let value):
                    let JSON = value as? [String : Any]
                    
                    if JSON!["Key"] != nil{
                        self.TextImage = JSON!["Key"] as! String
                        self.UploadimageSignature(token: self.tokenID!, image: ManageAddSaleViewController.imageSignImage)
                    }
        
                case .failure(_):
                    
                    break
                }
        })
    }
    
    func UploadimageSignature(token:String ,image:UIImage){
        
        var image = image
        if image.size.width == 0{
            image = UIImage(color: .white, size: CGSize(width: 1, height: 1))!
        }
        
        let base64Image = image.toBase64()
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let parameter = ["path":"sales/imageSignature_" + TextAccount + ".jpg","bucket":"arforsalesfullimage","image":base64Image]
        let Url = DataSource.Url_ImageUploadImage()

        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
                
                switch response.result{
                case .success(let value):
                    let JSON = value as? [String : Any]
                    
                    if JSON!["Key"] != nil{
                        self.TextSignImage = JSON!["Key"] as! String
                        
                        let fullname = self.TextFirstName + " " + self.TextLastName

                        self.insertSales(token: self.tokenID!, username: self.TextAccount , password: self.TextPassword, fullname: fullname, employeeid: self.TextEmployeeID, tel: self.TextPhoneNumber, email: self.TextEmail, image: self.TextImage, Signature: self.TextSignImage)
                    }
        
                case .failure(_):
                    
                    break
                }
        })
    }
    
    func insertSales(token:String,username:String,password:String,
      fullname:String,employeeid:String,
      tel:String,email:String,image:String,Signature:String){
                
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_InsertSales()
        let parameter = ["Username":username,"Password":password,"Fullname":fullname,"EmployeeID":employeeid,"Tel":tel,"Email":email,"Image":image,"SignImage":Signature,"SalesTarget":"0"]

        
        AF.request(Url, method: .post,parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                //print(value)
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
    
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.MitrMedium(size: 18), color: .red)
        alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.9))
        
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


extension ManageAddSaleViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField.tag {
        case 2://TextPhoneNumber
            let invalidCharacters = CharacterSet(charactersIn: "1234567890+").inverted
            return string.rangeOfCharacter(from: invalidCharacters) == nil
        case 3://TextEmail
            let invalidCharacters = CharacterSet(charactersIn: "1234567890AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz@.-_").inverted
            return string.rangeOfCharacter(from: invalidCharacters) == nil
        case 4://TextAccount TextPassword
            let invalidCharacters = CharacterSet(charactersIn: "1234567890AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz").inverted
            return string.rangeOfCharacter(from: invalidCharacters) == nil
        default: return true
        }
    }
    
}

