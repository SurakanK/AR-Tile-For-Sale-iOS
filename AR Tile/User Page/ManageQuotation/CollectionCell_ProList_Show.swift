//
//  CollectionCell_ProList_Show.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 29/4/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class CollectionCell_ProList_Show : UICollectionViewCell {
    
    // MARK: Parameter
    // ratio of cell
    lazy var ratio = self.frame.width / 325
    
    // State Edit
    var State_Edit : Bool = false {
        
        didSet {
            var color = UIColor.clear
            // true
            if self.State_Edit == true {
                color = .white
                Btn_DeletePro.alpha = 1
            }
            else {
                Btn_DeletePro.alpha = 0
            }
            // Change State TextFiled
            Txt_Quan.isEnabled = self.State_Edit
            Txt_Quan.isUserInteractionEnabled = self.State_Edit
            Txt_Quan.backgroundColor = color
            
            Txt_Price.isEnabled = self.State_Edit
            Txt_Price.isUserInteractionEnabled = self.State_Edit
            Txt_Price.backgroundColor = color
            
            Txt_Discount.isEnabled = self.State_Edit
            Txt_Discount.isUserInteractionEnabled = self.State_Edit
            Txt_Discount.backgroundColor = color
            
        }
        
    }
    
    // State Delete
    var State_Delete : Bool = false {
        didSet{
            
            var Alpha : CGFloat = 1
            if self.State_Delete == true {
                Alpha = 0.3
                // Change Icon Button Delete
                Btn_DeletePro.setImage(#imageLiteral(resourceName: "multimedia-option").withRenderingMode(.alwaysTemplate), for: .normal)
                Btn_DeletePro.tintColor = .systemGreen
                
            }
            else {
                // Change Icon Button Delete
                Btn_DeletePro.setImage(#imageLiteral(resourceName: "rubbish-can").withRenderingMode(.alwaysTemplate), for: .normal)
                Btn_DeletePro.tintColor = .systemRed
            }
            
            // alpha Element
            
            if State_Edit == false {
                Btn_DeletePro.alpha = 0
            }else {
                Btn_DeletePro.alpha = 1
            }
            View_Quan.alpha = Alpha
            View_Price.alpha = Alpha
            View_Discount.alpha = Alpha
            Lb_Total.alpha = Alpha
            Lb_NamePro.alpha = Alpha
            
            // Txt Enable
            Txt_Quan.isEnabled = !self.State_Delete
            Txt_Price.isEnabled = !self.State_Delete
            Txt_Discount.isEnabled = !self.State_Delete
            
            Txt_Quan.isUserInteractionEnabled = !self.State_Delete
            Txt_Price.isUserInteractionEnabled = !self.State_Delete
            Txt_Discount.isUserInteractionEnabled = !self.State_Delete
            
            // Call Total Sales Product
            Cal_TotalSales_Product?()
            
        }
        
    
    }
    
    
    // Total Price
    var Total_Price : Double = 0 {
        
        didSet{
            
            Lb_Total.text = "฿ " + String(Total_Price).currencyFormatting()
            
            
        }
        
    }
    
    // Event Cal Total Product
    var Cal_TotalSales_Product : (()->())?
    
    // MARK: Element
    // label of Name Product
    lazy var Lb_NamePro : UILabel = {
        let label = UILabel()
        label.text = "กระเบื้อง A"
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.textColor = UIColor.BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Label Total Price Product
    lazy var Lb_Total : UILabel = {
        let label = UILabel()
        label.text = "฿ 100,000"
        label.font = UIFont.MitrMedium(size: 20 * ratio)
        label.textColor = .BlueDeep
        return label
    }()
    
    // Button Delete Product
    var Btn_DeletePro : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "rubbish-can").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemRed
        
        button.alpha = 0
        
        return button
    }()
    
    // Section Quantity ---
    // View Quantity
    lazy var View_Quan : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 87 / 255, green: 197 / 255, blue: 214 / 255, alpha: 0.2)
        
        view.layer.cornerRadius = 5
        return view
    }()
    // Label Quantity
    lazy var Lb_Quan : UILabel = {
        let label = UILabel()
        label.text = "Quantity (m²)"
        label.font = UIFont.MitrRegular(size: 13 * ratio)
        label.textColor = .BlueDeep
        return label
    }()
    // TextField Quantity
    lazy var Txt_Quan : UITextField = {
        let txt = UITextField()
        
        txt.text = "1,000"
        txt.font = UIFont.MitrLight(size: 15 * ratio)
        txt.backgroundColor = .clear
        
        txt.keyboardType = .decimalPad
        
        txt.delegate = self
        
        txt.layer.cornerRadius = 5
        txt.isEnabled = false
        txt.isUserInteractionEnabled = false
        
        return txt
    }()
    // --------------------
    
    // Section Price ---
    // View Price
    lazy var View_Price : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 87 / 255, green: 197 / 255, blue: 214 / 255, alpha: 0.2)
        
        view.layer.cornerRadius = 5
        return view
    }()
    // Label Price
    lazy var Lb_Price : UILabel = {
        let label = UILabel()
        label.text = "Price (฿/m²)"
        label.font = UIFont.MitrRegular(size: 13 * ratio)
        label.textColor = .BlueDeep
        return label
    }()
    // TextField Price
    lazy var Txt_Price : UITextField = {
        let txt = UITextField()
        
        txt.text = "100"
        txt.font = UIFont.MitrLight(size: 15 * ratio)
        txt.backgroundColor = .clear
        
        txt.keyboardType = .decimalPad
        
        txt.delegate = self
        
        txt.layer.cornerRadius = 5
        txt.isEnabled = false
        txt.isUserInteractionEnabled = false
        
        return txt
    }()
    // --------------------
    
    
    // Section Discount ---
    // View Discount
    var View_Discount : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 87 / 255, green: 197 / 255, blue: 214 / 255, alpha: 0.2)
        
        view.layer.cornerRadius = 5
        return view
    }()
    // label Discount
    lazy var Lb_Discount : UILabel = {
        let label = UILabel()
        label.text = "Discount (฿)"
        label.font = UIFont.MitrRegular(size: 13 * ratio)
        label.textColor = .BlueDeep
        return label
    }()
    // Txt Field Discount
    lazy var Txt_Discount : UITextField = {
        let txt = UITextField()
        txt.font = UIFont.MitrLight(size: 15 * ratio)
        txt.text = "100"
        txt.backgroundColor = .clear
        
        txt.keyboardType = .decimalPad

        txt.layer.cornerRadius = 5
        
        txt.delegate = self
        txt.isEnabled = false
        txt.isUserInteractionEnabled = false
        return txt
    }()
    
    // --------------------

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.isUserInteractionEnabled = false
        
        // layout
        backgroundColor = .white
        // Set Corner Radius and Boader Line
        layer.cornerRadius = 5
        layer.borderColor = UIColor.BlueDeep.cgColor
        layer.borderWidth = 1
        // Able Skeleton
        isSkeletonable = true
        
        // Layout Element
        // Button Delete Product
        addSubview(Btn_DeletePro)
        Btn_DeletePro.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 20 * ratio, heightConstant: 20 * ratio)
        Btn_DeletePro.addTarget(self, action: #selector(Event_DeleteCell), for: .touchUpInside)
        
        // Label Name Product
        addSubview(Lb_NamePro)
        Lb_NamePro.anchorCenter(nil, AxisY: Btn_DeletePro.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_NamePro.anchor(nil, left: leftAnchor, bottom: nil, right: Btn_DeletePro.leftAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Label Total Price Product
        addSubview(Lb_Total)
        Lb_Total.anchor(Lb_NamePro.bottomAnchor, left: Lb_NamePro.leftAnchor, bottom: nil, right: nil, topConstant: 2 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Section Quantity Price Discount Product -----
        // Stack View
        let Stack = UIStackView(arrangedSubviews: [View_Quan, View_Price, View_Discount])
        Stack.distribution = .fillEqually
        Stack.axis = .horizontal
        Stack.spacing = 2.5 * ratio
        addSubview(Stack)
        Stack.anchor(Lb_Total.bottomAnchor, left: Lb_Total.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 2 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Section Quantity ---
        // Label Quantity
        View_Quan.addSubview(Lb_Quan)
        Lb_Quan.anchor(nil, left: View_Quan.leftAnchor, bottom: View_Quan.centerYAnchor, right: View_Quan.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 5 * ratio, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        // TextField Quantity
        View_Quan.addSubview(Txt_Quan)
        Txt_Quan.anchor(View_Quan.centerYAnchor, left: Lb_Quan.leftAnchor, bottom: nil, right: Lb_Quan.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20 * ratio)
        // --------------------
        
        // Section Price ---
        // Label Price
        View_Price.addSubview(Lb_Price)
        Lb_Price.anchor(nil, left: View_Price.leftAnchor, bottom: View_Price.centerYAnchor, right: View_Price.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 5 * ratio, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        // TextField Price
        View_Price.addSubview(Txt_Price)
        Txt_Price.anchor(View_Price.centerYAnchor, left: Lb_Price.leftAnchor, bottom: nil, right: Lb_Price.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20 * ratio)
        // --------------------
        
        // Section Discount ---
        // Label Discount
        View_Discount.addSubview(Lb_Discount)
        Lb_Discount.anchor(nil, left: View_Discount.leftAnchor, bottom: View_Discount.centerYAnchor, right: View_Discount.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 5 * ratio, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        // TextField Quantity
        View_Discount.addSubview(Txt_Discount)
        Txt_Discount.anchor(View_Discount.centerYAnchor, left: Lb_Discount.leftAnchor, bottom: nil, right: Lb_Discount.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20 * ratio)
        // --------------------
        
        // ---------------------------------------------
        
        // Section Discount ------------
        // ViewDiscount
        
        // ------------------------------
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAR: Event Delete Cell
    @objc func Event_DeleteCell(){
        
        // Action
        State_Delete = !State_Delete
        
        
    }
    
    
}
// Extension TextField
extension CollectionCell_ProList_Show : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Check TextField no Data
        if textField.text!.count == 0 {
            textField.text = "0"
        }
        
        // Cal Total Price of Product
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        let Quan = Double(truncating: formatter.number(from: Txt_Quan.text!)!)
        let Price = Double(truncating: formatter.number(from: Txt_Price.text!)!)
        let Discount = Double(truncating: formatter.number(from: Txt_Discount.text!)!)
        
        let Subtotal = (Quan * Price)
        let DisTotal = Discount//(Subtotal * (Discount/100))
        let TotalPrice = Subtotal - DisTotal
        
        // Update Value in Label Total
        Total_Price = TotalPrice
        
        // Call Total Sales Product
        Cal_TotalSales_Product?()
        
    }
    
}
