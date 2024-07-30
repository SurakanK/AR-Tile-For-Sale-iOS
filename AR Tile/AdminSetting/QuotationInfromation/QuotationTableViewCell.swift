//
//  QuotationTableViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 23/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class QuotationTableViewCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrLight(size: 18)
        return label
    }()
    
    let TextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.BlackAlpha(alpha: 0.3)
        label.font = UIFont.MitrLight(size: 16)
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 18), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = UIColor.BlackAlpha(alpha: 0.8)
        textField.font = UIFont.MitrLight(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    
    let textClearButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.BlackAlpha(alpha: 0.5)
        button.layer.cornerRadius = 12.5
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        return button
    }()
    
    let imageNext: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "next").withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.tintColor = UIColor.BlueLight.withAlphaComponent(0.7)
        return image
    }()
    
    let SwitchUI: UISwitch = {
        let Switch = UISwitch()
        return Switch
    }()
    
    let TextRemark: UITextView = {
        let textView = UITextView()
        textView.textColor = .BlackAlpha(alpha: 0.8)
        textView.font = UIFont.MitrLight(size: 14)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.layer.borderColor = UIColor.BlueLight.withAlphaComponent(0.7).cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    let remarktitle: UILabel = {
        let label = UILabel()
        label.text = "Remark"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrLight(size: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlackAlpha(alpha: 0.1)
        return view
    }()
    
    func SetupTableViewCell(){
                
        contentView.addSubview(titleTextLabel)
        contentView.addSubview(TextLabel)
        contentView.addSubview(textField)
        contentView.addSubview(textClearButton)
        contentView.addSubview(imageNext)
        contentView.addSubview(SwitchUI)
        contentView.addSubview(TextRemark)
        contentView.addSubview(remarktitle)
        contentView.addSubview(line)
    
        imageNext.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 13, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 24, heightConstant: 24)
        
        textField.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 35, widthConstant: 0, heightConstant: 0)
        
        textClearButton.anchor(textField.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 12.5, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 25, heightConstant: 25)
        
        titleTextLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        TextLabel.anchor(nil, left: titleTextLabel.rightAnchor, bottom: titleTextLabel.bottomAnchor, right: imageNext.leftAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        SwitchUI.anchor(titleTextLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: -2, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        line.anchor(titleTextLabel.bottomAnchor, left: titleTextLabel.leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        TextRemark.anchor(line.bottomAnchor, left: titleTextLabel.leftAnchor, bottom: nil, right: SwitchUI.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 60)
        
        remarktitle.anchor(TextRemark.topAnchor, left: TextRemark.leftAnchor, bottom: nil, right: nil, topConstant: -9, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
       
        selectionStyle = .none
        TextLabel.isHidden = true
        imageNext.isHidden = true
        textField.isHidden = true
        textClearButton.isHidden = true
        SwitchUI.isHidden = true
        TextRemark.isHidden = true
        remarktitle.isHidden = true
        line.isHidden = true
        
      }
    
  
    
    
}
