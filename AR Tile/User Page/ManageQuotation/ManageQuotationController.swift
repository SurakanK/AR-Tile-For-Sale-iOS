//
//  ManageQuotationController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 1/4/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import UIDropDown
import Alamofire
import TagListView
import SearchTextField
import MDatePickerView

// Id Cell
private let reuseIdentify = "Collectioncell_Quotation"

class ManageQuotationController : UIViewController, UINavigationControllerDelegate {
    
    // MARK: Parameter
    // ratio
    lazy var ratio = view.frame.width / 375
    
    var DataSource_TableSortby : [String] = ["วันเวลา(ใหม่ไปเก่า)","มูลค่า(มากไปน้อย)","มูลค่า(น้อยไปมาก)"]
    // DataSource Colleciton
    var DataSource_DataFilter : [String] = ["Test1","Test2","Test3"]
    
    // DropDownString Choose
    var DropDownSortBy_Choose : String = "วันเวลา(ใหม่ไปเก่า)"
    
    // Data Quotaion
    var DataQuo = [[String : Any]]()
    // Data Filter
    var Data_Filter = [[String : Any]]()
    // Data Main
    var DataMain = [[String : Any]]()
    // Parameter Data Search
    var Search_DataQuo = [[String : Any]]()
    
    
    // Filter Status Quotation
    var Filter_StatusQuo : [Int] = []
    
    
    // State of Download Data Quotation
    var State_Request : Bool = false
    
    // State of User Use
    var Sale_Use : Bool = true
    // State Open Page From Customer Detial
    var State_CustomerPage : Bool = false
    // Name Customer
    var Name_Customer : String? = nil
    
    
    // SeachBar
    let SearchController = UISearchController(searchResultsController: nil)
    
