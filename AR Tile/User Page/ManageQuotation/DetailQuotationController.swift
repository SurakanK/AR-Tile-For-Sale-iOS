//
//  DetailQuotationController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 27/4/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import TTSegmentedControl
import QuartzCore
import Alamofire

private var IdCellShow = "CollectionCell_ProList_Show"

class DetailQuotationController : UIViewController, UIScrollViewDelegate{
    
    // MARK: Parameter
    // Ratio of Page
    lazy var ratio : CGFloat = view.frame.width / 375
    
    // Key of Json Header
    var Key_Quo = Head_QuotationList()
    
    // DataPass from Manage Quotaion page
    var Data_Pass = [String : Any]()
    // Data Product Original
    var DataPro_Ori = [[String : Any]]()
    // Data Product Edit
    var DataPro_Edit = [[String : Any]]()
    
    // Url Request Detail Quotation
    var Url_Request : String = DataSource.Url_GetDetailQuotation_Admin()
    // Url Edit Quotation
    var Url_EditQuo  : String = DataSource.Url_EditQuotation_Admin()
    
    // Total Sales of Product
    var TotalSales_Product : [Double] = [] {
        didSet {
            
            // cal Sum total Sales Quotation
            self.Sum_TotalSales()
            
        }
    }
    
    
    // State of Page
    var State_EditQuo : Bool = false // State Edit Quotation
    // State Download Detail Pro
    var State_Download : Bool = false
    // Check Sales Use Edit
    var Sale_Use : Bool = false
    
    // Id of Delete Product
    var Id_ProdcutDelete : [Int] = []
    // Index of Delete
    var Index_Delete : [Int] = []
    
