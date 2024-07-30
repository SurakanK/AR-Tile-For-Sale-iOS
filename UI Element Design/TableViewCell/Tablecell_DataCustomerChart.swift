//
//  Tablecell_DataCustomerChart.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 20/6/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
private var Id_TablePoppro : String = "Cell_PopularProduct"
class Tablecell_DataCustomerChart : UITableViewCell {

    // MARK: Parameter
    lazy var ratio = frame.width / 335
    
    // Parameter DropDown Chart Choose
    var DropDown_Choose : Int = 0 {
        didSet{
            
            if DropDown_Choose == 0 {
                View_Chanel.alpha = 0
                View_Chanel.removeFromSuperview()
                
            }
            else if DropDown_Choose == 1 {
                View_PopProduct.alpha = 0
                View_PopProduct.removeFromSuperview()
            }
            
        }
    }
    
    // Parameter Status Expended
    var State_Expended : Bool = false {
        didSet{
            
            
            if State_Expended {
                
                // Rotate Image Arrow
                // Animation Rotate Image Arrow
                UIView.animate(withDuration: 0.5) {
                    self.Icon_Arrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                    
                    // Check DropDown Choose
                    // Type
                    if self.DropDown_Choose == 0 {
                        self.View_PopProduct.alpha = 1
                        self.add_ViewPop()
                    }
                    // Chanel
                    else if self.DropDown_Choose == 1 {
                        self.View_Chanel.alpha = 1
                        self.add_ViewChanel()
                    }

                }
                
                
            }else {
    
                // Animation Rotate Image Arrow to Original
                UIView.animate(withDuration: 0.5) {
                    self.Icon_Arrow.transform = .identity
                    
                    // Check DropDown Choose
                    // Type
                    if self.DropDown_Choose == 0 {
                        self.View_PopProduct.alpha = 0
                        self.View_PopProduct.removeFromSuperview()
                    }
                    // Chanel
                    else if self.DropDown_Choose == 1 {
                        self.View_Chanel.alpha = 0
                        self.View_Chanel.removeFromSuperview()
                    }
              
                }
                
                
            }
            
        }
    }
    
    
    //  Section Parameter for Set Chart Customer Type
    // Set Color Chart
    var Set_ColorChart : UIColor = .white {
        didSet{
            
            // Set Color Chart
            Im_DataChart.backgroundColor = Set_ColorChart
            
        }
    }
    
    // Set Num People
    var Set_NumType : Int = 0 {
        didSet {
            
            // Update label Num Type
            Lb_ValueChart.text = String(Set_NumType) + " People"
            
        }
    }
    
    // Set Data Table Popular Product
    var Data_Product : [Struct_PopularPro] = [] {
        didSet {
            
            //Reload Data TableView Popular Product
            Table_PopPro.reloadData()

        }
    }
    // -----------------------------------------
    
    // MARK: Element
    // View of Cell
    var View_Cell : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        // Set Border
        view.layer.borderColor = UIColor.BlueDeep.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    // Section View Main Data ----------
    var View_MainData : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    
    // Image Data Chart
    var Im_DataChart : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 5
    
