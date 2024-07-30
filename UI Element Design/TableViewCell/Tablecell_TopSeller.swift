//
//  Tablecell_TopSeller.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 1/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class Tablecell_TopSeller : UITableViewCell {
    
    // Label Order Top Seller
    var Lb_Order : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 10)
        label.text = "1"
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Image Seller
    var Im_Seller : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "user")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    // Label Name Seller
    var Lb_NameSeller : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 10)
        label.text = "Name"
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.numberOfLines = 2
        return label
    }()
    
    // Label Sales Seller
    var Lb_SalesSeller : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 10)
        label.text = "1,000,000฿"
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    
    
    // Label Quotation Seller
    var Lb_QuotationSeller : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 10)
        label.text = "10"
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.textAlignment = .center
        
        return label
    }()
    
    
    // Layout TableView cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(Lb_Order)
        addSubview(Im_Seller)
        addSubview(Lb_NameSeller)
        addSubview(Lb_SalesSeller)
        addSubview(Lb_QuotationSeller)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
