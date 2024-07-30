//
//  TablecellSideMenuOption_AdminTableViewCell.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 18/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class TablecellSideMenuOption_AdminTableViewCell: UITableViewCell {
    
    // ratio
    lazy var ratio = frame.width / 375
    
    
    // Icon
    var Icon : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "crown").withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    // Label
    lazy var label_func : UILabel = {
        let label = UILabel()
        label.text = "Setiing"
        label.font = UIFont.PoppinsMedium(size: 20 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.8)
        return label
    }()

    // Layout TableView cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set BG Cell
        backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.YellowLight
        backgroundView.layer.cornerRadius = 5 
        selectedBackgroundView = backgroundView
        
        // Layout Element in Cell
        addSubview(Icon)
        Icon.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        addSubview(label_func)
        label_func.anchor(nil, left: Icon.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        label_func.centerYAnchor.constraint(equalTo: Icon.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
