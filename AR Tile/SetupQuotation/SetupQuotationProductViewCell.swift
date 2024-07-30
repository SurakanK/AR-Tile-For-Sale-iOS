//
//  SetupQuotationProductViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 30/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class SetupQuotationProductViewCell: UITableViewCell {
    
    let viewCellProduct: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let viewSubnumber: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        return view
    }()
    
    let viewRemark: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        return view
    }()
    
    let viewDiscount: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        return view
    }()
    
    let viewPriceTotal: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        return view
    }()
    
    let number: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.backgroundColor = UIColor.systemGray5
        label.font = UIFont.MitrLight(size: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let productName: UILabel = {
        let label = UILabel()
        label.text = "GA-01 wood"
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.backgroundColor = UIColor.systemGray6
        label.font = UIFont.MitrRegular(size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    let discription: UILabel = {
        let label = UILabel()
        label.text = "tile size15*60CM.TTE-6255-15"
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.backgroundColor = UIColor.systemGray5
        label.font = UIFont.MitrLight(size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    let area: UILabel = {
        let label = UILabel()
        label.text = "1234.00 m2"
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.backgroundColor = UIColor.systemGray6
        label.font = UIFont.MitrLight(size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    let unitPricet: UILabel = {
        let label = UILabel()
        label.text = "1,457"
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.backgroundColor = UIColor.systemGray5
        label.font = UIFont.MitrLight(size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    let discountField: UITextField = {
        let textField = UITextField()
        textField.textColor = .BlackAlpha(alpha: 0.8)
        textField.font = UIFont.MitrRegular(size: 12)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.keyboardType = .decimalPad
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.tag = 0
        return textField
    }()
    
    let remarktitle: UILabel = {
        let label = UILabel()
        label.text = "Remark"
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.font = UIFont.MitrRegular(size: 12)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let priceTotaltitle: UILabel = {
        let label = UILabel()
        label.text = "Total Price"
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.font = UIFont.MitrRegular(size: 12)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let priceTotal: UILabel = {
        let label = UILabel()
        label.text = "13,004"
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.font = UIFont.MitrRegular(size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let remarkField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .whiteAlpha(alpha: 0.8)
        textView.textColor = .BlackAlpha(alpha: 0.8)
        textView.font = UIFont.MitrLight(size: 14)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.text = ""
        return textView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.selectionStyle = .none

        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
    func SetupTableViewCell(){
        
        contentView.addSubview(viewCellProduct)
        
        viewCellProduct.addSubview(number)
        viewCellProduct.addSubview(productName)
        viewCellProduct.addSubview(discription)
        viewCellProduct.addSubview(area)
        viewCellProduct.addSubview(unitPricet)
        viewCellProduct.addSubview(viewDiscount)
        viewCellProduct.addSubview(viewRemark)
        viewCellProduct.addSubview(viewSubnumber)
        viewCellProduct.addSubview(viewPriceTotal)
        
        viewDiscount.addSubview(discountField)
        
        viewRemark.addSubview(remarktitle)
        viewRemark.addSubview(remarkField)
        
        viewPriceTotal.addSubview(priceTotaltitle)
        viewPriceTotal.addSubview(priceTotal)
        
        // bottomAnchor
        viewCellProduct.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 1.5, leftConstant: 3, bottomConstant: 1.5, rightConstant: 3, widthConstant: 0, heightConstant: 0)
        
        number.anchor(viewCellProduct.topAnchor, left: viewCellProduct.leftAnchor, bottom: productName.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 0)
         
        viewSubnumber.anchor(viewRemark.topAnchor, left: viewCellProduct.leftAnchor, bottom: viewCellProduct.bottomAnchor, right: number.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        productName.anchor(viewCellProduct.topAnchor, left: number.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 80)
        
        discription.anchor(viewCellProduct.topAnchor, left: productName.rightAnchor, bottom: productName.bottomAnchor, right: nil, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        area.anchor(viewCellProduct.topAnchor, left: discription.rightAnchor, bottom: productName.bottomAnchor, right: nil, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 0)
        
        unitPricet.anchor(viewCellProduct.topAnchor, left: area.rightAnchor, bottom: productName.bottomAnchor, right: nil, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 0)
       
        viewDiscount.anchor(viewCellProduct.topAnchor, left: unitPricet.rightAnchor, bottom: productName.bottomAnchor, right: viewCellProduct.rightAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 0)
        
        discountField.anchor(viewDiscount.topAnchor, left: viewDiscount.leftAnchor, bottom: viewDiscount.bottomAnchor, right: viewDiscount.rightAnchor, topConstant: 25, leftConstant: 7, bottomConstant: 25, rightConstant: 7, widthConstant: 0, heightConstant: 0)
        
        // viewCellProduct bottomAnchor
         viewRemark.anchor(productName.bottomAnchor, left: number.rightAnchor, bottom: viewCellProduct.bottomAnchor, right: area.rightAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 80)
        
        remarktitle.anchor(viewRemark.topAnchor, left: viewRemark.leftAnchor, bottom: nil, right: nil, topConstant: 3, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 14)
        
        remarkField.anchor(remarktitle.bottomAnchor, left: viewRemark.leftAnchor, bottom: viewRemark.bottomAnchor, right: viewRemark.rightAnchor, topConstant: 3, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        viewPriceTotal.anchor(viewRemark.topAnchor, left: unitPricet.leftAnchor, bottom: viewRemark.bottomAnchor, right: viewCellProduct.rightAnchor, topConstant: 0, leftConstant: -3, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        priceTotaltitle.anchor(viewPriceTotal.topAnchor, left: viewPriceTotal.leftAnchor, bottom: nil, right: nil, topConstant: 3, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 14)
        
        priceTotal.anchor(viewPriceTotal.topAnchor, left: viewPriceTotal.leftAnchor, bottom: viewPriceTotal.bottomAnchor, right: viewPriceTotal.rightAnchor, topConstant: 3, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)

    }

    
}
