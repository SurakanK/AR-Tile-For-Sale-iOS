//
//  ProductAddPhotoViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 6/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//
import UIKit
import Alamofire
import TTSegmentedControl
import NVActivityIndicatorView

class ProductAddPhotoViewController: UIViewController, UICollectionViewDelegateFlowLayout , UINavigationControllerDelegate , UITextViewDelegate, UICollectionViewDataSource{
    let tokenID = LoginPageController.DataLogin?.Token_Id

    private var CellID = "Cell"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var indexfinish = 0
    
    var textname = [String]()
    var textdescription = [String]()
    var textprice = [String]()
    var textwidth = [String]()
    var textheight = [String]()
    var textpattern = [Int]()
    var textRemark = [String]()
    
    var NameFieldborderColor = [UIColor]()
    var PriceFieldborderColor = [UIColor]()
    var SizeWidthFieldborderColor = [UIColor]()
    var SizeHeighFieldborderColor = [UIColor]()
    
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
        navigationItem.title = "Add Product"
                
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
                        
        let Done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoneTapped))
        navigationItem.rightBarButtonItem = Done
                
        //config collection view
        collectionView.register(ProductAddPhotoViewCell.self, forCellWithReuseIdentifier: CellID)
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.dataSourceSectionIndex(forPresentationSectionIndex: 1)
        
        view.addSubview(collectionView)
        collectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let section = ProductPhotolibraryViewController.PhotosPicker.count
        textname = [String](repeating: "", count: section)
        textdescription = [String](repeating: "", count: section)
        textRemark = [String](repeating: "", count: section)
        textprice = [String](repeating: "", count: section)
        textwidth = [String](repeating: "", count: section)
        textheight = [String](repeating: "", count: section)
        textpattern = [Int](repeating: 0, count: section)
        
        NameFieldborderColor = [UIColor](repeating: .BlueDeep, count: section)
        PriceFieldborderColor = [UIColor](repeating: .BlueDeep, count: section)
        SizeWidthFieldborderColor = [UIColor](repeating: .BlueDeep, count: section)
        SizeHeighFieldborderColor = [UIColor](repeating: .BlueDeep, count: section)
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = ProductPhotolibraryViewController.PhotosPicker.count
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! ProductAddPhotoViewCell
        
        cell.NameField.addTarget(self, action: #selector(NameFieldChange), for: .editingChanged)
        cell.PriceField.addTarget(self, action: #selector(PriceFieldChange), for: .editingChanged)
        cell.SizeWidthField.addTarget(self, action: #selector(SizeWidthFieldChange), for: .editingChanged)
        cell.SizeHeighField.addTarget(self, action: #selector(SizeHeighFieldChange), for: .editingChanged)
        
        cell.NameField.addTarget(self, action: #selector(NameFieldDidEnd), for: .editingDidEnd)
        cell.PriceField.addTarget(self, action: #selector(PriceFieldDidEnd), for: .editingDidEnd)
        cell.SizeWidthField.addTarget(self, action: #selector(SizeWidthFieldDidEnd), for: .editingDidEnd)
        cell.SizeHeighField.addTarget(self, action: #selector(SizeHeighFieldDidEnd), for: .editingDidEnd)
        
        cell.TextDescription.delegate = self
        cell.TextRemark.delegate = self

        cell.SegmenControl.didSelectItemWith = { (Index,text) -> () in
            self.textpattern[indexPath.row] = Index
        }
        
        cell.NameField.text = textname[indexPath.row]
        cell.PriceField.text = textprice[indexPath.row]
        cell.SizeWidthField.text = textwidth[indexPath.row]
        cell.SizeHeighField.text = textheight[indexPath.row]
        cell.TextDescription.text = textdescription[indexPath.row]
        cell.TextRemark.text = textRemark[indexPath.row]
        cell.SegmenControl.selectItemAt(index: textpattern[indexPath.row])
        
        cell.TextDescription.tag = 0
        cell.TextRemark.tag = 1
        
        cell.imageProduct.image = ProductPhotolibraryViewController.PhotosPicker[indexPath.row]
        
        
        cell.PriceField.delegate = self
        cell.SizeWidthField.delegate = self
        cell.SizeHeighField.delegate = self
        
        cell.NameField.layer.borderColor = NameFieldborderColor[indexPath.row].cgColor
        cell.PriceField.layer.borderColor = PriceFieldborderColor[indexPath.row].cgColor
        cell.SizeWidthField.layer.borderColor = SizeWidthFieldborderColor[indexPath.row].cgColor
        cell.SizeHeighField.layer.borderColor = SizeHeighFieldborderColor[indexPath.row].cgColor
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: collectionView.bounds.width - 20, height: 440)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @objc func NameFieldChange(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        
        textname[indexPath!.row] = sender.text
    }
    
    @objc func PriceFieldChange(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        
        textprice[indexPath!.row] = sender.text
    }
    
    @objc func SizeWidthFieldChange(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        
        textwidth[indexPath!.row] = sender.text
    }
    
    @objc func SizeHeighFieldChange(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        
        textheight[indexPath!.row] = sender.text
    }
    
    @objc func NameFieldDidEnd(textField: UITextField){
        
        if textField.text?.isEmpty == true{
            textField.layer.borderColor = UIColor.systemRed.cgColor
        }else{
            textField.layer.borderColor = UIColor.BlueDeep.cgColor
        }
    }
    
    @objc func PriceFieldDidEnd(textField: UITextField){
        
        if textField.text?.isEmpty == true{
            textField.layer.borderColor = UIColor.systemRed.cgColor
        }else{
            textField.layer.borderColor = UIColor.BlueDeep.cgColor
        }
    }
    
    @objc func SizeWidthFieldDidEnd(textField: UITextField){
        
        if textField.text?.isEmpty == true{
            textField.layer.borderColor = UIColor.systemRed.cgColor
        }else{
            textField.layer.borderColor = UIColor.BlueDeep.cgColor
        }
    }
    
    @objc func SizeHeighFieldDidEnd(textField: UITextField){
        if textField.text?.isEmpty == true{
            textField.layer.borderColor = UIColor.systemRed.cgColor
        }else{
            textField.layer.borderColor = UIColor.BlueDeep.cgColor
        }
    
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let point : CGPoint = textView.convert(textView.bounds.origin, to: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
    
        if textView.tag == 0{
            textdescription[indexPath!.row] = textView.text
        }else{
            textRemark[indexPath!.row] = textView.text
        }
    }
    
    
    
    @objc func DoneTapped(){
        
        //Check TextField No text
        let Checkname = textname.filter({$0 == ""}).isEmpty
        let Checkprice = textprice.filter({$0 == ""}).isEmpty
        let Checkwidth = textwidth.filter({$0 == ""}).isEmpty
        let Checkheight = textheight.filter({$0 == ""}).isEmpty
        
        if Checkname == true && Checkprice == true && Checkwidth == true && Checkheight == true{
            
            let index = ProductPhotolibraryViewController.PhotosPicker.count
             // Show Loader
             Show_Loader()
                     
             for i in 0..<index{
                 let name = textname[i]
                 let description = textdescription[i]
                 let remark = textRemark[i]
                 let price = textprice[i]
                 let width = textwidth[i]
                 let height = textheight[i]
                 let pattern = String(textpattern[i])
                 
                 let imagePhoto = ProductPhotolibraryViewController.PhotosPicker[i].resizeImageUpload()
                
                 let timestamp = Int(NSDate().timeIntervalSince1970 * 1000000)
                 let path = name + "_" + String(timestamp)
                 
                 self.UploadimageProduct(token: tokenID!, path: path, image: imagePhoto, name: name, description: description, price: price, width: width, height: height, pattern: pattern, remark: remark)
             }
        }else{
            self.Create_AlertMessage(Title: "amiss", Message: "Please fill out all information.")
            
            let count = ProductPhotolibraryViewController.PhotosPicker.count
            
            for index in 0..<count{
                                
                if textname[index] == ""{
                    NameFieldborderColor[index] = .systemRed
                }else{
                    NameFieldborderColor[index] = .BlueDeep
                }
                
                if textprice[index] == ""{
                    PriceFieldborderColor[index] = .systemRed
                }else{
                    PriceFieldborderColor[index] = .BlueDeep
                }
                
                if textwidth[index] == ""{
                    SizeWidthFieldborderColor[index] = .systemRed
                }else{
                    SizeWidthFieldborderColor[index] = .BlueDeep
                }
                
                if textheight[index] == ""{
                    SizeHeighFieldborderColor[index] = .systemRed
                }else{
                    SizeHeighFieldborderColor[index] = .BlueDeep
                }
                
            }
            
            collectionView.reloadData()
        }
        
        
    }
    
    func UploadimageProduct(token:String, path:String, image:UIImage, name:String,
                            description:String, price:String, width:String, height:String,
                            pattern:String, remark:String){
       
    
        var image = image
        if image.size.width == 0{
            image = UIImage(color: .white, size: CGSize(width: 1, height: 1))!
        }
        
        let base64Image = image.toBase64()
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let parameter = ["path":"product/" + path + ".jpg","bucket":"arforsalesfullimage","image":base64Image]
        let Url = DataSource.Url_ImageUploadImage()
        
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
                
                switch response.result{
                case .success(let value):
                    let JSON = value as? [String : Any]
                    
                    if JSON!["Key"] != nil{
                        let key = JSON!["Key"] as! String
        
                        self.insertProduct(token: self.tokenID!, name: name, description: description, price: price, key: key, width: width, height: height, pattern: pattern, remark: remark)
                    }
        
                case .failure(_):
                    
                    break
                }
        })
    }
    
    func insertProduct(token:String, name:String,description:String,
                       price:String,key:String,width:String,height:String,
                       pattern:String,remark:String){

        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminInsertProduct()
        
        let parameter = ["Name":name,"Description":description,"Price":price,"Image":key,
                         "Width":width,"Height":height,"Pattern":pattern,"Remark":remark]

        
        AF.request(Url, method: .post,parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                if JSON!["results"] != nil{
                    
                    let indexMax = ProductPhotolibraryViewController.PhotosPicker.count
                   
                    self.indexfinish = self.indexfinish + 1
                    
                    if self.indexfinish == indexMax{
                        // Close loader
                        self.Show_Loader()
                        self.navigationController?.popViewController(animated: true)
                    }
                    
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

extension ProductAddPhotoViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 0{
            let invalidCharacters = CharacterSet(charactersIn: "123456789").inverted
            return string.rangeOfCharacter(from: invalidCharacters) == nil
        }else{
            let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
            return string.rangeOfCharacter(from: invalidCharacters) == nil
        }
    }
    
}
