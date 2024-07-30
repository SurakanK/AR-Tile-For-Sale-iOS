//
//  ProductDetailPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 5/4/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import SkeletonView
import Alamofire

class ProductDetailPageController : UIViewController, UIScrollViewDelegate {
    
    // MARK: Paratmeter
    var Data_Cross : [String : Any] = ["Name" : "", "Price" : "", "NumSold" : "", "KeyImage" : ""]
    
    // Data Prduct Server Pass
    var DataProductDetail = [String : Any]()
    
    // Data Detail of Product
    var Data_Spacific = [String : Any]()
    
    // Delegate TabbarToll
    var DelegateTabbarTool : TabbarToolDelegate?
    
    // Parameter Static AR Measure
    static var ARMeasure : Double = 0
    
    // Parameter State of Add Product for Check Product Add to Cart
    var State_AddProduct : Bool = false {
        
        didSet {
            
            if State_AddProduct {
                
                // Change Button Add Product to Remove Product
                Btn_AddCart.setTitle("Remove From Cart", for: .normal)
                
            }
            else {
                
                // Change Button remove Product to Add Product
                Btn_AddCart.setTitle("Add To Cart", for: .normal)
                
            }
            
        }
        
    }
    
    
    // String Pattern Tile
    var txt_PatternTile : [String] = ["1 Sheet assembled", "4 sheet assembled"]
    
