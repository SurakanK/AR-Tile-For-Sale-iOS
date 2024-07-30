//
//  CustomTileViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 26/4/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import TTSegmentedControl
import PaintBucket
import FlexColorPicker
import Alamofire
import NVActivityIndicatorView

class CustomTileViewController: UIViewController{
        
    let tokenID = LoginPageController.DataLogin?.Token_Id

    static var ColorPicker = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
    static var imageCustom = UIImage()
    let image = CustomTileViewController.imageCustom
    //let image = #imageLiteral(resourceName: "GA-022_20x20_1950_")

    var imageHistory = [UIImage]()
    var ColorHistory = [UIColor]()
    
    var ProductData = [String : Any]()
    var ProductDataSpecific = [String : Any]()
    
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
    
    //Top Control image Custom--------------------------------------------------------
    let RedoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueLight
        button.layer.cornerRadius = 20
        button.setImage(#imageLiteral(resourceName: "undo"), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.addTarget(self, action: #selector(handkeRedoButton), for: .touchUpInside)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueLight
        button.layer.cornerRadius = 20
        button.setImage(#imageLiteral(resourceName: "brush"), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.addTarget(self, action: #selector(handleclearButton), for: .touchUpInside)
        return button
    }()
    
    let ARButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        button.setImage(#imageLiteral(resourceName: "3d"), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.addTarget(self, action: #selector(handleToARPage), for: .touchUpInside)
        return button
    }()
    
    let addToCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(handleaddToCategory), for: .touchUpInside)
        return button
    }()
    
    let SegmenControl: TTSegmentedControl = {
       let Segmen = TTSegmentedControl()
        Segmen.defaultTextFont = UIFont.MitrLight(size: 13)
        Segmen.defaultTextColor = .BlueDeep

        Segmen.selectedTextFont = UIFont.MitrLight(size: 13)
        Segmen.selectedTextColor = .white
        
        Segmen.thumbGradientColors = [.BlueDeep,.BlueDeep]
        Segmen.itemTitles = ["1 Tile","4 Tile"]
        
        Segmen.useShadow = true
        Segmen.allowChangeThumbWidth = false
        return Segmen
    }()
    
    //Table Custom image--------------------------------------------------------
    var ScrollView : UIScrollView = {
        let ScrollView = UIScrollView()
        ScrollView.contentMode = .scaleAspectFit
        return ScrollView
    }()
    
    var imageCustom: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    
    //Color Control bottom--------------------------------------------------------
    let ColorPickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueDeep
        button.setImage(#imageLiteral(resourceName: "painting"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleColorPicker), for: .touchUpInside)
        return button
    }()
    
    let ColorListButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueDeep
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handelColorList), for: .touchUpInside)
        return button
    }()
    
    //Color Preview Select--------------------------------------------------------
    let viewColor: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemFill
        view.layer.cornerRadius = 20
        return view
    }()
    
    let ColorSelect: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.systemGray6.cgColor
        return view
    }()
    
    let HEXCodeLable: UILabel = {
        let label = UILabel()
        label.text = UIColor.white.toHexString()
        label.adjustsFontSizeToFitWidth = true
        label.textColor =  UIColor.systemGray6
        label.font = UIFont.MitrExLight(size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .midnightBlue
       
        //Set Image
        imageCustom.image = image
        imageHistory.append(image)
        
        //Set Color Select
        ColorSelect.backgroundColor = CustomTileViewController.ColorPicker
        
        //Update Color Select--------------------------------------------------------------------
        NotificationCenter.default.addObserver(self, selector: #selector(ColorSelectUpdate(notification:)), name: NSNotification.Name(rawValue: "ColorSelectUpdate"), object: nil)
        
        //Set ScrollView-------------------------------------------------------------------------
        let ScreenSize = UIScreen.main.bounds.width
        let minimumZoom = UIScreen.main.bounds.width / image.size.width
        ScrollView.delegate = self
        ScrollView.maximumZoomScale = 3.0
        ScrollView.minimumZoomScale = minimumZoom
        ScrollView.setZoomScale(minimumZoom, animated: true)

        // Set Element Table Custom image---------------------------------------------------------
        view.addSubview(ScrollView)
        ScrollView.addSubview(imageCustom)
        
        ScrollView.anchorCenter(view.centerXAnchor, AxisY: view.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: ScreenSize, heightConstant: ScreenSize)
                        
        imageCustom.anchor(ScrollView.topAnchor, left: ScrollView.leftAnchor, bottom: ScrollView.bottomAnchor, right: ScrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        //Set Touch LongPress in ScrollView----------------------------------------------------
        let TouchLongPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        TouchLongPress.minimumPressDuration = 0.3
        TouchLongPress.delaysTouchesBegan = true
        ScrollView.addGestureRecognizer(TouchLongPress)
        
        //Set Element Top Control image Custom----------------------------------------------------
        view.addSubview(RedoButton)
        view.addSubview(clearButton)
        view.addSubview(ARButton)
        view.addSubview(addToCategoryButton)
        view.addSubview(SegmenControl)

        RedoButton.anchor(nil, left: ScrollView.leftAnchor, bottom: ScrollView.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 20, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        clearButton.anchor(nil, left: RedoButton.rightAnchor, bottom: ScrollView.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 20, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        ARButton.anchor(nil, left: clearButton.rightAnchor, bottom: ScrollView.topAnchor, right: nil, topConstant: 0, leftConstant: 30, bottomConstant: 20, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        addToCategoryButton.anchor(nil, left: ARButton.rightAnchor, bottom: ScrollView.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 20, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        SegmenControl.anchor(nil, left: addToCategoryButton.rightAnchor, bottom: ScrollView.topAnchor, right: ScrollView.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 20, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        
        // View Buttom menu--------------------------------------------------------------
        let viewColorPickerButtom = UIView()
        viewColorPickerButtom.backgroundColor = .red
        let viewColorListButtom = UIView()
        viewColorListButtom.backgroundColor = .green
        
        // StackView-------------------------------------------------------------------
        let StackView = UIStackView(arrangedSubviews: [viewColorPickerButtom,viewColorListButtom])
        StackView.axis = .horizontal
        StackView.distribution = .fillEqually
        StackView.spacing = 1
        
        // Set Element Color Control bottom--------------------------------------------------------
        view.addSubview(StackView)
        StackView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        viewColorPickerButtom.addSubview(ColorPickerButton)
        viewColorListButtom.addSubview(ColorListButton)
        
        ColorPickerButton.anchor(viewColorPickerButtom.topAnchor, left: viewColorPickerButtom.leftAnchor, bottom: viewColorPickerButtom.bottomAnchor, right: viewColorPickerButtom.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        ColorListButton.anchor(viewColorListButtom.topAnchor, left: viewColorListButtom.leftAnchor, bottom: viewColorListButtom.bottomAnchor, right: viewColorListButtom.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let inset = (UIScreen.main.bounds.width / 2) / 2 - 15
        ColorPickerButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: inset, bottom: 10, right: inset)
        ColorListButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: inset, bottom: 10, right: inset)
        
       //Event SegmenControl didselect----------------------------------------------------------
        SegmenControl.didSelectItemWith = { (Index,text) -> () in
            if Index == 0{
                let image = self.imageHistory.last
                let minimumZoom = UIScreen.main.bounds.width / image!.size.width
                self.ScrollView.minimumZoomScale = minimumZoom
                self.ScrollView.setZoomScale(minimumZoom, animated: true)
                
                self.imageCustom.image = image
            }else{
                let image = self.Assembly(ImageASB: self.imageHistory.last!)
                let minimumZoom = UIScreen.main.bounds.width / image.size.width
                self.ScrollView.minimumZoomScale = minimumZoom
                self.ScrollView.setZoomScale(minimumZoom, animated: true)
                
                self.imageCustom.image = self.Assembly(ImageASB: self.imageHistory.last!)
            }
        }

        // Set Element Color Preview Select--------------------------------------------------------
        view.addSubview(viewColor)
        viewColor.addSubview(ColorSelect)
        viewColor.addSubview(HEXCodeLable)
        
        viewColor.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        viewColor.anchor(ScrollView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 40)
        
        ColorSelect.anchor(viewColor.topAnchor, left: viewColor.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        HEXCodeLable.anchor(viewColor.topAnchor, left: ColorSelect.rightAnchor, bottom: viewColor.bottomAnchor, right: viewColor.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        //--------------------------------------------------
        AnimationViewLoadAnchor()
    }
    
    @objc func ColorSelectUpdate(notification: NSNotification) {
        ColorSelect.backgroundColor = CustomTileViewController.ColorPicker
        HEXCodeLable.text = CustomTileViewController.ColorPicker.toHexString()
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        guard SegmenControl.currentIndex == 0 else {return}
       
        if gestureReconizer.state == UIGestureRecognizer.State.began {
            let Position = gestureReconizer.location(ofTouch: 0, in: ScrollView)
            let ScrollWidth = ScrollView.contentSize.width
            let Scrollheight = ScrollView.contentSize.height
            let ImageWidth = imageCustom.image?.size.width
            let Imageheight = imageCustom.image?.size.height
            
            let X = map(x: Position.x, in_min: 0, in_max: ScrollWidth, out_min: 0, out_max: ImageWidth!)
            let Y = map(x: Position.y, in_min: 0, in_max: Scrollheight, out_min: 0, out_max: Imageheight!)
            
            let color = CustomTileViewController.ColorPicker
            let imageWithoutBackground = imageCustom.image!.pbk_imageByReplacingColorAt(Int(X),Int(Y), withColor: color, tolerance: 1000,antialias: true)
            
            imageCustom.image = imageWithoutBackground
            imageHistory.append(imageWithoutBackground)
            ColorHistory.append(color)
        }
    }
    
    @objc func handleColorPicker(){
        let colorPickerController = DefaultColorPickerViewController()
        colorPickerController.selectedColor = CustomTileViewController.ColorPicker
        colorPickerController.delegate = self
        colorPickerController.useRadialPalette = false
        let navigationController = UINavigationController(rootViewController: colorPickerController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func handelColorList(){
        let colorPickerController = ColorPickerHEXViewController()
        let navigationController = UINavigationController(rootViewController: colorPickerController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func handleclearButton(){
        imageCustom.image = image
        
        imageHistory.removeAll()
        ColorHistory.removeAll()
        imageHistory.append(image)
        
        let minimumZoom = UIScreen.main.bounds.width / (imageCustom.image?.size.width)!
        self.ScrollView.minimumZoomScale = minimumZoom
        self.ScrollView.setZoomScale(minimumZoom, animated: true)
    
        SegmenControl.selectItemAt(index: 0, animated: true)
    }
    
    @objc func handkeRedoButton(){
        guard imageHistory.count != 1 else {return}
        imageHistory.removeLast()
        ColorHistory.removeLast()
        imageCustom.image = imageHistory[imageHistory.count - 1]
        
        let minimumZoom = UIScreen.main.bounds.width / (imageCustom.image?.size.width)!
        self.ScrollView.minimumZoomScale = minimumZoom
        self.ScrollView.setZoomScale(minimumZoom, animated: true)
        
        SegmenControl.selectItemAt(index: 0, animated: true)
    }
    
    @objc func handleaddToCategory(){
        
        // Dimension split data width and height
        let Dimension = ProductDataSpecific["Dimension"] as? String
        let DimensionArr = Dimension?.components(separatedBy: " x ")
        
        //Removing duplicate Color in Customtile and Convert Data To HexCode
        var HexColorAll = String()
        let unique = Array(Set(ColorHistory))
        for i in 0..<unique.count{
            HexColorAll = HexColorAll + unique[i].toHexString() + "\n"
        }
        
        //Creat ProductName Custom
        let timestamp = String(Int(NSDate().timeIntervalSince1970 * 1000000))
        let CustomCode = timestamp.suffix(4)
        var name = (ProductData["ProductName"] as? String)!
        name = name + " [C-" + CustomCode + "]"
        
        //Insert Color HexCode to description
        var description = (ProductDataSpecific["ProductDescription"] as? String)!
        description = description + "\n" + HexColorAll
        
        //Creat imageName path .jpg
        var namepath = (ProductData["ProductName"] as? String)!
        namepath = namepath + "[C-" + CustomCode + "]"
        let path = namepath + "_" + timestamp

        let image = imageHistory.last
        let price = ProductData["ProductPrice"] as? Int
        let width = DimensionArr?.first
        let height = DimensionArr?.last
        let pattern = ProductDataSpecific["ProductPattern"] as? Int
        let remark = ProductDataSpecific["ProductRemark"] as? String
        
        
        UploadimageProductCustom(token: tokenID!, path: path, image: image!, name: name, description: description, price: String(price!), width: String(width!), height: String(height!), pattern: String(pattern!), remark: remark!)

        
    }
    
    // Func to AR Page
    @objc func handleToARPage(){
        
        // Get Image Custom to ProductData
        ProductData["Image"] = imageHistory.last
        
        // Next to ARPage
        let ARPage = ARPageController()
        ARPage.DataProduct = ProductData
        navigationController?.pushViewController(ARPage, animated: true)
    }
    
    func UploadimageProductCustom(token:String, path:String, image:UIImage, name:String,
                            description:String, price:String, width:String, height:String,
                            pattern:String, remark:String){
        
        guard image.size.width != 0 else {return}
        self.Show_Loader()

        let base64Image = image.toBase64()
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let parameter = ["path":"productcustom/" + path + ".jpg","bucket":"arforsalesfullimage","image":base64Image]
        let Url = DataSource.Url_ImageUploadImage()
        
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
                
                switch response.result{
                case .success(let value):
                    let JSON = value as? [String : Any]
                    
                    if JSON!["Key"] != nil{
                        let key = JSON!["Key"] as! String
        
                        self.insertProductCustom(token: self.tokenID!, name: name, description: description, price: price, key: key, width: width, height: height, pattern: pattern, remark: remark)
                    }
        
                case .failure(_):
                    
                    break
                }
        })
    }
    
    func insertProductCustom(token:String, name:String,description:String,
                       price:String,key:String,width:String,height:String,
                       pattern:String,remark:String){

        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_saleInsertProductCustom()
        
        let parameter = ["Name":name,"Description":description,"Price":price,"Image":key,
                         "Width":width,"Height":height,"Pattern":pattern,"Remark":remark]

        
        AF.request(Url, method: .post,parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                if JSON!["results"] != nil{

                    // Close loader
                    self.Show_Loader()
                    self.AlertMessage_AddProductSucceed(Title: "Add Product Custom", Message: "product has been added to the category custom.")
                    
                }
        
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func map(x: CGFloat,in_min: CGFloat,in_max: CGFloat,out_min: CGFloat,out_max: CGFloat) -> CGFloat{
        return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
    }
    
    func Assembly(ImageASB: UIImage) -> UIImage{
        let angles = [270,0,180,90]
        let ImageWidht = ImageASB.size.width
        let ImageHeight = ImageASB.size.height
        let imageGrout = UIBezierPath(rect: CGRect(x: 0, y: 0, width: (ImageWidht * 1.01438), height: (ImageHeight * 1.01438)))
        UIGraphicsBeginImageContextWithOptions(imageGrout.bounds.size, false, 0)
        let position_Grout_x = (imageGrout.bounds.size.width / 2) - (ImageWidht / 2)
        let position_Grout_Y = (imageGrout.bounds.size.height / 2) - (ImageHeight / 2)
        
        ImageASB.draw(at: CGPoint(x: position_Grout_x, y: position_Grout_Y))
        let image_Grout = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let ImageGroutWidht = image_Grout!.size.width
        let ImageGroutHeight = image_Grout!.size.height
        let ImageASBSize = CGSize(width: image_Grout!.size.width * 2, height: image_Grout!.size.height * 2)
        var positionImage = ImageGroutWidht
        
        print(ImageASBSize)
        
        UIGraphicsBeginImageContextWithOptions(ImageASBSize, false, 0)
        
        for index in 1...2{
            let ImageASB = image_Grout!.rotateImage(radians: CGFloat(angles[index-1].degreesToRadians))
            ImageASB.draw(at: CGPoint(x: positionImage - ImageGroutWidht, y: 0))
            
            positionImage = positionImage + ImageGroutWidht
        }
        positionImage = ImageGroutWidht
        
        for index in 3...4{
            let ImageASB = image_Grout!.rotateImage(radians: CGFloat(angles[index-1].degreesToRadians))
            ImageASB.draw(at: CGPoint(x: positionImage - ImageGroutWidht, y: ImageGroutHeight))
            
            positionImage = positionImage + ImageGroutWidht
        }
        
        let image_ASS = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image_ASS!
    }
    
    func Create_AlertMessage(Title : String!, Message : String!){
           let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           
           // Set Attribute Alert
           alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
           alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
           
           self.present(alert, animated: true, completion: nil)
    }
    
    func AlertMessage_AddProductSucceed(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
                
                alert.setTitlet(font: UIFont.MitrMedium(size: 20), color: .BlueLight)
                alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.5))
                
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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

extension CustomTileViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageCustom
    }
}

extension CustomTileViewController: ColorPickerDelegate{
    func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
        CustomTileViewController.ColorPicker = selectedColor
    }
    
    func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
        
    }
}

extension UIImage {
    func rotateImage(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.x, y: -origin.y,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return NSString(format:"#%06x", rgb) as String
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

}
