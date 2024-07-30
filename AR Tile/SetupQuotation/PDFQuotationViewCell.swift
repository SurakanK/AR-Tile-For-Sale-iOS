//
//  PDFQuotationViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 10/4/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class PDFQuotationViewCell: UITableViewCell {
    
    let numberline: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let numberktitle: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 6, weight: .medium)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let productNameAndDescriptitle: UILabel = {
        let label = UILabel()
        label.text = "ESM-EX6255-156 : wood tile size 50*60CM. TTE-6255-15"
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let productRemarktitle: UILabel = {
        let label = UILabel()
        label.text = "บรรจุ 16 แผ่น/กล่อง/1.44ตร.ม \n จำนวนที่เสนอสำหรับ 1234.08ตร.ม"
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let productNamline: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let areatitle: UILabel = {
        let label = UILabel()
        label.text = "1234.08ตร.ม"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let arealine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let unitPricetitle: UILabel = {
        let label = UILabel()
        label.text = "457.940"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let priceline: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    
    let discountitle: UILabel = {
        let label = UILabel()
        label.text = "100%"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let discountline: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let priceTotaltitle: UILabel = {
        let label = UILabel()
        label.text = "9,074,465.77"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.selectionStyle = .none

        SetupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
    func SetupTableViewCell(){
        
        addSubview(numberktitle)
        addSubview(productNameAndDescriptitle)
        addSubview(productRemarktitle)
        addSubview(areatitle)
        addSubview(unitPricetitle)
        addSubview(discountitle)
        addSubview(priceTotaltitle)
        
        addSubview(numberline)
        addSubview(productNamline)
        addSubview(arealine)
        addSubview(priceline)
        addSubview(discountline)

        
        numberktitle.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 10, heightConstant: 0)
        
        numberline.anchor(self.topAnchor, left: numberktitle.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0.3, heightConstant: 0)
        
        productNameAndDescriptitle.anchor(self.topAnchor, left: numberktitle.rightAnchor, bottom: nil, right: productRemarktitle.leftAnchor, topConstant: 2, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 0, heightConstant: 0)
        
        productRemarktitle.anchor(productNameAndDescriptitle.bottomAnchor, left: productNameAndDescriptitle.leftAnchor, bottom: self.bottomAnchor, right: productNameAndDescriptitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 2, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        productNamline.anchor(self.topAnchor, left: productNameAndDescriptitle.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0.3, heightConstant: 0)
        
        areatitle.anchor(self.topAnchor, left: productRemarktitle.rightAnchor, bottom: self.bottomAnchor, right: unitPricetitle.leftAnchor, topConstant: 0, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 40, heightConstant: 0)
        
        arealine.anchor(self.topAnchor, left: areatitle.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0.3, heightConstant: 0)
        
        unitPricetitle.anchor(self.topAnchor, left: areatitle.rightAnchor, bottom: self.bottomAnchor, right: discountitle.leftAnchor, topConstant: 0, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 40, heightConstant: 0)
        
        priceline.anchor(self.topAnchor, left: unitPricetitle.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0.3, heightConstant: 0)
        
        discountitle.anchor(self.topAnchor, left: unitPricetitle.rightAnchor, bottom: self.bottomAnchor, right: priceTotaltitle.leftAnchor, topConstant: 0, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 20, heightConstant: 0)
        
        discountline.anchor(self.topAnchor, left: discountitle.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0.3, heightConstant: 0)
        
        priceTotaltitle.anchor(self.topAnchor, left: discountitle.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 50, heightConstant: 0)
    }

    
}
