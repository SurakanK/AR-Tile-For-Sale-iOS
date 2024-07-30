//
//  CollectionCell_ListReportExport.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 27/8/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class CollectionCell_ListReportExport : UICollectionViewCell {
    
    // MARK: Parameter
    lazy var ratio = frame.width / 355
    
    
    // MARK: Element
    // Icon Report
    lazy var Icon_Report : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Icon-Tile").withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Name Report
    lazy var Lb_NameReport : UILabel = {
        let label = UILabel()
        label.text = "Name Report"
        label.font = UIFont.MitrMedium(size: 16 * ratio)
        label.textColor = .BlueDeep
        label.numberOfLines = 2
        return label
    }()
    // Label Description Report
    lazy var Lb_DescripReport : UILabel = {
        let label = UILabel()
        label.text = "Description Report"
        label.font = UIFont.MitrLight(size: 12 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.numberOfLines = 3
        return label
    }()
    
    
    
    
    // MARK: Func Layout and Config
    // Layout ColletionView Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set BG Cell
        backgroundColor = .whiteAlpha(alpha: 0.9)
        // Set CornerRadius
        layer.cornerRadius = 5
        // Set Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3 * ratio, height: 3 * ratio)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        
        // Set Icon Report
        addSubview(Icon_Report)
        Icon_Report.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 100 * ratio, heightConstant: 100 * ratio)
        // Set Label Name Report
        addSubview(Lb_NameReport)
        Lb_NameReport.anchor(Icon_Report.topAnchor, left: Icon_Report.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        // Set Label Description Report
        addSubview(Lb_DescripReport)
        Lb_DescripReport.anchor(Lb_NameReport.bottomAnchor, left: Lb_NameReport.leftAnchor, bottom: nil, right: Lb_NameReport.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
