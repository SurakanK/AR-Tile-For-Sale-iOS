//
//  CollectionCell_ProductHorizon.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 4/4/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import SkeletonView

class CollecitonCell_ProductHorizon : UICollectionViewCell {
    
    // View
    var view : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // Image Product
    var Im_Product : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "GA-037_20x20_1950_").withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFit
        
        image.isSkeletonable = true
        
        return image
    }()
    
    // Label Name Product
    var Lb_NamePro : UILabel = {
        let label = UILabel()
        label.text = "กระเบื้องลายโบราณ รหัส GA-101"
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 2
        label.textColor = UIColor.BlackAlpha(alpha: 0.9)
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label Price Product
    var Lb_PricePro : UILabel = {
        let label = UILabel()
        label.text = "฿ 1,120/m²"
        label.font = UIFont.MitrMedium(size: 23)
        label.textColor = UIColor.BlueDeep
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label Num Sold Product
    var Lb_NumSoldPro : UILabel = {
        let label = UILabel()
        label.text = "Sold : 120 m²"
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = UIColor.BlackAlpha(alpha: 0.5)
        
        label.isSkeletonable = true
        
        return label
    }()
    
    
    
    // Layout ColletionView Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Layout
        backgroundColor = UIColor.white
        let ratio = frame.width / 355
        // Shadow cell
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        // CornerRadius
        layer.cornerRadius = 10 * ratio
        
        // view
        addSubview(view)
        view.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.layer.cornerRadius = 10 * ratio
        view.layer.masksToBounds = true
        
        // Image Product
        view.addSubview(Im_Product)
        Im_Product.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.height, heightConstant: frame.height)
        
        // Label Name Product
        view.addSubview(Lb_NamePro)
        Lb_NamePro.anchor(topAnchor, left: Im_Product.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 10 * ratio, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_NamePro.font = UIFont.MitrLight(size: 15 * ratio)
        
        // Label Price Product
        view.addSubview(Lb_PricePro)
        Lb_PricePro.anchor(Lb_NamePro.bottomAnchor, left: Lb_NamePro.leftAnchor, bottom: nil, right: Lb_NamePro.rightAnchor, topConstant: -5 * ratio , leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_PricePro.font = UIFont.MitrMedium(size: 23 * ratio)
        
        // label Num Sold Product
        view.addSubview(Lb_NumSoldPro)
        Lb_NumSoldPro.anchor(nil, left: Lb_NamePro.leftAnchor, bottom: bottomAnchor, right: Lb_NamePro.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_NumSoldPro.font = UIFont.MitrLight(size: 15 * ratio)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
