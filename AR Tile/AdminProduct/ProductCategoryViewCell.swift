//
//  ProductCategoryViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 28/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class ProductCategoryViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    let viewCollage: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 241, green: 243, blue: 244)
        view.layer.cornerRadius = 22.5
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.9).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0
        view.layer.masksToBounds = true
        return view
    }()
    
    let imageCategory: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
  
    let viewCollageAlpha: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteAlpha(alpha: 0.9)
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.8).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0
        return view
    }()
    
    let NameGroupLable: UILabel = {
        let label = UILabel()
        label.text = "กระเบื้องลายโบราณ"
        label.textColor = UIColor.BlueDeep
        label.font = UIFont.MitrLight(size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    func SetupTableViewCell(){
                
        selectionStyle = .none
        backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        
        addSubview(viewCollage)
        viewCollage.addSubview(imageCategory)
        viewCollage.addSubview(viewCollageAlpha)
        viewCollage.addSubview(NameGroupLable)
        
        viewCollage.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        viewCollage.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 150)
        
        imageCategory.anchor(viewCollage.topAnchor, left: viewCollage.leftAnchor, bottom: viewCollage.bottomAnchor, right: viewCollage.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        NameGroupLable.anchor(nil, left: viewCollage.leftAnchor, bottom: viewCollage.bottomAnchor, right: viewCollage.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 3, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        viewCollageAlpha.anchor(NameGroupLable.topAnchor, left: viewCollage.leftAnchor, bottom: viewCollage.bottomAnchor, right: viewCollage.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
}
