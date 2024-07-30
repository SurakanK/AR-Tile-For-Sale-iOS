//
//  ManageFooterViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 24/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class ManageFooterViewCell: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let FooterTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.BlackAlpha(alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    func SetupTableViewCell(){
        
        addSubview(FooterTextLabel)
        
        FooterTextLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
