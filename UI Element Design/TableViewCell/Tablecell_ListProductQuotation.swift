//
//  Tablecell_ListProductQuotation.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 10/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class Tablecell_ListProductQuotation : UITableViewCell {
    
    // Label Name Product
    var Lb_NamePro : UILabel = {
        let label = UILabel()
        label.text = "GA-110"
        label.font = UIFont.PoppinsRegular(size: 10)
        return label
    }()
    
    // Label Quantity Product
    var Lb_QuanPro : UILabel = {
        let label = UILabel()
        label.text = "GA-110"
        label.font = UIFont.PoppinsRegular(size: 10)
        label.textAlignment = .center
        return label
    }()
    
    // Label Price Product
    var Lb_PricePro : UILabel = {
        let label = UILabel()
        label.text = "GA-110"
        label.font = UIFont.PoppinsRegular(size: 10)
        label.textAlignment = .center
        return label
    }()
    
    // Label Total Product
    var Lb_TotalPro : UILabel = {
        let label = UILabel()
        label.text = "GA-110"
        label.font = UIFont.PoppinsRegular(size: 10)
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    // Layout TableView cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(Lb_NamePro)
        addSubview(Lb_QuanPro)
        addSubview(Lb_PricePro)
        addSubview(Lb_TotalPro)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
