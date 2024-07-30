//
//  ProductViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 4/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class ProductViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.9).cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "tile").withTintColor(UIColor.whiteAlpha(alpha: 0.9))
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Manage Product"
        label.textColor = UIColor.whiteAlpha(alpha: 0.8)
        label.font = UIFont.MitrLight(size: 25)
        label.numberOfLines = 0
        return label
    }()
    
    func SetupTableViewCell(){
        
        addSubview(view)
        view.addSubview(iconImage)
        view.addSubview(titleLable)
        
        view.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 90)
        
        iconImage.anchorCenter(nil, AxisY: view.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        iconImage.anchor(nil, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        titleLable.anchorCenter(nil, AxisY: view.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        titleLable.anchor(nil, left: iconImage.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        
    }

}
