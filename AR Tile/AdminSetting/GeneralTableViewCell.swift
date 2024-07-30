//
//  GeneralTableViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 19/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageNext: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "next").withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.tintColor = UIColor.BlueLight.withAlphaComponent(0.7)
        return image
    }()
    
    let imageIconViewCell: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "menu")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textColor = UIColor.BlackAlpha(alpha: 0.8)
        label.font = UIFont.MitrLight(size: 18)
        return label
    }()
    
    let SwitchUI: UISwitch = {
        let Switch = UISwitch()
        return Switch
    }()
    
    func SetupTableViewCell(){
        
        addSubview(titleTextLabel)
        addSubview(imageNext)
        addSubview(SwitchUI)
        addSubview(imageIconViewCell)
        
        titleTextLabel.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        titleTextLabel.anchor(nil, left: imageIconViewCell.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        SwitchUI.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        imageNext.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        imageNext.anchor(nil, left: nil, bottom: nil, right: rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 24, heightConstant: 24)
        
        imageIconViewCell.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        imageIconViewCell.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        
    }
}
