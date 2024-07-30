//
//  CustomerListViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 23/5/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class CustomerListViewCell: UICollectionViewCell {
    
    let labelCompanyName: UILabel = {
        let label = UILabel()
        label.text = "บริษัท CP จำกัด มหาชน"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrMedium(size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let labelTypeCompany: UILabel = {
        let label = UILabel()
        label.text = "ประเภท : วิศวกร"
        label.textColor = .BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrRegular(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let labelContactPersonCompany: UILabel = {
        let label = UILabel()
        label.text = "ชื่อผู้ติดต่อ : นาย ประยุทธ์ ซันโนบรา"
        label.textColor = .BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrRegular(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let labelPhoneContactPersonCompany: UILabel = {
        let label = UILabel()
        label.text = "หมายเลขโทรศัพท์ : 084-758-2323"
        label.textColor = .BlackAlpha(alpha: 0.5)
        label.font = UIFont.MitrRegular(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let labelGradeCustomer: UILabel = {
        let label = UILabel()
        label.text = "B"
        label.textColor = .white
        label.font = UIFont.MitrMedium(size: 25)
        label.textAlignment = .center
        label.backgroundColor = .systemYellow
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    let IconimageViewEditCustomer: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "gear").withTintColor(.systemGray4)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
        
        SetupCollectionViewCell()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func SetupCollectionViewCell(){
        
        addSubview(labelCompanyName)
        addSubview(labelTypeCompany)
        addSubview(labelContactPersonCompany)
        addSubview(labelPhoneContactPersonCompany)
        addSubview(labelGradeCustomer)
        addSubview(IconimageViewEditCustomer)
        
        labelCompanyName.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        labelTypeCompany.anchor(nil, left: self.leftAnchor, bottom: labelContactPersonCompany.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelContactPersonCompany.anchor(nil, left: self.leftAnchor, bottom: labelPhoneContactPersonCompany.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelPhoneContactPersonCompany.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelGradeCustomer.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 40, heightConstant: 40)

        IconimageViewEditCustomer.anchor(labelGradeCustomer.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        IconimageViewEditCustomer.anchorCenter(labelGradeCustomer.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
    }
    

}