    // Test Data
    var Data_test : [[String]] = [["กระเบื้อง A", "0", "0", "0", "0"], ["กระเบื้อง B", "0", "0", "0", "0"], ["กระเบื้อง C", "0", "0", "0", "0"]]
    
    
    // MARK: Element Page
    // Scroll View
    var Scroll_Page : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    
    // Segment Button Status Quotation ----
    // View Segment
    var View_Segment : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // Segment Button
    var Seg_StatusQuo : UISegmentedControl = {
        let button = UISegmentedControl(items: ["Complete", "InProcess", "Reject"])
        
        button.selectedSegmentTintColor = .systemGreen
        button.tintColor = .white
        
        button.backgroundColor = .white
        
        button.selectedSegmentIndex = 0
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.3

        button.addTarget(self, action: #selector(Seg_Change(_:)), for: .valueChanged)
        
        return button
    }()
    // ---------------------------------
    
    // Detail Quotation -----------
    // View Detail Quotation
    var View_Detail : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        
        return view
    }()
    // Label Num of Overall Sales Quotation
    var Lb_NumSales : UILabel = {
        let label = UILabel()
        label.text = "#$$$$$$$"
        label.font = UIFont.MitrBold(size: 30)
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    // Customer Name ---
    // Icon
    var Icon_Customer : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "company").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label
    var Lb_Customer : UILabel = {
        let label = UILabel()
        label.text = "The Three Touch Asia "
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // -----------------
    // Address Customer ---
    // Icon
    var Icon_Address : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "pin").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label
    var Lb_Address : UILabel = {
        let label = UILabel()
        label.text = "56/23 SeriThai Rd., Ramintra, Kannayao, 10230"
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.numberOfLines = 3
        return label
    }()
    // -----------------
    // Contract Name ---
    // Icon
    var Icon_NameContract : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "contact").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label
    var Lb_NameContract : UILabel = {
        let label = UILabel()
        label.text = "นาย ชะมด ชดใช้"
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // -----------------
    // Contract Phone Number ---
    // Icon
    var Icon_PhoneContract : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "phone2").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label
    var Lb_PhoneContract : UILabel = {
        let label = UILabel()
        label.text = "082-122-4233"
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // -----------------
    // Date Quotation ---
    // Icon
    var Icon_Date : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "calendar2").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label
    var Lb_Date : UILabel = {
        let label = UILabel()
        label.text = "01/02/2020"
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // -----------------
    
    // Create Quotation By ---
    // Icon
    var Icon_By : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "salesman2").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label
    var Lb_By : UILabel = {
        let label = UILabel()
        label.text = "นาย ประยุทธ์ ประหยัด"
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // -----------------
    // ---------------------------------
    
    // Collection Product List -------
    // View Collection Product
    var View_CollectionPro : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        
        return view
    }()
    
    // Height Collection
    
    // Collection Product and Label ---
    // Label Product List Header
    lazy var Lb_HProList : UILabel = {
        let label = UILabel()
        label.text = "Product List"
        label.font = UIFont.MitrMedium(size: 20 * self.ratio)
        label.textColor = .BlueDeep
        return label
    }()
    // Collection Productlist
    lazy var CollectionProList : UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.delegate = self
        collection.dataSource = self
        
        collection.alwaysBounceVertical = true
        collection.backgroundColor = .clear
        
        collection.register(CollectionCell_ProList_Show.self, forCellWithReuseIdentifier: IdCellShow)
        
        return collection
    }()
    
    // Height collection per cell
    lazy var Height_CollectionPercell = (150 * ratio) + (15 * ratio) + (7.5 * ratio)  // Height cell, margin of All cell (top,bottom), space between cell / 2
    // Constraint Height Collection Product List
    lazy var Height_ConstraintColleciton = self.CollectionProList.heightAnchor.constraint(equalToConstant: self.Height_CollectionPercell)
    // -----------------
    
    // Label SubTotal Vat Total ---
    lazy var Lb_SubTotal : UILabel = {
        let label = UILabel()
        label.text = " Sub Total : 900,000 ฿ "
        label.font = UIFont.MitrRegular(size: 18 * self.ratio)
        label.textColor = .white
        
        label.layer.backgroundColor = UIColor.BlueDeep.cgColor
        label.layer.cornerRadius = 5
        
        label.textAlignment = .left
        
        return label
    }()
    // Label Vat
    lazy var Lb_Vat : UILabel = {
        let label = UILabel()
        label.text = " Vat : 7% "
        label.font = UIFont.MitrRegular(size: 18 * self.ratio)
        label.textColor = .white
        
        label.layer.backgroundColor = UIColor.systemRed.cgColor
        label.layer.cornerRadius = 5
        
        label.textAlignment = .left
        
        return label
    }()
    // Label Discount All Quotation (Not Discount Product)
    lazy var Lb_Discount : UILabel = {
        let label = UILabel()
        label.text = " Discount : 0 ฿ "
        label.font = UIFont.MitrRegular(size: 18 * self.ratio)
        label.textColor = .white
               
        label.layer.backgroundColor = UIColor.systemGreen.cgColor
        label.layer.cornerRadius = 5
               
        label.textAlignment = .left
               
        return label
    }()
    // Section View Discount All of Quotation
    // View Discount
    var View_Discount : UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 5
        return view
    }()
    // Label Header Discount
    lazy var Lb_HDiscount : UILabel = {
        let label = UILabel()
        label.text = " Discount : "
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.backgroundColor = .clear
        label.textColor = .white
        return label
    }()
    // TxtField Discount
    lazy var Txt_Discount : UITextField = {
        let txt = UITextField()
        txt.font = UIFont.MitrRegular(size: 18 * ratio)
        txt.textColor = .white
        txt.isEnabled = false
        txt.backgroundColor = .clear
        txt.textAlignment = .right
        txt.keyboardType = .decimalPad
        txt.layer.cornerRadius = 5 * ratio
        
        // Config Delegate
        txt.delegate = self
        
        return txt
    }()
    // Label Unit Discount
    lazy var Lb_UnitDiscount : UILabel = {
        let label = UILabel()
        label.text = " ฿ "
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.backgroundColor = .clear
        label.textColor = .white
        return label
    }()
    // --------------
    // Label Total
    lazy var Lb_Total : UILabel = {
        let label = UILabel()
        label.text = " Total : 1,000,000 ฿ "
        label.font = UIFont.MitrRegular(size: 18 * self.ratio)
        label.textColor = .white
        
        label.layer.backgroundColor = UIColor.systemGreen.cgColor
        label.layer.cornerRadius = 5
        
        label.textAlignment = .left
        
        return label
    }()
    // -----------------
    // ---------------------------------
    
    // Reson Reject And Note Quotation -------
    // View Note and Reson Reject
    var View_NoteReason : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        
        return view
    }()
    
    // Label Header Note Quotation ---
    lazy var Lb_HNote : UILabel = {
        let label = UILabel()
        label.text = "Note"
        label.font = UIFont.MitrRegular(size: 18 * self.ratio)
        label.textColor = .BlueDeep
        
        label.backgroundColor = .white
        return label
    }()
    // Text Editor Note Quotation
    lazy var Txt_Note : UITextView = {
        let txt = UITextView()
        txt.delegate = self
        
        // Set Attribute
        txt.isScrollEnabled = false
        
        txt.font = UIFont.MitrLight(size: 15 * self.ratio)
        txt.textColor = UIColor.BlackAlpha(alpha: 0.9)
        
        txt.isEditable = false
        
        txt.layer.cornerRadius = 5
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.BlueDeep.cgColor
        
        return txt
    }()
    // -----------------
    // Label Header Reason Reject Quotation ---
    lazy var Lb_HReason : UILabel = {
        let label = UILabel()
        label.text = "Reject Reason"
        label.font = UIFont.MitrRegular(size: 18 * self.ratio)
        label.textColor = .BlueDeep
        
        label.backgroundColor = .white
        return label
    }()
    // Text Editor Reason Reject Quotation
    lazy var Txt_Reason : UITextView = {
        let txt = UITextView()
        txt.delegate = self
        
        // Set Attribute
        txt.isScrollEnabled = false
        
        txt.font = UIFont.MitrLight(size: 15 * self.ratio)
        txt.textColor = UIColor.BlackAlpha(alpha: 0.9)
        
        txt.isEditable = false
        
        txt.layer.cornerRadius = 5
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.BlueDeep.cgColor
        
        return txt
    }()
    // -----------------
    
    // ---------------------------------
    
    
    // MARK: Func Layout Page
    func Layout_Page(){
        
        // Set BG view
        view.backgroundColor = .systemGray5
        
        // Set Navigation bar --------
        navigationItem.title = "Detail Quotation"
        
        // Set right Button Navigation Bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(Event_EditQuotation))
        // ---------------------------
        
        // Scroll View Page
        view.addSubview(Scroll_Page)
        Scroll_Page.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Stack View of Element Page
        let StackView = UIStackView(arrangedSubviews: [View_Segment, View_Detail, View_CollectionPro, View_NoteReason])
        Scroll_Page.addSubview(StackView)
        
        StackView.backgroundColor = .clear
        StackView.distribution = .fill
        StackView.axis = .vertical
        StackView.spacing = 10 * ratio
    
        StackView.anchor(Scroll_Page.topAnchor, left: Scroll_Page.leftAnchor, bottom: Scroll_Page.bottomAnchor, right: view.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Segment Status Quotation ----------------
        View_Segment.addSubview(Seg_StatusQuo)
        Seg_StatusQuo.anchor(View_Segment.topAnchor, left: View_Segment.leftAnchor, bottom: View_Segment.bottomAnchor, right: View_Segment.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
        
        Seg_StatusQuo.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.MitrRegular(size: 15 * ratio), NSAttributedString.Key.foregroundColor : UIColor.BlackAlpha(alpha: 0.9)], for: .normal)
        Seg_StatusQuo.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.MitrMedium(size: 15 * ratio), NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        // -----------------------------------------
        
        // Section Detail Quotation ----------------
        // Label Overall Sales
        View_Detail.addSubview(Lb_NumSales)
        Lb_NumSales.anchor(View_Detail.topAnchor, left: View_Detail.leftAnchor, bottom: nil, right: View_Detail.rightAnchor, topConstant: 10 * ratio, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 15 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_NumSales.font = UIFont.MitrBold(size: 30 * ratio)
        
        // Icon Customer
        View_Detail.addSubview(Icon_Customer)
        Icon_Customer.anchor(Lb_NumSales.bottomAnchor, left: Lb_NumSales.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 18 * ratio, heightConstant: 18 * ratio)
        // Label Customer
        View_Detail.addSubview(Lb_Customer)
        Lb_Customer.anchorCenter(nil, AxisY: Icon_Customer.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Customer.anchor(nil, left: Icon_Customer.rightAnchor, bottom: nil, right: Lb_NumSales.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Lb_Customer.font = UIFont.MitrLight(size: 13 * ratio)
        
        // Icon Address
        View_Detail.addSubview(Icon_Address)
        Icon_Address.anchor(Icon_Customer.bottomAnchor, left: Icon_Customer.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 18 * ratio, heightConstant: 18 * ratio)
        // Label Address
        View_Detail.addSubview(Lb_Address)
        //Lb_Address.anchorCenter(nil, AxisY: Icon_Address.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Address.anchor(Icon_Address.topAnchor, left: Icon_Address.rightAnchor, bottom: nil, right: Lb_Customer.rightAnchor, topConstant: -2 * ratio , leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Lb_Address.font = UIFont.MitrLight(size: 13 * ratio)
        
        // Icon Contract Name
        View_Detail.addSubview(Icon_NameContract)
        Icon_NameContract.anchor(Lb_Address.bottomAnchor, left: Icon_Address.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 18 * ratio, heightConstant: 12 * ratio)
        // Label Name Contract
        View_Detail.addSubview(Lb_NameContract)
        Lb_NameContract.anchorCenter(nil, AxisY: Icon_NameContract.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_NameContract.anchor(nil, left: Icon_NameContract.rightAnchor, bottom: nil, right: View_Detail.centerXAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        Lb_NameContract.font = UIFont.MitrLight(size: 13 * ratio)
        
        // Icon Phone Contract
        View_Detail.addSubview(Icon_PhoneContract)
        Icon_PhoneContract.anchor(Icon_NameContract.topAnchor, left: View_Detail.centerXAnchor, bottom: Icon_NameContract.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 18 * ratio, heightConstant: 18 * ratio)
        // Label Phone Contract
        View_Detail.addSubview(Lb_PhoneContract)
        Lb_PhoneContract.anchorCenter(nil, AxisY: Icon_PhoneContract.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_PhoneContract.anchor(nil, left: Icon_PhoneContract.rightAnchor, bottom: nil, right: Lb_Address.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Lb_PhoneContract.font = UIFont.MitrLight(size: 13 * ratio)
        
        // Icon Date
        View_Detail.addSubview(Icon_Date)
        Icon_Date.anchor(Icon_NameContract.bottomAnchor, left: Icon_NameContract.leftAnchor, bottom: View_Detail.bottomAnchor, right: nil, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 20 * ratio, rightConstant: 0, widthConstant: 18 * ratio, heightConstant: 18 * ratio)
        // Label Date
        View_Detail.addSubview(Lb_Date)
        Lb_Date.anchorCenter(nil, AxisY: Icon_Date.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Date.anchor(nil, left: Icon_Date.rightAnchor, bottom: nil, right: Lb_NameContract.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Lb_Date.font = UIFont.MitrLight(size: 13 * ratio)
        
        // Icon By
        View_Detail.addSubview(Icon_By)
        Icon_By.anchor(Icon_Date.topAnchor, left: Icon_PhoneContract.leftAnchor, bottom: Lb_Date.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 18 * ratio, heightConstant: 18 * ratio)
        // Label By
        View_Detail.addSubview(Lb_By)
        Lb_By.anchorCenter(nil, AxisY: Icon_By.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_By.anchor(nil, left: Lb_PhoneContract.leftAnchor, bottom: nil, right: Lb_PhoneContract.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Lb_By.font = UIFont.MitrLight(size: 13 * ratio)
        // -----------------------------------------
        
        // Collection Product List -----------
        // Label Header Product List
        View_CollectionPro.addSubview(Lb_HProList)
        Lb_HProList.anchor(View_CollectionPro.topAnchor, left: View_CollectionPro.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // CollectionView Product List
        View_CollectionPro.addSubview(CollectionProList)
        CollectionProList.anchor(Lb_HProList.bottomAnchor, left: View_CollectionPro.leftAnchor, bottom: nil, right: View_CollectionPro.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Height_ConstraintColleciton.constant = (Height_CollectionPercell * CGFloat(Data_test.count))
        Height_ConstraintColleciton.isActive = true
        
        // label Subtotal
        View_CollectionPro.addSubview(Lb_SubTotal)
        Lb_SubTotal.anchor(CollectionProList.bottomAnchor, left: nil, bottom: nil, right: View_CollectionPro.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 15 * ratio, widthConstant: 0, heightConstant: 0)
        // label Vat
        View_CollectionPro.addSubview(Lb_Vat)
        Lb_Vat.anchor(Lb_SubTotal.bottomAnchor, left: nil, bottom: nil, right: Lb_SubTotal.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Section Discount All Quotation
        // View Discount
        View_CollectionPro.addSubview(View_Discount)
        View_Discount.anchor(Lb_Vat.bottomAnchor, left: nil, bottom: nil, right: Lb_Vat.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Label Unit Discount
        View_Discount.addSubview(Lb_UnitDiscount)
        Lb_UnitDiscount.anchor(View_Discount.topAnchor, left: nil, bottom: View_Discount.bottomAnchor, right: View_Discount.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Txt Field Discount
        View_Discount.addSubview(Txt_Discount)
        Txt_Discount.anchor(View_Discount.topAnchor, left: nil, bottom: View_Discount.bottomAnchor, right: Lb_UnitDiscount.leftAnchor, topConstant: 2 * ratio, leftConstant: 0, bottomConstant: 2 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Label Header Discount
        View_Discount.addSubview(Lb_HDiscount)
        Lb_HDiscount.anchor(View_Discount.topAnchor, left: View_Discount.leftAnchor, bottom: View_Discount.bottomAnchor, right: Txt_Discount.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // ------------------------------
        
        // label Total
        View_CollectionPro.addSubview(Lb_Total)
        Lb_Total.anchor(View_Discount.bottomAnchor, left: nil, bottom: View_CollectionPro.bottomAnchor, right: Lb_Vat.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 15 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // -----------------------------------------
        
        // Note And Reason Reject Reason -----------
        // Label Header Note Quotation
        View_NoteReason.insertSubview(Lb_HNote, at: 1)
        Lb_HNote.anchor(View_NoteReason.topAnchor, left: View_NoteReason.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 25 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // TextView Note Quotation
        View_NoteReason.insertSubview(Txt_Note, at: 0)
        Txt_Note.anchor(Lb_HNote.centerYAnchor, left: View_NoteReason.leftAnchor, bottom: nil, right: View_NoteReason.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 15 * ratio, widthConstant: 0, heightConstant: 30 * ratio)
        Txt_Note.textContainerInset = UIEdgeInsets(top: 15 * ratio, left: 10 * ratio, bottom: 15 * ratio, right: 10 * ratio)
        textViewDidChange(Txt_Note)
        
        // Label Header Reason Reject Quotation
        View_NoteReason.insertSubview(Lb_HReason, at: 1)
        Lb_HReason.anchor(Txt_Note.bottomAnchor, left: Lb_HNote.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // TextView Reject Reason
        View_NoteReason.insertSubview(Txt_Reason, at: 0)
        Txt_Reason.anchor(Lb_HReason.centerYAnchor, left: Txt_Note.leftAnchor, bottom: View_NoteReason.bottomAnchor, right: Txt_Note.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        Txt_Reason.textContainerInset = UIEdgeInsets(top: 15 * ratio, left: 10 * ratio, bottom: 15 * ratio, right: 10 * ratio)
        textViewDidChange(Txt_Reason)
        
        // -----------------------------------------
        
        
        
        
        
        // Config ContentSize of Scroll View
        Scroll_Page.contentSize = StackView.bounds.size
        
        
    }
    
    // MARK: Func Scroll View in Page
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Disable Horizontol Scroll
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    // MARK: Func Config Page
    func Config_Page(){
        
        // Config Scroll View Page
        Scroll_Page.delegate = self
        
        
        // if User is Sale Set Url
        if Sale_Use == true {
            
            Url_Request = DataSource.Url_GetDetailQuotation()
            Url_EditQuo = DataSource.Url_EditQuotation()
        }
        
        
        // Set initail Data -------------------
        // Set Status Quotation ---
        // Complete
        if (Data_Pass["QuotationCompleted"] as! Int) == 1 {
            Seg_StatusQuo.selectedSegmentIndex = 0
            Seg_StatusQuo.selectedSegmentTintColor = UIColor.systemGreen
            // Enable false Another Segment
            Seg_StatusQuo.setEnabled(false, forSegmentAt: 1)
            Seg_StatusQuo.setEnabled(false, forSegmentAt: 2)
            
        }
        // Reject
        else if (Data_Pass["QuotationCompleted"] as! Int) == 2 {
            Seg_StatusQuo.selectedSegmentIndex = 2
            Seg_StatusQuo.selectedSegmentTintColor = UIColor.systemRed
            // Enable false Another Segment
            Seg_StatusQuo.setEnabled(false, forSegmentAt: 0)
            Seg_StatusQuo.setEnabled(false, forSegmentAt: 1)
        }
        // In Process
        else {
            Seg_StatusQuo.selectedSegmentIndex = 1
            Seg_StatusQuo.selectedSegmentTintColor = UIColor.systemYellow
            // Enable false Another Segment
            Seg_StatusQuo.setEnabled(false, forSegmentAt: 0)
            Seg_StatusQuo.setEnabled(false, forSegmentAt: 2)
        }
        // -------------
        // Set Name Quotation
        Lb_NumSales.text = String(Data_Pass[Key_Quo.Quo_Name] as! String)
        // Set Name Customer
        Lb_Customer.text = String(Data_Pass[Key_Quo.Cus_Company] as! String)
        
        // Set Customer Address
        let CompanyAddress = String(Data_Pass[Key_Quo.Cus_Adress] as! String)
        var Address = ""
        let DataAddress = CompanyAddress.split(separator: "$")
        if DataAddress.count != 0{
              Address = String(DataAddress[0]) + " " +
                        String(DataAddress[1]) + " " +
                        String(DataAddress[2]) + " " +
                        String(DataAddress[3]) + " " +
                        String(DataAddress[4])
        }
        
        Lb_Address.text = Address
        // Set Contract Name Customer
        Lb_NameContract.text = String(Data_Pass[Key_Quo.Cus_ContactName] as! String)
        // Set Tele Contract
        Lb_PhoneContract.text = String(Data_Pass[Key_Quo.Cus_ContactTel] as! String)
        // Set Date Quotation
        Lb_Date.text = String(Data_Pass[Key_Quo.DateBegin] as! String)
        // Set By Sales
        Lb_By.text = String(Data_Pass[Key_Quo.Sale_Name] as! String)
        // Set Note Quotation
        Txt_Note.text = String(Data_Pass[Key_Quo.Quo_Note] as! String)
        textViewDidChange(Txt_Note)
        // Set Reason Reject
        Txt_Reason.text = String(Data_Pass[Key_Quo.Quo_ResonReject] as! String)
        textViewDidChange(Txt_Reason)
        
        // Cal Vat, SubTotal, TotalPrice
        if Data_Pass[Key_Quo.Quo_TotalPrice] as? Double != nil {
            
            let vat = Double(Data_Pass[Key_Quo.Vat] as! String) ?? 0
            let SubTotal = Data_Pass[Key_Quo.Quo_TotalPrice] as? Double ?? 0
            let Discount = Double(Data_Pass[Key_Quo.Discount] as? Double ?? 0)
            let TotalPrice = (SubTotal + (SubTotal * (vat / 100))) - Discount
            
            //Set Vat
            Lb_Vat.text = " Vat : \(String(Data_Pass[Key_Quo.Vat] as! String)) % "
            // Set Subtotal
            Lb_SubTotal.text = " Sub Total : \(String(Data_Pass[Key_Quo.Quo_TotalPrice] as? Double ?? 0).currencyFormatting()) ฿ "
            // Set Discount
            Txt_Discount.text =  String(Discount).currencyFormatting()
            // Set Total Price
            Lb_Total.text = " Total : \(String(TotalPrice).currencyFormatting()) ฿ "
        }
        else {
            //Set Vat
            Lb_Vat.text = " Vat : \(String(Data_Pass[Key_Quo.Vat] as! String)) % "
            // Set Subtotal
            Lb_SubTotal.text = " Sub Total : 0 ฿ "
            // Set Total Price
            Lb_Total.text = " Total : 0 ฿ "
        }
        
        // ----------------------------------
        
        // Request Detail Quotation
        CollectionProList.reloadData()
        Request_DetailQuotation(TokenId: LoginPageController.DataLogin?.Token_Id, Url: Url_Request, Id_Quo: String(Data_Pass[Key_Quo.id] as! Int))
        
        
        
        
    }
    
    // MARK: Life Cycle Func of Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element in Page
        Layout_Page()
        // Config Element in Page
        Config_Page()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    // MARK: Func Button in Page
    @objc func Event_EditQuotation(){
        
        // Hide Keyboard
        view.endEditing(true)
        
        // When Edit Quotation
        if State_EditQuo == false {
            
            // Enable Txt_Discount and Change Attribute
            Txt_Discount.isEnabled = true
            Txt_Discount.backgroundColor = .white
            Txt_Discount.textColor = .BlackAlpha(alpha: 0.9)
            
            // Enable Txt_Note and Txt_Reason
            Txt_Note.isEditable = true
            Txt_Reason.isEditable = true
            
            // Change Title Button right nav bar
            navigationItem.rightBarButtonItem?.title = "Done"
            
            // Change State Edit Quotation
            State_EditQuo = true
            
            // Permiss Edit Status Quotation
            for count in 0...2{
                self.Seg_StatusQuo.setEnabled(true, forSegmentAt: count)
            }

            
            // Reload Collection ProductList
            if self.DataPro_Edit.count == 0 {
                
                self.CollectionProList.reloadData()
                
            }else {
                for count in 0...(self.DataPro_Edit.count - 1) {
                    let indexPath = IndexPath(item: count, section: 0)
                    self.CollectionProList.reloadItems(at: [indexPath])
                }
            }
            
        }
        // Edit to Done Quotation
        else {
            
            // if Status Quotation == Reject Must Fill Reason Reject
            if Seg_StatusQuo.selectedSegmentIndex == 2 && Txt_Reason.text == "" {
                
                // Scroll View to Section txt Reason Reject
                let bottomOffset = CGPoint(x: 0, y: Scroll_Page.contentSize.height - Scroll_Page.bounds.size.height)
                Scroll_Page.setContentOffset(bottomOffset, animated: true)
                self.Scroll_Page.setContentOffset(bottomOffset, animated: true)
                
                // Alert Boarder Txt Reason Reject
                Txt_Reason.layer.borderColor = UIColor.systemRed.cgColor
                
                return
            }
            
            
            // Show Aleart Box For Decide
            let alert = UIAlertController(title: "Confirm Edit", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive,handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler:{ action in
                
                // Record Data to DataEdit
                if self.DataPro_Edit.count != 0 {
                    
                    for count in 0...(self.DataPro_Edit.count - 1) {
                        let indexPath = IndexPath(item: count, section: 0)
                        let cell = self.CollectionProList.cellForItem(at: indexPath) as! CollectionCell_ProList_Show
                        // Check Product Delete
                        if cell.State_Delete == false {
                            
                            let formatter = NumberFormatter()
                            formatter.locale = Locale.current
                            formatter.numberStyle = .decimal
                            
                            let Quantity = formatter.number(from: cell.Txt_Quan.text!)
                            self.DataPro_Edit[count]["QuoproQuantity"] = Double(Quantity!)
                            let Price = formatter.number(from: cell.Txt_Price.text!)
                            self.DataPro_Edit[count]["QuoproPrice"] = Double(Price!)
                            let Discount = formatter.number(from: cell.Txt_Discount.text!)
                            self.DataPro_Edit[count]["QuoproDiscount"] = Double(Discount!)
                        }
                        else {
                            self.Id_ProdcutDelete.append(self.DataPro_Edit[count]["idQuotationProduct"] as! Int)
                            self.Index_Delete.append(count)
                        }
                        
                    }
                    
                }
                
                
                // Update Quotation Edit to Database Server
                self.Update_DataEditServer(TokenId: LoginPageController.DataLogin?.Token_Id, Url: self.Url_EditQuo)
                
                
            }))
            // Set Attribute Alert
            alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
            alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    
    // MARK: Func Request and Manage Data from Database
    func Request_DetailQuotation(TokenId : String! ,Url : String!, Id_Quo : String!) {
        
        let Header : HTTPHeaders = [HTTPHeader.authorization(bearerToken: TokenId), HTTPHeader.contentType("application/json")]
        let parameter = ["QuotationID" : Id_Quo]
           
        AF.sessionConfiguration.timeoutIntervalForRequest = 1
        AF.request(Url, method : .post, parameters:  parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON { response in
               
            switch response.result {
            case .success(let value):
                print(value)
                if let json = value as? [String : Any] {
                    
                    let data = json["results"] as! [[String : Any]]
                    // Check Verify Request
                    guard data.count != 0 else {
                        self.Create_AlertMessage(Title: "No Product", Message: "Quotation has not Product")
                        return
                    }
                    // Record Data to Data Center Page
                    self.DataPro_Ori = data
                    self.DataPro_Edit = self.DataPro_Ori
                    
                    print(self.DataPro_Edit)
                    
                    // append Count of Array to TotalSales_Product
                    if self.DataPro_Edit.count != 0 {
                        for count in 0..<self.DataPro_Edit.count {
                            let Quantity = (self.DataPro_Edit[count]["QuoproQuantity"] as! Double)
                            let Price = (self.DataPro_Edit[count]["QuoproPrice"] as! Double)
                            let Discount = (self.DataPro_Edit[count]["QuoproDiscount"] as! Double)
                            let TotalProduct = (Quantity * Price) - Discount//((Quantity * Price) * (Discount / 100))
                            
                            self.TotalSales_Product.append(TotalProduct)
                        }
                    }
                    
                    // Set Height Colleciton Product
                    self.Height_ConstraintColleciton.constant = (self.Height_CollectionPercell * CGFloat(self.DataPro_Edit.count))
                    self.view.layoutIfNeeded()
                    
                    // Change State Download to Complete and reload Colleciton
                    self.State_Download = true
                    self.CollectionProList.reloadData()
   
                }
                   
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Quotation Detail is not success")
                break
            }
               
        }
           
    }
    
    // MARK : Update Data Edit Quotation to Database Server
    func Update_DataEditServer(TokenId : String! ,Url : String!){
        
        let Header : HTTPHeaders = [HTTPHeader.authorization(bearerToken: TokenId), HTTPHeader.contentType("application/json")]
        
        // Stack Num of Edit Quatation to Name Quotation ---
        var Name_Edit : String = (Data_Pass["QuotationRecName"] as! String)
        let ArrayName = Name_Edit.split(separator: " ")
        // Edit First Times
        if ArrayName.count == 1 {
            Name_Edit = Name_Edit + " (1)"
        }
        else {
            let Index = Name_Edit.index(before: Name_Edit.firstIndex(of: ")")!)
            let Num = Int(String(Name_Edit[Index]))! + 1
            
            Name_Edit = ArrayName[0] + " (\(Num))"
        }
        // -------------------------------------------------
        // Status Quotation
        var Status_Quo : String = "1"
        if Seg_StatusQuo.selectedSegmentIndex == 1 {
            Status_Quo = "0"
        }
        else if Seg_StatusQuo.selectedSegmentIndex == 2 {
            Status_Quo = "2"
        }
        
        //
        
        // Set Data Section Detail Quotation for Body
        let QuatationDetail = ["id" : String(Data_Pass["idQuotation"] as! Int), "RecordName" : Name_Edit, "Completed" : Status_Quo, "RejectedReason" : String(Txt_Reason.text), "Note" : String(Txt_Note.text), "discount" : String(Txt_Discount.text!)]
        // Set Data Section Product Edit
        var Product_Edit : [[String : Any]] = []
        if self.DataPro_Edit.count != 0 {
            
            print(self.DataPro_Edit)
            
            for count in 0...(self.DataPro_Edit.count - 1){
                
                var data : [String : Any] = [:]
                print(String(DataPro_Edit[count]["idQuotationProduct"] as! Int))
                data["id"] = String(DataPro_Edit[count]["idQuotationProduct"] as! Int)
                data["Price"] = String(DataPro_Edit[count]["QuoproPrice"] as! Double)
                data["Quantity"] = String(DataPro_Edit[count]["QuoproQuantity"] as! Double)
                data["Discount"] = String(DataPro_Edit[count]["QuoproDiscount"] as! Double)
                
                Product_Edit.append(data)
                
            }
            
        }

        
        
        
        let parameter = ["Quotation" : QuatationDetail,
                         "DeleteProduct" : Id_ProdcutDelete,
                         "Product" : Product_Edit ] as [String : Any]
        
        AF.sessionConfiguration.timeoutIntervalForRequest = 1
        AF.request(Url, method : .post, parameters:  parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { response in
            
            
            switch response.result {
            case .success(let value) :
                print(value)
                
                
                // Delete Product
                if self.Index_Delete.count != 0 {
                    for count in 0..<self.Index_Delete.count {
                        // Remove TotalSales_Product
                        self.TotalSales_Product.remove(at: self.Index_Delete[count] - count)
                        // Remove Data Product
                        self.DataPro_Edit.remove(at: self.Index_Delete[count] - count)
                    }
                }
                
                // Update Name Quotation
                self.Lb_NumSales.text = Name_Edit
                
                // Reset Id Product Delete
                self.Id_ProdcutDelete.removeAll()
                self.Index_Delete.removeAll()
                
                // Enable Txt_Discount and Change Attribute
                self.Txt_Discount.isEnabled = false
                self.Txt_Discount.backgroundColor = .clear
                self.Txt_Discount.textColor = .white
                
                // Not Enable Txt_Note and Txt_Reason
                self.Txt_Note.isEditable = false
                self.Txt_Reason.isEditable = false
                
                // Change Title Button right nav bar
                self.navigationItem.rightBarButtonItem?.title = "Edit"
                
                // Change State Edit Quotation
                self.State_EditQuo = false
                
                // Permiss Edit Status Quotation
                for count in 0...2{
                    if count != self.Seg_StatusQuo.selectedSegmentIndex {
                        self.Seg_StatusQuo.setEnabled(false, forSegmentAt: count)
                    }
                }
                
                
                // Update Collection Product Height
                self.Height_ConstraintColleciton.constant = (self.Height_CollectionPercell * CGFloat(self.DataPro_Edit.count))
                self.view.layoutIfNeeded()
                
                // Reload Collection ProductList
                self.CollectionProList.reloadData()
                /*if self.DataPro_Edit.count == 0 {
                    
                    self.CollectionProList.reloadData()
                    
                }else {
                    for count in 0...(self.DataPro_Edit.count - 1) {
                        let indexPath = IndexPath(item: count, section: 0)
                        self.CollectionProList.reloadItems(at: [indexPath])
                    }
                }*/
                
            case .failure(_) :
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Update quotation not success")
                break
            }
            
        }
        
        
        
    }
    
    // MARK: Alert Box
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
           
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: Func SegmentControl DidChange
    @objc func Seg_Change(_ sender : UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            sender.selectedSegmentTintColor = UIColor.systemGreen
        }
        else if sender.selectedSegmentIndex == 1 {
            sender.selectedSegmentTintColor = UIColor.systemYellow
        }
        else {
            sender.selectedSegmentTintColor = UIColor.systemRed
        }
        
    }
    
    
    // MARK : Func Sum Total Sales of Quotation
    func Sum_TotalSales(){
        
        // Check Count of Total
        guard TotalSales_Product.count != 0 else {
            return
        }
        
        // Sum Sub total
        var SubTotal : Double = TotalSales_Product.reduce(0,+)
        
        self.Lb_SubTotal.text = " Sub Total : \(String(SubTotal).currencyFormatting()) ฿ "
        
        // Discount All of Quotation
        // Cal Total Price of Product
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let Discount =  Double(formatter.number(from: Txt_Discount.text!) ?? 0)/*Double(Data_Pass[Key_Quo.Discount] as? Double ?? 0)*/
        
        // Cal Vat
        let vat = Double(Data_Pass[Key_Quo.Vat] as! String) ?? 0
        
        let TotalPrice = (SubTotal + (SubTotal * Double(vat/100))) - Discount
        
        // Update Label Total
        Txt_Discount.text = String(Discount).currencyFormatting()
        Lb_Total.text = " Total : \(String(TotalPrice).currencyFormatting()) ฿ "
        
    }
    
    // MARK: Event Button Navigation Bar Back
    @objc func Back_BeforePage() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

// MARK: Extension of Page
// Extension TextView
extension DetailQuotationController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimateSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            
            if constraint.firstAttribute == .height {
                constraint.constant = estimateSize.height
            }
            
        }
        
        Txt_Reason.layer.borderColor = UIColor.BlueDeep.cgColor
        
    }
    
    
}

// Extension Collection View (Delegate, DataSource)
extension DetailQuotationController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if State_Download == false {
            return 3
        }else {
            return DataPro_Edit.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCellShow, for: indexPath) as! CollectionCell_ProList_Show
        
        // State Download Detail false
        if State_Download == false {
            
            // Show Skeleton Loader
            cell.showAnimatedSkeleton()
            
        }else {
            print(indexPath.row)
            
            // Hide Skeleton Loader
            cell.hideSkeleton()
            
            let Data = DataPro_Edit[indexPath.row]
            
            // Set State Edit for Cell
            cell.State_Edit = self.State_EditQuo
            
            // Set Data
            cell.Lb_NamePro.text = (Data["ProductName"] as! String)
            // Set Quan
            let Quantity = (Data["QuoproQuantity"] as! Double)
            cell.Txt_Quan.text = String(Quantity).currencyFormatting()
            // Set Price
            let Price = (Data["QuoproPrice"] as! Double)
            cell.Txt_Price.text = String(Price).currencyFormatting()
            // Set Discount
            let Discount = (Data["QuoproDiscount"] as! Double)
            cell.Txt_Discount.text = String(Discount).currencyFormatting()
            // Set Total Price Product
            let TotalProduct : Double = (Quantity * Price) - Discount//((Quantity * Price) * (Discount / 100))
            cell.Total_Price = TotalProduct
            
            // Add Event Cal TotalSale Product
            cell.Cal_TotalSales_Product = { () in
                
                // Check Delete Product
                if cell.State_Delete == true {
                    
                    // Cal Total **
                    self.TotalSales_Product[indexPath.row] = 0
                    
                }
                else {
                    // Cal Total **
                    self.TotalSales_Product[indexPath.row] = cell.Total_Price
                    
                }
                
                
            }
            
            // Must Set State of Delete after Func Cal_TotalSales_Product becouse Set State have impact to Index of  al_TotalSales_Product (**)
            cell.State_Delete = false
            
            
        }
        
        
        
        return cell
        
        
    }
    
}
// Extention Collection View (FlowLayout)
extension DetailQuotationController : UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - (30 * ratio), height: (150 * ratio))
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15 * ratio, left: 15 * ratio, bottom: 15 * ratio, right: 15 * ratio) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Space Vertical of cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15 * ratio
    }
    
    
}

// extension TextField
extension DetailQuotationController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            
        // Check Txt Discount End Edit
        if textField == Txt_Discount {
            
            Sum_TotalSales()
            
        }
        
        
        
    }
    
    
}
