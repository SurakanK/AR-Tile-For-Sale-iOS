//
//  CollectionCell_TopProductOverall.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 10/6/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import SkeletonView

class CollectionCell_TopProductOverall : UICollectionViewCell {
    
    // MARK: Parameter
    lazy var ratio = frame.width / 335
    
    // Parameter for Set Image
    var ImageProduct : UIImage = #imageLiteral(resourceName: "Icon-Tile") {
        didSet{
            
            // Set Image
            Im_Pro.image = ImageProduct
            
        }
    }
    
    
    // MARK: Element
    // View Order
    var View_Order : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    
    // Label Order
    lazy var Lb_Order : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.MitrRegular(size: 23 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    
    // Image Product
    var Im_Pro : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Icon-Tile")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        
        image.isSkeletonable = true
        return image
    }()
    
    // Label Name Pro
    lazy var Lb_NamePro : UILabel = {
        let label = UILabel()
        label.text = "?????"
        label.font = UIFont.MitrMedium(size: 23 * ratio)
        label.textColor = .BlueDeep
        
        label.isSkeletonable = true
        return label
    }()
    
    // Label Quantity Pro
    lazy var Lb_QuanPro : UILabel = {
        let label = UILabel()
        label.text = "QTY : 0 m²"
        label.font = UIFont.MitrLight(size: 15 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        
        label.isSkeletonable = true
        return label
    }()
    
    // Label Total Price
    lazy var Lb_TotalPro : UILabel = {
        let label = UILabel()
        label.text = "Total : 0 ฿"
        label.font = UIFont.MitrLight(size: 15 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        
        label.isSkeletonable = true
        return label
    }()
    
    
    // MARK: Layout Pagea
    // Layout ColletionView Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Layout
        backgroundColor = .whiteAlpha(alpha: 1)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        // View Order
        addSubview(View_Order)
        View_Order.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50 * ratio, heightConstant: 0)
        
        // Label Order
        View_Order.addSubview(Lb_Order)
        Lb_Order.anchorCenter(View_Order.centerXAnchor, AxisY: View_Order.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        // Image Product
        addSubview(Im_Pro)
        Im_Pro.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Im_Pro.anchor(nil, left: View_Order.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 100 * ratio, heightConstant: 100 * ratio)
        
        // Label Quantity Product
        addSubview(Lb_QuanPro)
        Lb_QuanPro.anchorCenter(nil, AxisY: Im_Pro.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_QuanPro.anchor(nil, left: Im_Pro.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Label Name Pro
        addSubview(Lb_NamePro)
        Lb_NamePro.anchor(nil, left: Lb_QuanPro.leftAnchor, bottom: Lb_QuanPro.topAnchor, right: Lb_QuanPro.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 3 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Label Total Price Product
        addSubview(Lb_TotalPro)
        Lb_TotalPro.anchor(Lb_QuanPro.bottomAnchor, left: Lb_QuanPro.leftAnchor, bottom: nil, right: Lb_QuanPro.rightAnchor, topConstant: 3 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