        return image
    }()
    // Label Name Chart
    lazy var Lb_NameChart : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.text = "Data"
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // Label Value Data Chart
    lazy var Lb_ValueChart : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrLight(size: 18 * ratio)
        label.text = "????????"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .right
        return label
    }()
    // Icon Arrow
    var Icon_Arrow : UIImageView = {
        let image = UIImageView()
        var imageArrow = #imageLiteral(resourceName: "arrowTop")
        imageArrow = imageArrow.rotate(radians: 3.14159)
        image.image = imageArrow.withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // ---------------------------------
    
    // Section Popular Product
    // View Popular Product
    var View_PopProduct : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0
        return view
    }()
    // Icon Popular Product
    var Icon_PopPro : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "PopProduct").withRenderingMode(.alwaysTemplate)
        image.tintColor = .BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Header Popular Product
    lazy var Lb_PopPro : UILabel = {
        let label = UILabel()
        label.text = "Popular Product"
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // Table View Popular Product
    lazy var Table_PopPro :UITableView = {
        let table = UITableView()
        
        // Config TableView
        table.delegate = self
        table.dataSource = self
        table.register(Cell_PopularProduct.self, forCellReuseIdentifier: Id_TablePoppro)
        
        table.isScrollEnabled = false
        table.separatorStyle = .none
        // Set Height
        table.estimatedRowHeight = 45 * ratio
        
        return table
    }()
    
    // ---------------------------------
    
    // Section Chanel income
    // View Chanel Income
    var View_Chanel : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
    // Icon Header Quotation
    var Icon_Quo : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bill N 25").withRenderingMode(.alwaysTemplate)
        image.tintColor = .BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Header Quotation
    lazy var Lb_Quo : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.text = "Successful offering in this channel"
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // Section View Num Quo Success
    // View Num Quo Success
    lazy var View_QuoSuccess : UIView = {
        let view = UIView()
        view.backgroundColor = .GreenAlpah
        // Add Corner radius
        view.layer.cornerRadius = 5
        // Add Shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.opacity = 15
        view.layer.shadowOffset = CGSize(width: 3 * ratio, height: 3 * ratio)
        return view
    }()
    // View Sales Quo Success
    lazy var View_SalesQuoSucess : UIView = {
        let view = UIView()
        view.backgroundColor = .GreenAlpah
        // Add Corner radius
        view.layer.cornerRadius = 5
        // Add Shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.opacity = 15
        view.layer.shadowOffset = CGSize(width: 3 * ratio, height: 3 * ratio)
        return view
    }()
    // Label Quotation Success Sub Header
    lazy var Lb_HSubQuoSuccess : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrLight(size: 14 * ratio)
        label.text = "Offering"
        label.textAlignment = .center
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // Label Num Quo Success
    lazy var Lb_QuoSuc : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrBold(size: 18 * ratio)
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    // Label Sales Quo Success Sub Header
    lazy var Lb_HSubSucSales : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrLight(size: 14 * ratio)
        label.text = "Sales"
        label.textAlignment = .center
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // Label Sales Quo Success
    lazy var Lb_SalesQuoSuc : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrBold(size: 18 * ratio)
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // Section View Num Quo Success
    // View Num Quo Success
    lazy var View_QuoAll : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeepAlpha
        // Add Corner radius
        view.layer.cornerRadius = 5
        // Add Shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.opacity = 15
        view.layer.shadowOffset = CGSize(width: 3 * ratio, height: 3 * ratio)
        return view
    }()
    // View Sales Quo Success
    lazy var View_SalesQuoAll : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeepAlpha
        // Add Corner radius
        view.layer.cornerRadius = 5
        // Add Shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.opacity = 15
        view.layer.shadowOffset = CGSize(width: 3 * ratio, height: 3 * ratio)
        return view
    }()
    // Label Quotation Success Sub Header
    lazy var Lb_HSubFromQuo : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrLight(size: 14 * ratio)
        label.text = "From"
        label.textAlignment = .center
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // Label Num Quo Success
    lazy var Lb_QuoAll : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrBold(size: 18 * ratio)
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    // Label Sales Quo Success Sub Header
    lazy var Lb_HSubFromSales : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrLight(size: 14 * ratio)
        label.text = "From"
        label.textAlignment = .center
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // Label Sales Quo Success
    lazy var Lb_SalesQuoAll : UILabel = {
        let label = UILabel()
        label.font = UIFont.MitrBold(size: 18 * ratio)
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // ---------------------------------
    
    // MARK: Func Layout
    // Layout TableView cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        // Layout Element in Page
        // View Cell
        addSubview(View_Cell)
        View_Cell.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Section View Main Data
        // View Main Data
        View_Cell.addSubview(View_MainData)
        View_MainData.anchor(View_Cell.topAnchor, left: View_Cell.leftAnchor, bottom: nil, right: View_Cell.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 45 * ratio)
        
        // Im DataChart
        View_MainData.addSubview(Im_DataChart)
        Im_DataChart.anchorCenter(nil, AxisY: View_MainData.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Im_DataChart.anchor(nil, left: View_MainData.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 20 * ratio, heightConstant: 20 * ratio)
        
        // Label NameChart
        View_MainData.addSubview(Lb_NameChart)
        Lb_NameChart.anchorCenter(nil, AxisY: Im_DataChart.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_NameChart.anchor(nil, left: Im_DataChart.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Icon Arrow
        View_MainData.addSubview(Icon_Arrow)
        Icon_Arrow.anchor(Im_DataChart.topAnchor, left: nil, bottom: Im_DataChart.bottomAnchor, right: View_MainData.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 20 * ratio, heightConstant: 20 * ratio)
        
        // Label Value Data
        View_MainData.addSubview(Lb_ValueChart)
        Lb_ValueChart.anchor(Lb_NameChart.topAnchor, left: Lb_NameChart.rightAnchor, bottom: Lb_NameChart.bottomAnchor, right: Icon_Arrow.leftAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)

        // ----------------------
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add_ViewPop(){
        // Section Popular Product
        // View Popular Product
        View_Cell.addSubview(View_PopProduct)
        View_PopProduct.anchor(View_MainData.bottomAnchor, left: View_Cell.leftAnchor, bottom: View_Cell.bottomAnchor, right: View_Cell.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Icon Popular Product
        View_PopProduct.addSubview(Icon_PopPro)
        Icon_PopPro.anchor(View_PopProduct.topAnchor, left: View_PopProduct.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        // Lb Header Popular Product
        View_PopProduct.addSubview(Lb_PopPro)
        Lb_PopPro.anchorCenter(nil, AxisY: Icon_PopPro.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_PopPro.anchor(nil, left: Icon_PopPro.rightAnchor, bottom: nil, right: View_PopProduct.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Tableew Popular Product
        View_PopProduct.addSubview(Table_PopPro)
        let Height_Table = (45 * ratio) * 3
        Table_PopPro.anchor(Icon_PopPro.bottomAnchor, left: Icon_PopPro.leftAnchor, bottom: View_PopProduct.bottomAnchor, right: Lb_PopPro.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: Height_Table)
        // ----------------------
    }
    
    func add_ViewChanel() {
        
        // View Chanel
        View_Cell.addSubview(View_Chanel)
        View_Chanel.anchor(View_MainData.bottomAnchor, left: View_Cell.leftAnchor, bottom: View_Cell.bottomAnchor, right: View_Cell.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Icon Quotation
        View_Chanel.addSubview(Icon_Quo)
        Icon_Quo.anchor(View_Chanel.topAnchor, left: View_Chanel.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        // Label Quotation
        View_Chanel.addSubview(Lb_Quo)
        Lb_Quo.anchorCenter(nil, AxisY: Icon_Quo.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Quo.anchor(nil, left: Icon_Quo.rightAnchor, bottom: nil, right: View_Cell.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Label Header Sub Quo Success
        View_Chanel.addSubview(Lb_HSubQuoSuccess)
        Lb_HSubQuoSuccess.anchor(Icon_Quo.bottomAnchor, left: Icon_Quo.leftAnchor, bottom: nil, right: nil, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 111 * ratio, heightConstant: 0)
        // Label Header Sub Sales Quo Success
        View_Chanel.addSubview(Lb_HSubSucSales)
        Lb_HSubSucSales.anchor(Lb_HSubQuoSuccess.topAnchor, left: Lb_HSubQuoSuccess.rightAnchor, bottom: nil, right: View_Chanel.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        // View Num Quo Success
        View_Chanel.addSubview(View_QuoSuccess)
        View_QuoSuccess.anchor(Lb_HSubQuoSuccess.bottomAnchor, left: Lb_HSubQuoSuccess.leftAnchor, bottom: nil, right: Lb_HSubQuoSuccess.rightAnchor, topConstant: 1 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 38 * ratio)
        // Label Value Num Quotation Success
        View_QuoSuccess.addSubview(Lb_QuoSuc)
        Lb_QuoSuc.anchorCenter(View_QuoSuccess.centerXAnchor, AxisY: View_QuoSuccess.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        // View Sales of Quo Success
        View_Chanel.addSubview(View_SalesQuoSucess)
        View_SalesQuoSucess.anchor(Lb_HSubSucSales.bottomAnchor, left: Lb_HSubSucSales.leftAnchor, bottom: View_QuoSuccess.bottomAnchor, right: Lb_HSubSucSales.rightAnchor, topConstant: 1 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Label Value Sales Quo Success
        View_SalesQuoSucess.addSubview(Lb_SalesQuoSuc)
        Lb_SalesQuoSuc.anchorCenter(View_SalesQuoSucess.centerXAnchor, AxisY: View_SalesQuoSucess.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        // Label Header From Quo All
        View_Chanel.addSubview(Lb_HSubFromQuo)
        Lb_HSubFromQuo.anchor(View_QuoSuccess.bottomAnchor, left: Icon_Quo.leftAnchor, bottom: nil, right: nil, topConstant: 2 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 111 * ratio, heightConstant: 0)
        // Label Header Fron Sales All
        View_Chanel.addSubview(Lb_HSubFromSales)
        Lb_HSubFromSales.anchor(Lb_HSubFromQuo.topAnchor, left: Lb_HSubFromQuo.rightAnchor, bottom: nil, right: View_Chanel.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        // View Num Quo All
        View_Chanel.addSubview(View_QuoAll)
        View_QuoAll.anchor(Lb_HSubFromQuo.bottomAnchor, left: Lb_HSubFromQuo.leftAnchor, bottom: View_Chanel.bottomAnchor, right: Lb_HSubFromQuo.rightAnchor, topConstant: 1 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 38 * ratio)
        // Label Value Num Quotation Success
        View_QuoAll.addSubview(Lb_QuoAll)
        Lb_QuoAll.anchorCenter(View_QuoAll.centerXAnchor, AxisY: View_QuoAll.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        // View Sales of Quo All
        View_Chanel.addSubview(View_SalesQuoAll)
        View_SalesQuoAll.anchor(Lb_HSubFromSales.bottomAnchor, left: Lb_HSubFromSales.leftAnchor, bottom: View_QuoAll.bottomAnchor, right: Lb_HSubFromSales.rightAnchor, topConstant: 1 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Label Value Sales Quo All
        View_SalesQuoAll.addSubview(Lb_SalesQuoAll)
        Lb_SalesQuoAll.anchorCenter(View_SalesQuoAll.centerXAnchor, AxisY: View_SalesQuoAll.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    
}

// Extension tableView
extension Tablecell_DataCustomerChart : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data_Product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Id_TablePoppro, for: indexPath) as! Cell_PopularProduct
        
        cell.Lb_Order.text = String(indexPath.row + 1) + "."
        cell.Lb_NamePro.text = Data_Product[indexPath.row].Name_Product
        cell.Set_Image = Data_Product[indexPath.row].Image_Product
        cell.Set_QTY = Data_Product[indexPath.row].Num_Product
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45 * ratio
    }

}

// Class TableView Cell Popular Product
class Cell_PopularProduct : UITableViewCell {
    
    // Ratio
    lazy var ratio = frame.width / 315
    
    // Parameter Set QTY Product
    var Set_QTY : Double = 0.0 {
        didSet{
            
            // Update Label QTY
            Lb_QTY.text = String(Set_QTY).currencyFormatting() + " m²"
            
        }
    }
    
    // Parameter Set Image Product
    var Set_Image : UIImage = #imageLiteral(resourceName: "Icon-Tile") {
        didSet {
            
            // Update Image Product
            Im_Product.image = Set_Image
            
        }
    }
    
    // MARK: Element TableCell Popular Product
    lazy var Lb_Order : UILabel = {
        let label = UILabel()
        label.text = "1."
        label.font = UIFont.MitrLight(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Image Product
    lazy var Im_Product : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Icon-Tile").withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.alpha = 0
        return image
    }()
    
    // Label Name Product
    lazy var Lb_NamePro : UILabel = {
        let label = UILabel()
        label.text = "?????"
        label.font = UIFont.MitrLight(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Label QTY Product
    lazy var Lb_QTY : UILabel = {
        let label = UILabel()
        label.text = "0 m²"
        label.font = UIFont.MitrLight(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.textAlignment = .right
        return label
    }()
    
    
    
    // Layout TableView cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set Cell
        backgroundColor = .clear
        layer.cornerRadius = 5
        
        // Layout Element in Page
        // Label Order
        addSubview(Lb_Order)
        Lb_Order.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Order.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Image Product
        addSubview(Im_Product)
        Im_Product.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Im_Product.anchor(nil, left: Lb_Order.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        layoutIfNeeded()
        Im_Product.layer.cornerRadius = Im_Product.frame.width / 2
        
        // Label Name Product
        addSubview(Lb_NamePro)
        Lb_NamePro.anchor(Lb_Order.topAnchor, left: Lb_Order.rightAnchor, bottom: Lb_Order.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Label QTY
        addSubview(Lb_QTY)
        Lb_QTY.anchor(Lb_NamePro.topAnchor, left: Lb_NamePro.rightAnchor, bottom: Lb_NamePro.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
