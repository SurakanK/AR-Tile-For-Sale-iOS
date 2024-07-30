//
//  SideMenuUserController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 29/3/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Charts

class SideMenuUserController : UIViewController {
    
    // MARK: Parameter
    // ratio
    lazy var ratio : CGFloat = view.frame.height / 667//view.frame.width / 375.0
    var Delegate : TabBarUserDelegate?
    
    // Element in Page
    // Image Seller
    var Im_Seller : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "saleAccount")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        
        return image
    }()
    // Label Name Seller
    var Lb_NameSeller : UILabel = {
        let label = UILabel()
        label.text = "นายพัทธนันท์ ปุ่นน้ำใส"
        label.font = UIFont.MitrMedium(size: 17)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        return label
    }()
    // Label ID Seller
    var Lb_IDSeller : UILabel = {
        let label = UILabel()
        label.text = "ID: D000013"
        label.font = UIFont.MitrRegular(size: 15)
        label.textColor = UIColor.whiteAlpha(alpha: 0.8)
        return label
    }()
    // -------------------------------------------------
    
    // Label Header Status Quotation
    var Lb_HeaderStatusQuo : UILabel = {
        let label = UILabel()
        label.text = "Quotation Status"
        label.font = UIFont.MitrBold(size: 23)
        label.textColor = UIColor.BlackAlpha(alpha: 0.9)
        //label.textAlignment = .center
        return label
    }()
    
    // View Quotation All -----------
    var View_QuoAll : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlueDeep
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // Icon Quotation All
    var Icon_QuoAll : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bill").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    // Label Quotation All
    var Lb_QuoAll : UILabel = {
        let label = UILabel()
        label.text = "Total Quotation"
        label.font = UIFont.MitrMedium(size: 18)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        return label
    }()
    // Label Num of Quotation
    var Lb_NumQuoAll : UILabel = {
        let label = UILabel()
        label.text = "350"
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        return label
    }()
    
    
    // View Sales Success -----------
    var View_Success : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    // Icon_Success
    var Icon_Success : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "correct").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Success
    var Lb_Success : UILabel = {
        let label = UILabel()
        label.text = "Succcess"
        label.font = UIFont.MitrRegular(size: 15)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // Label Num Sales Success
    var Lb_NumSuccess : UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = UIFont.MitrRegular(size: 15)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // View InProcess -----------
    var View_InProcess : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.YellowDeep
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    // Icon_Success
    var Icon_InProcess : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "stopwatch").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Success
    var Lb_InProcess : UILabel = {
        let label = UILabel()
        label.text = "InProcess"
        label.font = UIFont.MitrRegular(size: 15)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // Label Num Sales Success
    var Lb_NumInProcess : UILabel = {
        let label = UILabel()
        label.text = "50"
        label.font = UIFont.MitrRegular(size: 15)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // View Reject -----------
    var View_Reject : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemRed
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    // Icon_Success
    var Icon_Reject : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "cross-mark-on-a-black-circle-background").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Success
    var Lb_Reject : UILabel = {
        let label = UILabel()
        label.text = "Reject"
        label.font = UIFont.MitrRegular(size: 15)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // Label Num Sales Success
    var Lb_NumReject : UILabel = {
        let label = UILabel()
        label.text = "200"
        label.font = UIFont.MitrRegular(size: 15)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    
    // View Estimate Sales
    var View_Estimate : UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // Icon Estimate Sales
    var Icon_Estimate : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "thai-baht").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    // Label Estimate Sales
    var Lb_Estimate : UILabel = {
        let label = UILabel()
        label.text = "Estimated Sales"
        label.font = UIFont.MitrRegular(size: 18)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        return label
    }()
    // Label Num Estimate Sales
    var Lb_NumEstimate : UILabel = {
        let label = UILabel()
        label.text = "243,000 ฿"
        label.font = UIFont.MitrRegular(size: 18)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        return label
    }()
    
    
    // -------------------------------------------------
    
    // Line Provide Section of Element
    var Line_Section1 : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.BlackAlpha(alpha: 0.6)
        return line
    }()
    
    // View Button Manage -----------
    var View_ManageQuo : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // Icon Manage Quotation
    var Icon_ManageQuo : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bill N 25").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.BlueDeep
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    // Label Manage Quotation
    var Lb_ManageQuo : UILabel = {
        let label = UILabel()
        label.text = "Quotation Management"
        label.font = UIFont.MitrRegular(size: 18)
        label.textColor = UIColor.BlackAlpha(alpha: 0.9)
        return label
    }()
    // Btn Manage Quotation
    var Btn_ManageQuo : UIButton = {
        let button = UIButton()
        button.backgroundColor = .BlueLight
        button.alpha = 0.1
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(ManageQuotation_Click), for: .touchUpInside)
        return button
    }()
    
    // View Sign out ---------
    var View_SignOut : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // Icon Sign out
    var Icon_SignOut : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "logout2").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.systemRed
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    // Label SignOut
    var Lb_SignOut : UILabel = {
        let label = UILabel()
        label.text = "SignOut"
        label.font = UIFont.MitrRegular(size: 18)
        label.textColor = UIColor.BlackAlpha(alpha: 0.9)
        return label
    }()
    // Button Sign out
    var Btn_SignOut : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.alpha = 0.1
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(SignOut_Click), for: .touchUpInside)
        return button
    }()
    // -------------------------------------------------
    
    
    
    
    // MARK: Layout
    func Layout_Page(){
        view.backgroundColor = UIColor.systemGray6
        
        // Image Seller
        view.addSubview(Im_Seller)
        Im_Seller.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 75 * ratio, heightConstant: 75 * ratio)
        
        Im_Seller.layer.cornerRadius = (75 * ratio) / 2
        
        // Label Name Seller
        view.addSubview(Lb_NameSeller)
        Lb_NameSeller.anchor(nil, left: Im_Seller.rightAnchor, bottom: Im_Seller.centerYAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 2.5 * ratio, rightConstant: 60 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_NameSeller.font = UIFont.MitrMedium(size: 18 * ratio)
        
        // Label ID Seller
        view.addSubview(Lb_IDSeller)
        Lb_IDSeller.anchor(Im_Seller.centerYAnchor, left: Lb_NameSeller.leftAnchor, bottom: nil, right: Lb_NameSeller.rightAnchor, topConstant: 2.5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_IDSeller.font = UIFont.MitrRegular(size: 15 * ratio)
        
        // View Background of Upper Section
        let View_Upper = UIView()
        View_Upper.backgroundColor = .BlueDeep
        
        View_Upper.layer.shadowColor = UIColor.gray.cgColor
        View_Upper.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        View_Upper.layer.shadowRadius = 1
        View_Upper.layer.shadowOpacity = 0.5
        
        
        
        view.insertSubview(View_Upper, at: 0)
        View_Upper.anchor(view.topAnchor, left: view.leftAnchor, bottom: Im_Seller.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: -15 *  ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        
        
        // Status Sales of Seller
        // Label Header Status Quotation
        view.addSubview(Lb_HeaderStatusQuo)
        Lb_HeaderStatusQuo.anchor(View_Upper.bottomAnchor, left: Im_Seller.leftAnchor, bottom: nil, right: Lb_NameSeller.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_HeaderStatusQuo.font = UIFont.MitrBold(size: 23)
        
        // View Quotation All -------------------------
        view.addSubview(View_QuoAll)
        View_QuoAll.anchor(Lb_HeaderStatusQuo.bottomAnchor, left: Lb_HeaderStatusQuo.leftAnchor, bottom: nil, right: Lb_HeaderStatusQuo.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Icon Quotation All
        View_QuoAll.addSubview(Icon_QuoAll)
        Icon_QuoAll.anchor(View_QuoAll.topAnchor, left: View_QuoAll.leftAnchor, bottom: View_QuoAll.bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 50 * ratio, heightConstant: 50 * ratio)
        // Label Quotation All
        View_QuoAll.addSubview(Lb_QuoAll)
        Lb_QuoAll.anchor(nil, left: Icon_QuoAll.rightAnchor, bottom: Icon_QuoAll.centerYAnchor, right: View_QuoAll.rightAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 2.5 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_QuoAll.font = UIFont.MitrRegular(size: 18 * ratio)
        // Label NumQuotation All
        View_QuoAll.addSubview(Lb_NumQuoAll)
        Lb_NumQuoAll.anchor(Icon_QuoAll.centerYAnchor, left: Lb_QuoAll.leftAnchor, bottom: nil, right: Lb_QuoAll.rightAnchor, topConstant: 2.5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_NumQuoAll.font = UIFont.MitrRegular(size: 18 * ratio)
        
        // Stack View
        let StackView = UIStackView(arrangedSubviews: [View_Success, View_InProcess, View_Reject])
        StackView.axis = .horizontal
        StackView.spacing = 5
        StackView.distribution = .fillEqually
        
        view.addSubview(StackView)
        StackView.anchor(View_QuoAll.bottomAnchor, left: Lb_HeaderStatusQuo.leftAnchor, bottom: nil, right: Lb_HeaderStatusQuo.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100 * ratio)
        
        // View Success -----------------------------------
        View_Success.addSubview(Icon_Success)
        Icon_Success.anchorCenter(View_Success.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Icon_Success.anchor(View_Success.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 35 * ratio, heightConstant: 35 * ratio)
        // Label Success
        View_Success.addSubview(Lb_Success)
        Lb_Success.anchor(Icon_Success.bottomAnchor, left: View_Success.leftAnchor, bottom: nil, right: View_Success.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Success.font = UIFont.MitrRegular(size: 15 * ratio)
        // Label Num Success
        View_Success.addSubview(Lb_NumSuccess)
        Lb_NumSuccess.anchor(Lb_Success.bottomAnchor, left: Lb_Success.leftAnchor, bottom: View_Success.bottomAnchor, right: Lb_Success.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_NumSuccess.font = UIFont.MitrRegular(size: 15 * ratio)
        
        // View InProcess -----------------------------------
        View_InProcess.addSubview(Icon_InProcess)
        Icon_InProcess.anchorCenter(View_InProcess.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Icon_InProcess.anchor(View_InProcess.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 35 * ratio, heightConstant: 35 * ratio)
        // Label InProcess
        View_InProcess.addSubview(Lb_InProcess)
        Lb_InProcess.anchor(Icon_InProcess.bottomAnchor, left: View_InProcess.leftAnchor, bottom: nil, right: View_InProcess.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_InProcess.font = UIFont.MitrRegular(size: 15 * ratio)
        // Label Num InProcess
        View_InProcess.addSubview(Lb_NumInProcess)
        Lb_NumInProcess.anchor(Lb_InProcess.bottomAnchor, left: Lb_InProcess.leftAnchor, bottom: View_InProcess.bottomAnchor, right: Lb_InProcess.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_NumInProcess.font = UIFont.MitrRegular(size: 15 * ratio)
        
        // View Reject -----------------------------------
        View_Reject.addSubview(Icon_Reject)
        Icon_Reject.anchorCenter(View_Reject.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Icon_Reject.anchor(View_Reject.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 35 * ratio, heightConstant: 35 * ratio)
        // Label reject
        View_Reject.addSubview(Lb_Reject)
        Lb_Reject.anchor(Icon_Reject.bottomAnchor, left: View_Reject.leftAnchor, bottom: nil, right: View_Reject.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Reject.font = UIFont.MitrRegular(size: 15 * ratio)
        // Label Num Reject
        View_Reject.addSubview(Lb_NumReject)
        Lb_NumReject.anchor(Lb_Reject.bottomAnchor, left: Lb_Reject.leftAnchor, bottom: View_Reject.bottomAnchor, right: Lb_Reject.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_NumReject.font = UIFont.MitrRegular(size: 15 * ratio)
        
        // View Quotation All -------------------------
        view.addSubview(View_Estimate)
        View_Estimate.anchor(StackView.bottomAnchor, left: StackView.leftAnchor, bottom: nil, right: StackView.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Icon Quotation All
        View_Estimate.addSubview(Icon_Estimate)
        Icon_Estimate.anchor(View_Estimate.topAnchor, left: View_Estimate.leftAnchor, bottom: View_Estimate.bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 50 * ratio, heightConstant: 50 * ratio)
        // Label Quotation All
        View_Estimate.addSubview(Lb_Estimate)
        Lb_Estimate.anchor(nil, left: Icon_Estimate.rightAnchor, bottom: Icon_Estimate.centerYAnchor, right: View_Estimate.rightAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 2.5 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_Estimate.font = UIFont.MitrRegular(size: 18 * ratio)
        // Label NumQuotation All
        View_Estimate.addSubview(Lb_NumEstimate)
        Lb_NumEstimate.anchor(Icon_Estimate.centerYAnchor, left: Lb_Estimate.leftAnchor, bottom: nil, right: Lb_Estimate.rightAnchor, topConstant: 2.5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_NumEstimate.font = UIFont.MitrRegular(size: 18 * ratio)
        // ---------------------------------------------------------
        
        // Line Section 1
        view.addSubview(Line_Section1)
        Line_Section1.anchor(View_Estimate.bottomAnchor, left: View_Estimate.leftAnchor, bottom: nil, right: View_Estimate.rightAnchor, topConstant: 20 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 1 * ratio)
        Line_Section1.layer.cornerRadius = (1 * ratio) / 2
        
        // Button of Side Menu
        // StackView2
        let StackView2 = UIStackView(arrangedSubviews: [View_ManageQuo, View_SignOut])
        StackView2.axis = .vertical
        StackView2.spacing = 5 * ratio
        StackView2.distribution = .fillEqually
        
        view.addSubview(StackView2)
        StackView2.anchor(Line_Section1.bottomAnchor, left: StackView.leftAnchor, bottom: nil, right: StackView.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // View Manage Quotation
        View_ManageQuo.addSubview(Icon_ManageQuo)
        Icon_ManageQuo.anchor(View_ManageQuo.topAnchor, left: View_ManageQuo.leftAnchor, bottom: View_ManageQuo.bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        // Label Manage Quotation
        View_ManageQuo.addSubview(Lb_ManageQuo)
        Lb_ManageQuo.anchorCenter(nil, AxisY: Icon_ManageQuo.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_ManageQuo.anchor(nil, left: Icon_ManageQuo.rightAnchor, bottom: nil, right: View_ManageQuo.rightAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_ManageQuo.font = UIFont.MitrRegular(size: 18 * ratio)
        // Button Manage Quotaiton
        View_ManageQuo.addSubview(Btn_ManageQuo)
        Btn_ManageQuo.anchor(View_ManageQuo.topAnchor, left: View_ManageQuo.leftAnchor, bottom: View_ManageQuo.bottomAnchor, right: View_ManageQuo.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // View SignOut
        View_SignOut.addSubview(Icon_SignOut)
        Icon_SignOut.anchor(View_SignOut.topAnchor, left: View_SignOut.leftAnchor, bottom: View_SignOut.bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        // Label SignOut
        View_SignOut.addSubview(Lb_SignOut)
        Lb_SignOut.anchorCenter(nil, AxisY: Icon_SignOut.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_SignOut.anchor(nil, left: Icon_SignOut.rightAnchor, bottom: nil, right: View_SignOut.rightAnchor, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_SignOut.font = UIFont.MitrRegular(size: 18 * ratio)
        // Button SignOut
        View_SignOut.addSubview(Btn_SignOut)
        Btn_SignOut.anchor(View_SignOut.topAnchor, left: View_SignOut.leftAnchor, bottom: View_SignOut.bottomAnchor, right: View_SignOut.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    // MARK: Config
    func Config_Page(){
        
        
        
    }
    
    // MARK: Func Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element in Page
        Layout_Page()
        // Config Element in Page
        Config_Page()
        
        
    }
    
    
    // MARK: Func in Page
    // Update Data Detial Selller Initial
    func Update_DataSeller(){
        
        // Set Initail Detail Seller
        Im_Seller.image = TabBarUserController.DataSeller?.Image_Seller
        Lb_NameSeller.text = TabBarUserController.DataSeller?.NameSeller
        Lb_IDSeller.text = "ID : " +  TabBarUserController.DataSeller!.Seller_Id
        
        let TotalQuo = TabBarUserController.DataSeller!.Quo_Complete + TabBarUserController.DataSeller!.Quo_InPro + TabBarUserController.DataSeller!.Quo_Reject
        Lb_NumQuoAll.text = String(TotalQuo).currencyFormatting()
        
        Lb_NumSuccess.text = String(TabBarUserController.DataSeller!.Quo_Complete).currencyFormatting()
        Lb_NumReject.text = String(TabBarUserController.DataSeller!.Quo_Reject).currencyFormatting()
        Lb_NumInProcess.text = String(TabBarUserController.DataSeller!.Quo_InPro).currencyFormatting()
        
        Lb_NumEstimate.text = String(TabBarUserController.DataSeller!.TotalSales).currencyFormatting() + " ฿"
        
    }
    
    
    // Btn Manage Quotation Click
    @objc func ManageQuotation_Click(){
        
        // Hightlight Button
        UIView.animate(withDuration: 0.5, animations: {
            self.Btn_ManageQuo.alpha = 0.5
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.Btn_ManageQuo.alpha = 0.1
            }) { (_) in
                self.Delegate?.ToggleSideMenu(Command: "Manage Quotation")
            }
        }
        
        
        
    }
    
    // Btn SignOut Click
    @objc func SignOut_Click(){
        // Hightlight Button
        UIView.animate(withDuration: 0.5, animations: {
            self.Btn_SignOut.alpha = 0.5
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.Btn_SignOut.alpha = 0.1
            }) { (_) in
                self.Delegate?.ToggleSideMenu(Command: "SignOut")
            }
        }
    }
    
    
    
}
