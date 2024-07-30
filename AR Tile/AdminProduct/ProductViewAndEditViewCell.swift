//
//  ProductViewAndEditViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 1/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import TTSegmentedControl


class ProductViewAndEditViewCell: UITableViewCell {
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let productImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Icon-Tile")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let texttitel: UILabel = {
        let label = UILabel()
        label.text = "Product Name"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrLight(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Product Name", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 18), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = .BlackAlpha(alpha: 0.5)
        textField.font = UIFont.MitrLight(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlackAlpha(alpha: 0.3).cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        return textField
    }()
        
    let viewPrice: UIView = {
         let view = UIView()
         view.backgroundColor = .white
         return view
     }()
     
    let SizeWidthtitel: UILabel = {
        let label = UILabel()
        label.text = "width:"
        label.textColor = .BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrLight(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let SizeHeighttitel: UILabel = {
        let label = UILabel()
        label.text = "height:"
        label.textColor = .BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrLight(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let TilePatterntitle: UILabel = {
        let label = UILabel()
        label.text = "Tile Pattern"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrLight(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let Descriptiontitle: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrLight(size: 18)
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
    
    let PriceWidthField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 18), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = .BlackAlpha(alpha: 0.5)
        textField.font = UIFont.MitrLight(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlackAlpha(alpha: 0.3).cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let PriceHeighField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 18), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = .BlackAlpha(alpha: 0.5)
        textField.font = UIFont.MitrLight(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlackAlpha(alpha: 0.3).cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad
        return textField
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
    
    func SetupTableViewCell(){
        
        contentView.addSubview(productImage)
        contentView.addSubview(texttitel)
        contentView.addSubview(textField)
        contentView.addSubview(TilePatterntitle)
        contentView.addSubview(SegmenControl)
        contentView.addSubview(Descriptiontitle)
        contentView.addSubview(TextDescription)
        contentView.addSubview(Remarktitel)
        contentView.addSubview(TextRemark)
        
        contentView.addSubview(viewPrice)
        viewPrice.addSubview(SizeWidthtitel)
        viewPrice.addSubview(PriceWidthField)
        viewPrice.addSubview(SizeHeighttitel)
        viewPrice.addSubview(PriceHeighField)
       

        productImage.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        texttitel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        textField.anchor(texttitel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 40)
        
        viewPrice.anchor(texttitel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 40)
        
        SizeWidthtitel.anchor(viewPrice.topAnchor, left: viewPrice.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        PriceWidthField.anchor(viewPrice.topAnchor, left: SizeWidthtitel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 40)
        
        SizeHeighttitel.anchor(viewPrice.topAnchor, left: PriceWidthField.rightAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        PriceHeighField.anchor(viewPrice.topAnchor, left: SizeHeighttitel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 40)
        
        TilePatterntitle.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        SegmenControl.anchor(TilePatterntitle.bottomAnchor, left: TilePatterntitle.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 40)
        
        Descriptiontitle.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        TextDescription.anchor(Descriptiontitle.bottomAnchor, left: Descriptiontitle.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        Remarktitel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        TextRemark.anchor(Descriptiontitle.bottomAnchor, left: Descriptiontitle.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
    }
}
