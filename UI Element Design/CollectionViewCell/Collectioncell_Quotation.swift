//
//  Collectioncell_Quotation.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 5/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class Collectioncell_Quotation : UICollectionViewCell {
    
    // View Check Complete
    var viewLabelCheck : UIView = {
        let view = UIView()
        //view.backgroundColor = .green
        
        view.isSkeletonable = true
        
        return view
    }()
    
    // Label Check Complete
    var Lb_CheckComp : UILabel = {
        let label = UILabel()
        label.text = "Complete"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.font = UIFont.PoppinsBold(size: 13)
        label.textAlignment = .center
        return label
    }()
    
    // Label ID Quotation
    var Lb_IDQuo : UILabel = {
        let label = UILabel()
        label.text = "#PO123983"
        label.font = UIFont.PoppinsMedium(size: 18)
        label.textColor = .BlackAlpha(alpha: 0.9)
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label Date Quotation
    var Lb_Date : UILabel = {
        let label = UILabel()
        label.text = "Date : 06/03/20"
        label.font = UIFont.PoppinsRegular(size: 10)
        label.textColor = .BlackAlpha(alpha: 0.6)
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label Customer
    var Lb_Customer : UILabel = {
        let label = UILabel()
        label.text = "Customer : $$$$$$$$"
        label.font = UIFont.MitrRegular(size: 10)
        label.textColor = .BlackAlpha(alpha: 0.6)
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label By Sale
    var Lb_By : UILabel = {
        let label = UILabel()
        label.text = "By : Pattanun Punnumsai"
        label.font = UIFont.PoppinsRegular(size: 13)
        label.textColor = .BlueDeep
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Label Price of Quotation
    var Lb_Price : UILabel = {
        let label = UILabel()
        label.text = "4,000,000฿"
        label.font = UIFont.PoppinsMedium(size: 20)
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.textAlignment = .right
        
        label.isSkeletonable = true
        
        return label
    }()
    
    // Btn Detail Quotation
    var Btn_Detail : UIButton = {
        let button = UIButton()
        button.backgroundColor = .BlueDeep
        button.titleLabel?.font = UIFont.PoppinsMedium(size: 18)
        button.setTitle("Detail", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.isSkeletonable = true
        
        return button
    }()
    
    var ColorView : String = "1" {
        didSet{
            if self.ColorView == "1" {
                viewLabelCheck.backgroundColor = .systemGreen
                Lb_CheckComp.text = "Complete"
            }
            else if self.ColorView == "0" {
                viewLabelCheck.backgroundColor = .systemYellow
                Lb_CheckComp.text = "InProcess"
            }
            else if self.ColorView == "2" {
                viewLabelCheck.backgroundColor = .systemRed
                Lb_CheckComp.text = "Reject"
            }
        }
    }
    
    // this will be our "call back" action
    var btnTapAction : (()->())?
    
    // Layout ColletionView Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // ratio
        let ratio = frame.width / 355
       
        self.contentView.isUserInteractionEnabled = false
        
        backgroundColor = .white
        // Shadow cell
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        // CornerRadius
        layer.cornerRadius = 10 * ratio
        
        // Layout
        addSubview(viewLabelCheck)
        viewLabelCheck.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 100 * ratio, heightConstant: 25 * ratio)
        viewLabelCheck.layer.cornerRadius = (25 * ratio) / 2
        
        viewLabelCheck.addSubview(Lb_CheckComp)
        
        Lb_CheckComp.anchorCenter(viewLabelCheck.centerXAnchor, AxisY: viewLabelCheck.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_CheckComp.font = UIFont.PoppinsBold(size: 13 * ratio)
        
        // Label ID Quotation
        addSubview(Lb_IDQuo)
        
        Lb_IDQuo.anchor(viewLabelCheck.bottomAnchor, left: viewLabelCheck.leftAnchor, bottom: nil, right: nil , topConstant: 2 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_IDQuo.font = UIFont.PoppinsMedium(size: 20 * ratio)
        
        // Label Price
        addSubview(Lb_Price)
        
        Lb_Price.anchor(viewLabelCheck.topAnchor, left: viewLabelCheck.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 20 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_Price.font = UIFont.PoppinsMedium(size: 20 * ratio)
        
        // Button Detail
        addSubview(Btn_Detail)
        
        Btn_Detail.anchor(nil, left: nil, bottom: bottomAnchor, right: Lb_Price.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15 * ratio, rightConstant: 0, widthConstant: 100 * ratio, heightConstant: 30 * ratio)
        Btn_Detail.layer.cornerRadius = (30 * ratio) / 2
        Btn_Detail.titleLabel?.font = UIFont.PoppinsMedium(size: 18 * ratio)
        
        Btn_Detail.addTarget(self, action: #selector(Event_DetailClick), for: .touchUpInside)
        
        // Label By
            addSubview(Lb_By)
            
        Lb_By.anchor(nil, left: viewLabelCheck.leftAnchor, bottom: bottomAnchor, right: Btn_Detail.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
            Lb_By.font = UIFont.PoppinsRegular(size: 12 * ratio)
        
        // Label Customer
        addSubview(Lb_Customer)
        Lb_Customer.anchor(nil, left: Lb_By.leftAnchor, bottom: Lb_By.topAnchor, right: Lb_By.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Customer.font = UIFont.MitrRegular(size: 12 * ratio)
        
        // Label Date Quotation
        addSubview(Lb_Date)
        
        Lb_Date.anchor(nil, left: Lb_By.leftAnchor, bottom: Lb_Customer.topAnchor, right: nil , topConstant: 0, leftConstant: 0, bottomConstant:  0 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Date.font = UIFont.PoppinsRegular(size: 12 * ratio)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Event Button Click
    @objc func Event_DetailClick() {
        
        // Action
        btnTapAction?()
        
    }
    
    
}
