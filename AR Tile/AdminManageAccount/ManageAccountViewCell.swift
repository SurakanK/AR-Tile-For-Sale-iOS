//
//  ManageAccountViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 24/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import SkeletonView

class ManageAccountViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewAccount: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let viewAccountID: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlueDeep
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let imageSaleAccont: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "saleAccount")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 40
        return image
    }()
    
    let Line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()

    let SaleName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let SalePhoneNumber: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let SaleEmail: UILabel = {
        let label = UILabel()
        label.text = "teeeee"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let SaleEmployeeID: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let SaleAccountID: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let SaleAccountPassword: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    func SetupTableViewCell(){
                
        contentView.addSubview(viewAccountID)
        contentView.addSubview(viewAccount)
        
        viewAccount.addSubview(imageSaleAccont)
        viewAccount.addSubview(Line)
        viewAccount.addSubview(SaleName)
        viewAccount.addSubview(SalePhoneNumber)
        viewAccount.addSubview(SaleEmail)
        viewAccount.addSubview(SaleEmployeeID)
        
        viewAccountID.addSubview(SaleAccountID)
        viewAccountID.addSubview(SaleAccountPassword)
        
        viewAccountID.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 40, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 125)
        
        viewAccount.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 125)
        
        imageSaleAccont.anchorCenter(nil, AxisY: viewAccount.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        imageSaleAccont.anchor(nil, left: viewAccount.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 80)
        
        Line.anchor(viewAccount.topAnchor, left: imageSaleAccont.rightAnchor, bottom: viewAccount.bottomAnchor, right: nil, topConstant: 5, leftConstant: 10, bottomConstant: 5, rightConstant: 0, widthConstant: 1, heightConstant: 0)
        
        SaleName.anchor(viewAccount.topAnchor, left: Line.rightAnchor, bottom: nil, right: viewAccount.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                
        SalePhoneNumber.anchor(SaleName.bottomAnchor, left: Line.rightAnchor, bottom: nil, right: viewAccount.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        SaleEmail.anchor(SalePhoneNumber.bottomAnchor, left: Line.rightAnchor, bottom: nil, right: viewAccount.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        SaleEmployeeID.anchor(SaleEmail.bottomAnchor, left: Line.rightAnchor, bottom: nil, right: viewAccount.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        SaleAccountID.anchor(nil, left: viewAccountID.leftAnchor, bottom: viewAccountID.bottomAnchor, right: SaleAccountPassword.leftAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        SaleAccountPassword.anchor(nil, left: viewAccountID.leftAnchor, bottom: viewAccountID.bottomAnchor, right: viewAccountID.rightAnchor, topConstant: 0, leftConstant: 170, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
        
}
