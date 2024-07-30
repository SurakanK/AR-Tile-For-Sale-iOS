//
//  CollectionCell_StatusQuo.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 9/6/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class CollectionCell_StatusQuo : UICollectionViewCell {
    
    // MARK: Parameter
    var BGColor : UIColor = .whiteAlpha(alpha: 0.9) {
        didSet {
            backgroundColor = self.BGColor
        }
    }
    
    
    // MARK: Element Cell
    var Lb_Header : UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = UIFont.MitrRegular(size: 15)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        return label
    }()
    
    var Lb_Value : UILabel = {
        let label = UILabel()
        label.text = "???"
        label.font = UIFont.MitrRegular(size: 15)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        label.textAlignment = .right
        return label
    }()
    
    
    
    // Layout ColletionView Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Layout Cell
        backgroundColor = BGColor
        layer.cornerRadius = 5
        
        // Label Header
        addSubview(Lb_Header)
        Lb_Header.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Header.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Label Value
        addSubview(Lb_Value)
        Lb_Value.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Value.anchor(nil, left: Lb_Header.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