    // Ratio of Page
    lazy var ratio : CGFloat = self.view.frame.width / 375
    
    
    // Button Add Cart
    var Btn_AddCart : UIButton = {
        let button = UIButton()
        
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        
        // Normal State
        button.setTitle("Add To Cart", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 3
        button.setBackgroundColor(color: .white, forState: .normal)
        
        // Selected State
        button.setTitleColor(.white, for: .highlighted)
        button.setBackgroundColor(color: .BlueDeep, forState: .highlighted)
        
        // Add Target
        button.addTarget(self, action: #selector(AddProduct_Cart), for: .touchUpInside)
        
        return button
    }()
    
    // Scroll View
    var ScrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // View Show 1
    var View_Element : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    // Image product
    var Im_Product : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        image.isSkeletonable = true
        
        return image
    }()
    
    // Button AR
    var view_BtnAR : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    var Btn_AR : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(Btn_ARClick), for: .touchUpInside)
        return button
    }()
    var Icon_BtnAR : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "ar").withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.white
        return image
    }()
    var Lb_BtnAR : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrRegular(size: 10)
        label.text = "View AR"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // ---------------------------
    // Button Custom Tile
    var view_BtnCustomTile : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    var Btn_CustomTile : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(Btn_CustomTileClick), for: .touchUpInside)
        return button
    }()
    var Icon_BtnCustomTile : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "color-palette").withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.white
        return image
    }()
    var Lb_BtnCustomTile : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrRegular(size: 10)
        label.text = "Custom Tile"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // ---------------------------
    
    // Line_Section 1
    var Line_Section1 : UIView = {
        let line = UIView()
        line.backgroundColor = .BlackAlpha(alpha: 0.3)
        
        return line
    }()
    
    // Label name Product
    var Lb_NamePro : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrLight(size: 18)
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.numberOfLines = 2
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label Price Product
    var Lb_PricePro : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrMedium(size: 25)
        label.textColor = .BlueDeep
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label Comment Box
    var Lb_PerBox : UILabel = {
        let label = UILabel()
        label.text = "1 Box/m² "
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .BlackAlpha(alpha: 0.5)
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Line_Section 2
    var Line_Section2 : UIView = {
        let line = UIView()
        line.backgroundColor = .BlackAlpha(alpha: 0.3)
        
        return line
    }()
    
    // Label Header Dimension
    var Lb_HDimension : UILabel = {
        let label = UILabel()
        label.text = "Dimensions:"
        label.font = UIFont.MitrMedium(size: 15)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Label Dimension
    var Lb_Dimension : UILabel = {
        let label = UILabel()
        label.text = "20 x 20 cm"
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .BlackAlpha(alpha: 0.9)
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label Header Pattern Tile
    var Lb_HPattern : UILabel = {
        let label = UILabel()
        label.text = "Tile Pattern:"
        label.font = UIFont.MitrMedium(size: 15)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Label Pattern
    var Lb_Pattern : UILabel = {
        let label = UILabel()
        label.text = "4 Sheet assembled"
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .BlackAlpha(alpha: 0.9)
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label Header Description
    var Lb_HDescription : UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.font = UIFont.MitrMedium(size: 15)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Label Pattern
    var Lb_Description : UILabel = {
        let label = UILabel()
        label.text = "กระเบื้องลายโบราณ เหมาะสำหรับการต่อเติมบ้านนอกตัวอาคาร ทำจาก Celamic ที่เผาที่ความร้อนสูงถึง 10,000,000 องศา เนื่องจากต้องใช้ความร้อนสูงถึงขนาดนี้จึงไม่สามารถผลิตที่โลกได้ ดังนั้นจึงเป็นสินค้านำเข้าจากดาวเคราะนิวตรอนสีฟ้า ที่อยู่ในระบบสุริยะแห่งใหม่ ที่อยู่ในกลุ่มดาวคนแคระ บนกาแล็กซี่ซินเดอเรร่า เรื่องความแข็งแรงไม่ต้องพูดถึง ได้รับการทดลองจากสถาบันวิจัย Umbrella Corps โดยการทำสอบนั้นทำโดยการนำ อุกาบาต ขนาดเส้นผ่านศูนย์กลาง 100,000 Km พุ่งชนดาวเคราะที่ทำการปูด้วยกระเบื้องนี้บนพิ้นผิว ผลปรากฎผู้วิจัยนั้นเสียชีวิตทั้งหมด ดังนั้นผลการทดสอบจึงเป็นปริศนาจนถึงทุกวันนี้"
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        label.textColor = .BlackAlpha(alpha: 0.9)
        
        label.isSkeletonable = true
        
        return label
    }()
    
    
    // Badge Button Cart in Navigation Bar
    lazy var Btn_Cart : SSBadgeButton = {
        let button = SSBadgeButton(frame: CGRect(x: 0, y: 0, width: 44 , height: 44 ))
        button.setImage(#imageLiteral(resourceName: "shopping-cart N25").withRenderingMode(.alwaysTemplate), for: .normal)
        button.badgeEdgeInsets = UIEdgeInsets(top: 20 , left: 0, bottom: 0, right: 10)
        button.badgeFont = UIFont.MitrRegular(size: 10)
        button.badgeBackgroundColor = UIColor.systemRed
        
        // Add Target
        button.addTarget(self, action: #selector(Goto_CartPage), for: .touchUpInside)
        
        return button
    }()
    
    
    
    
    
    // MARK: Layout Page
    func Layout_Page(){
        
        view.backgroundColor = .white
        
        // Set Navigation Bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: Btn_Cart)
        
        
        // Add Button Add to Cart
        view.addSubview(Btn_AddCart)
        Btn_AddCart.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Btn_AddCart.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 5 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 50 * ratio)
        
        Btn_AddCart.layer.cornerRadius = (50 * ratio) / 2
        
        // Scroll View
        view.addSubview(ScrollView)
        ScrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: Btn_AddCart.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // View Show
        ScrollView.addSubview(View_Element)
        View_Element.anchor(ScrollView.topAnchor, left: ScrollView.leftAnchor, bottom: ScrollView.bottomAnchor, right: ScrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Image Product
        View_Element.addSubview(Im_Product)
        Im_Product.anchor(View_Element.topAnchor, left: View_Element.leftAnchor, bottom: nil, right: View_Element.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.width)
        
        Im_Product.image = #imageLiteral(resourceName: "GA-037_20x20_1950_")
        
        // Stack View Button -----------
        let StackViewBtn = UIStackView(arrangedSubviews: [view_BtnAR, view_BtnCustomTile])
        StackViewBtn.axis = .horizontal
        StackViewBtn.distribution = .fillEqually
        StackViewBtn.spacing = 10
        View_Element.addSubview(StackViewBtn)

        StackViewBtn.anchor(Im_Product.bottomAnchor, left: View_Element.leftAnchor, bottom: nil, right: View_Element.rightAnchor, topConstant: 5 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Button AR
        /// Icon Btn AR
        view_BtnAR.addSubview(Icon_BtnAR)
        Icon_BtnAR.anchor(view_BtnAR.topAnchor, left: view_BtnAR.leftAnchor, bottom: view_BtnAR.bottomAnchor, right: nil, topConstant: 5 * ratio, leftConstant: 15 * ratio, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        /// label Btn AR
        view_BtnAR.addSubview(Lb_BtnAR)
        Lb_BtnAR.anchorCenter(nil, AxisY: Icon_BtnAR.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_BtnAR.anchor(nil, left: Icon_BtnAR.rightAnchor, bottom: nil, right: view_BtnAR.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_BtnAR.font = UIFont.MitrRegular(size: 18 * ratio)
        /// Btn AR
        view_BtnAR.addSubview(Btn_AR)
        Btn_AR.anchor(view_BtnAR.topAnchor, left: view_BtnAR.leftAnchor, bottom: view_BtnAR.bottomAnchor, right: view_BtnAR.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // ---------------------
        // Button Custom Tile
        /// Icon Btn Custom Tile
        view_BtnCustomTile.addSubview(Icon_BtnCustomTile)
        Icon_BtnCustomTile.anchor(view_BtnCustomTile.topAnchor, left: view_BtnCustomTile.leftAnchor, bottom: view_BtnCustomTile.bottomAnchor, right: nil, topConstant: 5 * ratio, leftConstant: 15 * ratio, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        /// label Btn CustomTile
        view_BtnCustomTile.addSubview(Lb_BtnCustomTile)
        Lb_BtnCustomTile.anchorCenter(nil, AxisY: Icon_BtnCustomTile.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_BtnCustomTile.anchor(nil, left: Icon_BtnCustomTile.rightAnchor, bottom: nil, right: view_BtnCustomTile.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_BtnCustomTile.font = UIFont.MitrRegular(size: 18 * ratio)
        /// Btn AR
        view_BtnCustomTile.addSubview(Btn_CustomTile)
        Btn_CustomTile.anchor(view_BtnCustomTile.topAnchor, left: view_BtnCustomTile.leftAnchor, bottom: view_BtnCustomTile.bottomAnchor, right: view_BtnCustomTile.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // --------------------
        
        // Line Section1
        View_Element.addSubview(Line_Section1)
        Line_Section1.anchor(StackViewBtn.bottomAnchor, left: View_Element.leftAnchor, bottom: nil, right: View_Element.rightAnchor, topConstant: 5 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0.5 * ratio)
        
        // Label name Product
        View_Element.addSubview(Lb_NamePro)
        Lb_NamePro.anchor(Line_Section1.bottomAnchor, left: View_Element.leftAnchor, bottom: nil, right: View_Element.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_NamePro.font = UIFont.MitrLight(size: 18 * ratio)
        
        // Label Price
        View_Element.addSubview(Lb_PricePro)
        Lb_PricePro.anchor(Lb_NamePro.bottomAnchor, left: Lb_NamePro.leftAnchor, bottom: nil, right: Lb_NamePro.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_PricePro.font = UIFont.MitrMedium(size: 25 * ratio)
        
        // Label Per Box
        View_Element.addSubview(Lb_PerBox)
        Lb_PerBox.anchor(Lb_PricePro.bottomAnchor, left: Lb_PricePro.leftAnchor, bottom: nil, right: Lb_PricePro.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_PerBox.font = UIFont.MitrLight(size: 18 * ratio)
        
        // Line Section 2
        View_Element.addSubview(Line_Section2)
        Line_Section2.anchor(Lb_PerBox.bottomAnchor, left: Line_Section1.leftAnchor, bottom: nil, right: Line_Section1.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5 * ratio)
        
        // Label Header Dimension
        View_Element.addSubview(Lb_HDimension)
        Lb_HDimension.anchor(Line_Section2.bottomAnchor, left: Lb_PerBox.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_HDimension.font = UIFont.MitrMedium(size: 15 * ratio)
        
        // Label Dimension
        View_Element.addSubview(Lb_Dimension)
        Lb_Dimension.anchor(Lb_HDimension.topAnchor, left: Lb_HDimension.rightAnchor, bottom: Lb_HDimension.bottomAnchor, right: Lb_PerBox.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Dimension.font = UIFont.MitrLight(size: 15 * ratio)
    
        // Label Header Pattern
        View_Element.addSubview(Lb_HPattern)
        Lb_HPattern.anchor(Lb_HDimension.bottomAnchor, left: Lb_HDimension.leftAnchor, bottom: nil, right: nil, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_HPattern.font = UIFont.MitrMedium(size: 15 * ratio)
        
        // Label Pattern
        View_Element.addSubview(Lb_Pattern)
        Lb_Pattern.anchor(Lb_HPattern.topAnchor, left: Lb_HPattern.rightAnchor, bottom: nil, right: Lb_Dimension.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Pattern.font = UIFont.MitrLight(size: 15 * ratio)
        
        // Label Header Description
        View_Element.addSubview(Lb_HDescription)
        Lb_HDescription.anchor(Lb_HPattern.bottomAnchor, left: Lb_HPattern.leftAnchor, bottom: nil, right: Lb_Pattern.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_HDescription.font = UIFont.MitrMedium(size: 15 * ratio)
        
        // Label Description
        View_Element.addSubview(Lb_Description)
        Lb_Description.anchor(Lb_HDescription.bottomAnchor, left: Lb_HDescription.leftAnchor, bottom: View_Element.bottomAnchor, right: Lb_HDescription.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Description.font = UIFont.MitrLight(size: 15 * ratio)
        
        // Config ContentSize of Scroll View
        ScrollView.contentSize = View_Element.bounds.size
        
    }
    
    // MARK: Func Scroll View in Page
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Disable Horizontol Scroll
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    // MARK: Config
    func Config_Page(){
        
        // Config Scroll View
        ScrollView.delegate = self
        
        // Show Element Loader
        Lb_NamePro.showAnimatedSkeleton()
        Lb_PerBox.showAnimatedSkeleton()
        Lb_PricePro.showAnimatedSkeleton()
        Lb_Dimension.showAnimatedSkeleton()
        Lb_Description.showAnimatedSkeleton()
        Lb_Pattern.showAnimatedSkeleton()
        Im_Product.showAnimatedSkeleton()
        
        // Request Data Product and Image
        Server_SendDataLogin(TokenId: LoginPageController.DataLogin?.Token_Id, Url: DataSource.Url_GetDetailProduct(), idProduct: String(DataProductDetail["idProduct"] as! Int))
        
        
    }
    
    // MARK: Func Life Cycle Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element in Page
        Layout_Page()
        // Config Element in Page
        Config_Page()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Show Navigation bar
        navigationController?.isNavigationBarHidden = false
        
        // Check State of Product Add to Cart ?
        // Check repeat Id Product Add to Cart
        let Check_Id = TabBarUserController.ProductCart.filter{($0["idProduct"] as! Int) == (DataProductDetail["idProduct"] as! Int)}
        if Check_Id.count > 0 {
            State_AddProduct = true
        }else {
            State_AddProduct = false
        }
        
        // Update Badge Value of Application
        Update_BadgeValue()
        
    }
    
    // MARK: Func in Page
    // Btn AR Click
    @objc func Btn_ARClick(){
        
        // Next to AR Page
        let ARPage = ARPageController()
        ARPage.DataProduct = DataProductDetail
        navigationController?.pushViewController(ARPage, animated: true)
        
        
    }
    // Btn CustomTile Click
    @objc func Btn_CustomTileClick(){
        CustomTileViewController.imageCustom = Im_Product.image!
        
         let ViewController = CustomTileViewController()
         ViewController.ProductData = DataProductDetail
         ViewController.ProductDataSpecific = Data_Spacific

         navigationController?.pushViewController(ViewController, animated: true)
        
        
    }
    
    // MARK : Request data From Server
    func Server_SendDataLogin(TokenId : String! ,Url : String!, idProduct : String) {
        
        let Header : HTTPHeaders = [HTTPHeader.authorization(bearerToken: TokenId), HTTPHeader.contentType("application/json")]
        let parameter = ["id" : idProduct]
        
        AF.sessionConfiguration.timeoutIntervalForRequest = 1
        AF.request(Url, method : .post, parameters: parameter, encoding: JSONEncoding.default , headers: Header).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                if let json = value as? [String : Any] {
                    
                    // Check Response Error
                    guard json["results"] != nil else {
                        let errormesaage = json["message"] as! String
                        print(errormesaage)
                        return
                    }
                    
                    let result = json["results"] as? [[String : Any]]
                    let data = result?.first
                    
                    self.Data_Spacific = data!
             
                    
                    // Hide Skeleton
                    self.Lb_PerBox.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                    self.Lb_NamePro.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                    self.Lb_PricePro.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                    self.Lb_Dimension.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                    self.Lb_Description.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                    self.Lb_Pattern.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                    
                    // Update Data to Element
                    self.Lb_NamePro.text = self.Data_Cross["Name"] as? String
                    self.Lb_PricePro.text = self.Data_Cross["Price"] as? String
                    self.Lb_PerBox.text = (data!["ProductRemark"] as! String)
                    self.Lb_Dimension.text = String(data!["Dimension"] as! String) + " cm"
                    self.Lb_Pattern.text = self.txt_PatternTile[(data!["ProductPattern"] as! Int)]
                    self.Lb_Description.text = (data!["ProductDescription"] as! String)
                    
                    
                    // Download Image Product
                    self.Download_Image(Url: DataSource.Url_DownloadImage(), Key: self.Data_Cross["KeyImage"] as! String, Token: TokenId)
               
                    
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Item Product InComplete")
                break
            }
            
        }
        
        
    }
    
    // MARK: Download Image Catagory
    func Download_Image(Url : String, Key : String, Token : String){
        
        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: LoginPageController.DataLogin!.Token_Id), .contentType("application/json")]
        let parameter = ["bucket":"arforsalesfullimage", "path": Key]
        AF.download(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value) :
                if let json = value as? [String : Any] {
                    
                    let Body = json["Body"] as? [String : Any]
                    
                    // Convert Data Buffer to UIImage
                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let datos: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
                    let image = UIImage(data: datos as Data)
                    
                    // Hide Skeleton Loader
                    self.Im_Product.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                    
                    // Update Image
                    self.Im_Product.image = image
                    // Record to Data Product Detail
                    self.DataProductDetail["Image"] = image
                    self.DataProductDetail["Description"] = self.Lb_Description.text
                    self.DataProductDetail["Dimension"] = self.Data_Spacific["Dimension"]
                    self.DataProductDetail["TilePattern"] = self.Data_Spacific["ProductPattern"]
                    
                    
                    
                }
            case .failure(_):
                
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Image of Item Product InComplete")
                
                break
            }
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
    
    // MARK: Func Update Badge Value of Application
    func Update_BadgeValue(){
        
        // Update Badge Value Button Cart Navigation Bar
        if TabBarUserController.ProductCart.count <= 0 {
            Btn_Cart.badge = nil
        }
        else {
            Btn_Cart.badge = String(TabBarUserController.ProductCart.count)
        }
        
        // Update Badge Value of Tabbar in TabberUserController Page
        DelegateTabbarTool?.Update_BadgeValue(Num: TabBarUserController.ProductCart.count)
        
    }
    
    
    // MARK : Event Go to Cart
    @objc func Goto_CartPage(){
       
        DelegateTabbarTool?.Goto_CartPage()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    // MARK: Add Product to Cart
    @objc func AddProduct_Cart(){
        
        
        // Check State Add Product
        // Remove Product
        if State_AddProduct == false {
            
            // Check repeat Id Product Add to Cart
            let Check_Id = TabBarUserController.ProductCart.filter{($0["idProduct"] as! Int) == (DataProductDetail["idProduct"] as! Int)}
            
            guard Check_Id.count == 0 else {
                return
            }
            
            // Add Image to Data of Product Cart and Header AR Measure
            var DataAppend = DataProductDetail
            //DataAppend["Image"] = Im_Product.image
            DataAppend["ARMeasure"] = ProductDetailPageController.ARMeasure
            //DataAppend["Description"] = Lb_Description.text
            
            TabBarUserController.ProductCart.append(DataAppend)
            
            // Change State Add Product to false
            State_AddProduct = true
            
            // Update Badge Value of Application
            Update_BadgeValue()
            
        }
        // Add Product
        else {
            
            // Find Index Product Added From Cart
            let index = TabBarUserController.ProductCart.firstIndex(where : {($0["idProduct"] as! Int) == (DataProductDetail["idProduct"] as! Int)})
            
            // Remove to Product Cart
            TabBarUserController.ProductCart.remove(at: index!)
            
            // Change State Remove Product
            State_AddProduct = false
            
            // Update Badge Value
            Update_BadgeValue()
            
        }
        
        
    }
    
    
    
}
