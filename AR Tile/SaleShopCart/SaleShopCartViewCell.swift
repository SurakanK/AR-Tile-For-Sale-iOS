//
//  SaleShopCartViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 26/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class SaleShopCartViewCell: UITableViewCell {
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let viewshadow: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.cornerRadius = 10
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    let imageProduct: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Icon-Tile")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    let productNametitle: UILabel = {
        let label = UILabel()
        label.text = "GA-01"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.BlueLight
        label.font = UIFont.MitrRegular(size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let unitPricetitle: UILabel = {
        let label = UILabel()
        label.text = "Unit Price : 960"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrExLight(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let areatitle: UILabel = {
      let label = UILabel()
        label.text = "ARMeasure : 125.7 m2"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrExLight(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let pricetitle: UILabel = {
        let label = UILabel()
        label.text = "12,394 Baht/m2"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.BlueLight
        label.font = UIFont.MitrLight(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let areaQuantityfield: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.BlackAlpha(alpha: 0.8)
        textField.font = UIFont.MitrLight(size: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.keyboardType = .decimalPad
        textField.backgroundColor = .white
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.BlueLight.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let areaQuantitytitle: UILabel = {
        let label = UILabel()
        label.text = "Area Quantity"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 14)
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        self.backgroundColor = .systemGray6
        self.selectionStyle = .none
        
        SetupTableViewCell()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func SetupTableViewCell(){
        
        addSubview(viewshadow)
        contentView.addSubview(view)
        view.addSubview(imageProduct)
        view.addSubview(productNametitle)
        view.addSubview(unitPricetitle)
        view.addSubview(areatitle)
        view.addSubview(pricetitle)
        view.addSubview(areaQuantityfield)
        view.addSubview(areaQuantitytitle)

        
        view.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 150)
        
        viewshadow.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        imageProduct.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        
        productNametitle.anchor(view.topAnchor, left: imageProduct.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 26)
        
        unitPricetitle.anchor(productNametitle.bottomAnchor, left: imageProduct.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        areatitle.anchor(unitPricetitle.bottomAnchor, left: imageProduct.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        pricetitle.anchor(areatitle.bottomAnchor, left: imageProduct.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 26)

        areaQuantityfield.anchor(pricetitle.bottomAnchor, left: imageProduct.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        areaQuantitytitle.anchor(areaQuantityfield.topAnchor, left: areaQuantityfield.leftAnchor, bottom: nil, right: nil, topConstant: -8, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 16)
        

    }
}
