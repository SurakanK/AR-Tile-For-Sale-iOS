//
//  ColorPickerHEXViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 2/5/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ColorPickerHEXViewController: UIViewController {
    let tokenID = LoginPageController.DataLogin?.Token_Id

    var CellID = "Cell"
    weak var collectionView : UICollectionView?

    var ColorlistData = [[String : Any]]()

    let viewColor: UIView = {
        let view = UIView()
        view.backgroundColor = CustomTileViewController.ColorPicker
        view.layer.cornerRadius = 90
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 5
        return view
    }()
    
    let handleKeyboardDismiss: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let HEXField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "#ffffff", attributes: [NSAttributedString.Key.font :  UIFont.MitrLight(size: 22) , NSAttributedString.Key.foregroundColor:  UIColor.systemGray3])
        textField.textColor = .BlackAlpha(alpha: 0.8)
        textField.font =  UIFont.PoppinsMedium(size: 22)
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.keyboardType = .asciiCapable
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 25
        
        textField.addTarget(nil, action: #selector(FieldeditingChanged), for: .editingChanged)
        textField.addTarget(nil, action: #selector(FieldeditingDidBegin), for: .editingDidBegin)
        textField.addTarget(nil, action: #selector(FieldeditingDidEnd), for: .editingDidEnd)

        return textField
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
        
        view.backgroundColor = .white
        
        navigationItem.title = "Color HEX"
        let Done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Donehandle))
        navigationItem.rightBarButtonItem = Done
        
        view.addSubview(viewColor)
        view.addSubview(HEXField)
        view.addSubview(handleKeyboardDismiss)

        //Touch keyboard Dismiss
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.delegate = self as? UIGestureRecognizerDelegate
        handleKeyboardDismiss.addGestureRecognizer(tapRecognizer)
        
        HEXField.delegate = self
        
        handleKeyboardDismiss.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: HEXField.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        viewColor.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 180, heightConstant: 180)
        viewColor.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        HEXField.anchor(viewColor.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        //config collection view
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = collection
        collectionView!.register(ColorPickerHEXViewCell.self, forCellWithReuseIdentifier: CellID)
        collectionView!.backgroundColor = .white
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
        view.addSubview(collectionView!)
        collectionView?.anchor(HEXField.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        getColorlist(token: tokenID!)
    }
    
    @objc func Donehandle(){
        self.dismiss(animated: true, completion: nil)
        
        let color = viewColor.backgroundColor
        if color != nil {
            CustomTileViewController.ColorPicker = color!
            NotificationCenter.default.post(name: NSNotification.Name("ColorSelectUpdate"), object: nil)

        }
       
    }
    
    @objc func FieldeditingChanged(){
        if HEXField.text?.count == 7{
            let HEXcode = HEXField.text! + "ff"
            viewColor.backgroundColor = UIColor(hex: HEXcode)
        }
        
        if HEXField.text?.count == 0{
            HEXField.text = "#"
        }
    }
    
    @objc func FieldeditingDidBegin(){
        if HEXField.text?.count == 0{
            HEXField.text = "#"
        }
    }
    
    @objc func FieldeditingDidEnd(){
        if HEXField.text?.count == 1{
            HEXField.text = ""
        }
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        if HEXField.isTouchInside == true{
            view.endEditing(true)
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
    
    func getColorlist(token:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_saleGetColor()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.ColorlistData = JSON!["results"] as! [[String : Any]]
                    
                    self.collectionView!.reloadData()
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

extension ColorPickerHEXViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ColorlistData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! ColorPickerHEXViewCell
        
        let colorHexCode = ColorlistData[indexPath.row]["ColorHex"] as! String
        let StatusColor = ColorlistData[indexPath.row]["Popular"] as! Int

        cell.viewColor.backgroundColor = UIColor(hex: colorHexCode + "FF" )
        cell.HEXColortitle.text = colorHexCode
        
        if StatusColor == 0{
            cell.ColorStatus.backgroundColor = .BlueDeep
        }else{
            cell.ColorStatus.backgroundColor = .systemOrange
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let colorHexCode = ColorlistData[indexPath.row]["ColorHex"] as! String
        viewColor.backgroundColor = UIColor(hex: colorHexCode + "FF" )
        
        self.dismiss(animated: true, completion: nil)
        
        let color = viewColor.backgroundColor
        if color != nil {
            CustomTileViewController.ColorPicker = color!
            NotificationCenter.default.post(name: NSNotification.Name("ColorSelectUpdate"), object: nil)

        }
        
    }

}

extension ColorPickerHEXViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth: CGFloat = (UIScreen.main.bounds.width) / 4
        return CGSize(width: itemWidth, height: itemWidth)
     }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        
         return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
     
}

extension ColorPickerHEXViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 7
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
