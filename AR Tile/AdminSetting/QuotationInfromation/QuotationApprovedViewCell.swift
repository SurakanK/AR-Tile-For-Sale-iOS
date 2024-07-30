//
//  QuotationApprovedViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 5/4/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class QuotationApprovedViewCell: UITableViewCell , UITextViewDelegate {
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
    
    let SwitchUI: UISwitch = {
        let Switch = UISwitch()
        return Switch
    }()
    
    let namefield: UITextField = {
        let textField = UITextField()
        textField.textColor = .BlackAlpha(alpha: 0.8)
        textField.font = UIFont.MitrLight(size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueLight.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let nametitle: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrLight(size: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
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
    
    let imageAutograph: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "autographTest")
        image.layer.borderColor = UIColor.BlueLight.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let autographButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueLight
        button.imageView?.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "autograph").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitle("Signature", for: .normal)
        button.titleLabel?.font = UIFont.MitrRegular(size: 20)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        return button
    }()
    
    func SetupTableViewCell(){
                
        contentView.addSubview(titleTextLabel)
        contentView.addSubview(SwitchUI)
        contentView.addSubview(namefield)
        contentView.addSubview(nametitle)
        contentView.addSubview(textClearButton)
        contentView.addSubview(imageAutograph)
        contentView.addSubview(autographButton)
        
        titleTextLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        SwitchUI.anchor(titleTextLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: -2, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        namefield.anchor(titleTextLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 50)
        
        nametitle.anchor(namefield.topAnchor, left: namefield.leftAnchor, bottom: nil, right: nil, topConstant: -9, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
        textClearButton.anchor(namefield.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 12.5, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 25, heightConstant: 25)
        
        imageAutograph.anchor(namefield.bottomAnchor, left: namefield.leftAnchor, bottom: nil, right: namefield.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
        autographButton.anchor(imageAutograph.bottomAnchor, left: namefield.leftAnchor, bottom: nil, right: namefield.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        let right = UIScreen.main.bounds.width - 100  - 50 - 30
        autographButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: right)
      }
    
    
    
}
