//
//  LoginPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 29/1/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Pastel
import TTSegmentedControl
import Alamofire
import NVActivityIndicatorView

class LoginPageController : UIViewController, UITextFieldDelegate {
    
    // ratio
    lazy var ratio = view.frame.width / 375//667
    
    // Image BG Page
    var BGImage : UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = #imageLiteral(resourceName: "robin-worrall-FPt10LXK0cg-unsplash")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
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
    // Label Page
    var LabelPage : UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        label.font = UIFont.PoppinsBold(size: 50)
        label.textAlignment = .center
        return label
    }()
    
    // Segment Button Admin and User
    lazy var Seg_ChooseCer : TTSegmentedControl = {
        let button = TTSegmentedControl()
        button.defaultTextFont = UIFont.PoppinsRegular(size: 15 * ratio)
        button.defaultTextColor = .BlackAlpha(alpha: 0.6)
        
        button.allowChangeThumbWidth = true
        
        button.selectedTextFont = UIFont.PoppinsMedium(size: 15 * ratio)
        button.selectedTextColor = .whiteAlpha(alpha: 0.8)
        
        button.thumbGradientColors = [.BlueDeep, .BlueDeep]
        button.itemTitles = ["Admin", "User"]
        button.allowChangeThumbWidth = false
        button.useShadow = true
        
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    // ------------------------------------------------------------------
    // Icon Login Page
    var IconPage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Logo_ARTileForSale")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    
    // ------------------------------------------------------------------
    // UIView of StackView Username and Element Them
    var UsernameView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // Icon Username
    var IconUsername : UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "email")
        icon.contentMode = .scaleAspectFit
        icon.layer.masksToBounds = true
        return icon
    }()
    // TextFill
    var TxtUsername : UITextField = {
        let Txt = UITextField()
        Txt.backgroundColor = .clear
        Txt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.font : UIFont.PoppinsRegular(size: 18), NSAttributedString.Key.foregroundColor : UIColor.whiteAlpha(alpha: 0.5)])
        Txt.textColor = UIColor.whiteAlpha(alpha: 0.8)
        Txt.font = UIFont.PoppinsRegular(size: 18)
        Txt.returnKeyType = .done
        return Txt
    }()
    // Line
    var UsernameBottomLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.whiteAlpha(alpha: 0.8)
        return line
    }()
    
    
    // ------------------------------------------------------------------
    // UIView of StackView Password and Element Them
    var PasswordView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // Icon Username
    var IconPassword : UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "key")
        icon.contentMode = .scaleAspectFit
        icon.layer.masksToBounds = true
        return icon
    }()
    // TextFill
    var TxtPassword : UITextField = {
        let Txt = UITextField()
        Txt.backgroundColor = .clear
        Txt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.font : UIFont.PoppinsRegular(size: 18), NSAttributedString.Key.foregroundColor : UIColor.whiteAlpha(alpha: 0.5)])
        Txt.textColor = UIColor.whiteAlpha(alpha: 0.8)
        Txt.font = UIFont.PoppinsRegular(size: 18)
        Txt.isSecureTextEntry = true
        Txt.returnKeyType = .done
        return Txt
    }()
    // Button Hide Password
    var Btn_HidePassword : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "eye").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        button.addTarget(self, action: #selector(HandleHidePassword), for: .touchUpInside)
        return button
    }()
    // Line
    var PasswordBottomLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.whiteAlpha(alpha: 0.8)
        return line
    }()
    // ------------------------------------------------------------------
    // UIView of StackView Keep me logged and Element Them
    var KeepmeView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // UIView of Element Keepme (Button Check and Label)
    var KeepView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    //  Button Check Keep me
    var Btn_CheckKeepMe : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "UnCheckBox"), for: .normal)
        button.addTarget(self, action: #selector(BtnCheckKeep_Click), for: .touchUpInside)
        return button
    }()
    // Label Keep me
    var LabelKeepMe : UILabel = {
        let label = UILabel()
        label.text = "Keep Me Logged In"
        label.font = UIFont.PoppinsMedium(size: 18)
        label.textColor = UIColor.whiteAlpha(alpha: 0.8)
        return label
    }()
    // ------------------------------------------------------------------
    
    // Button Sign Up
    var BtnLogin : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.YellowLight
        button.layer.cornerRadius = 60/2
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.whiteAlpha(alpha: 0.9), for: .normal)
        button.titleLabel?.font = UIFont.PoppinsMedium(size: 30)
        button.addTarget(self, action: #selector(BtnLogin_Click), for: .touchUpInside)
        return button
    }()
    
    fileprivate func Layout_Application(){
        
        // Set Attribute View
        view.backgroundColor = .clear
        
        // Set Pastel View
        let pastelView = PastelView(frame: view.bounds)

        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight

        // Custom Duration
        pastelView.animationDuration = 1.0

        // Custom Color
        /*pastelView.setColors([UIColor.rgb(red: 104, green: 167, blue: 185), UIColor.rgb(red: 12, green: 74, blue: 93), UIColor.BlueLight,
                              UIColor.rgb(red: 16, green: 104, blue: 130),
                              UIColor.rgb(red: 72, green: 160, blue: 185)])*/
        
        pastelView.setColors([UIColor.BlueDeep, UIColor.BlueLight])
        pastelView.startAnimation()
        pastelView.alpha = 1
        
        // Set StackView
        let StackView = UIStackView(arrangedSubviews: [UsernameView,PasswordView,KeepmeView])
        StackView.distribution = .fillEqually
        StackView.spacing = 10
        StackView.axis = .vertical
        
        // Add Element to View
        view.insertSubview(BGImage, at: 0)
        view.insertSubview(pastelView, at: 1)
        view.addSubview(LabelPage)
        view.addSubview(IconPage)
        view.addSubview(StackView)
        view.addSubview(BtnLogin)
        
        // Set Constraint of Element
        //Label page -----------------------------------------------
        LabelPage.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        LabelPage.font = UIFont.PoppinsBold(size: 50 * ratio)
        
        // IconPage -----------------------------------------------
        IconPage.anchor(LabelPage.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 20 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 170 * ratio, heightConstant: 170 * ratio)
        IconPage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        
        // Segment Choose Certificate Login
        view.addSubview(Seg_ChooseCer)
        
        Seg_ChooseCer.anchorCenter(IconPage.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        Seg_ChooseCer.anchor(IconPage.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 40 * ratio, leftConstant: 30 * ratio, bottomConstant: 0, rightConstant: 30 * ratio, widthConstant: 0, heightConstant: 40 * ratio)
        
        // StackView and Element Of Them -----------------------------------------------
        StackView.anchor(Seg_ChooseCer.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 195 * ratio)
        
        
        // Element in UsernameView -----------------------------------------------
        UsernameView.addSubview(IconUsername)
        UsernameView.addSubview(TxtUsername)
        UsernameView.addSubview(UsernameBottomLine)
        
        IconUsername.anchor(UsernameView.topAnchor, left: UsernameView.leftAnchor, bottom: nil, right: nil, topConstant: 20 * ratio, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 40 * ratio, heightConstant: 40 * ratio)

        TxtUsername.anchor(nil, left: IconUsername.rightAnchor, bottom: nil, right: UsernameView.rightAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 20 * ratio, widthConstant: 0, heightConstant: 0)
        TxtUsername.centerYAnchor.constraint(equalTo: IconUsername.centerYAnchor, constant: 0).isActive = true
        
        TxtUsername.font = UIFont.PoppinsRegular(size: 18 * ratio)

        UsernameBottomLine.anchor(nil, left: IconUsername.leftAnchor, bottom: UsernameView.bottomAnchor, right: TxtUsername.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 3 * ratio)
        
        // Element in PasswordView -----------------------------------------------
        PasswordView.addSubview(IconPassword)
        PasswordView.addSubview(TxtPassword)
        PasswordView.addSubview(PasswordBottomLine)
        PasswordView.addSubview(Btn_HidePassword)
        
        IconPassword.anchor(PasswordView.topAnchor, left: PasswordView.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 40 * ratio, heightConstant: 40 * ratio)
        
        TxtPassword.anchor(nil, left: IconPassword.rightAnchor, bottom: nil, right: Btn_HidePassword.leftAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        TxtPassword.centerYAnchor.constraint(equalTo: IconPassword.centerYAnchor, constant: 0).isActive = true
        
        TxtPassword.font = UIFont.PoppinsRegular(size: 18 * ratio)
        
        Btn_HidePassword.anchor(PasswordView.topAnchor, left: nil, bottom: nil, right: PasswordView.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 20 * ratio, widthConstant: 40 * ratio, heightConstant: 40 * ratio)
        
        PasswordBottomLine.anchor(nil, left: IconPassword.leftAnchor, bottom: PasswordView.bottomAnchor, right: Btn_HidePassword.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 3 * ratio)
        
        // Element in KeepMeView -----------------------------------------------
        KeepmeView.addSubview(KeepView)
        KeepView.addSubview(Btn_CheckKeepMe)
        KeepView.addSubview(LabelKeepMe)
        
        KeepView.anchorCenter(KeepmeView.centerXAnchor, AxisY: KeepmeView.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 200 * ratio, heightConstant: 50 * ratio)
        
        Btn_CheckKeepMe.anchor(KeepView.topAnchor, left: KeepView.leftAnchor, bottom: KeepView.bottomAnchor, right: nil, topConstant: 12.5 * ratio, leftConstant: 0, bottomConstant: 12.5 * ratio, rightConstant: 0, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
        
        LabelKeepMe.anchor(nil, left: Btn_CheckKeepMe.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        LabelKeepMe.anchorCenter(nil, AxisY: Btn_CheckKeepMe.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 40 * ratio)
        LabelKeepMe.font = UIFont.PoppinsMedium(size: 18 * ratio)
        
        // Button Login -----------------------------------------------
        BtnLogin.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 60 * ratio)
        
        BtnLogin.layer.cornerRadius = (60 * ratio) / 2
        
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
    
    // Change Status Bar Light Sty
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // Animation Button
    func animation_ButtonClick(Button : UIButton){
        let bounds = Button.bounds
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            Button.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
        }) { (Success : Bool) in
            
        }
    }
    
    // MARK: Start Func Response Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // Func Hide Keyboard when Press 'Done'
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Parameter of Login Page ===================================================
    
    // Static Data
    static var DataLogin : DataUser? // DataLogin

    // Parameter URl
    var urlAdmin : String = DataSource.Url_AdminLogin()//"http://\(DataSource.IP())/arforsales/loginadmin.php"
    var urlUSer : String = DataSource.Url_UserLogin()
    // Filename Directory
    let Filename : [String] = ["StateKeepMe.txt", "Certificate.txt", "Username.txt", "Password.txt"]
    
    // State Button Keep Me
    var BoolCheckKeepMe : Bool = false
    
    // ===========================================================================
    
    // MARK: Config Element
    func Config_Element(){
        
        // Config Element Check Keep Me
        // Read Status of Button KeepMe from Directory
        // Check Verify
        let Data = self.ReadData_FromDoc(FileName: Filename[0])
        
        // if State Keep Me true
        if Data == "true" {
            
            // Get Data from Directory Application
            let CerData = self.ReadData_FromDoc(FileName: Filename[1])
            let UsernameData = self.ReadData_FromDoc(FileName: Filename[2])
            let PasswordData = self.ReadData_FromDoc(FileName: Filename[3])
            
            TxtUsername.text = UsernameData
            TxtPassword.text = PasswordData
            Btn_CheckKeepMe.setImage(#imageLiteral(resourceName: "CheckBox"), for: .normal)
            // Change State
            BoolCheckKeepMe = true
            
            // Show Data in TextField and Send Username and Password to Server and Verify Data Receive
            // Admin Login
            if CerData == "Admin" {
                Seg_ChooseCer.selectItemAt(index: 0, animated: true)
                self.Server_SendDataLogin(Username: UsernameData, Password: PasswordData, Url: urlAdmin)
            }
            // User Login
            else if CerData == "User" {
                Seg_ChooseCer.selectItemAt(index: 1, animated: true)
                self.Server_SendDataLogin(Username: UsernameData, Password: PasswordData, Url: urlUSer)
            }
            
        }
        // Filename Not Data
        else if Data == "Filename wrong" {
            self.SaveData_ToDoc(FileName: Filename[0], Data: "false")
        }
        
        // --------------------------------------------------------
        // Config Response Keyboard
        TxtUsername.delegate = self
        TxtPassword.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        
        
    }
    
    // MARK: Func Event Cycle Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element in Page
        Layout_Application()
        
        // Config Element
        Config_Element()
    
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // Set Hide Keybord
        view.endEditing(true)
        
    }
    // ====================================================
    
    // Event Button Login
    @objc func BtnLogin_Click(){
        
        // Hide Keyboard
        view.endEditing(true)
        
        // Animation Button
        animation_ButtonClick(Button: BtnLogin)
        
        // Admin Login Application
        if Seg_ChooseCer.currentIndex == 0 {
            // Send Username and Password to Server and Verify Data Receive
            self.Server_SendDataLogin(Username: TxtUsername.text, Password: TxtPassword.text, Url: urlAdmin)
        }
        // User Login Application
        else if Seg_ChooseCer.currentIndex == 1 {
            // Next to TabBarUserContainer
            self.Server_SendDataLogin(Username: TxtUsername.text, Password: TxtPassword.text, Url: urlUSer)
        }
        
        
    
        
    }
    //Event Button Check Keep Me Logged In
    @objc func BtnCheckKeep_Click(){

        // Hide Keyboard
        view.endEditing(true)
        
        if BoolCheckKeepMe == false {
            animation_ButtonClick(Button: Btn_CheckKeepMe)
            Btn_CheckKeepMe.setImage(#imageLiteral(resourceName: "CheckBox"), for: .normal)
            // Change State
            BoolCheckKeepMe = true
        }
        else{
            animation_ButtonClick(Button: Btn_CheckKeepMe)
            Btn_CheckKeepMe.setImage(#imageLiteral(resourceName: "UnCheckBox"), for: .normal)
            // Change State
            BoolCheckKeepMe = false
        }
        
    }
    // Event Hide and Show Password
    @objc func HandleHidePassword(){
        if TxtPassword.isSecureTextEntry {
            animation_ButtonClick(Button: Btn_HidePassword)
            Btn_HidePassword.setImage(#imageLiteral(resourceName: "hide").withRenderingMode(.alwaysTemplate), for: .normal)
            Btn_HidePassword.tintColor = UIColor.whiteAlpha(alpha: 0.8)
            TxtPassword.isSecureTextEntry = false
        }
        else {
            animation_ButtonClick(Button: Btn_HidePassword)
            Btn_HidePassword.setImage(#imageLiteral(resourceName: "eye").withRenderingMode(.alwaysTemplate), for: .normal)
            Btn_HidePassword.tintColor = UIColor.whiteAlpha(alpha: 0.8)
            TxtPassword.isSecureTextEntry = true
        }
    }
    
    // MARK: Func Send Data to Server and Verify Data Receive
    func Server_SendDataLogin(Username : String!, Password : String!, Url : String!) {
        
        // Show Loader
        Show_Loader()
        
        // Sent Data to Server
        let parameter = ["Username" : Username, "Password" : Password]
        AF.sessionConfiguration.timeoutIntervalForRequest = 1
        AF.request(Url, method: .post,  parameters: parameter as! [String : String], encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        
                        // Hide Show Loader
                        self.Show_Loader()
                        
                        // Check Response error
                        guard json["results"] != nil else {
                            
                            let errormessage = json["message"] as! String
                            print(errormessage)
                            self.Create_AlertMessage(Title: "Invalid", Message: errormessage)
                            return
                        }
                        
                        // Get Data Response
                        let data = json["results"] as? [String : Any]
                        // Record Data to DataCenter Application (Static Variable)
                        LoginPageController.DataLogin = DataUser(AdminUse: true, CompanyName: "", Logo: #imageLiteral(resourceName: "Logo TheThreeTouch"), CompanyEmail: "", SaleQuan: "", SaleMax: "", ProductQuan: "", ProductMax: "", ProductCustomQuan: "", ProductCustomMax: "", Package: "", Token_Id: data!["Access_token"] as! String)
                        
                        // Record Data Username, Password to Dicrectory
                        self.Record_DatatoDirectory()
                        // Next Page
                        if self.Seg_ChooseCer.currentIndex == 0 {
                            // Record Type User
                            LoginPageController.DataLogin?.AdminUse = true
                            
                            // Next Page
                            self.Next_Page(PageForNext: TabBarAdminContainer())
                        }
                        else if self.Seg_ChooseCer.currentIndex == 1 {
                            // Record Type User
                            LoginPageController.DataLogin?.AdminUse = false
                            
                            // Next Page
                            self.Next_Page(PageForNext: TabBarUserContainer())
                        }
                        
                    }
                case .failure(_):
                    // Close loader
                    self.Show_Loader()
                                   
                    self.Create_AlertMessage(Title: "Network", Message: "Please check your network")
                    break
                }
        }
        /*AF.request(Url, method: .post, parameters: parameter).responseJSON(completionHandler: { (response) in
            
            print(response)
            
            switch response.result {
            case .success(let value):
                print(value)
                // Convert Data (Any) to [String : Any]
                if let json = value as? [[String : String]] {
                    let data = json.first!
                    
                    // Close loader
                    self.Show_Loader()
                    
                    // Verify Process Sign In Server
                    guard data["CompanyName"] != nil else {
                        print(data["STATUS"]!)
                        self.Create_AlertMessage(Title: "Invalid", Message: (data["STATUS"]!))
                        return
                    }
                    
                    // Record Data to DataCenter Application (Static Variable)
                    LoginPageController.DataLogin = DataUser(CompanyName: data["CompanyName"]!, Logo: #imageLiteral(resourceName: "Logo TheThreeTouch"), SaleQuan: data["SalesQuantity"]!, SaleMax: data["SalesMaximum"]!, ProductQuan: data["ProductQuantity"]!, ProductMax: data["ProductMaximum"]!, Package: data["package"]!, Token_Id: data["Token"]!)
        
                    
                    // Record Data Username, Password to Dicrectory
                    self.Record_DatatoDirectory()
                    // Next Page
                    self.Next_Page(PageForNext: TabBarAdminContainer())
                
                }
            case .failure(let error):
                // Close loader
                self.Show_Loader()
                
                self.Create_AlertMessage(Title: "Network", Message: "Please check your network")
                break
            }
            
        })*/
        
    }
    
    // MARK: Next Page , Switch View Loader, Save Data to Dicrectory
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
    
    // Func Next Page
    func Next_Page(PageForNext : UIViewController){
        
        
        // Next To Login Page for watch Example
        //let Next_LoginPage = TabBarAdminContainer()
        //let navigation = UINavigationController(rootViewController: Next_LoginPage)
        //navigation.isNavigationBarHidden = true
        //navigation.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(PageForNext, animated: true)
        
    }
    
    // Func Record Data to Directory
    func Record_DatatoDirectory(){
        // Save Data Login to Directory App
        if BoolCheckKeepMe == true {
            // Save Data
            self.SaveData_ToDoc(FileName: Filename[0], Data: String(BoolCheckKeepMe))
            self.SaveData_ToDoc(FileName: Filename[1], Data: Seg_ChooseCer.titleForItemAtIndex(Seg_ChooseCer.currentIndex))
            self.SaveData_ToDoc(FileName: Filename[2], Data: TxtUsername.text!)
            self.SaveData_ToDoc(FileName: Filename[3], Data: TxtPassword.text!)
            
        }
        else if BoolCheckKeepMe == false {
            // Clear Data in Directory
            self.SaveData_ToDoc(FileName: Filename[0], Data: String(BoolCheckKeepMe))
            self.SaveData_ToDoc(FileName: Filename[1], Data: Seg_ChooseCer.titleForItemAtIndex(0))
            self.SaveData_ToDoc(FileName: Filename[2], Data: "")
            self.SaveData_ToDoc(FileName: Filename[3], Data: "")
        }
    }
    
    // MARK: Alert Box
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: Func Document
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    // Save Data to Directory
    func SaveData_ToDoc(FileName : String, Data : String){
        let url = self.getDocumentsDirectory().appendingPathComponent(FileName)

        do {
            try Data.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    // Read Data From Directory
    func ReadData_FromDoc(FileName : String) -> String {
        let url = self.getDocumentsDirectory().appendingPathComponent(FileName)

        do {
            let input = try String(contentsOf: url)
            return input
        } catch {
            print(error.localizedDescription)
            return "Filename wrong"
        }
    }
    
}

