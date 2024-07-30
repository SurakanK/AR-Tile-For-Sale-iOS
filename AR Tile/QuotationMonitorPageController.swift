//
//  QuotationMonitorPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 5/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import TTSegmentedControl
import UIDropDown
import TagListView
import SearchTextField

private let reuseIdentify = "Collectioncell_Quotation"

class QuotationMonitorPageController : UIViewController, UISearchBarDelegate {
    
    //MARK: Parameter
    // DataQuotation Center
    var DataQuo_Center = [[String : Any]]()
    // State View Befor
    var State_ViewBefor : Bool = false
    // Parameter Data Search
    var Search_DataQuo = [[String : Any]]()
    // List of Customer
    var List_Customer : [String] = []
    // DataSouce Table Sortby
    var DataSource_TableSortby : [String] = ["วันเวลา(ใหม่ไปเก่า)","มูลค่า(มากไปน้อย)","มูลค่า(น้อยไปมาก)"]
    // DropDownString Choose
    var DropDownSortBy_Choose : String = "วันเวลา(ใหม่ไปเก่า)"
    
    // Data Filter
    var Data_Filter = [[String : Any]]()
    // Filter Status Quotation
    var Filter_StatusQuo : [Int] = []
    // Filter Date
    var Filter_Date : String = ""
    
    
    //MARK: Element Page
    // Search Quotation
    var SearchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.searchTextField.font = UIFont.PoppinsRegular(size: 15)
        bar.searchTextField.textColor = .BlackAlpha(alpha: 0.8)
        bar.barTintColor = .BlueDeep
        
