//
//  ProductColorlistViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 22/5/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class ProductColorlistViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupTableViewCell()
    }
    
    let viewColor: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 30
        return view
    }()
    
    let HexCodeTitle: UILabel = {
        let label = UILabel()
        label.text = "#FFFFFF"
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.PoppinsRegular(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let Statustitle: UILabel = {
        let label = UILabel()
        label.text = "popular"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.PoppinsRegular(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let viewStatus: UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.cornerRadius = 20
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    func SetupTableViewCell(){
             
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(viewColor)
        addSubview(HexCodeTitle)
        
        addSubview(viewStatus)
        viewStatus.addSubview(Statustitle)
        
        viewColor.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        
        HexCodeTitle.anchor(self.topAnchor, left: viewColor.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        viewStatus.anchor(nil, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 100, heightConstant: 40)
        viewStatus.anchorCenter(nil, AxisY: self.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        Statustitle.anchor(viewStatus.topAnchor, left: viewStatus.leftAnchor, bottom: viewStatus.bottomAnchor, right: viewStatus.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
    }
    
}
