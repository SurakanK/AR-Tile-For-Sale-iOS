//
//  CollecitonCell_Catagory.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 3/4/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import SkeletonView

class CollecitonCell_Catagory : UICollectionViewCell {
    
    var view = UIView()
    
    // Label Name Catagory
    var Lb_Catagory : UILabel = {
        let label = UILabel()
        label.text = "PoolTile"
        label.font = UIFont.MitrMedium(size: 18)
        label.textColor = UIColor.BlueDeep
        
        label.isSkeletonable = true
        return label
    }()
    
    // Label Num Product
    var Lb_NumProduct : UILabel = {
        let label = UILabel()
        label.text = "30 Product"
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = UIColor.BlackAlpha(alpha: 0.9)
        
        label.layer.cornerRadius = 5
        
        label.isSkeletonable = true
        return label
    }()
    
    // Image of Cell
    var Image_Catagory : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "GA-060_20x20_1950_")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        
        image.isSkeletonable = true
        return image
    }()
    
    // View Gradient
    var View_Gradient : UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        return view
    }()
    
    
    // image Download
    var Image_Download : UIImage = #imageLiteral(resourceName: "Icon-Tile").withRenderingMode(.alwaysTemplate) {
        
        didSet{
            
            self.Image_Catagory.image = self.Image_Download
            
        }
        
    }
    
    // Layout ColletionView Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    
        // Layout
        // Set Cell
        layer.cornerRadius = 10
        
        let ratio = frame.width / 355
        
        backgroundColor = .white
        //layer.masksToBounds = true
        // Shadow cell
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        // CornerRadius
        layer.cornerRadius = 10 * ratio
        
        // view
        view.layer.cornerRadius = 10 * ratio
        view.layer.masksToBounds = true
        addSubview(view)
        view.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        // Image Catagory
        view.addSubview(Image_Catagory)
        Image_Catagory.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 150)
        
        Image_Catagory.layer.masksToBounds = true
        Image_Catagory.isSkeletonable = true
        
        // View Gradient
        view.addSubview(View_Gradient)
        View_Gradient.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        View_Gradient.layer.masksToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.masksToBounds = true
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.whiteAlpha(alpha: 0.9).cgColor, UIColor.whiteAlpha(alpha: 0.0).cgColor]
        gradient.cornerRadius = 10 * ratio
    
        View_Gradient.layer.addSublayer(gradient)
        
        // Label Name Catagory
        view.addSubview(Lb_Catagory)
        Lb_Catagory.anchor(nil, left: leftAnchor, bottom: centerYAnchor, right: nil, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 2.5 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Catagory.font = UIFont.MitrMedium(size: 18 * ratio)
        Lb_Catagory.isSkeletonable = true
        
        // Label Num Product
        view.addSubview(Lb_NumProduct)
        Lb_NumProduct.anchor(centerYAnchor, left: Lb_Catagory.leftAnchor, bottom: nil, right: nil, topConstant: 2.5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_NumProduct.font = UIFont.MitrLight(size: 15 * ratio)
        Lb_NumProduct.isSkeletonable = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
