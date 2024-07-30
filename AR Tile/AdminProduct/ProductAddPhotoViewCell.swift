//
//  ProductAddPhotoViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 6/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import TTSegmentedControl

class ProductAddPhotoViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .white
        
        
        SetupTableViewCell()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageProduct: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    let titleName: UILabel = {
        let label = UILabel()
        label.text = "Product Name"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let titleSize: UILabel = {
        let label = UILabel()
        label.text = "Size Product"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let titlePrice: UILabel = {
        let label = UILabel()
        label.text = "Price Product"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let SizeWidthtitel: UILabel = {
        let label = UILabel()
        label.text = "width:"
        label.textColor = .BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let SizeHeighttitel: UILabel = {
        let label = UILabel()
        label.text = "height:"
        label.textColor = .BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let Patterntitel: UILabel = {
        let label = UILabel()
        label.text = "Tile Pattern"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let Descriptiontitel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let Remarktitel: UILabel = {
        let label = UILabel()
        label.text = "Remark"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let NameField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 15), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = .BlackAlpha(alpha: 0.8)
        textField.font = UIFont.MitrLight(size: 15)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let PriceField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Price: baht", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 15), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = .BlackAlpha(alpha: 0.8)
        textField.font = UIFont.MitrLight(size: 15)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    
    let SizeWidthField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Width: cm", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 15), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = .BlackAlpha(alpha: 0.8)
        textField.font = UIFont.MitrLight(size: 15)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let SizeHeighField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Heigh: cm", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 15), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = .BlackAlpha(alpha: 0.8)
        textField.font = UIFont.MitrLight(size: 15)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueDeep.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let TextDescription: UITextView = {
        let textView = UITextView()
        textView.textColor = .BlackAlpha(alpha: 0.8)
        textView.font = UIFont.MitrLight(size: 15)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.layer.borderColor = UIColor.BlueDeep.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.text = ""
        return textView
    }()
    
    let TextRemark: UITextView = {
        let textView = UITextView()
        textView.textColor = .BlackAlpha(alpha: 0.8)
        textView.font = UIFont.MitrLight(size: 15)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.layer.borderColor = UIColor.BlueDeep.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.text = ""
        return textView
    }()
    
    let SegmenControl: TTSegmentedControl = {
       let Segmen = TTSegmentedControl()
        Segmen.defaultTextFont = UIFont.MitrLight(size: 15)
        Segmen.defaultTextColor = .BlueDeep

        Segmen.selectedTextFont = UIFont.MitrLight(size: 15)
        Segmen.selectedTextColor = .white
        
        Segmen.thumbGradientColors = [.BlueDeep,.BlueDeep]
        Segmen.itemTitles = ["1 Tile","4 Tile"]
        
        Segmen.useShadow = true
        Segmen.allowChangeThumbWidth = false
        return Segmen
    }()
    
    func SetupTableViewCell(){
       
        contentView.addSubview(imageProduct)
        contentView.addSubview(titleName)
        contentView.addSubview(titleSize)
        contentView.addSubview(titlePrice)
        contentView.addSubview(SizeWidthtitel)
        contentView.addSubview(SizeHeighttitel)
        contentView.addSubview(NameField)
        contentView.addSubview(PriceField)
        contentView.addSubview(SizeWidthField)
        contentView.addSubview(SizeHeighField)
        contentView.addSubview(TextDescription)
        contentView.addSubview(Patterntitel)
        contentView.addSubview(Descriptiontitel)
        contentView.addSubview(SegmenControl)
        contentView.addSubview(TextRemark)
        contentView.addSubview(Remarktitel)
        
        imageProduct.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 180, heightConstant: 180)
        
        titleName.anchor(topAnchor, left: imageProduct.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        NameField.anchor(titleName.bottomAnchor, left: titleName.leftAnchor, bottom: nil, right: titleName.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        titlePrice.anchor(NameField.bottomAnchor, left: titleName.leftAnchor, bottom: nil, right: titleName.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        PriceField.anchor(titlePrice.bottomAnchor, left: titleName.leftAnchor, bottom: nil, right: titleName.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        Patterntitel.anchor(PriceField.bottomAnchor, left: titleName.leftAnchor, bottom: nil, right: titleName.rightAnchor, topConstant: 0, leftConstant: 0 , bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        SegmenControl.anchor(Patterntitel.bottomAnchor, left: Patterntitel.leftAnchor, bottom: nil, right: Patterntitel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 35)
        
        
        let cellWidth = (frame.size.width - 130)/2
        
        titleSize.anchor(imageProduct.bottomAnchor, left: imageProduct.leftAnchor, bottom: nil, right: titleName.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        SizeWidthtitel.anchor(titleSize.bottomAnchor, left: imageProduct.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 0)
        
        SizeWidthField.anchor(titleSize.bottomAnchor, left: SizeWidthtitel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: cellWidth, heightConstant: 40)
        
        SizeHeighttitel.anchor(SizeWidthtitel.topAnchor, left: SizeWidthField.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 0)
        
        SizeHeighField.anchor(titleSize.bottomAnchor, left: SizeHeighttitel.rightAnchor, bottom: nil, right: titleName.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)

        Descriptiontitel.anchor(SizeHeighField.bottomAnchor, left: imageProduct.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        TextDescription.anchor(Descriptiontitel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        Remarktitel.anchor(TextDescription.bottomAnchor, left: imageProduct.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        TextRemark.anchor(Remarktitel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
               
    }
}
