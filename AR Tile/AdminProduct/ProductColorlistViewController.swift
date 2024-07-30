//
//  ProductColorlistViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 22/5/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import TTSegmentedControl
import Alamofire

class ProductColorlistViewController: UIViewController,UINavigationControllerDelegate{
    
    let tokenID = LoginPageController.DataLogin?.Token_Id

    var searching = false
    let SearchController = UISearchController(searchResultsController: nil)

    var ColorlistData = [[String : Any]]()
    var ColorlistDatasearch = [[String:Any]]()

    var CellID = "Cell"
    weak var tableView : UITableView?

    //View insert color list---------------------------------------------
    let viewBlurBackgroung: UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.8)
        return view
    }()
    
    let viewInsertColorList: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let viewShowColor: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.systemGray6.cgColor
        return view
    }()
    
    var ColorHEXCodeField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "#ffffff", attributes: [NSAttributedString.Key.font :  UIFont.PoppinsRegular(size: 22), NSAttributedString.Key.foregroundColor:  UIColor.systemGray3])
        textField.textColor = .BlackAlpha(alpha: 0.8)
        textField.font =  UIFont.PoppinsRegular(size: 22)
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.keyboardType = .asciiCapable
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.borderWidth = 1
        
        textField.addTarget(nil, action: #selector(FieldeditingChanged), for: .editingChanged)
        textField.addTarget(nil, action: #selector(FieldeditingDidBegin), for: .editingDidBegin)
        textField.addTarget(nil, action: #selector(FieldeditingDidEnd), for: .editingDidEnd)

        return textField
    }()
    
    let CloseButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setBackgroundImage(#imageLiteral(resourceName: "remove").withTintColor(.BlueDeep), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        button.addTarget(self, action: #selector(DismissViewInsertColor), for: .touchUpInside)
        return button
    }()
    
    let SegmenControl: TTSegmentedControl = {
       let Segmen = TTSegmentedControl()
        Segmen.defaultTextFont = UIFont.PoppinsRegular(size: 18)
        Segmen.defaultTextColor = .BlackAlpha(alpha: 0.3)

        Segmen.selectedTextFont = UIFont.PoppinsRegular(size: 18)
        Segmen.selectedTextColor = .white
        
        Segmen.thumbGradientColors = [.systemOrange,.systemOrange]
        Segmen.itemTitles = ["Nomal","Popular"]
        
        Segmen.useShadow = true
        Segmen.allowChangeThumbWidth = false
        return Segmen
    }()
    
    let insertButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueDeep
        button.layer.cornerRadius = 10
        button.setTitle("Insert Color", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.PoppinsRegular(size: 20)
        button.addTarget(self, action: #selector(insertColorlist), for: .touchUpInside)
        return button
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

        // ConfigNavigation Bar
        navigationItem.title = "Manage Color list"
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
        navigationController?.navigationBar.backgroundColor = .BlueDeep
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
        
        //config cearch controller
        SearchController.searchResultsUpdater = self
        SearchController.searchBar.delegate = self
        SearchController.searchBar.searchBarStyle = .minimal
        SearchController.obscuresBackgroundDuringPresentation = false
        SearchController.searchBar.searchTextField.backgroundColor = .white
        SearchController.searchBar.tintColor = .white
        SearchController.searchBar.placeholder = "search your Color"
        SearchController.searchBar.searchTextField.font = UIFont.MitrLight(size: 18)
        SearchController.searchBar.searchTextField.textColor = .BlackAlpha(alpha: 0.8)
        
        navigationItem.searchController = SearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DismissKeyBoardSearchBar))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // ConfigRegister Tableview cell
        let table =  UITableView(frame: .zero)
        tableView = table
        tableView!.rowHeight = UITableView.automaticDimension
        tableView!.backgroundColor = .white
        tableView!.register(ProductColorlistViewCell.self, forCellReuseIdentifier: CellID)
        tableView!.delegate = self
        tableView!.dataSource = self
        
        //set layout viewController
        view.addSubview(tableView!)
        tableView!.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //Set layout View insert color list
        SetlayoutViewInsertColorList()
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
    }
    
    @objc func DismissKeyBoardSearchBar(){
        self.SearchController.searchBar.endEditing(true)
    }
    
    func SetlayoutViewInsertColorList(){
        
        let ScreenWidth = UIScreen.main.bounds.width - 40
        
        view.addSubview(viewBlurBackgroung)
        viewBlurBackgroung.addSubview(viewInsertColorList)
        viewBlurBackgroung.addSubview(CloseButton)
        viewBlurBackgroung.addSubview(viewShowColor)
        viewBlurBackgroung.addSubview(ColorHEXCodeField)
        viewBlurBackgroung.addSubview(SegmenControl)
        viewBlurBackgroung.addSubview(insertButton)
        
        viewBlurBackgroung.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        viewInsertColorList.anchorCenter(view.centerXAnchor, AxisY: view.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: ScreenWidth, heightConstant: ScreenWidth)
        
        CloseButton.anchor(viewInsertColorList.topAnchor, left: nil, bottom: nil, right: viewInsertColorList.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 30, heightConstant: 30)
        
        viewShowColor.anchor(viewInsertColorList.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        viewShowColor.anchorCenter(viewInsertColorList.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        ColorHEXCodeField.anchor(viewShowColor.bottomAnchor, left: viewInsertColorList.leftAnchor, bottom: nil, right: viewInsertColorList.rightAnchor, topConstant: 20, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        SegmenControl.anchor(ColorHEXCodeField.bottomAnchor, left: viewInsertColorList.leftAnchor, bottom: nil, right: viewInsertColorList.rightAnchor, topConstant: 15, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50)
        
        insertButton.anchor(SegmenControl.bottomAnchor, left: viewInsertColorList.leftAnchor, bottom: viewInsertColorList.bottomAnchor, right: viewInsertColorList.rightAnchor, topConstant: 15, leftConstant: 30, bottomConstant: 15, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
        
        //
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.delegate = self as? UIGestureRecognizerDelegate
        viewInsertColorList.addGestureRecognizer(tapRecognizer)

        //
        ColorHEXCodeField.delegate = self
        
        viewBlurBackgroung.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getColorlist(token: tokenID!)
    }
    
    @objc func addTapped(){
        if viewBlurBackgroung.isHidden == true{
            viewBlurBackgroung.isHidden = false
            ColorHEXCodeField.text = ""
            viewShowColor.backgroundColor = .white
            SegmenControl.selectItemAt(index: 0)
        }
    }
    
    @objc func insertColorlist(){
        
        let HEXcode = ColorHEXCodeField.text! + "ff"
        let CheckColor = UIColor(hex: HEXcode)
        
        if ColorHEXCodeField.text!.count == 7 && CheckColor != nil{
            let ColorHex = ColorHEXCodeField.text?.uppercased()
            let Stage = SegmenControl.currentIndex

            insertColor(token: tokenID!, ColorHex: ColorHex!, Stage: Stage)
        }else{
            ColorHEXCodeField.layer.borderColor = UIColor.systemRed.cgColor
            Create_AlertMessage(Title: "amiss", Message: "Please fill in the correct information.")
        }
                
        
    }
    
    @objc func DismissViewInsertColor(){
        viewBlurBackgroung.isHidden = true
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func FieldeditingChanged(){
        if ColorHEXCodeField.text?.count == 7{
            let HEXcode = ColorHEXCodeField.text! + "ff"
            viewShowColor.backgroundColor = UIColor(hex: HEXcode)
        }
        
        if ColorHEXCodeField.text?.count == 0{
            ColorHEXCodeField.text = "#"
        }
    }
    
    @objc func FieldeditingDidBegin(){
        if ColorHEXCodeField.text?.count == 0{
            ColorHEXCodeField.text = "#"
        }
    }
    
    @objc func FieldeditingDidEnd(){
        if ColorHEXCodeField.text?.count == 1{
            ColorHEXCodeField.text = ""
            ColorHEXCodeField.layer.borderColor = UIColor.BlueDeep.cgColor
        }else if ColorHEXCodeField.text!.count > 1 && ColorHEXCodeField.text!.count != 7{
            ColorHEXCodeField.layer.borderColor = UIColor.systemRed.cgColor
        }else{
            ColorHEXCodeField.layer.borderColor = UIColor.BlueDeep.cgColor
        }
    }
    
    func getColorlist(token:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminGetColor()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.ColorlistData = JSON!["results"] as! [[String : Any]]
                    
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
    
    func insertColor(token:String,ColorHex:String,Stage:Int){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminInsertColor()
        let parameters = ["ColorHex":ColorHex,"Popular":Stage] as [String : Any]
        
        AF.request(Url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    // Close loader
                    self.Show_Loader()
                    self.viewBlurBackgroung.isHidden = true
                    self.viewWillAppear(true)
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func delProductColor(token:String,idCompanyColor:Int){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminDelColor()
        let parameters = ["idCompanyColor":idCompanyColor]
        
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

//MARK: Event SearchBar
extension ProductColorlistViewController: UISearchBarDelegate , UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
           
           let searchText = searchController.searchBar.text
           
           if searchText!.count > 0{
           
            self.ColorlistDatasearch = ColorlistData.filter{($0["ColorHex"] as! String).lowercased().prefix(searchText!.lowercased().count) == searchText!.lowercased()}
                            
                searching = true
                tableView!.reloadData()
           }else{
                searching = false
                tableView!.reloadData()
           }

       }
           
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchBar.text = ""
           searching = false
        //collectionView!.reloadData()
       }
}

extension ProductColorlistViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching{
            return ColorlistDatasearch.count
        }else{
            return ColorlistData.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! ProductColorlistViewCell
        
        //
        var colorHexCode = ""
        var StatusColor = 0
        if searching{
            colorHexCode = ColorlistDatasearch[indexPath.row]["ColorHex"] as! String
            StatusColor = ColorlistDatasearch[indexPath.row]["Popular"] as! Int
        }else{
            colorHexCode = ColorlistData[indexPath.row]["ColorHex"] as! String
            StatusColor = ColorlistData[indexPath.row]["Popular"] as! Int
        }
        
        //
        cell.HexCodeTitle.text = colorHexCode
        cell.viewColor.backgroundColor = UIColor(hex: colorHexCode + "FF" )

        //
        if StatusColor == 0{
            cell.viewStatus.backgroundColor = .BlueDeep
            cell.Statustitle.text = "Normal"
        }else{
            cell.viewStatus.backgroundColor = .systemOrange
            cell.Statustitle.text = "Popular"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
              
        
        let delete = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in

            //alert message searching or nomal
            var ColorHEX = ""
            if self.searching{
                ColorHEX = self.ColorlistDatasearch[indexPath.row]["ColorHex"] as! String
            }else{
                ColorHEX = self.ColorlistData[indexPath.row]["ColorHex"] as! String
            }
            
            let alert = UIAlertController(title: "Do You Want to Delete This Color?", message: ColorHEX, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
                 
                if self.searching{
                    //find id color in stage nomal and delete data
                    let id = self.ColorlistDatasearch[indexPath.row]["idCompanyColor"] as? Int
                    let index = self.ColorlistData.indices.filter({self.ColorlistData[$0]["idCompanyColor"] as? Int == id})
                    
                    //delete color in server
                    self.delProductColor(token: self.tokenID!, idCompanyColor: id!)
                    
                    //delete data in tableview
                    self.tableView!.setEditing(false, animated: true)
                    self.ColorlistData.remove(at: index[0])
                    self.ColorlistDatasearch.remove(at: indexPath.row)
                    self.tableView!.deleteRows(at: [indexPath], with: .automatic)

                }else{
                    //find id color
                    let id = self.ColorlistData[indexPath.row]["idCompanyColor"] as? Int
                    self.tableView!.setEditing(false, animated: true)
                    
                    //delete color in server
                    self.delProductColor(token: self.tokenID!, idCompanyColor: id!)
                    
                    //delete data in tableview
                    self.tableView!.setEditing(false, animated: true)
                    self.ColorlistData.remove(at: indexPath.row)
                    self.tableView!.deleteRows(at: [indexPath], with: .automatic)
                }
               
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            completionHandler(true)
        }
              
        
              
        delete.backgroundColor = .white
        delete.image = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40)).image { _ in
               #imageLiteral(resourceName: "remove").withTintColor(UIColor.rgb(red: 255, green: 105, blue: 97)).draw(in: CGRect(x: 0, y: 0, width: 40, height: 40))}
                      
        let configuration = UISwipeActionsConfiguration(actions: [delete])
           
        return configuration
              
    }
    
}

extension ProductColorlistViewController: UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if(textField == ColorHEXCodeField){
        
            let invalidCharacters = CharacterSet(charactersIn: "AaBbCcDdEeFf0123456789").inverted
            let textCharacter = string.rangeOfCharacter(from: invalidCharacters)
            let currentText = textField.text! + string
            let count = currentText.count <= 7
        
            if count == true && textCharacter == nil{
                return true
            }else{
                return false
            }
            
        }
        return true;
    }
}



