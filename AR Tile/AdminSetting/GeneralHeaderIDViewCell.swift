//
//  GeneralHeaderIDViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 19/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class GeneralHeaderIDViewCell: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let HeaderTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.BlueLight.withAlphaComponent(0.8)
        label.font = UIFont.MitrMedium(size: 18)
        return label
    }()
    
    func SetupTableViewCell(){
        
        addSubview(HeaderTextLabel)
        
        HeaderTextLabel.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