    // View Sort and Filter --------
    var View_SortFilter : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    // Icon SortBy
    var Icon_SortBy : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "sort").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.BlueDeep
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    // Label Sort By
    var Lb_SortBy : UILabel = {
        let label = UILabel()
        label.text = "Sort by"
        label.font = UIFont.MitrMedium(size: 18)
        return label
    }()
    
    // View DropDown ---
    var View_DropSort : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // View List DropDown Sort By
    var View_ListDrop : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()
    
    // ----------------
    
    // Line Devide Section Filter and Sort By
    var Line_Section : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.BlackAlpha(alpha: 0.5)
        return line
    }()
    
    // Icon Filter
    var Icon_Filter : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "filter").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // Botton Filter
    var Btn_Filter : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.MitrMedium(size: 15)
        
        // State Normal
        button.setBackgroundColor(color: .BlueDeep, forState: .normal)
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        // Highlight State
        button.setTitleColor(.BlueDeep, for: .highlighted)
        button.setTitle("Filter", for: .highlighted)
        button.setBackgroundColor(color: .white, forState: .highlighted)
        
        // Add Target
        button.addTarget(self, action: #selector(Event_Filter), for: .touchUpInside)
        
        return button
    }()
    
    // --------------------------------
    
    // Collection Filter
    var Collection_Filter : UICollectionView!
    
    // Filter Section -----------------
    var View_BlurFilter : UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.7)
        view.alpha = 0
        return view
    }()
    
    // View Filter
    var View_Filter : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 1
        
        return view
    }()
    
    // Constraint left of View Filter
    lazy var LeftAnchor_ViewFilter = self.View_Filter.leftAnchor.constraint(equalToSystemSpacingAfter: self.view.leftAnchor, multiplier: self.view.frame.width)
    
    // Button Reset Filter
    var Btn_ResetFilter : UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        
        // Normal State
        button.setTitle("Reset", for: .normal)
        button.setBackgroundColor(color: .white, forState: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        
        // Highlight State
        button.setTitle("Reset", for: .highlighted)
        button.setBackgroundColor(color: .BlueDeep, forState: .highlighted)
        button.setTitleColor(.white, for: .highlighted)
        
        button.addTarget(self, action: #selector(Reset_Filter), for: .touchUpInside)
        
        
        return button
    }()
    // Button Submit Filter
    var Btn_SubmitFilter : UIButton = {
        let button = UIButton()
    
        
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        
        // Normal State
        button.setTitle("Submit", for: .normal)
        button.setBackgroundColor(color: .BlueDeep, forState: .normal)
        button.setTitleColor(.white, for: .normal)
        
        // Highlight State
        button.setTitle("Submit", for: .highlighted)
        button.setBackgroundColor(color: .white, forState: .highlighted)
        button.setTitleColor(.BlueDeep, for: .highlighted)
        
        // add target
        button.addTarget(self, action: #selector(Submit_Filter), for: .touchUpInside)
        
        return button
    }()
    
    // Label Header Status Quo
    var Lb_HStatusQuo : UILabel = {
        let label = UILabel()
        label.text = "Status Quotation"
        label.font = UIFont.MitrMedium(size: 18)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // TagList View of State Quotation
    var TagList_Quo : TagListView = {
        let tag = TagListView()
        
        // Set Border
        tag.borderColor = .BlueDeep
        tag.borderWidth = 1
        
        // Set Font
        tag.textFont = UIFont.MitrLight(size: 15)
        tag.textColor = UIColor.BlackAlpha(alpha: 0.9)
        
        // Normal State
        tag.tagBackgroundColor = .white
        tag.textColor = .BlueDeep
        
        // Selected State
        tag.tagSelectedBackgroundColor = .BlueDeep
        tag.selectedTextColor = .white
        
        
        // Add tag
        tag.addTags(["Complete", "InProcess", "Reject"])
        
        
        return tag
    }()
    
    // Label Header Customer
    var Lb_HCustomer : UILabel = {
        let label = UILabel()
        label.text = "Customer"
        label.font = UIFont.MitrMedium(size: 18)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // Auto Complete Search Customer
    var Search_Customer : SearchTextField = {
        let search = SearchTextField()
        search.theme.font = UIFont.MitrLight(size: 15)
        search.theme.fontColor = .BlackAlpha(alpha: 0.9)
        search.theme.separatorColor = .BlackAlpha(alpha: 0.5)
        
        search.theme.borderColor = .BlueDeep
        search.theme.borderWidth = 1
        search.theme.bgColor = UIColor.white
        
        search.maxNumberOfResults = 5
        search.textAlignment = .center
        
        // Layer
        search.layer.cornerRadius = 5
        search.layer.borderColor = UIColor.BlueDeep.cgColor
        search.layer.borderWidth = 1
        return search
    }()
    
    // label Header Filter Date
    var Lb_HDate : UILabel = {
        let label = UILabel()
        
        label.text = "Quotation period"
        label.font = UIFont.MitrMedium(size: 18)
        label.textColor = .BlackAlpha(alpha: 0.9)
        
        return label
    }()
    
    // Switch Enable Date
    var Sw_Date : UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = .BlueDeep
        sw.addTarget(self, action: #selector(Sw_DateFilter(_:)), for: .allEvents)
        return sw
    }()
    
    // View Set Date
    var View_DatePicker : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0
        return view
    }()
    
    
    // Label Date Start
    var Lb_DateStart : UILabel = {
        let label = UILabel()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: Date())
        label.text = date
        
        
        label.font = UIFont.MitrLight(size: 15)
        label.textColor = .BlueDeep
        label.textAlignment = .center
        return label
    }()
    
    
    // Picker Date Start
    var Picker_StartDate : MDatePickerView = {
        let picker = MDatePickerView()

        picker.Color = .BlueDeep
        picker.cornerRadius = 5
        picker.from = 2020
        picker.to = 2050
        
        return picker
    }()
    
    // --------------------------------
    
    
    
    
    // MARK: Layout
    func Layout_Page(){
        view.backgroundColor = UIColor.systemGray6
        
        // Set NavigationBar
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.title = "Manage Quotation"
        // SeachBar in NavigationBar
        SearchController.searchResultsUpdater = self
        SearchController.searchBar.delegate = self
        SearchController.searchBar.searchBarStyle = .minimal
        SearchController.obscuresBackgroundDuringPresentation = false
        SearchController.searchBar.searchTextField.backgroundColor = .white
        SearchController.searchBar.tintColor = .white
        
        let TxtField = SearchController.searchBar.value(forKey: "searchField") as? UITextField
        TxtField?.font = UIFont.MitrRegular(size: 15 * ratio)
        TxtField?.backgroundColor = .white
        TxtField?.placeholder = "Search Quotation"
        
        navigationItem.searchController = SearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        //navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
       
        // View Sort Filter -------
        view.addSubview(View_SortFilter)
        View_SortFilter.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // Icon Sort By
        View_SortFilter.addSubview(Icon_SortBy)
        Icon_SortBy.anchor(View_SortFilter.topAnchor, left: View_SortFilter.leftAnchor, bottom: View_SortFilter.bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 20 * ratio, heightConstant: 20 * ratio)
        // Label Sort By
        View_SortFilter.addSubview(Lb_SortBy)
        Lb_SortBy.anchorCenter(nil, AxisY: Icon_SortBy.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_SortBy.anchor(nil, left: Icon_SortBy.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_SortBy.font = UIFont.MitrMedium(size: 15 * ratio)
        // View DropDown and Custom DropDown
        View_SortFilter.addSubview(View_DropSort)
        View_DropSort.anchor(Icon_SortBy.topAnchor, left: Lb_SortBy.rightAnchor, bottom: Icon_SortBy.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 150 * ratio, heightConstant: 0)
        
        view.layoutIfNeeded()
        // Line Provide Section
        View_SortFilter.addSubview(Line_Section)
        Line_Section.anchor(View_SortFilter.topAnchor, left: View_DropSort.rightAnchor, bottom: View_SortFilter.bottomAnchor, right: nil, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 1 * ratio, heightConstant: 0)
        // Icon Filter
        View_SortFilter.addSubview(Icon_Filter)
        Icon_Filter.anchorCenter(nil, AxisY: Icon_SortBy.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Icon_Filter.anchor(nil, left: Line_Section.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 20 * ratio, heightConstant: 20 * ratio)
        // Btn Filter
        View_SortFilter.addSubview(Btn_Filter)
        Btn_Filter.anchor(Line_Section.topAnchor, left: Icon_Filter.rightAnchor, bottom: Line_Section.bottomAnchor, right: View_SortFilter.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        Btn_Filter.titleLabel?.font = UIFont.MitrMedium(size: 15 * ratio)
        // -------------------------------
        
        // Collection Filter Setting And Layout
        let CollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
        view.addSubview(CollectionView)
        CollectionView.anchor(View_SortFilter.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        CollectionView.alwaysBounceVertical = true
        CollectionView.backgroundColor = .clear
               
        self.Collection_Filter = CollectionView
        
        
        // Setting Drop Down Sort By
        let DropDownSort = UIDropDown(frame: View_DropSort.frame)
        DropDownSort.font = "Mitr-Light"
        DropDownSort.fontSize = (15 * ratio)
        DropDownSort.layer.borderWidth = 0
        DropDownSort.placeholder = DataSource_TableSortby[0]
        DropDownSort.options = DataSource_TableSortby
        DropDownSort.optionsFont = "Mitr-Light"
        DropDownSort.optionsSize = (15 * ratio)
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = 50
        DropDownSort.tableHeight = CGFloat(50 * DataSource_TableSortby.count)
        
        
        DropDownSort.didSelect { (Text, index) in
            DropDownSort.placeholder = Text
            
            self.DropDownSortBy_Choose = Text
            
            // Sort Data
            self.Search_DataQuo = self.Sort_Data(SortBy: Text, DataForSort: self.Data_Filter)
            self.Collection_Filter.reloadData()
        }
        
        view.addSubview(DropDownSort)
        
        
        // Filter Section --------------------------
        // View Blur
        view.addSubview(View_BlurFilter)
        View_BlurFilter.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // View Filter
        view.addSubview(View_Filter)
        View_Filter.anchor(view.topAnchor, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        LeftAnchor_ViewFilter.isActive = true
        
        // Label Header Status Quotation
        View_Filter.addSubview(Lb_HStatusQuo)
        Lb_HStatusQuo.anchor(View_Filter.topAnchor, left: View_Filter.leftAnchor, bottom: nil, right: View_Filter.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_HStatusQuo.font = UIFont.MitrMedium(size: 18 * ratio)
        
        // Tag List Status Quotation
        View_Filter.addSubview(TagList_Quo)
        TagList_Quo.anchor(Lb_HStatusQuo.bottomAnchor, left: Lb_HStatusQuo.leftAnchor, bottom: nil, right: Lb_HStatusQuo.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        TagList_Quo.paddingX  = 10 * ratio
        TagList_Quo.paddingY = 10 * ratio
        TagList_Quo.cornerRadius = 5 * ratio
        
        // label Header Customer Filter
        View_Filter.addSubview(Lb_HCustomer)
        Lb_HCustomer.anchor(TagList_Quo.bottomAnchor, left: TagList_Quo.leftAnchor, bottom: nil, right: TagList_Quo.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_HCustomer.font = UIFont.MitrMedium(size: 18 * ratio)
        
        // Search Customer Filter
        View_Filter.addSubview(Search_Customer)
        Search_Customer.anchor(Lb_HCustomer.bottomAnchor, left: Lb_HCustomer.leftAnchor, bottom: nil, right: Lb_HCustomer.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
        
        // label Header Date Quotation Filter
        View_Filter.addSubview(Lb_HDate)
        Lb_HDate.anchor(Search_Customer.bottomAnchor, left: Search_Customer.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_HDate.font = UIFont.MitrMedium(size: 18 * ratio)
        
        // Switch Date Enable
        View_Filter.addSubview(Sw_Date)
        Sw_Date.anchor(Lb_HDate.topAnchor, left: Lb_HDate.rightAnchor, bottom: Lb_HDate.bottomAnchor, right: Search_Customer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50 * ratio, heightConstant: 0)
        
        
        // Button Section -----
        let View_BtnFilter = UIView()
        View_BtnFilter.backgroundColor = .white
        View_Filter.addSubview(View_BtnFilter)
        View_BtnFilter.anchor(nil, left: View_Filter.leftAnchor, bottom: View_Filter.bottomAnchor, right: View_Filter.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 50 * ratio)
        // Button Reset Filter
        View_BtnFilter.addSubview(Btn_ResetFilter)
        Btn_ResetFilter.anchor(View_BtnFilter.topAnchor, left: View_BtnFilter.leftAnchor, bottom: View_BtnFilter.bottomAnchor, right: View_BtnFilter.centerXAnchor, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 5 * ratio, rightConstant: 2.5 * ratio, widthConstant: 0, heightConstant: 0)
        // Button Submit Filter
        View_BtnFilter.addSubview(Btn_SubmitFilter)
        Btn_SubmitFilter.anchor(Btn_ResetFilter.topAnchor, left: View_BtnFilter.centerXAnchor, bottom: Btn_ResetFilter.bottomAnchor, right: View_BtnFilter.rightAnchor, topConstant: 0, leftConstant: 2.5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        // -----------------------------------------
        
        // Date Filter Section ---------------------
        // View Date
        View_Filter.addSubview(View_DatePicker)
        View_DatePicker.anchor(Lb_HDate.bottomAnchor, left: Lb_HDate.leftAnchor, bottom: View_BtnFilter.topAnchor, right: Sw_Date.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Label Date Filter
        View_DatePicker.addSubview(Lb_DateStart)
        Lb_DateStart.anchor(View_DatePicker.topAnchor, left: View_DatePicker.leftAnchor, bottom: nil, right: View_DatePicker.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_DateStart.font = UIFont.MitrRegular(size: 15 * ratio)
        
        // Picker Filter Date
        View_DatePicker.addSubview(Picker_StartDate)
        Picker_StartDate.anchor(Lb_DateStart.bottomAnchor, left: Lb_DateStart.leftAnchor, bottom: View_DatePicker.bottomAnchor, right: Lb_DateStart.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // -----------------------------------------
        
        
        
    }
    
    // MARK: Config
    func Config_Page(){
        
        // Config Collection Filter and Quotation
        self.Collection_Filter.delegate = self
        self.Collection_Filter.dataSource = self
        self.Collection_Filter.register(Collectioncell_Quotation.self.self, forCellWithReuseIdentifier: reuseIdentify)
        
        // TagList_Quo Delegate
        TagList_Quo.delegate = self
        
        // Config Picker Date
        Picker_StartDate.delegate = self
        
        // Reset DataQuo and State Dowmload
        //DataQuo.removeAll()
        //Collection_Filter.reloadData()
        
        
        // Config Tap View Blur Filter
        let tap = UITapGestureRecognizer(target: self, action: #selector(Tap_ViewBlurFilter))
        View_BlurFilter.addGestureRecognizer(tap)
    
        
    }
    
    // MARK: Func Life Cycle Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element Page
        Layout_Page()
        // Config Element in Page
        Config_Page()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Reset DataQuo and State Dowmload
        State_Request = false
        DataQuo.removeAll()
        Collection_Filter.reloadData()
        
        
        // Check Type User use Page (For Request Quotation List)
        // Sale use
        if Sale_Use {
            // Request Quotation
            self.Server_SendDataLogin(TokenId: LoginPageController.DataLogin?.Token_Id, Url: DataSource.Url_GetQuoSeller())
        }
        // Admin use
        else {
            
            // Date For Request 2000 - DateCurrent
            let date = Date()
            let formatter = DateFormatter()
            
            formatter.dateFormat = "yyyy"
            formatter.calendar = Calendar(identifier: .gregorian)
            
            // Config Date
            var DateStart = "2000" // since year 2000
            var DateEnd = formatter.string(from: date) // Current Year
            
            DateStart = "\(DateStart)-01"
            DateEnd = "\(DateEnd)-12"
            // Request Quotation
            self.Request_QuotationListAdmin(Url: DataSource.Url_GetQuotationListAdmin(), Date: ["Start" : DateStart, "End" : DateEnd])
            
            
        }
        
    }
    
    // MARK: Func in Page
    @objc func Tap_ViewBlurFilter(){
        
        Control_FilterPage()
        
    }
    
    // MARK: Event Button of View Filter
    // Event Filter Button
    @objc func Event_Filter(){
           
           Control_FilterPage()
           
       }
    
    // Event Reset Filter
    @objc func Reset_Filter(){
        
        // Reset Tag List ---------
        TagList_Quo.removeAllTags()
        TagList_Quo.addTags(["Complete", "InProcess", "Reject"])
        
        // Clear Data in Filter Status Quotation
        Filter_StatusQuo.removeAll()
        // ------------------------
        
        // Reset Customer
        Search_Customer.text = ""
        
        // Reset Filter Date
        Sw_Date.isOn = false
        UIView.animate(withDuration: 0.5) {
            self.View_DatePicker.alpha = 0
        }
        
        // Change Data Filter = initial Data
        Data_Filter = DataQuo
        Search_DataQuo = Sort_Data(SortBy: DropDownSortBy_Choose, DataForSort: Data_Filter)
        Collection_Filter.reloadData()
        
    }
    // Event Submit Filter
    @objc func Submit_Filter(){
        
        // Hide View Filter
        Control_FilterPage()
        
        // Filter Data Quotaion
        Filter_DataQuotation()
        
    }
    
    // Func Filter Data Quotation
    func Filter_DataQuotation(){
        
        Data_Filter = DataQuo
        
        // Filter Customer ----
        // Check Lenght of Searh_Customer text
        if Search_Customer.text!.count != 0 {
            
            Data_Filter = Data_Filter.filter{($0["CustomerCompanyName"] as! String) == Search_Customer.text}
            
        }

        // --------------------
        
        
        // Filter Status Quotation ------
        if Filter_StatusQuo.count == 1 {
            Data_Filter = Data_Filter.filter{($0["QuotationCompleted"] as! Int) == Filter_StatusQuo[0]}
        }
        else if Filter_StatusQuo.count == 2 {
            Data_Filter = Data_Filter.filter{($0["QuotationCompleted"] as! Int) == Filter_StatusQuo[0] || ($0["QuotationCompleted"] as! Int) == Filter_StatusQuo[1]}
        }
        // ------------------------------
        
        // Filter Date Quotaion --------
        if Sw_Date.isOn == true{
            
            Data_Filter = Data_Filter.filter{($0["EndDate"] as! String) == Lb_DateStart.text}
            
        }
        // -----------------------------
        
        
        // Update Collection Quotation
        Search_DataQuo = Sort_Data(SortBy: DropDownSortBy_Choose, DataForSort: Data_Filter)
        self.Collection_Filter.reloadData()
        
    }
    
    // MARK: Sort Data
    func Sort_Data(SortBy : String, DataForSort : [[String : Any]]) -> [[String : Any]] {
        
        var Data_Sort = DataForSort
        
        // Sort Price (High to Low)
        if SortBy == "มูลค่า(มากไปน้อย)" {
            // Check nil
            for count in 0...(DataForSort.count - 1){
                
                if Data_Sort[count]["TotalSales"] as? Double == nil {
                    Data_Sort[count]["TotalSales"] = Double(0)
                }
                
            }
            
            Data_Sort = Data_Sort.sorted{($0["TotalSales"] as! Double) >= ($1["TotalSales"] as! Double)}
            
        }
        // Sort Price Low to Hight
        else if SortBy == "มูลค่า(น้อยไปมาก)" {
            
            // Check nil
            for count in 0...(DataForSort.count - 1){
                
                if Data_Sort[count]["TotalSales"] as? Double == nil {
                    Data_Sort[count]["TotalSales"] = Double(0)
                }
                
            }
            
            Data_Sort = Data_Sort.sorted{($0["TotalSales"] as! Double) <= ($1["TotalSales"] as! Double)}
            
        }
        // Sort Data New to Old
        else if SortBy == "วันเวลา(ใหม่ไปเก่า)" {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            Data_Sort = Data_Sort.sorted{dateFormatter.date(from:$0["EndDate"] as! String)!.compare(dateFormatter.date(from:$1["EndDate"] as! String)!) == .orderedDescending }
            
        }
        
        
        
        return Data_Sort
    }
    
    
    // MARK : Func Open and Close Filter Page
    func Control_FilterPage(){
        
        view.endEditing(true)
        
        // Open Filter Page
        if View_BlurFilter.alpha == 0 {
            
            let width_ViewFilter = self.view.frame.width / 4
            LeftAnchor_ViewFilter.constant = width_ViewFilter * 0.5
            
            
            UIView.animate(withDuration: 0.5) {
                // Change Alpha Blur Filter
                self.View_BlurFilter.alpha = 1
                
                self.view.layoutIfNeeded()
            }
            
        
            
        }
        // Close  Filter Page
        else if View_BlurFilter.alpha == 1 {
            LeftAnchor_ViewFilter.constant = view.frame.width
            
            
            UIView.animate(withDuration: 0.5) {
                // Change Alpha Blur Filter
                self.View_BlurFilter.alpha = 0
                
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
    
    
    // MARK: Request data Quotation List From Server (Sale Use)
    func Server_SendDataLogin(TokenId : String! ,Url : String!) {
           
        let Header : HTTPHeaders = [HTTPHeader.authorization(bearerToken: TokenId), HTTPHeader.contentType("application/json")]
           
        AF.sessionConfiguration.timeoutIntervalForRequest = 1
        AF.request(Url, method : .post, headers: Header).responseJSON { response in
               
            switch response.result {
            case .success(let value):
                
                if let json = value as? [String : Any] {
                       
                    // Check Response Error
                    guard json["results"] != nil else {
                        let errormesaage = json["message"] as! String
                        print(errormesaage)
                        return
                    }
                    // Set Data
                    self.DataQuo = (json["results"] as? [[String : Any]])!
                    
                    // CHeck From Customer Detail Page
                    if self.State_CustomerPage {
                        
                        // Filter Quotation Customer
                        self.DataQuo = self.DataQuo.filter{($0["CustomerCompanyName"] as! String) == self.Name_Customer}
                        
                    }
                    
                    
                    self.Data_Filter = self.DataQuo
                    self.Search_DataQuo = self.Sort_Data(SortBy: self.DropDownSortBy_Choose, DataForSort: self.DataQuo)
                    self.Collection_Filter.reloadData()
                    
                       
                    // Add List Customer for Filter Section
                    // Clear Data List Customer for Refreash List
                    var List_Customer : [String] = []
                    for count in 0..<self.DataQuo.count{
                        let data = self.DataQuo[count]
                        List_Customer.append((data["CustomerCompanyName"] as! String))
                    }
                       
                    // Update to Search_Customer
                    self.Search_Customer.filterStrings(List_Customer)
                       
                    // Change State Request
                    self.State_Request = true
                    
                       
                  
                       
                }
                   
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Quotation InComplete")
                break
            }
               
        }
           
           
    }
    
    // MARK: Request Data Quotation List from Server (Admin Use)
    public func Request_QuotationListAdmin(Url : String ,Date : [String : String]){
        
        let parameter = Date
        let Header : HTTPHeaders = [.authorization(bearerToken: LoginPageController.DataLogin!.Token_Id), .contentType("application/json")]
        
        AF.request(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success(let value) :
                
                if let json = value as? [String : Any] {
                                      
                    // Check Response Error
                    guard json["results"] != nil else {
                        let errormesaage = json["message"] as! String
                        print(errormesaage)
                        return
                    }
                    // Set Data
                    self.DataQuo = (json["results"] as? [[String : Any]])!
                    
                    // CHeck From Customer Detail Page
                    if self.State_CustomerPage {
                        
                        // Filter Quotation Customer
                        self.DataQuo = self.DataQuo.filter{($0["CustomerCompanyName"] as! String) == self.Name_Customer}
                        
                    }
                    
                    self.Data_Filter = self.DataQuo
                    self.Search_DataQuo = self.Sort_Data(SortBy: self.DropDownSortBy_Choose, DataForSort: self.DataQuo)
                    self.Collection_Filter.reloadData()
                                   
                                      
                    // Add List Customer for Filter Section
                    // Clear Data List Customer for Refreash List
                    var List_Customer : [String] = []
                    for count in 0..<self.DataQuo.count{
                        let data = self.DataQuo[count]
                        List_Customer.append((data["CustomerCompanyName"] as! String))
                    }
                                      
                    // Update to Search_Customer
                    self.Search_Customer.filterStrings(List_Customer)
                                      
                    // Change State Request
                    self.State_Request = true
                                   
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                break
            }
            
            
        })
        
        
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
    
    
    
    // MARK: Event Date Filter
    // Event Switch Date Filter
    @objc func Sw_DateFilter(_ sender : UISwitch) {
        
        if sender.isOn == true {
            
            // Open Date Filter
            Control_DateFilter()
            
        }
        else {
            
            // Hide Date Filter
            Control_DateFilter()
            
        }
        
    }
    
    // Func Control Date Filter
    func Control_DateFilter(){
        
        if View_DatePicker.alpha == 0 {
            
            UIView.animate(withDuration: 0.5) {
                self.View_DatePicker.alpha = 1
                
            }
            
        }
        else {
            
            UIView.animate(withDuration: 0.5) {
                self.View_DatePicker.alpha = 0
            }
            
        }
        
    }
    
    
    
}

// MARK: Extention Page
extension ManageQuotationController : UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let Txt_Search = searchController.searchBar.text!
        
        if Txt_Search.count > 0 {
            self.Search_DataQuo = Search_DataQuo.filter{($0["QuotationRecName"] as! String).prefix(Txt_Search.count) == Txt_Search}
        }
        else {
            self.Search_DataQuo = Data_Filter
        }
        
        self.Collection_Filter.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    
    
}

// Extension TagListView
extension ManageQuotationController : TagListViewDelegate {
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        if tagView.isSelected == false {
            
            // Add Filter Status to List Filter Status Quotation
            if title == "Complete" {
                Filter_StatusQuo.append(1)
            }
            else if title == "InProcess" {
                Filter_StatusQuo.append(0)
            }
            else if title == "Reject" {
                Filter_StatusQuo.append(2)
            }
            
            tagView.isSelected = true
            
        }
        else if tagView.isSelected == true {
            
            // Remove Filter Status from List Filter Status Quotation
            if title == "Complete" {
                let index = Filter_StatusQuo.lastIndex(of: 1)
                print(Filter_StatusQuo[index!])
                Filter_StatusQuo.remove(at: index!)
            }
            else if title == "InProcess" {
                let index = Filter_StatusQuo.lastIndex(of: 0)
                print(Filter_StatusQuo[index!])
                Filter_StatusQuo.remove(at: index!)
            }
            else if title == "Reject" {
                let index = Filter_StatusQuo.lastIndex(of: 2)
                print(Filter_StatusQuo[index!])
                Filter_StatusQuo.remove(at: index!)
            }
            
            tagView.isSelected = false
            
        }
        
        
    }
    
}


// Extention Collection
extension ManageQuotationController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if State_Request == false {
            return 10
        }
        else {
            return Search_DataQuo.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentify, for: indexPath) as! Collectioncell_Quotation
        
        // Check Count DataQuo for Show Skeleton Loader
        if State_Request == false {
            
            // Show Skeleton Loader
            cell.viewLabelCheck.showAnimatedSkeleton()
            cell.Lb_IDQuo.showAnimatedSkeleton()
            cell.Lb_Date.showAnimatedSkeleton()
            cell.Lb_Customer.showAnimatedSkeleton()
            cell.Lb_By.showAnimatedSkeleton()
            cell.Lb_Price.showAnimatedSkeleton()
            cell.Btn_Detail.showAnimatedSkeleton()
            
        }
        else {
            
            // Hide Skeleton Loader
            cell.viewLabelCheck.hideSkeleton()
            cell.Lb_IDQuo.hideSkeleton()
            cell.Lb_Date.hideSkeleton()
            cell.Lb_Customer.hideSkeleton()
            cell.Lb_By.hideSkeleton()
            cell.Lb_Price.hideSkeleton()
            cell.Btn_Detail.hideSkeleton()
            
            let data = Search_DataQuo[indexPath.row]
            
            // Show Status Quotation
            cell.ColorView = String(data["QuotationCompleted"] as! Int)
            
            // Show label ID Quo
            cell.Lb_IDQuo.text = (data["QuotationRecName"] as! String)
            // Show label Date
            let DateArr = (data["EndDate"]! as! String).components(separatedBy: "-")
            cell.Lb_Date.text = "Date : \(DateArr[0])/\(DateArr[1])/\(DateArr[2])"
            // Show Customer
            cell.Lb_Customer.text = "Customer : \(data["CustomerCompanyName"] as! String)"
            // Show label By
            cell.Lb_By.text = "By : \(data["ProjectSalesName"] as! String)"
            // Show Price
            // Cal Discount and Vat for Sales
            if data["TotalSales"] as? Double != nil {
                var OverallSales = Double(data["TotalSales"]! as! Double)
                let Vat = Double(OverallSales / 100) * Double(data["vat"]! as! String)!
                let Discount = Double(data["discount"] as? Double ?? 0)
                OverallSales = (OverallSales + Vat) - Discount
                cell.Lb_Price.text = String(OverallSales).currencyFormatting() + " ฿"
            }
            else {
                cell.Lb_Price.text = "0" + " ฿"
            }
            
            cell.btnTapAction = { () in
                
                // Pass Data And Push to Detail Quotation Page
                print(data)
                
                let DetailPage = DetailQuotationController()
                DetailPage.Data_Pass = data
                DetailPage.Sale_Use = self.Sale_Use
                
                self.navigationController?.pushViewController(DetailPage, animated: true)
                
            }
            
        }
        
        
        
        return cell
    }
    
    
    
}
// Collection Delegate Layout
extension ManageQuotationController : UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - (20 * ratio), height: 150 * ratio)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //.zero
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
        return 10
    }
    
}

// Extension Picker Date
extension ManageQuotationController : MDatePickerViewDelegate {
    
    func mdatePickerView(selectDate: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.string(from: selectDate)
        Lb_DateStart.text = date
        
    }
    
    
}
