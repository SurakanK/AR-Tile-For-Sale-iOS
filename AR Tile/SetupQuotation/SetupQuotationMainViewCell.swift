//
//  SetupQuotationMainViewCell.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 30/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class SetupQuotationMainViewCell: UITableViewCell{
    
    weak var tableViewProduct : UITableView?

    private var CellID = "CellID"

    let sideButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueLight
        button.setImage(#imageLiteral(resourceName: "arrowTop").withTintColor(.white), for: .normal)
        button.imageView?.tintColor = .white
        button.setTitle("Company", for: .normal)
        button.titleLabel?.font = UIFont.MitrRegular(size: 20)
        button.layer.cornerRadius = 5
        button.tintColor = .white        
        return button
    }()
    
    let CreateQoutationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemOrange
        button.setImage(#imageLiteral(resourceName: "checklist").withTintColor(.white), for: .normal)
        button.imageView?.tintColor = .white
        button.setTitle("Create", for: .normal)
        button.titleLabel?.font = UIFont.MitrRegular(size: 20)
        button.layer.cornerRadius = 5
        button.tintColor = .white
        return button
    }()
    
    let viewCompany: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let viewCustomerDetail: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let viewCustomer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let viewSale: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let viewProduct: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let viewApproved: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    //Element viewCompany-------------------------------------------------------------------------------------------------
    let imageLogo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Logo TheThreeTouch")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let companyNametile: UILabel = {
        let label = UILabel()
        label.text = "บริษัท เดอะตรีทัช เอเชียแปซิฟิค จำกัด"
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrRegular(size: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let companyAddresstitle: UILabel = {
        let label = UILabel()
        label.text = "56/23 ถ.เสรีไทย แขวงรามอินทรา เขตคันนายาว กรุงเทพ 10240"
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    let companyEmailandWebtitle: UILabel = {
        let label = UILabel()
        label.text = "Email : threetouch@gmail.com , Web : www.theetouch.com"
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    let companyPhoneandFaxtitle: UILabel = {
        let label = UILabel()
        label.text = "Phone : 02-379-9065 , Fax : 02-379-9070"
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    //Element viewCustomerDetail------------------------------------------------------------------------------------------

    let buttonSelectCustomer: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemOrange
        button.setImage(#imageLiteral(resourceName: "IconAccount").withTintColor(.white), for: .normal)
        button.imageView?.tintColor = .white
        button.setTitle("Select your customer", for: .normal)
        button.titleLabel?.font = UIFont.MitrRegular(size: 20)
        button.layer.cornerRadius = 5
        button.tintColor = .white
        return button
    }()
    
    //Element viewCustomer------------------------------------------------------------------------------------------------

    let CustomerCompanyNametitle: UILabel = {
        let label = UILabel()
        label.text = "Company Name"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let CustomerCompanyAddresstitle: UILabel = {
        let label = UILabel()
        label.text = "Company Address"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let CustomerCompanyNametextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .BlackAlpha(alpha: 0.6)
        textField.font = UIFont.MitrLight(size: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueLight.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let CustomerCompanyAddresstextField: UITextView = {
        let textView = UITextView()
        textView.textColor = .BlackAlpha(alpha: 0.6)
        textView.font = UIFont.MitrLight(size: 16)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        textView.layer.borderColor = UIColor.BlueLight.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.text = ""
        return textView
    }()
    
    let viewCustomerContact: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 5
        return view
    }()
    
    let CustomerContacttitle: UILabel = {
        let label = UILabel()
        label.text = "Contact"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.sizeToFit()
        return label
    }()
    
    let CustomerContactNametitle: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 14)
        label.sizeToFit()
        return label
    }()
    
    let CustomerContactPhoneNumbertitle: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 14)
        label.sizeToFit()
        return label
    }()
    
    let CustomerContactEmailtitle: UILabel = {
        let label = UILabel()
        label.text = "Email "
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 14)
        label.sizeToFit()
        return label
    }()
    
    let CustomerContactLinetitle: UILabel = {
        let label = UILabel()
        label.text = "ID Line"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 14)
        label.sizeToFit()
        return label
    }()
    let CustomerContactRemarktitle: UILabel = {
        let label = UILabel()
        label.text = "Remark"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 14)
        label.sizeToFit()
        return label
    }()
    
    let CustomerContactNameField: UITextField = {
        let textField = UITextField()
        textField.textColor = .BlackAlpha(alpha: 0.6)
        textField.font = UIFont.MitrLight(size: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueLight.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let CustomerContactPhoneNumberField: UITextField = {
        let textField = UITextField()
        textField.textColor = .BlackAlpha(alpha: 0.6)
        textField.font = UIFont.MitrLight(size: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueLight.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let CustomerContactEmailField: UITextField = {
        let textField = UITextField()
        textField.textColor = .BlackAlpha(alpha: 0.6)
        textField.font = UIFont.MitrLight(size: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueLight.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let CustomerContactLineField: UITextField = {
        let textField = UITextField()
        textField.textColor = .BlackAlpha(alpha: 0.6)
        textField.font = UIFont.MitrLight(size: 16)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.BlueLight.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let CustomerContactRemarkField: UITextView = {
        let textView = UITextView()
        textView.textColor = .BlackAlpha(alpha: 0.6)
        textView.font = UIFont.MitrLight(size: 16)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.layer.borderColor = UIColor.BlueLight.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.text = ""
        textView.tag = 0
        return textView
    }()
    
    let buttonResetCustomer: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemOrange
        button.setImage(#imageLiteral(resourceName: "undo").withTintColor(.white), for: .normal)
        button.imageView?.tintColor = .white
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = UIFont.MitrRegular(size: 20)
        button.layer.cornerRadius = 5
        button.tintColor = .white
        return button
    }()
    
    //Element viewsale------------------------------------------------------------------------------------------------
   
    let saleNametitle: UILabel = {
        let label = UILabel()
        label.text = "Name : นาย สุรกานต์ กาสุรงค์"
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let salePhoneNumberitle: UILabel = {
        let label = UILabel()
        label.text = "Phone : 0839958375"
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.numberOfLines = 0
        label.sizeToFit()
         return label
    }()
    
    let saleEmailtitle: UILabel = {
        let label = UILabel()
        label.text = "Email : surakan@gmail.com"
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let saleRemarktitle: UILabel = {
         let label = UILabel()
         label.text = "Remark"
         label.backgroundColor = .white
         label.textColor = .BlackAlpha(alpha: 0.6)
         label.font = UIFont.MitrLight(size: 14)
         label.sizeToFit()
         return label
     }()
    
    let saleRemarkField: UITextView = {
        let textView = UITextView()
        textView.textColor = .BlackAlpha(alpha: 0.6)
        textView.font = UIFont.MitrLight(size: 16)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.layer.borderColor = UIColor.BlueLight.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.text = ""
        textView.tag = 1
        return textView
    }()
    
    //Element viewProduct------------------------------------------------------------------------------------------------

    let Numbertitle: UILabel = {
        let label = UILabel()
        label.text = "No."
        label.backgroundColor = UIColor.BlueLight
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let productNametitle: UILabel = {
        let label = UILabel()
        label.text = "Product id"
        label.backgroundColor = UIColor.BlueLight
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let Discriptiontitle: UILabel = {
        let label = UILabel()
        label.text = "Discription"
        label.backgroundColor = UIColor.BlueLight
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let quantitytitle: UILabel = {
        let label = UILabel()
        label.text = "Quantity\n(m2)"
        label.backgroundColor = UIColor.BlueLight
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let unitPricetitle: UILabel = {
        let label = UILabel()
        label.text = "Unit Price\n(baht)"
        label.backgroundColor = UIColor.BlueLight
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let Discounttitle: UILabel = {
        let label = UILabel()
        label.text = "Discount\n(baht)"
        label.backgroundColor = UIColor.BlueLight
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let viewTotalPrice: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlueLight
        view.layer.cornerRadius = 5
        return view
    }()
    
    let Pricetitle: UILabel = {
        let label = UILabel()
        label.text = "Total :"
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let totalPricetitle: UILabel = {
        let label = UILabel()
        label.text = "Total Price :"
        label.textColor = .white
        label.font = UIFont.MitrSemiBold(size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let VATPricetitle: UILabel = {
        let label = UILabel()
        label.text = "VAT 7% :"
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let DiscountPricetitle: UILabel = {
        let label = UILabel()
        label.text = "Discount :"
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let Price: UILabel = {
        let label = UILabel()
        label.text = "1,342,593"
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()
    
    let VATPrice: UILabel = {
        let label = UILabel()
        label.text = "93,981.51"
        label.textColor = .white
        label.font = UIFont.MitrRegular(size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()
    
    let DiscountPriceField: UITextField = {
        let textField = UITextField()
        textField.textColor = .BlackAlpha(alpha: 0.8)
        textField.font = UIFont.MitrRegular(size: 17)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        textField.text = "0.0"
        textField.tag = 1
        return textField
    }()
    
    let totalPrice: UILabel = {
        let label = UILabel()
        label.text = "1,436,574"
        label.textColor = .white
        label.font = UIFont.MitrSemiBold(size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()
    
    let productRemarktitle: UILabel = {
         let label = UILabel()
         label.text = "Remark"
         label.backgroundColor = .white
         label.textColor = .BlackAlpha(alpha: 0.6)
         label.font = UIFont.MitrLight(size: 16)
         label.sizeToFit()
         return label
     }()
    
    let productRemarkField: UITextView = {
        let textView = UITextView()
        textView.textColor = .BlackAlpha(alpha: 0.6)
        textView.font = UIFont.MitrLight(size: 16)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.layer.borderColor = UIColor.BlueLight.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.text = ""
        textView.tag = 1
        return textView
    }()
    //Element viewApproved--------------------------------------------------------------------------------------------------------------
    
    let ApprovedBytitle: UILabel = {
        let label = UILabel()
        label.text = "Approved By"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    let CreatedBytitle: UILabel = {
        let label = UILabel()
        label.text = "Created By"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.textAlignment = .center

        label.sizeToFit()
        return label
    }()
    
    let ApprovedBy: UILabel = {
        let label = UILabel()
        label.text = "( สุรกานต์ กาสุรงค์ )"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    let CreatedBy: UILabel = {
        let label = UILabel()
        label.text = "( สุรกานต์ กาสุรงค์ )"
        label.backgroundColor = .white
        label.textColor = .BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrLight(size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    let signatureCreatedImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "autographTest")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let signatureApprovedImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "autographTest")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none

        setViewCompany()
        
        setviewCustomerDetail()
        
        setViewCustomer()
        
        setViewSale()

        setViewProduct()

        setViewApproved()
        
        setupTableViewMain()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //set Layout setupTableViewMain---------------------------------------------------------------------------------------

    func setupTableViewMain(){
        let width = SetupQuotationViewController().view.frame.width
        
        contentView.addSubview(sideButton)
        contentView.addSubview(CreateQoutationButton)
        contentView.addSubview(viewCompany)
        contentView.addSubview(viewSale)
        contentView.addSubview(viewCustomerDetail)
        contentView.addSubview(viewCustomer)
        contentView.addSubview(viewProduct)
        contentView.addSubview(viewApproved)
        
        sideButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: width - 40, bottom: 10, right: 10)
        CreateQoutationButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 120, bottom: 10, right: width - 50 - 120)

    }
    
    //set Layout ViewCompany----------------------------------------------------------------------------------------------
    func setViewCompany(){
        
        viewCompany.addSubview(imageLogo)
        viewCompany.addSubview(companyNametile)
        viewCompany.addSubview(companyAddresstitle)
        viewCompany.addSubview(companyEmailandWebtitle)
        viewCompany.addSubview(companyPhoneandFaxtitle)
        
        imageLogo.anchor(viewCompany.topAnchor, left: viewCompany.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 80)
        
        companyNametile.anchor(viewCompany.topAnchor, left: imageLogo.rightAnchor, bottom: nil, right: viewCompany.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 16)
        
        companyAddresstitle.anchor(companyNametile.bottomAnchor, left: companyNametile.leftAnchor, bottom: nil, right: companyNametile.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        companyEmailandWebtitle.anchor(companyAddresstitle.bottomAnchor, left: companyNametile.leftAnchor, bottom: nil, right: companyNametile.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //viewCompany bottomAnchor
        companyPhoneandFaxtitle.anchor(companyEmailandWebtitle.bottomAnchor, left: companyNametile.leftAnchor, bottom: viewCompany.bottomAnchor, right: companyNametile.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        
    }
    
    //set Layout ViewCustomerDetail---------------------------------------------------------------------------------------------
    func setviewCustomerDetail(){
        viewCustomerDetail.addSubview(buttonSelectCustomer)
        
        buttonSelectCustomer.anchor(viewCustomerDetail.topAnchor, left: viewCustomerDetail.leftAnchor, bottom: viewCustomerDetail.bottomAnchor, right: viewCustomerDetail.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        let width = SetupQuotationViewController().view.frame.width        
        buttonSelectCustomer.imageEdgeInsets = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: width - 60 - 40)

    }
    
    
    //set Layout ViewCustomer---------------------------------------------------------------------------------------------
    func setViewCustomer(){
        
        viewCustomer.addSubview(CustomerCompanyNametextField)
        viewCustomer.addSubview(CustomerCompanyNametitle)
        viewCustomer.addSubview(CustomerCompanyAddresstextField)
        viewCustomer.addSubview(CustomerCompanyAddresstitle)
        viewCustomer.addSubview(viewCustomerContact)
        viewCustomer.addSubview(CustomerContacttitle)
        viewCustomer.addSubview(buttonResetCustomer)
        
        viewCustomerContact.addSubview(CustomerContactNameField)
        viewCustomerContact.addSubview(CustomerContactNametitle)
        viewCustomerContact.addSubview(CustomerContactPhoneNumberField)
        viewCustomerContact.addSubview(CustomerContactPhoneNumbertitle)
        viewCustomerContact.addSubview(CustomerContactEmailField)
        viewCustomerContact.addSubview(CustomerContactEmailtitle)
        viewCustomerContact.addSubview(CustomerContactLineField)
        viewCustomerContact.addSubview(CustomerContactLinetitle)
        viewCustomerContact.addSubview(CustomerContactRemarkField)
        viewCustomerContact.addSubview(CustomerContactRemarktitle)
        
        CustomerCompanyNametextField.anchor(viewCustomer.topAnchor, left: viewCustomer.leftAnchor, bottom: nil, right: viewCustomer.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        
        CustomerCompanyNametitle.anchor(CustomerCompanyNametextField.topAnchor, left: CustomerCompanyNametextField.leftAnchor, bottom: nil, right: nil, topConstant: -8, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
        CustomerCompanyAddresstextField.anchor(CustomerCompanyNametextField.bottomAnchor, left: viewCustomer.leftAnchor, bottom: nil, right: viewCustomer.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 80)
        
        CustomerCompanyAddresstitle.anchor(CustomerCompanyAddresstextField.topAnchor, left: CustomerCompanyAddresstextField.leftAnchor, bottom: nil, right: nil, topConstant: -8, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
        viewCustomerContact.anchor(CustomerCompanyAddresstextField.bottomAnchor, left: viewCustomer.leftAnchor, bottom: nil, right: viewCustomer.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        buttonResetCustomer.anchor(viewCustomerContact.bottomAnchor, left: viewCustomer.leftAnchor, bottom: viewCustomer.bottomAnchor, right: viewCustomer.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 50)//viewCustomer bottomAnchor

        
        CustomerContacttitle.anchor(viewCustomerContact.topAnchor, left: viewCustomerContact.leftAnchor, bottom: nil, right: nil, topConstant: -8, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
        CustomerContactNameField.anchor(viewCustomerContact.topAnchor, left: viewCustomerContact.leftAnchor, bottom: nil, right: viewCustomerContact.rightAnchor, topConstant: 25, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        
        CustomerContactNametitle.anchor(CustomerContactNameField.topAnchor, left: CustomerContactNameField.leftAnchor, bottom: nil, right: nil, topConstant: -7, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 16)
        
        CustomerContactPhoneNumberField.anchor(CustomerContactNameField.bottomAnchor, left: viewCustomerContact.leftAnchor, bottom: nil, right: viewCustomerContact.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        
        CustomerContactPhoneNumbertitle.anchor(CustomerContactPhoneNumberField.topAnchor, left: CustomerContactPhoneNumberField.leftAnchor, bottom: nil, right: nil, topConstant: -7, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 16)
        
        CustomerContactEmailField.anchor(CustomerContactPhoneNumberField.bottomAnchor, left: viewCustomerContact.leftAnchor, bottom: nil, right: viewCustomerContact.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        
        CustomerContactEmailtitle.anchor(CustomerContactEmailField.topAnchor, left: CustomerContactEmailField.leftAnchor, bottom: nil, right: nil, topConstant: -7, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 16)
        
        CustomerContactLineField.anchor(CustomerContactEmailField.bottomAnchor, left: viewCustomerContact.leftAnchor, bottom: nil, right: viewCustomerContact.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        
        CustomerContactLinetitle.anchor(CustomerContactLineField.topAnchor, left: CustomerContactLineField.leftAnchor, bottom: nil, right: nil, topConstant: -7, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 16)
        
        //viewCustomerContact bottomAnchor
        CustomerContactRemarkField.anchor(CustomerContactLineField.bottomAnchor, left: viewCustomerContact.leftAnchor, bottom: viewCustomerContact.bottomAnchor, right: viewCustomerContact.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 80)
        
        CustomerContactRemarktitle.anchor(CustomerContactRemarkField.topAnchor, left: CustomerContactRemarkField.leftAnchor, bottom: nil, right: nil, topConstant: -7, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 16)
        
        let width = SetupQuotationViewController().view.frame.width
        buttonResetCustomer.imageEdgeInsets = UIEdgeInsets(top: 10, left: 115, bottom: 10, right: width - 60 - 115)
    }
    
    //set Layout setViewSale----------------------------------------------------------------------------------------------
    func setViewSale(){
        
        viewSale.addSubview(saleNametitle)
        viewSale.addSubview(salePhoneNumberitle)
        viewSale.addSubview(saleEmailtitle)
        viewSale.addSubview(saleRemarkField)
        viewSale.addSubview(saleRemarktitle)

        saleNametitle.anchor(viewSale.topAnchor, left: viewSale.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
        salePhoneNumberitle.anchor(saleNametitle.bottomAnchor, left: viewSale.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
                
        saleEmailtitle.anchor(salePhoneNumberitle.bottomAnchor, left: viewSale.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
        //setViewSale bottomAnchor
        saleRemarkField.anchor(saleEmailtitle.bottomAnchor, left: viewSale.leftAnchor, bottom: viewSale.bottomAnchor, right: viewSale.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 80)
        
        saleRemarktitle.anchor(saleRemarkField.topAnchor, left: saleRemarkField.leftAnchor, bottom: nil, right: nil, topConstant: -7, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 16)

    }
    //set Layout ViewProduct---------------------------------------------------------------------------------------------
    func setViewProduct() {
        
        // ConfigRegister Tableview cell,header,footer
        let table =  UITableView(frame: .zero, style: .plain)
        tableViewProduct = table
        tableViewProduct!.delegate = self
        tableViewProduct!.dataSource = self
        tableViewProduct!.tableFooterView = UIView()
        tableViewProduct!.backgroundColor = UIColor.white
        tableViewProduct!.separatorStyle = .none
        tableViewProduct!.rowHeight = UITableView.automaticDimension
        tableViewProduct!.register(SetupQuotationProductViewCell.self, forCellReuseIdentifier: CellID)
        tableViewProduct?.isScrollEnabled = false
        
        
        viewProduct.addSubview(Numbertitle)
        viewProduct.addSubview(productNametitle)
        viewProduct.addSubview(Discriptiontitle)
        viewProduct.addSubview(quantitytitle)
        viewProduct.addSubview(unitPricetitle)
        viewProduct.addSubview(Discounttitle)
        viewProduct.addSubview(tableViewProduct!)
        viewProduct.addSubview(viewTotalPrice)
        viewProduct.addSubview(VATPricetitle)
        viewProduct.addSubview(productRemarkField)
        viewProduct.addSubview(productRemarktitle)
        
        viewTotalPrice.addSubview(Pricetitle)
        viewTotalPrice.addSubview(VATPricetitle)
        viewTotalPrice.addSubview(Price)
        viewTotalPrice.addSubview(VATPrice)
        viewTotalPrice.addSubview(DiscountPricetitle)
        viewTotalPrice.addSubview(DiscountPriceField)
        viewTotalPrice.addSubview(totalPricetitle)
        viewTotalPrice.addSubview(totalPrice)
        
        DiscountPriceField.delegate = self
        productRemarkField.delegate = self

        Numbertitle.anchor(viewProduct.topAnchor, left: viewProduct.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 40)
        
        productNametitle.anchor(Numbertitle.topAnchor, left: Numbertitle.rightAnchor, bottom: Numbertitle.bottomAnchor, right: nil, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 0)
        
        Discriptiontitle.anchor(Numbertitle.topAnchor, left: productNametitle.rightAnchor, bottom: Numbertitle.bottomAnchor, right: quantitytitle.leftAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 3, widthConstant: 0, heightConstant: 0)
        
        quantitytitle.anchor(Numbertitle.topAnchor, left: nil, bottom: Numbertitle.bottomAnchor, right: unitPricetitle.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 3, widthConstant: 60, heightConstant: 0)
        
        unitPricetitle.anchor(Numbertitle.topAnchor, left: nil, bottom: Numbertitle.bottomAnchor, right: Discounttitle.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 3, widthConstant: 60, heightConstant: 0)
        
        Discounttitle.anchor(Numbertitle.topAnchor, left: nil, bottom: Numbertitle.bottomAnchor, right: viewProduct.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 3, widthConstant: 50, heightConstant: 0)
        
        
        tableViewProduct!.anchor(Numbertitle.bottomAnchor, left: viewProduct.leftAnchor, bottom: nil, right: viewProduct.rightAnchor, topConstant: 1.5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        viewTotalPrice.anchor(tableViewProduct?.bottomAnchor, left: Numbertitle.leftAnchor, bottom: nil, right: Discounttitle.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 150)
        
        //viewProduct bottomAnchor
        productRemarkField.anchor(viewTotalPrice.bottomAnchor, left: Numbertitle.leftAnchor, bottom: viewProduct.bottomAnchor, right: Discounttitle.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 100)
        
        productRemarktitle.anchor(productRemarkField.topAnchor, left: productRemarkField.leftAnchor, bottom: nil, right: nil, topConstant: -9, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
        //set Layout viewTotalPrice-----------------------------------------------------------------------------------------------------
        Pricetitle.anchor(viewTotalPrice.topAnchor, left: viewTotalPrice.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        
        Price.anchor(Pricetitle.topAnchor, left: Pricetitle.rightAnchor, bottom: nil, right: viewTotalPrice.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        VATPricetitle.anchor(Pricetitle.bottomAnchor, left: viewTotalPrice.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        
        VATPrice.anchor(VATPricetitle.topAnchor, left: VATPricetitle.rightAnchor, bottom: nil, right: viewTotalPrice.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        DiscountPricetitle.anchor(VATPricetitle.bottomAnchor, left: viewTotalPrice.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        
        DiscountPriceField.anchor(DiscountPricetitle.topAnchor, left: nil, bottom: nil, right: viewTotalPrice.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 80, heightConstant: 0)
        
        totalPricetitle.anchor(DiscountPricetitle.bottomAnchor, left: viewTotalPrice.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        
        totalPrice.anchor(totalPricetitle.topAnchor, left: totalPricetitle.rightAnchor, bottom: nil, right: viewTotalPrice.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)

        
    }
    
    func setViewApproved(){
        
        viewApproved.addSubview(CreatedBytitle)
        viewApproved.addSubview(ApprovedBytitle)
        viewApproved.addSubview(CreatedBy)
        viewApproved.addSubview(ApprovedBy)
        viewApproved.addSubview(signatureCreatedImage)
        viewApproved.addSubview(signatureApprovedImage)
        
        let viewWidth = (UIScreen.main.bounds.width - 10) / 2
        CreatedBytitle.anchor(viewApproved.topAnchor, left: viewApproved.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: viewWidth, heightConstant: 18)
        
        ApprovedBytitle.anchor(viewApproved.topAnchor, left: CreatedBytitle.rightAnchor, bottom: nil, right: viewApproved.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
        signatureCreatedImage.anchor(CreatedBytitle.bottomAnchor, left: viewApproved.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: viewWidth, heightConstant: 50)
        
        signatureApprovedImage.anchor(signatureCreatedImage.topAnchor, left: signatureCreatedImage.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: viewWidth, heightConstant: 50)
        
        CreatedBy.anchor(signatureCreatedImage.bottomAnchor, left: viewApproved.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: viewWidth, heightConstant: 18)
        
        //viewApproved bottomAnchor
        ApprovedBy.anchor(signatureCreatedImage.bottomAnchor, left: CreatedBy.rightAnchor, bottom: viewApproved.bottomAnchor, right: viewApproved.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
    }

    
}

extension SetupQuotationMainViewCell: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
                
        if textField.tag == 0{
            
            // find indexPath Element action DidChange for discountField
            let point : CGPoint = textField.convert(textField.bounds.origin, to: self.tableViewProduct)
            let indexPath = self.tableViewProduct!.indexPathForRow(at: point)
            
            //register cell textField discountField According indexPath
            let cell = tableViewProduct?.cellForRow(at: indexPath!) as! SetupQuotationProductViewCell
            
            
            let ProductUnitprice = SetupQuotationViewController.DataProductShopCart[indexPath!.row]["ProductUnitprice"] as! Double
            let ProductQuantity = SetupQuotationViewController.DataProductShopCart[indexPath!.row]["ProductQuantity"] as! Double
            let Discount = textField.text! as NSString
                 
            //Check discount don't over total unit price
            if Double(Discount.doubleValue) > (ProductUnitprice * ProductQuantity){
                cell.discountField.text = "0"
            }else{

                // calculate discount and show on tabelview
                let total = (ProductUnitprice * ProductQuantity) - Double(Discount.doubleValue)
                cell.priceTotal.text = String(total.roundToDecimal(2))
                
                //save data to array
                SetupQuotationViewController.ProductDiscount[indexPath!.row] = Double(Discount.doubleValue)
                SetupQuotationViewController.ProductUnitPriceTotal[indexPath!.row] = total
                
                // buttom price total all product
                let allProductPrice = SetupQuotationViewController.ProductUnitPriceTotal.reduce(0, +)
                let vat = TabBarUserController.DataSeller!.QS_vat / 100
                Price.text = String(format: "%.2f", allProductPrice)
                VATPrice.text = String(format: "%.2f", allProductPrice * vat)
                 
                let DiscountEtc = Double(DiscountPriceField.text!) ?? 0.0
                let priceTotal = String(format: "%.2f", (allProductPrice + (allProductPrice * vat)) - DiscountEtc)
                SetupQuotationViewController.productpriceTotal = allProductPrice + (allProductPrice * vat)

                totalPrice.text = priceTotal
                
                SetupQuotationViewController.ProductPrice = Price.text!
                SetupQuotationViewController.ProductVATPrice = VATPrice.text!
                SetupQuotationViewController.ProducttotalPrice = totalPrice.text!
            }
        }else if textField.tag == 1{
            
            let DiscountEtc = Double(DiscountPriceField.text!) ?? 0.0
            let priceTotal = String(format: "%.2f", SetupQuotationViewController.productpriceTotal - DiscountEtc)
            totalPrice.text = priceTotal
            
            SetupQuotationViewController.ProducttotalPrice = totalPrice.text!
            SetupQuotationViewController.ProductDiscountEtc = textField.text!
        }

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0{
            // find indexPath Element action DidChange for discountField
            let point : CGPoint = textField.convert(textField.bounds.origin, to: self.tableViewProduct)
            let indexPath = self.tableViewProduct!.indexPathForRow(at: point)
            
            //register cell textField discountField According indexPath
            let cell = tableViewProduct?.cellForRow(at: indexPath!) as! SetupQuotationProductViewCell
            
            cell.discountField.text = ""
        }else{
            DiscountPriceField.text = ""
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text == "" ||  Double((textField.text! as NSString).doubleValue) == 0 else {return}
        
        if textField.tag == 0{
            // find indexPath Element action DidChange for discountField
            let point : CGPoint = textField.convert(textField.bounds.origin, to: self.tableViewProduct)
            let indexPath = self.tableViewProduct!.indexPathForRow(at: point)
            
            //register cell textField discountField According indexPath
            let cell = tableViewProduct?.cellForRow(at: indexPath!) as! SetupQuotationProductViewCell
            
            cell.discountField.text = "0.0"
        }else{
            DiscountPriceField.text = "0.0"
        }
    }
    
}

extension SetupQuotationMainViewCell: UITextViewDelegate{
   
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.tag == 0{// text view remark of product
            // find indexPath Element action DidChange for remarkField
            let point : CGPoint = textView.convert(textView.bounds.origin, to: self.tableViewProduct)
            let indexPath = self.tableViewProduct!.indexPathForRow(at: point)
            
            //save data to array
            SetupQuotationViewController.ProductRemark[indexPath!.row] = textView.text
        }else{// text view remark of product all
            SetupQuotationViewController.ProductRemarkAll = textView.text
        }
              
    }
    
}

extension SetupQuotationMainViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SetupQuotationViewController.DataProductShopCart.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! SetupQuotationProductViewCell
        
        let productName = SetupQuotationViewController.DataProductShopCart[indexPath.row]["ProductName"] as! String
        let discription = SetupQuotationViewController.DataProductShopCart[indexPath.row]["ProductDiscription"] as! String
        let ProductUnitprice = SetupQuotationViewController.DataProductShopCart[indexPath.row]["ProductUnitprice"] as! Double
        let ProductQuantity = SetupQuotationViewController.DataProductShopCart[indexPath.row]["ProductQuantity"] as! Double
        
        let ProductDiscount = SetupQuotationViewController.ProductDiscount[indexPath.row]
        
        cell.number.text = String(indexPath.row + 1)
        cell.productName.text = productName
        cell.discription.text = discription
        cell.area.text = String(ProductQuantity)
        cell.unitPricet.text = String(ProductUnitprice)
        
        cell.priceTotal.text = String(format: "%.1f", (ProductQuantity * ProductUnitprice) - ProductDiscount)
        
        cell.discountField.text = String(SetupQuotationViewController.ProductDiscount[indexPath.row])
        
        cell.discountField.delegate = self
        cell.remarkField.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 188
    }
    
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
