//
//  ManageHeaderViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 24/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class ManageHeaderViewCell: UITableViewHeaderFooterView {
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
        label.textColor = UIColor.BlueDeep
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    func SetupTableViewCell(){
        
        contentView.addSubview(HeaderTextLabel)
        
        HeaderTextLabel.anchor(nil, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
}