        let TxtField = bar.value(forKey: "searchField") as? UITextField
        TxtField?.backgroundColor = .white
        TxtField?.placeholder = "Search Quotation"    
        return bar
    }()
    // -----------------------------------------------
    // View SortFilter
    var View_SortFilter : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    // Icon Sortby
    var Icon_SortBy : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "sort").withRenderingMode(.alwaysTemplate)
        image.tintColor = .BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label SortBy
    var Lb_SortBy : UILabel = {
        let label = UILabel()
        label.text = "Sortby"
        label.font = UIFont.MitrMedium(size: 18)
        label.textColor = UIColor.BlackAlpha(alpha: 0.9)
        return label
    }()
    // View DropDown Sortby ------
    var View_DropSort : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // ---------------------------
    // Line Section Filter
    var Line_Section : UIView = {
        let line = UIView()
        line.backgroundColor = .BlackAlpha(alpha: 0.5)
        return line
    }()
    // Icon Filter
    var Icon_Filter : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "filter").withRenderingMode(.alwaysTemplate)
        image.tintColor = .BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Button Filter
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
        button.addTarget(self, action: #selector(BtnFilter_Click), for: .touchUpInside)
        
        return button
    }()
    
    // -----------------------------------------------
    // Collection View Quotation
    weak var Collection_Quo : UICollectionView!
    // -----------------------------------------------
    // View Blur
    var View_Blur : UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.7) // Active State 0.7
        view.alpha = 0
        return view
    }()
    // View Filter
    var View_Filter : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
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
    
    
    // Button Segment
    var Seg_Filter : TTSegmentedControl = {
        let button = TTSegmentedControl()
        button.containerBackgroundColor = UIColor.white
        button.defaultTextFont = UIFont.PoppinsRegular(size: 10)
        button.defaultTextColor = .BlackAlpha(alpha: 0.8)
        
        button.allowChangeThumbWidth = true

        button.selectedTextFont = UIFont.PoppinsMedium(size: 10)
        button.selectedTextColor = .whiteAlpha(alpha: 0.8)

        
        button.thumbGradientColors = [.BlueDeep, .BlueDeep]
        button.itemTitles = ["All", "Complete", "Inprocess", "Reject"]
        button.useShadow = true

        return button
    }()
    
    
    
    // -----------------------------------------------
    
    
    
    //MARK: Func Layout Page
    func Layout_Page(){
        
        view.backgroundColor = .systemGray6
        // ratio
        let ratio = view.frame.width / 375
        
        // Search Bar
        view.addSubview(SearchBar)
        
        SearchBar.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 40 * ratio)
        
        // ----------------------------------
        
        // View Sort Filter -------
        view.addSubview(View_SortFilter)
        View_SortFilter.anchor(SearchBar.bottomAnchor, left: SearchBar.leftAnchor, bottom: nil, right: SearchBar.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Icon Sort By
        View_SortFilter.addSubview(Icon_SortBy)
        Icon_SortBy.anchor(View_SortFilter.topAnchor, left: View_SortFilter.leftAnchor, bottom: View_SortFilter.bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 20 * ratio, heightConstant: 20 * ratio)
        // Label Sort By
        View_SortFilter.addSubview(Lb_SortBy)
        Lb_SortBy.anchorCenter(nil, AxisY: Icon_SortBy.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_SortBy.anchor(nil, left: Icon_SortBy.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_SortBy.font = UIFont.MitrMedium(size: 15 * ratio)
        // View DropDown and Custom DropDown
        view.addSubview(View_DropSort)
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
        
        // Seg Filter
        /*view.addSubview(Seg_Filter)
        
        Seg_Filter.anchor(SearchBar.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 40 * ratio)
        
        // Add Target Segment Control
        Seg_Filter.didSelectItemWith = { (Index,text) -> () in
            self.Seg_DidChange(Index: Index, Text: text!)
        }*/
        
        // CollectionView Quotation
        let CollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        view.addSubview(CollectionView)
        CollectionView.anchor(View_SortFilter.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
 
        CollectionView.alwaysBounceVertical = true
        CollectionView.backgroundColor = .clear
        
        self.Collection_Quo = CollectionView
        
        // Navigation Bar
        // Check View Befor
        if State_ViewBefor == true {
            
            let navigationBar = navigationController?.navigationBar
            navigationBar?.tintColor = UIColor.whiteAlpha(alpha: 0.8)
            navigationBar?.barTintColor = .BlueDeep
            
            navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsBold(size: 25)]
            navigationItem.title = "Quotation"
            
            //navigationItem.backBarButtonItem?.isEnabled = true
            
            let Button_back = UIBarButtonItem()
            Button_back.title = "Back"
            Button_back.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 17)], for: .normal)
            Button_back.action = #selector(backAction)
            Button_back.target = self
            
            self.navigationItem.leftBarButtonItem = Button_back
        }
        
        // Setting Drop Down Sort By
        print(View_DropSort.frame)
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
            self.Collection_Quo.reloadData()
        }
        
        view.addSubview(DropDownSort)
        
        // View Filter Section -------
        // View Blur
        view.addSubview(View_Blur)
        View_Blur.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.height)
        
        // View Filter
        View_Blur.addSubview(View_Filter)
        let width_ViewFilter = view.frame.width / 4
        View_Filter.frame = CGRect(x: view.frame.width, y: 0, width: (width_ViewFilter * 3.5), height: view.frame.height)
        
        // Button Section -----
        let View_BtnFilter = UIView()
        View_BtnFilter.backgroundColor = .white
        View_Filter.addSubview(View_BtnFilter)
        View_BtnFilter.anchor(nil, left: View_Blur.leftAnchor, bottom: View_Blur.bottomAnchor, right: View_Blur.rightAnchor, topConstant: 0, leftConstant: (width_ViewFilter * 0.5), bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50 * ratio)
        // Button Reset Filter
        View_BtnFilter.addSubview(Btn_ResetFilter)
        Btn_ResetFilter.anchor(View_BtnFilter.topAnchor, left: View_BtnFilter.leftAnchor, bottom: View_BtnFilter.bottomAnchor, right: View_BtnFilter.centerXAnchor, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 5 * ratio, rightConstant: 2.5 * ratio, widthConstant: 0, heightConstant: 0)
        // Button Submit Filter
        View_BtnFilter.addSubview(Btn_SubmitFilter)
        Btn_SubmitFilter.anchor(Btn_ResetFilter.topAnchor, left: View_BtnFilter.centerXAnchor, bottom: Btn_ResetFilter.bottomAnchor, right: View_BtnFilter.rightAnchor, topConstant: 0, leftConstant: 2.5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        // -------
        
        // label Header Status Quotation
        View_Filter.addSubview(Lb_HStatusQuo)
        Lb_HStatusQuo.anchor(View_Filter.topAnchor, left: View_BtnFilter.leftAnchor, bottom: nil, right: View_Blur.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_HStatusQuo.font = UIFont.MitrMedium(size: 18 * ratio)
        
        // Tag List Quotation
        View_Filter.addSubview(TagList_Quo)
        TagList_Quo.anchor(Lb_HStatusQuo.bottomAnchor, left: Lb_HStatusQuo.leftAnchor, bottom: nil, right: Lb_HStatusQuo.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        TagList_Quo.paddingX  = 10 * ratio
        TagList_Quo.paddingY = 10 * ratio
        TagList_Quo.cornerRadius = 5 * ratio
        
        
        TagList_Quo.textFont = UIFont.MitrLight(size: 15 * ratio)
        
        // Label Header Customer
        View_Filter.addSubview(Lb_HCustomer)
        Lb_HCustomer.anchor(TagList_Quo.bottomAnchor, left: Lb_HStatusQuo.leftAnchor, bottom: nil, right: Lb_HStatusQuo.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_HCustomer.font = UIFont.MitrMedium(size: 18 * ratio)
        // Auto Search Complete
        View_Filter.addSubview(Search_Customer)
        Search_Customer.anchor(Lb_HCustomer.bottomAnchor, left: Lb_HCustomer.leftAnchor, bottom: nil, right: Lb_HCustomer.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
        
        
        // ------------------------------------------
        
        
        
        
        
    }
    
    //MARK: Func Config Page
    func Config_Element(){
        
        // Config CollectionView Quotation
        Collection_Quo.delegate = self
        Collection_Quo.dataSource = self
        Collection_Quo.register(Collectioncell_Quotation.self, forCellWithReuseIdentifier: reuseIdentify)
        
        // Config SearchBar
        SearchBar.delegate = self
        
        // TagList_Quo Delegate
        TagList_Quo.delegate = self
        
        // Update Data Quotation from Data Search
        //self.Search_DataQuo = MainMonitorPageController.DataQuo

        
        // Add tab Recognizer of Hide View Filter
        //let tab_HideFilter = UITapGestureRecognizer(target: self, action: #selector(HandleTab(_:)))
        //View_Blur.addGestureRecognizer(tab_HideFilter)
        
    }
    
    //MARK: Event Page Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element Page
        Layout_Page()
        // Config Element Page
        Config_Element()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update Data Quotation from Data Search
        if State_ViewBefor == false {
            DataQuo_Center = MainMonitorPageController.DataQuo
        }
        
        // Add List Customer for Filter Section
        // Clear Data List Customer for Refreash List
        List_Customer.removeAll()
        for count in 0...(DataQuo_Center.count - 1){
            let data = DataQuo_Center[count]
            List_Customer.append((data["QuotationCompanyName"] as! String))
        }
        
        // Update to Search_Customer
        Search_Customer.filterStrings(List_Customer)
    
        self.Data_Filter = DataQuo_Center
        self.Search_DataQuo = Sort_Data(SortBy: DropDownSortBy_Choose, DataForSort: DataQuo_Center)
        Collection_Quo.reloadData()
        
    }
    
    //MARK: Event Button
    // Event Segment Button Filter didChange
    func Seg_DidChange(Index : Int, Text : String){
        
        // All Data
        if Text == "All" {
            Search_DataQuo = DataQuo_Center
            Collection_Quo.reloadData()
        }
        // Filter Data Complete Status
        else if Text == "Complete" {
            Search_DataQuo = DataQuo_Center.filter{String(($0["QuotationCompleted"]!) as! Int).prefix(1) == "1"}
            // Reload CollectionView
            Collection_Quo.reloadData()
        }
        // Filter Data InProcess Status
        else if Text == "Inprocess" {
            Search_DataQuo = DataQuo_Center.filter{String(($0["QuotationCompleted"]!) as! Int).prefix(1) == "0"}
            // Reload CollectionView
            Collection_Quo.reloadData()
        }
        
    }
    
    // Event Back Button
    @objc func backAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Event Filter Button Click
    @objc func BtnFilter_Click(){
        
        // Show View Filter
        ShowHide_ViewFilter()
        
    }

    // Func Tab UiView Blur for Hide View Filter
    @objc func HandleTab(_ sender: UITapGestureRecognizer? = nil){
        
        // hide View Filter
        ShowHide_ViewFilter()
        
    }
    
    // Func Show And Hide View Filter
    func ShowHide_ViewFilter(){
        
        // Show View Filter
        if View_Blur.alpha == 0 {
            
            // animation Show View Filter
            UIView.animate(withDuration: 0.5) {
                
                // Change Alpha View_Blur and View_Filter
                self.View_Blur.alpha = 1
                // Re Position View Filter
                let width_ViewFilter = self.view.frame.width / 4
                self.View_Filter.frame.origin.x -= (width_ViewFilter * 3.5)
                
            }
            
        }
        // Hide View Filter
        else if View_Blur.alpha == 1{
            
            // animation Hide View Filter
            UIView.animate(withDuration: 0.5) {
                
                // Change Alpha View_Blur and View_Filter
                self.View_Blur.alpha = 0
                // Re Position View Filter
                let width_ViewFilter = self.view.frame.width / 4
                self.View_Filter.frame.origin.x += (self.view.frame.width - (width_ViewFilter * 0.5))
                
            }
            
            
        }
        
    }
    
    // MARK: Event Button of View Filter
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
        
        // Change Data_Filter == initial Data
        Data_Filter = DataQuo_Center
        Search_DataQuo = self.Sort_Data(SortBy: DropDownSortBy_Choose, DataForSort: Data_Filter)
        Collection_Quo.reloadData()
        
        
        
        
    }
    // Event Submit Filter
    @objc func Submit_Filter(){
        
        // Hide View Filter
        ShowHide_ViewFilter()
        
        // Filter Data Quotaion
        Filter_DataQuotation()
        
    }
    
    // Func Filter Data Quotation
    func Filter_DataQuotation(){
        
        Data_Filter = DataQuo_Center
        
        // Filter Customer ----
        // Check Lenght of Searh_Customer text
        if Search_Customer.text!.count != 0 {
            
            Data_Filter = Data_Filter.filter{($0["QuotationCompanyName"] as! String) == Search_Customer.text}
            
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
        
        // Update Collection Quotation
        Search_DataQuo = Sort_Data(SortBy: DropDownSortBy_Choose, DataForSort: Data_Filter)
        self.Collection_Quo.reloadData()
        
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
            
            Data_Sort = Data_Sort.sorted{dateFormatter.date(from:$0["Date"] as! String)!.compare(dateFormatter.date(from:$1["Date"] as! String)!) == .orderedDescending }
            
        }
        
        
        
        return Data_Sort
    }
    
    
    //MARK: Func Search
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        // When Press Clear Text in SearchBar Hide Keyboard
        if (textSearched.count == 0) {
            searchBar.perform(#selector(UIResponder.resignFirstResponder), with: nil, afterDelay: 0.1)
        }
        
        Search_DataQuo = Data_Filter.filter{(($0["QuotationRecName"]!) as! String).prefix(textSearched.count) == textSearched}
        Collection_Quo.reloadData()
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        self.view.endEditing(true)
    }
    

    
}

// MARK: Extention
// CollectionView Delegate DataSource and didSelectItematRow
extension QuotationMonitorPageController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Search_DataQuo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentify, for: indexPath) as! Collectioncell_Quotation
        
        
        // Set Data in Collection
        let data = Search_DataQuo[indexPath.row]

        
        cell.ColorView = String(data["QuotationCompleted"]! as! Int)
        
        // Set Name ID Quotation
        cell.Lb_IDQuo.text = (data["QuotationRecName"] as! String)
        // Set Date
        let DateArr = (data["Date"]! as! String).components(separatedBy: "-")
        cell.Lb_Date.text = "Date : \(DateArr[0])/\(DateArr[1])/\(DateArr[2])"
        // Set Customer
        cell.Lb_Customer.text = "Customer : \(data["QuotationCompanyName"] as! String)"
        
        // Set By Seller
        cell.Lb_By.text = "By : \(data["QuotationSalesName"]!)"
        
        // Cal Discount and Vat for Sales
        var OverallSales : Double = 0
        if data["TotalSales"]! as? Double != nil {
            OverallSales = Double(data["TotalSales"]! as! Double)
        }
        let Vat = Double(OverallSales / 100) * Double(data["vat"]! as! Double)
        OverallSales = OverallSales + Vat
        
        // Set Sales of Quotation
        cell.Lb_Price.text = String(OverallSales).currencyFormatting() + " ฿"
        // Set Event Btn
        cell.btnTapAction = {
            () in
            
            let  NextPage = DetailQuotationController()
            NextPage.Data_Pass = data
            
            let navPage = UINavigationController(rootViewController: NextPage)
            
            
            navPage.modalPresentationStyle = .fullScreen
            self.present(navPage, animated: true, completion: nil)

        }
        
        return cell
        
    }
    
}

// UICollectionViewDelegateFlowLayout for Set Position, Margin, Space of cell
extension QuotationMonitorPageController : UICollectionViewDelegateFlowLayout {
    // UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 150)
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
// extension Tag ListView
extension QuotationMonitorPageController : TagListViewDelegate {
    
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

