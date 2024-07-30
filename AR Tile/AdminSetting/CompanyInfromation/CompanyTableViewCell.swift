//
//  CompanyTableViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 19/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell ,UITextFieldDelegate{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupTableViewCell()
        
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewimageLogoCompany: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 100
        view.layer.masksToBounds = true
        return view
    }()
    let imageLogoCompany: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Home")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let CameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.BlackAlpha(alpha: 0.3)
        button.layer.cornerRadius = 20
        button.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    
    let headTextLable: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrLight(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.BlackAlpha(alpha: 0.8)
        label.font = UIFont.MitrLight(size: 14)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let imageNext: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "next").withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.tintColor = UIColor.BlueLight.withAlphaComponent(0.7)
        return image
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 18), NSAttributedString.Key.foregroundColor: UIColor.BlackAlpha(alpha: 0.5)])
        textField.textColor = UIColor.BlackAlpha(alpha: 0.8)
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.adjustsFontSizeToFitWidth = true
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
    
    func SetupTableViewCell(){
        contentView.addSubview(viewimageLogoCompany)
        viewimageLogoCompany.addSubview(imageLogoCompany)
        contentView.addSubview(CameraButton)
        contentView.addSubview(headTextLable)
        contentView.addSubview(titleTextLabel)
        contentView.addSubview(imageNext)
        contentView.addSubview(textField)
        contentView.addSubview(textClearButton)
        
        viewimageLogoCompany.anchorCenter(centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 200, heightConstant: 200)
        
        viewimageLogoCompany.anchor(topAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        imageLogoCompany.anchor(viewimageLogoCompany.topAnchor, left: viewimageLogoCompany.leftAnchor, bottom: viewimageLogoCompany.bottomAnchor, right: viewimageLogoCompany.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        CameraButton.anchor(nil, left: nil, bottom: viewimageLogoCompany.bottomAnchor, right: viewimageLogoCompany.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 5, widthConstant: 40, heightConstant: 40)
        
        headTextLable.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        titleTextLabel.anchor(headTextLable.bottomAnchor, left: headTextLable.leftAnchor, bottom: nil, right: imageNext.leftAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        imageNext.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 18, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 24, heightConstant: 24)
        
        textField.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 35, widthConstant: 0, heightConstant: 0)
        
        textClearButton.anchor(textField.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 12.5, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 25, heightConstant: 25)
        
        selectionStyle = .none
        imageLogoCompany.isHidden = true
        CameraButton.isHidden = true
        headTextLable.isHidden = true
        titleTextLabel.isHidden = true
        imageNext.isHidden = true
        textField.isHidden = true
        textClearButton.isHidden = true
        viewimageLogoCompany.isHidden = true
        
      }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let set = NSCharacterSet.symbols
        let filtered = string.components(separatedBy: set).joined(separator: "")
        return (string == filtered)        
    }
    
}

