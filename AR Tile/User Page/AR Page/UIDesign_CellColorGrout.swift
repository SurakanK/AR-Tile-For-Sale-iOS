//
//  UIDesign_CellColorGrout.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 24/5/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class UIDesign_CellColorGrout : UICollectionViewCell {
    
    // MARK: Parameter
    var ratio : CGFloat = 1 {
        didSet {
            
            layoutIfNeeded()
            
        }
    }
    
    var ColorCell : UIColor = UIColor.BlueDeep {
        
        didSet {
            
            View_Color.backgroundColor = self.ColorCell
            
        }
        
    }
    
    
    // MARK: Element In Cell
    // View Color
    var View_Color : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        
        return view
    }()
    
    
    // Layout ColletionView Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // Layout Element in Cell
        backgroundColor = .clear
        
        // View_Color
        addSubview(View_Color)
        View_Color.anchorCenter(centerXAnchor, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 40 * ratio, heightConstant: 40 * ratio)
        // Set Corner radius
        layoutIfNeeded()
        View_Color.layer.cornerRadius = View_Color.frame.width / 2
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
