//
//  Tablecell_TopProduct.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 28/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class Tablecell_TopProduct : UITableViewCell {
    
    // View Name Product
    var View_NamePro : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // View Quantity
    var View_QuanPro : UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    // View Sales Product
    var View_SalesPro : UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    // Label Order Top Product
    var Lb_Order : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 10)
        label.textColor = .BlackAlpha(alpha: 0.8)
        
        label.text = "1."
        return label
    }()
    
    // Image Product
    var Im_Pro : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        
    
        return image
    }()
    
    // Name Product
    var Lb_NamePro : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 10)
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.numberOfLines = 3
        
        label.text = "GA-101"
        return label
    }()
    
    // Quantity Product
    var Lb_QuanPro : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 10)
        label.textColor = .BlackAlpha(alpha: 0.8)
        
        label.textAlignment = .center
        
        label.text = "100"
        return label
    }()
    
    // Sales Product
    var Lb_SalesPro : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 10)
        label.textColor = .BlackAlpha(alpha: 0.8)
        
        label.textAlignment = .center
        
        label.text = "10K"
        return label
    }()
    
    
    
    // Layout TableView cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(Lb_Order)
        addSubview(Im_Pro)
        addSubview(Lb_NamePro)
        addSubview(Lb_QuanPro)
        addSubview(Lb_SalesPro)
        
        
        
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
