//
//  ColorPickerHEXViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 22/5/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class ColorPickerHEXViewCell: UICollectionViewCell {
        
    let viewColor: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 35
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    let HEXColortitle: UILabel = {
        let label = UILabel()
        label.text = "#FFFFFF"
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.textAlignment = .center
        label.font = UIFont.PoppinsRegular(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let ColorStatus: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SetupTableViewCell()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func SetupTableViewCell(){
        
        addSubview(viewColor)
        addSubview(HEXColortitle)
        addSubview(ColorStatus)
        
        viewColor.anchorCenter(centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 70, heightConstant: 70)
        viewColor.anchor(topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        HEXColortitle.anchor(viewColor.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        ColorStatus.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 10, heightConstant: 10)
    }
    

}
