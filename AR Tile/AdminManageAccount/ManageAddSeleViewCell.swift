//
//  ManageAddSeleViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 27/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class ManageAddSeleViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    let textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = UIColor.BlackAlpha(alpha: 0.8)
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    
    let viewTextField: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 241, green: 243, blue: 244)
        view.layer.cornerRadius = 22.5
        view.layer.shadowColor = UIColor.BlackAlpha(alpha: 0.8).cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let imageAccount: UIImageView = {
           let image = UIImageView()
           image.image = #imageLiteral(resourceName: "saleAccount")
           image.contentMode = .scaleAspectFill
           image.layer.masksToBounds = true
           image.layer.cornerRadius = 75
    
           return image
    }()
    
    let iconTextField: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "IconAccount").withTintColor(UIColor.lightGray)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let CameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.BlackAlpha(alpha: 0.3)
        button.layer.cornerRadius = 17.5
        button.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        return button
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
    
    // Element Signature --------------------------------------------------------------------------------------------
    let viewSignature: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let SignatureButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueLight
        button.setImage(#imageLiteral(resourceName: "autograph"), for: .normal)
        button.imageView?.tintColor = .white
        button.setTitle("Signature", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.MitrRegular(size: 20)
        button.layer.cornerRadius = 25
        button.tintColor = .white
        return button
    }()
    
    
    let imageSignature: UIImageView = {
        let image = UIImageView()
        image.layer.borderColor = UIColor.BlueLight.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    func SetupTableViewCell(){
                
        contentView.addSubview(viewTextField)
        viewTextField.addSubview(iconTextField)
        viewTextField.addSubview(textField)
        viewTextField.addSubview(textClearButton)
        
        contentView.addSubview(imageAccount)
        contentView.addSubview(CameraButton)

        contentView.addSubview(viewSignature)
        viewSignature.addSubview(imageSignature)
        viewSignature.addSubview(SignatureButton)

        viewTextField.anchorCenter(nil, AxisY: centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        viewTextField.anchor(nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 45)
        
        iconTextField.anchorCenter(nil, AxisY: viewTextField.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 20, heightConstant: 20)
        
        iconTextField.anchor(nil, left: viewTextField.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        textField.anchorCenter(nil, AxisY: viewTextField.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        textField.anchor(iconTextField.topAnchor, left: iconTextField.rightAnchor, bottom: viewTextField.bottomAnchor, right: viewTextField.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 35, widthConstant: 0, heightConstant: 0)
        
        textClearButton.anchorCenter(nil, AxisY: viewTextField.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        textClearButton.anchor(nil, left: nil, bottom: nil, right: viewTextField.rightAnchor, topConstant: 12.5, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 25, heightConstant: 25)
        
        
        
        imageAccount.anchorCenter(centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 150, heightConstant: 150)
        
        imageAccount.anchor(topAnchor, left: nil, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        CameraButton.anchor(nil, left: nil, bottom: imageAccount.bottomAnchor, right: imageAccount.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 5, widthConstant: 35, heightConstant: 35)

        
        viewSignature.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        imageSignature.anchor(viewSignature.topAnchor, left: viewSignature.leftAnchor, bottom: nil, right: viewSignature.rightAnchor, topConstant: 10, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 100)
        
        SignatureButton.anchor(imageSignature.bottomAnchor, left: viewSignature.leftAnchor, bottom: nil, right: viewSignature.rightAnchor, topConstant: 15, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 50)
        
        let right = UIScreen.main.bounds.width - 100  - 50 - 30
        SignatureButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: right)
      }

    
}
