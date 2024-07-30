//
//  CollectionCell_TopSale.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 16/6/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class CollectionCell_TopSale : UICollectionViewCell {
    
    // MARK: Parameter
    lazy var ratio = frame.width / 335
    
    // Parameter for Set Value in Cell (Image Sale, NumQuo, TotalSales)
    // Image Sale
    var Set_Image : UIImage = #imageLiteral(resourceName: "user") {
        didSet{
            // Set Image to Im_Sale
            Im_Sale.image = Set_Image
        }
    }
    
    // Num Quotation
    var Set_NumQuo : Double =  1{
        didSet{
            
            // Set Text in Lb_NumQuo
            let Txt = "Total Offering : \(String(Set_NumQuo).currencyFormatting())"
            Lb_NumQuo.text = Txt
            
        }
    }
    
    // Num Success Quotation
    var Set_NumQuoSuc : Double = 1 {
        didSet{
            
            // Set Text in Lb_NumQuoSuc
            let Txt = "Success Offering : \(String(Set_NumQuoSuc).currencyFormatting())"
            Lb_NumQuoSuc.text = Txt
            
        }
    }
    
    // Total Sales
    var Set_TotalSales : Double = 1{
        didSet{
            
            // Set Text in Lb_TotalSales
            let Txt = "Total Sales : \(String(Set_TotalSales).currencyFormatting()) ฿"
            Lb_TotalSales.text = Txt
            
        }
    }
    
    // Success Sales
    var Set_SuccessSales : Double = 1{
        didSet{
            
            // Set Text in Lb_TotalSales
            let Txt = "Success Sales : \(String(Set_SuccessSales).currencyFormatting()) ฿"
            Lb_SuccessSales.text = Txt
            
        }
    }
    
    
    // MARK: Element
    // View Order
    var View_Order : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    
    // Label Order
    lazy var Lb_Order : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.MitrRegular(size: 23 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    
    // Image Sale
    var Im_Sale : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "user").withRenderingMode(.alwaysTemplate)
        image.tintColor = .BlueDeep
        image.contentMode = .scaleAspectFit
        
        image.layer.masksToBounds = true
        return image
    }()
    
    // Label Name Sale
    lazy var Lb_NameSale : UILabel = {
        let label = UILabel()
        label.text = "AAAAAAA AAAAAAA"
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.textColor = .BlueDeep
        return label
    }()
    
    // Label Num Quotation Sale
    lazy var Lb_NumQuo : UILabel = {
        let label = UILabel()
        label.text = "Total Offering : 100"
        label.font = UIFont.MitrLight(size: 15 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Label Num Quotation Success Sale
    lazy var Lb_NumQuoSuc : UILabel = {
        let label = UILabel()
        label.text = "Success Offering : 100"
        label.font = UIFont.MitrLight(size: 15 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Label Total Sales of Sale (Seller)
    lazy var Lb_TotalSales : UILabel = {
        let label = UILabel()
        label.text = "Total Sales : 100,000 ฿"
        label.font = UIFont.MitrLight(size: 15 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Label Success Sales of Sale (Seller)
    lazy var Lb_SuccessSales : UILabel = {
        let label = UILabel()
        label.text = "Success Sales : 100,000 ฿"
        label.font = UIFont.MitrLight(size: 15 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Line Section
    lazy var Line_Section : UIView = {
        let line = UIView()
        line.backgroundColor = .BlueLight
        return line
    }()
    
    // MARK: Func for Layout and Config Element in Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Set Background Cell
        backgroundColor = .white
        // Set CornerRadius and Enable MasktoBounds Cell
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        // Layout Element
        // View Order
        addSubview(View_Order)
        View_Order.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50 * ratio, heightConstant: 0)
        
        // Label Order
        View_Order.addSubview(Lb_Order)
        Lb_Order.anchorCenter(View_Order.centerXAnchor, AxisY: View_Order.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        // Image Sale
        addSubview(Im_Sale)
        Im_Sale.anchor(topAnchor, left: View_Order.rightAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        layoutIfNeeded()
        // Set Corner Radius Im_Sale (Circle)
        Im_Sale.layer.cornerRadius = (30 * ratio) / 2
        
        // Label Name Sale
        addSubview(Lb_NameSale)
        Lb_NameSale.anchorCenter(nil, AxisY: Im_Sale.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_NameSale.anchor(nil, left: Im_Sale.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Label Total Sales
        addSubview(Lb_TotalSales)
        Lb_TotalSales.anchor(nil, left: Im_Sale.leftAnchor, bottom: bottomAnchor, right: Lb_NameSale.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        // Label Total Sales
        addSubview(Lb_SuccessSales)
        Lb_SuccessSales.anchor(nil, left: Lb_TotalSales.leftAnchor, bottom: Lb_TotalSales.topAnchor, right: Lb_NameSale.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 1 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Line Section
        /*addSubview(Line_Section)
        Line_Section.anchor(nil, left: Lb_TotalSales.leftAnchor, bottom: Lb_SuccessSales.topAnchor, right: Lb_NameSale.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 2 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 1 * ratio)*/
        
        // Label Total Quotation
        addSubview(Lb_NumQuo)
        Lb_NumQuo.anchor(nil, left: Lb_TotalSales.leftAnchor, bottom: Lb_SuccessSales.topAnchor, right: Lb_NameSale.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Label Num Quotation
        addSubview(Lb_NumQuoSuc)
        Lb_NumQuoSuc.anchor(nil, left: Lb_TotalSales.leftAnchor, bottom: Lb_NumQuo.topAnchor, right: Lb_NameSale.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 1 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
