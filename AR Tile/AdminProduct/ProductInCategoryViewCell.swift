//
//  ProductLookViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 29/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class ProductInCategoryViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SetupTableViewCell()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewload: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        return view
    }()
    
    let CellImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    let ProductNamelable: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .BlackAlpha(alpha: 1)
        label.font = UIFont.MitrLight(size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let viewProductNamelable: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.8)
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.7).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let deleteProductButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.BlackAlpha(alpha: 0.5)
        button.layer.cornerRadius = 12.5
        button.setImage(#imageLiteral(resourceName: "remove"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.whiteAlpha(alpha: 0.9)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1
        return button
    }()
  
    func SetupTableViewCell(){
        
        addSubview(CellImage)
        addSubview(ProductNamelable)
        CellImage.addSubview(viewProductNamelable)
        CellImage.addSubview(viewload)
        contentView.addSubview(deleteProductButton)
        
        viewload.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        CellImage.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        ProductNamelable.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 3, rightConstant: 3, widthConstant: 0, heightConstant: 0)
        
        viewProductNamelable.anchor(ProductNamelable.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        deleteProductButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 25, heightConstant: 25)
    
        
        deleteProductButton.isHidden = !isEditing

    }
    
    var isEditing: Bool = false{
        didSet{
            deleteProductButton.isHidden = !isEditing
        }
    }
    
}

