//
//  CustomerQuotationViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 29/5/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class CustomerQuotationViewCell: UICollectionViewCell {
    
    let labelStatus: UILabel = {
        let label = UILabel()
        label.text = "Complete"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.font = UIFont.MitrRegular(size: 15)
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        return label
    }()
    
    let labelID: UILabel = {
        let label = UILabel()
        label.text = "#QO10001"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.font = UIFont.MitrMedium(size: 18)
        label.numberOfLines = 1
        return label
    }()
    
    let labelPrice: UILabel = {
        let label = UILabel()
        label.text = "5,000,000 ฿"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.font = UIFont.MitrMedium(size: 18)
        label.numberOfLines = 1
        return label
    }()
    
    let labelDate: UILabel = {
        let label = UILabel()
        label.text = "Date : 10/05/18"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .BlackAlpha(alpha: 0.4)
        label.font = UIFont.MitrRegular(size: 10)
        label.numberOfLines = 1
        return label
    }()
    
    let labelCustomer: UILabel = {
        let label = UILabel()
        label.text = "Customer : บริษัท CP จำกัด มหาชน"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .BlackAlpha(alpha: 0.4)
        label.font = UIFont.MitrRegular(size: 10)
        label.numberOfLines = 1
        return label
    }()
    
    let labelBySale: UILabel = {
        let label = UILabel()
        label.text = "By : นาย สุรกาน กาหลง"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .BlackAlpha(alpha: 0.4)
        label.font = UIFont.MitrRegular(size: 10)
        label.numberOfLines = 1
        return label
    }()
    
    let labelDetail: UILabel = {
        let label = UILabel()
        label.text = "Detail"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.font = UIFont.MitrRegular(size: 15)
        label.textAlignment = .center
        label.backgroundColor = .BlueDeep
        label.layer.cornerRadius = 12.5
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        return label
    }()
    
    // Btn View Detial Quotation
    var Btn_Detial : UIButton = {
        let button = UIButton()
        button.backgroundColor = .BlueDeep
        button.titleLabel?.font = UIFont.PoppinsMedium(size: 18)
        button.setTitle("Detail", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        //button.isSkeletonable = true
        
        return button
    }()

    
    // this will be our "call back" action
    var btnTapAction : (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.borderColor = UIColor.BlueDeep.cgColor
        layer.borderWidth = 2
        
        SetupCollectionViewCell()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func SetupCollectionViewCell(){
        addSubview(labelStatus)
        addSubview(labelPrice)
        addSubview(labelID)
        addSubview(labelDate)
        addSubview(labelCustomer)
        addSubview(labelBySale)
        //addSubview(labelDetail)
        contentView.addSubview(Btn_Detial)

        labelStatus.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 90, heightConstant: 30)

        labelPrice.anchor(labelStatus.topAnchor, left: labelStatus.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelID.anchor(labelStatus.bottomAnchor, left: labelStatus.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelDate.anchor(nil, left: labelStatus.leftAnchor, bottom: labelCustomer.topAnchor, right: Btn_Detial.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelCustomer.anchor(nil, left: labelStatus.leftAnchor, bottom: labelBySale.topAnchor, right: Btn_Detial.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelBySale.anchor(nil, left: labelStatus.leftAnchor, bottom: self.bottomAnchor, right: Btn_Detial.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        //labelDetail.anchor(nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 80, heightConstant: 25)
        Btn_Detial.anchor(nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 80, heightConstant: 25)
        Btn_Detial.layer.cornerRadius = 25 / 2
        
        Btn_Detial.addTarget(self, action: #selector(Event_DetailClick), for: .touchUpInside)
    }
    

    // MARK: Event Button Click
    @objc func Event_DetailClick() {
        
        // Action
        btnTapAction?()
        
    }
    
}
