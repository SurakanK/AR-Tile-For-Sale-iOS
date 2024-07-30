//
//  CustomerListViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 23/5/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import UIDropDown
import rubber_range_picker
import Alamofire
import NVActivityIndicatorView

class CustomerListViewController: UIViewController{
    
    let tokenID = LoginPageController.DataLogin?.Token_Id

    var searching = false
    let SearchController = UISearchController(searchResultsController: nil)
    
    var CellID = "Cell"
    weak var collectionView : UICollectionView?
    
    var DataCustomer = [[String : Any]]()
    var DataCustomerFilter = [[String : Any]]()
    var DataSortBy = [[String : Any]]()
    
    var CustomerType = [String]()
    var CustomerGrade = [String]()
    var CustomerOldANDNew = [Int]()
    var PriceRangeSlideReset = false
    
    var SearchBarButtonClear = false

    var MoveViewController = ""
    
    var EditStatus = false
    // ------------------------------------------------------------------
    // View Blur
    var view_Blur : UIView =  {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 0.7)
        view.alpha = 0
        return view
    }()
    // View of Loadinf
    var view_loader : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueLight
        return view
    }()
    // Loader Gift
    var Loader = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: .white, padding: 10)
    // ------------------------------------------------------------------
    
    //Element Header Control
    let viewHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    let ImageIconSortBy: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "sort").withTintColor(.BlueDeep)
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let labelTitleSortBy: UILabel = {
        let label = UILabel()
        label.text = "Sort By"
        label.font = UIFont.MitrMedium(size: 15)
        return label
    }()
    
    let DropDownSort: UIDropDown = {
        let DropDownSort = UIDropDown(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
        let DataSort = ["ลูกค้าทั้งหมด","ยอดขายมากที่สุด","ยอดขายน้อยที่สุด"]
        DropDownSort.font = "Mitr-Light"
        DropDownSort.fontSize = 16
        DropDownSort.layer.borderWidth = 0
        DropDownSort.placeholder = "ลูกค้าทั้งหมด"
        DropDownSort.options = DataSort
        DropDownSort.optionsFont = "Mitr-Light"
        DropDownSort.optionsSize = 16
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = 50
        DropDownSort.tableHeight = 50 * CGFloat(DataSort.count)
        
        return DropDownSort
    }()
    
    var LineSection : UIView = {
           let line = UIView()
           line.backgroundColor = UIColor.BlackAlpha(alpha: 0.5)
           return line
    }()
    
    var ImageIconFilter : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "filter").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let buttonFilter: UIButton = {
        let ratio = UIScreen.main.bounds.width / 375
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueDeep
        button.layer.cornerRadius = 5
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.MitrRegular(size: 15)
        button.addTarget(self, action: #selector(FilterHandle), for: .touchUpInside)
        return button
    }()
    
    //Element Filter Menu
    var viewBlurFilter : UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.7)
        view.alpha = 0
        return view
    }()
    
    var viewFilter : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 1
        return view
    }()
    
    lazy var LeftAnchorViewFilter = self.viewFilter.leftAnchor.constraint(equalToSystemSpacingAfter: self.view.leftAnchor, multiplier: self.view.frame.width)
    
    //Element Customer Type Filter Menu
    let labelCustomerTypetitle: UILabel = {
        let label = UILabel()
        label.text = "ประเภทลูกค้า"
        label.textColor = .black
        label.font = UIFont.MitrMedium(size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let buttonSelectGeneralCustomers: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("ลูกค้าทั่วไป", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(CustomerTypeSelect), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    let buttonSelectEngineer: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("วิศวกร", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(CustomerTypeSelect), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    let buttonSelectDesigner: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("สถาปนิก", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(CustomerTypeSelect), for: .touchUpInside)
        button.tag = 3
        return button
    }()
    
    let buttonSelectContractor: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("ผู้รับเหมา", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(CustomerTypeSelect), for: .touchUpInside)
        button.tag = 4
        return button
    }()
    
    let buttonSelectOwner: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("เจ้าของกิจการ", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(CustomerTypeSelect), for: .touchUpInside)
        button.tag = 5
        return button
    }()
    
    //Setting Customer Grade Filter Menu
    let labelGradeCustomerTitle: UILabel = {
        let label = UILabel()
        label.text = "ระดับลูกค้า"
        label.textColor = .black
        label.font = UIFont.MitrMedium(size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let buttonGrade_A: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("A", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 25)
        button.tag = 1
        button.addTarget(self, action: #selector(CustomerGradeSelect), for: .touchUpInside)
        return button
    }()
    
    let buttonGrade_B: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("B", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 25)
        button.tag = 2
        button.addTarget(self, action: #selector(CustomerGradeSelect), for: .touchUpInside)
        return button
    }()
    
    let buttonGrade_C: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("C", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 25)
        button.tag = 3
        button.addTarget(self, action: #selector(CustomerGradeSelect), for: .touchUpInside)
        return button
    }()
    
    //Element Customer history Filter Menu
    let labelCustomerHistoryTitle: UILabel = {
        let label = UILabel()
        label.text = "ประวัติลูกค้า"
        label.textColor = .black
        label.font = UIFont.MitrMedium(size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let buttonSelectOld: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("ลูกค้าเก่า", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(CustomerHistorySelect), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    let buttonSelectNew: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("ลูกค้าใหม่", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(CustomerHistorySelect), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    //Element Price range Filter Menu
    let labelCustomerPriceRangeTitle: UILabel = {
        let label = UILabel()
        label.text = "ยอดการซื้อขาย"
        label.textColor = .black
        label.font = UIFont.MitrMedium(size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let labelPriceRange: UILabel = {
        let label = UILabel()
        label.text = "Sales : 0฿ - 10000฿"
        label.textColor = .BlueDeep
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.MitrMedium(size: 20)
        label.numberOfLines = 1
        return label
    }()
    
    let PriceRangeSlider: RubberRangePicker = {
        let Slider = RubberRangePicker()
        Slider.thumbSize = 25
        Slider.tintColor = .BlueDeep
        Slider.minimumValue = 0
        Slider.maximumValue = 100
        Slider.lowerValue = Slider.minimumValue
        Slider.upperValue = Slider.maximumValue
        Slider.addTarget(self, action: #selector(PriceRangeSliderValueChanged), for: .valueChanged)
        Slider.addTarget(self, action: #selector(PriceRangeSliderTouchUp), for: .touchUpInside)
        Slider.addTarget(self, action: #selector(PriceRangeSliderTouchUp), for: .touchUpOutside)
        return Slider
    }()
    
    //Element Button Control Buttom Filter Menu
    let buttonReset: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.BlueDeep.cgColor
        button.layer.borderWidth = 2
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.BlueDeep, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        return button
    }()
    
    let buttonSubmit: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 5
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationSetting()
        SearchBarSetting()
        ElementSetting()
        collectionViewSetting()
        DropDownEvent()
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
        //function Data Customer Update 
        NotificationCenter.default.addObserver(self, selector: #selector(DataCustomerUpdate(notification:)), name: NSNotification.Name(rawValue: "DataCustomerUpdate"), object: nil)
        
        view.backgroundColor = .systemGray6

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard MoveViewController == "Admin" else {return}
        guard navigationItem.rightBarButtonItems!.count > 1 else {return}
        navigationItem.rightBarButtonItems?.removeFirst()
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        
        switch MoveViewController {
        case "Admin":
            getCustomerAdmin(token: tokenID!)
        case "SetupQuotation":
            getCustomerSale(token: tokenID!)
        default:
            print("Get Data from server error")
        }
        
    }
    
    @objc func DataCustomerUpdate(notification: NSNotification) {
        
        EditStatus = false
        navigationItem.rightBarButtonItems?.last?.title = "Edit"
        
        switch MoveViewController {
        case "Admin":
            getCustomerAdmin(token: tokenID!)
        case "SetupQuotation":
            getCustomerSale(token: tokenID!)
        default:
            print("Get Data from server error")
        }
        
    }
    
    func NavigationSetting(){
        
        navigationItem.title = "Customer List"
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItems = [add,edit]
        
        //let ConfirmNavigationButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddAccountSale))
        //navigationItem.rightBarButtonItem = ConfirmNavigationButton
       // navigationItem.rightBarButtonItem?.isEnabled = true
    
    }
    
    func SearchBarSetting(){
        
        //config cearch controller
        SearchController.searchResultsUpdater = self
        SearchController.searchBar.delegate = self
        SearchController.searchBar.searchBarStyle = .minimal
        SearchController.obscuresBackgroundDuringPresentation = false
        SearchController.searchBar.searchTextField.backgroundColor = .white
        SearchController.searchBar.tintColor = .white
        SearchController.searchBar.placeholder = "Search Customer"
        SearchController.searchBar.searchTextField.font = UIFont.MitrLight(size: 18)
        SearchController.searchBar.searchTextField.textColor = .BlackAlpha(alpha: 0.8)

        definesPresentationContext = true

        SearchController.searchBar.searchTextField.delegate = self

        // Add searchBar to navigationbar
        navigationItem.searchController = SearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false

        //Add Tap Dismiss KeyBoard SearchBar
        let tap = UITapGestureRecognizer(target: self, action: #selector(DismissKeyBoardSearchBar))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
        
    func collectionViewSetting(){
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = collection
        collectionView!.register(CustomerListViewCell.self, forCellWithReuseIdentifier: CellID)
        collectionView!.backgroundColor = .systemGray6
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
        view.addSubview(collectionView!)
        collectionView?.anchor(viewHeader.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        }
        
    func ElementSetting(){
            
        //Setting Element Header Control
        view.addSubview(viewHeader)
        viewHeader.addSubview(ImageIconSortBy)
        viewHeader.addSubview(labelTitleSortBy)
        view.addSubview(DropDownSort)
        viewHeader.addSubview(LineSection)
        viewHeader.addSubview(ImageIconFilter)
        viewHeader.addSubview(buttonFilter)

        collectionView?.layoutIfNeeded()
        viewHeader.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        ImageIconSortBy.anchor(nil, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        ImageIconSortBy.anchorCenter(nil, AxisY: viewHeader.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 20, heightConstant: 20)
        
        labelTitleSortBy.anchor(ImageIconSortBy.topAnchor, left: ImageIconSortBy.rightAnchor, bottom: ImageIconSortBy.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 0)
        
        DropDownSort.anchor(ImageIconSortBy.topAnchor, left: labelTitleSortBy.rightAnchor, bottom: ImageIconSortBy.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: DropDownSort.frame.width, heightConstant: 0)
        
        LineSection.anchor(viewHeader.topAnchor, left: DropDownSort.rightAnchor, bottom: viewHeader.bottomAnchor, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 0, widthConstant: 1, heightConstant: 0)
        
        ImageIconFilter.anchor(ImageIconSortBy.topAnchor, left: LineSection.rightAnchor, bottom: ImageIconSortBy.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 0)
        
        buttonFilter.anchor(LineSection.topAnchor, left: ImageIconFilter.rightAnchor, bottom: LineSection.bottomAnchor, right: viewHeader.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        //Setting Element Filter Menu
        view.addSubview(viewBlurFilter)
        view.addSubview(viewFilter)
        
        viewBlurFilter.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        viewFilter.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let tapFilter = UITapGestureRecognizer(target: self, action: #selector(DismissViewFilter))
        tapFilter.cancelsTouchesInView = false
        viewBlurFilter.addGestureRecognizer(tapFilter)
        
        //Setting Element Customer Type
        viewFilter.addSubview(labelCustomerTypetitle)
        viewFilter.addSubview(buttonSelectGeneralCustomers)
        viewFilter.addSubview(buttonSelectEngineer)
        viewFilter.addSubview(buttonSelectDesigner)
        viewFilter.addSubview(buttonSelectContractor)
        viewFilter.addSubview(buttonSelectOwner)
        
        LeftAnchorViewFilter.isActive = true
        
        labelCustomerTypetitle.anchor(viewFilter.topAnchor, left: viewFilter.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        buttonSelectGeneralCustomers.anchor(labelCustomerTypetitle.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 149, heightConstant: 40)
        
        buttonSelectEngineer.anchor(buttonSelectGeneralCustomers.topAnchor, left: buttonSelectGeneralCustomers.rightAnchor, bottom: buttonSelectGeneralCustomers.bottomAnchor, right: viewFilter.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        buttonSelectDesigner.anchor(buttonSelectGeneralCustomers.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 149, heightConstant: 40)
        
        buttonSelectContractor.anchor(buttonSelectDesigner.topAnchor, left: buttonSelectDesigner.rightAnchor, bottom: buttonSelectDesigner.bottomAnchor, right: viewFilter.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        buttonSelectOwner.anchor(buttonSelectDesigner.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 149, heightConstant: 40)
        
        //Setting Element Customer Grade Filter Menu
        viewFilter.addSubview(labelGradeCustomerTitle)
        viewFilter.addSubview(buttonGrade_A)
        viewFilter.addSubview(buttonGrade_B)
        viewFilter.addSubview(buttonGrade_C)
        
        labelGradeCustomerTitle.anchor(buttonSelectOwner.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        buttonGrade_A.anchor(labelGradeCustomerTitle.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        buttonGrade_B.anchor(buttonGrade_A.topAnchor, left: buttonGrade_A.rightAnchor, bottom: buttonGrade_A.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 0)

        buttonGrade_C.anchor(buttonGrade_A.topAnchor, left: buttonGrade_B.rightAnchor, bottom: buttonGrade_A.bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 0)

        //Setting Element Customer history Filter Menu
        viewFilter.addSubview(labelCustomerHistoryTitle)
        viewFilter.addSubview(buttonSelectOld)
        viewFilter.addSubview(buttonSelectNew)

        labelCustomerHistoryTitle.anchor(buttonGrade_A.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        buttonSelectOld.anchor(labelCustomerHistoryTitle.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 149, heightConstant: 40)
        
        buttonSelectNew.anchor(buttonSelectOld.topAnchor, left: buttonSelectOld.rightAnchor, bottom: buttonSelectOld.bottomAnchor, right: viewFilter.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        //Setting Element Price range Filter Menu
        viewFilter.addSubview(labelCustomerPriceRangeTitle)
        viewFilter.addSubview(PriceRangeSlider)
        viewFilter.addSubview(labelPriceRange)
        
        labelCustomerPriceRangeTitle.anchor(buttonSelectOld.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        labelPriceRange.anchor(labelCustomerPriceRangeTitle.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: viewFilter.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
    
        PriceRangeSlider.anchor(labelPriceRange.bottomAnchor, left: viewFilter.leftAnchor, bottom: nil, right: viewFilter.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 40, heightConstant: 0)
        
        //Setting Element Button Control Buttom Filter Menu
        viewFilter.addSubview(buttonReset)
        viewFilter.addSubview(buttonSubmit)

        buttonReset.anchor(nil, left: viewFilter.leftAnchor, bottom: viewFilter.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 149, heightConstant: 40)
        
        buttonSubmit.anchor(buttonReset.topAnchor, left: buttonReset.rightAnchor, bottom: buttonReset.bottomAnchor, right: viewFilter.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
    @objc func DismissKeyBoardSearchBar(){
        self.SearchController.searchBar.endEditing(true)
    }
    
    @objc func DismissViewFilter(){
        ShowFilterPage()
    }
    
    func ShowFilterPage(){
        
        view.endEditing(true)
        
        if viewBlurFilter.alpha == 0 { // Open Filter Page
            
            let widthViewFilter = self.view.frame.width / 4
            LeftAnchorViewFilter.constant = widthViewFilter * 0.5
            
            
            UIView.animate(withDuration: 0.5) {
                self.viewBlurFilter.alpha = 1
                self.view.layoutIfNeeded()
            }
            
        }else if viewBlurFilter.alpha == 1 { // Close  Filter Page
            
            LeftAnchorViewFilter.constant = view.frame.width
            
            UIView.animate(withDuration: 0.5) {
                // Change Alpha Blur Filter
                self.viewBlurFilter.alpha = 0
                
                self.view.layoutIfNeeded()
            }
            
        }
        
        
    }
    
    func DropDownEvent(){
        DropDownSort.didSelect { (Text, index) in
            self.DropDownSort.placeholder = Text
            
            switch Text {
            case "ยอดขายมากที่สุด":
                self.DataCustomerFilter = self.DataSortBy.sorted{($0["TotalSales"] as! Double) >= ($1["TotalSales"] as! Double)}
            case "ยอดขายน้อยที่สุด":
                self.DataCustomerFilter = self.DataSortBy.sorted{($0["TotalSales"] as! Double) <= ($1["TotalSales"] as! Double)}
            default:
                self.DataCustomerFilter = self.DataSortBy
            }
            self.collectionView?.reloadData()
        }
                
    }
    
    @objc func FilterHandle(){
        ShowFilterPage()
    }
    
    @objc func CustomerTypeSelect(Button: UIButton){
        
        switch Button.tag {
        case 1:
            
            if buttonSelectGeneralCustomers.backgroundColor == UIColor.BlueDeep{
                buttonSelectGeneralCustomers.backgroundColor = .white
                buttonSelectGeneralCustomers.setTitleColor(.BlueDeep, for: .normal)
                
                if let index = CustomerType.firstIndex(of: "General"){
                    CustomerType.remove(at: index)
                }
            }else{
                buttonSelectGeneralCustomers.backgroundColor = .BlueDeep
                buttonSelectGeneralCustomers.setTitleColor(.white, for: .normal)
                CustomerType.append("General")
            }
            
        case 2:
            
            if buttonSelectEngineer.backgroundColor == UIColor.BlueDeep{
                buttonSelectEngineer.backgroundColor = .white
                buttonSelectEngineer.setTitleColor(.BlueDeep, for: .normal)

                if let index = CustomerType.firstIndex(of: "Engineer"){
                      CustomerType.remove(at: index)
                }
            }else{
                buttonSelectEngineer.backgroundColor = .BlueDeep
                buttonSelectEngineer.setTitleColor(.white, for: .normal)
                CustomerType.append("Engineer")
            }
            
        case 3:
            
            if buttonSelectDesigner.backgroundColor == UIColor.BlueDeep{
                buttonSelectDesigner.backgroundColor = .white
                buttonSelectDesigner.setTitleColor(.BlueDeep, for: .normal)
                
                if let index = CustomerType.firstIndex(of: "Architect"){
                    CustomerType.remove(at: index)
                }
            }else{
                buttonSelectDesigner.backgroundColor = .BlueDeep
                buttonSelectDesigner.setTitleColor(.white, for: .normal)
                CustomerType.append("Architect")
            }
            
        case 4:
           
            if buttonSelectContractor.backgroundColor == UIColor.BlueDeep{
                buttonSelectContractor.backgroundColor = .white
                buttonSelectContractor.setTitleColor(.BlueDeep, for: .normal)
                
                if let index = CustomerType.firstIndex(of: "Contractor"){
                    CustomerType.remove(at: index)
                }
            }else{
                buttonSelectContractor.backgroundColor = .BlueDeep
                buttonSelectContractor.setTitleColor(.white, for: .normal)
                CustomerType.append("Contractor")
            }
          
        case 5:
           
            if buttonSelectOwner.backgroundColor == UIColor.BlueDeep{
                buttonSelectOwner.backgroundColor = .white
                buttonSelectOwner.setTitleColor(.BlueDeep, for: .normal)
                
                if let index = CustomerType.firstIndex(of: "Owner"){
                    CustomerType.remove(at: index)
                }
            }else{
                buttonSelectOwner.backgroundColor = .BlueDeep
                buttonSelectOwner.setTitleColor(.white, for: .normal)
                CustomerType.append("Owner")
            }
            
        default:
            print("CustomerTypeSelect")
        }

        print(CustomerType)
        
        //Filter Data Customer
        PriceRangeSlideReset = true
        ManageDataFilter()
    }
    
    @objc func CustomerGradeSelect(Button: UIButton){
        
        switch Button.tag {
        case 1:

            if buttonGrade_A.backgroundColor == UIColor.BlueDeep{
                buttonGrade_A.backgroundColor = .white
                buttonGrade_A.setTitleColor(.BlueDeep, for: .normal)
                
                if let index = CustomerGrade.firstIndex(of: "A"){
                    CustomerGrade.remove(at: index)
                }
            }else{
                buttonGrade_A.backgroundColor = .BlueDeep
                buttonGrade_A.setTitleColor(.white, for: .normal)
                CustomerGrade.append("A")
            }
            
        case 2:
            
            if buttonGrade_B.backgroundColor == UIColor.BlueDeep{
                buttonGrade_B.backgroundColor = .white
                buttonGrade_B.setTitleColor(.BlueDeep, for: .normal)
                
                if let index = CustomerGrade.firstIndex(of: "B"){
                    CustomerGrade.remove(at: index)
                }
            }else{
                buttonGrade_B.backgroundColor = .BlueDeep
                buttonGrade_B.setTitleColor(.white, for: .normal)
                CustomerGrade.append("B")
            }
           
        case 3:
            
            if buttonGrade_C.backgroundColor == UIColor.BlueDeep{
                buttonGrade_C.backgroundColor = .white
                buttonGrade_C.setTitleColor(.BlueDeep, for: .normal)
                
                if let index = CustomerGrade.firstIndex(of: "C"){
                    CustomerGrade.remove(at: index)
                }
            }else{
                buttonGrade_C.backgroundColor = .BlueDeep
                buttonGrade_C.setTitleColor(.white, for: .normal)
                CustomerGrade.append("C")
            }
            
        default:
            print("CustomerGradeSelect")
        }
        print(CustomerGrade)
        
        //Filter Data Customer
        PriceRangeSlideReset = true
        ManageDataFilter()
    }
    
    @objc func CustomerHistorySelect(Button: UIButton){
  
        switch Button.tag {
        case 1:
            
            if buttonSelectOld.backgroundColor == UIColor.BlueDeep{
                buttonSelectOld.backgroundColor = .white
                buttonSelectOld.setTitleColor(.BlueDeep, for: .normal)
                
                if let index = CustomerOldANDNew.firstIndex(of: 2){
                    CustomerOldANDNew.remove(at: index)
                }
            }else{
                buttonSelectOld.backgroundColor = .BlueDeep
                buttonSelectOld.setTitleColor(.white, for: .normal)
                CustomerOldANDNew.append(2)
            }
        
        case 2:
            
            if buttonSelectNew.backgroundColor == UIColor.BlueDeep{
                buttonSelectNew.backgroundColor = .white
                buttonSelectNew.setTitleColor(.BlueDeep, for: .normal)
                
                if let index = CustomerOldANDNew.firstIndex(of: 1){
                    CustomerOldANDNew.remove(at: index)
                }
             }else{
                buttonSelectNew.backgroundColor = .BlueDeep
                buttonSelectNew.setTitleColor(.white, for: .normal)
                CustomerOldANDNew.append(1)
             }
            
        default:
            print("CustomerHistorySelect")
        }
        print(CustomerOldANDNew)
        
        //Filter Data Customer
        PriceRangeSlideReset = true
        ManageDataFilter()
    }
    
    @objc func PriceRangeSliderValueChanged(){
        print(String(format:"Selected values: %.1f - %.1f", PriceRangeSlider.lowerValue, PriceRangeSlider.upperValue))
        
        labelPriceRange.text = "Sales : " + String(format: "%.1f", PriceRangeSlider.lowerValue) + "฿ - " + String(format: "%.1f", PriceRangeSlider.upperValue) + "฿"
    }
    
    @objc func PriceRangeSliderTouchUp(){
        ManageDataFilter()
    }
    
    @objc func addTapped(){
        let ViewController = AddNewCustomerViewController()
        ViewController.MoveViewController = "SaleAdd"
        navigationController?.pushViewController(ViewController, animated: true)
    }
        
    @objc func editTapped(sender: UIBarButtonItem){
        if EditStatus{
            
            sender.title = "Edit"
            EditStatus = false
            collectionView?.reloadData()
        }else{
            
            sender.title = "Done"
            EditStatus = true
            collectionView?.reloadData()
        }
    }
    
    func ManageDataFilter(){
        
        var TypeFilter = [[String : Any]]()
        var GradeFilter = [[String : Any]]()
        var OldAndNewFilter = [[String : Any]]()
        var PriceFilter = [[String : Any]]()
        
        
        DataCustomerFilter.removeAll()
        
        //find Data Customer Type
        if CustomerType.isEmpty == false{
            for i in 0..<CustomerType.count {
                let DataFilter = DataCustomer.filter{$0["CustomerType"] as! String == CustomerType[i]}
                TypeFilter.append(contentsOf: DataFilter)
            }
            DataCustomerFilter = TypeFilter
        }else{
            TypeFilter = DataCustomer
        }
        
        //find Data Customer Grade
        if CustomerGrade.isEmpty == false{
            for i in 0..<CustomerGrade.count {
                let DataFilter = TypeFilter.filter{$0["CustomerGrade"] as! String == CustomerGrade[i]}
                GradeFilter.append(contentsOf: DataFilter)
            }
            DataCustomerFilter = GradeFilter
        }else{
            GradeFilter = TypeFilter
        }
        
        //find Data Old - New customers
        if CustomerOldANDNew.isEmpty == false{
            for i in 0..<CustomerOldANDNew.count {
                
                if CustomerOldANDNew[i] == 1 {//find New customer
                    let DataFilter = GradeFilter.filter{$0["TotalQuotation"] as! Int == CustomerOldANDNew[i]}
                    OldAndNewFilter.append(contentsOf: DataFilter)
                }else{//old New customer
                    let DataFilter = GradeFilter.filter{$0["TotalQuotation"] as! Int >= CustomerOldANDNew[i]}
                    OldAndNewFilter.append(contentsOf: DataFilter)
                }
            }
            DataCustomerFilter = OldAndNewFilter
        }else{
            OldAndNewFilter = GradeFilter
        }
        
        //find Data Price Range Slider
        let MaxValue = OldAndNewFilter.reduce(0, { max($0, $1["TotalSales"] as! Double)})
        let MinValue = OldAndNewFilter.reduce(0, { min($0, $1["TotalSales"] as! Double)})
            
        if PriceRangeSlideReset == true{
            if MaxValue == 0 && MinValue == 0{
                PriceRangeSlider.maximumValue = 1
                PriceRangeSlider.minimumValue = 0
                PriceRangeSlider.upperValue = 1
                PriceRangeSlider.lowerValue = 0
                PriceRangeSlider.isEnabled = false
                
                labelPriceRange.text = "Sales : Data not found"
            }else{
                PriceRangeSlider.maximumValue = MaxValue
                PriceRangeSlider.minimumValue = MinValue
                PriceRangeSlider.upperValue = MaxValue
                PriceRangeSlider.lowerValue = MinValue
                PriceRangeSlider.isEnabled = true

                labelPriceRange.text = "Sales : " + String(format: "%.1f", PriceRangeSlider.lowerValue) + "฿ - " + String(format: "%.1f", PriceRangeSlider.upperValue) + "฿"
            }
            PriceRangeSlideReset = false
        }
        
        if PriceRangeSlider.lowerValue != PriceRangeSlider.minimumValue || PriceRangeSlider.upperValue != PriceRangeSlider.maximumValue{
            
            PriceFilter = OldAndNewFilter.filter{$0["TotalSales"] as! Double >= PriceRangeSlider.lowerValue && ($0["TotalSales"] as! Double) <= (PriceRangeSlider.upperValue)}
           
            DataCustomerFilter = PriceFilter
            DataSortBy = DataCustomerFilter
        }else{
            DataSortBy = DataCustomerFilter
        }
        
        
        //find Data All when no filter condition
        if CustomerType.isEmpty == true && CustomerGrade.isEmpty == true && CustomerOldANDNew.isEmpty == true && PriceRangeSlider.lowerValue == PriceRangeSlider.minimumValue && PriceRangeSlider.upperValue ==
            PriceRangeSlider.maximumValue{
            
            DataCustomerFilter = DataCustomer
            DataSortBy = DataCustomerFilter
        }

        
    }
    
    @objc func handleReset(){
        //Reset data filter
        CustomerType.removeAll()
        CustomerGrade.removeAll()
        CustomerOldANDNew.removeAll()
        
        //Reset button Customers type filter
        buttonSelectGeneralCustomers.backgroundColor = .white
        buttonSelectEngineer.backgroundColor = .white
        buttonSelectDesigner.backgroundColor = .white
        buttonSelectOwner.backgroundColor = .white
        buttonSelectContractor.backgroundColor = .white
        
        buttonSelectGeneralCustomers.setTitleColor(.BlueDeep, for: .normal)
        buttonSelectEngineer.setTitleColor(.BlueDeep, for: .normal)
        buttonSelectDesigner.setTitleColor(.BlueDeep, for: .normal)
        buttonSelectOwner.setTitleColor(.BlueDeep, for: .normal)
        buttonSelectContractor.setTitleColor(.BlueDeep, for: .normal)
       
        //Reset button Customers Grade filter
        buttonGrade_A.backgroundColor = .white
        buttonGrade_B.backgroundColor = .white
        buttonGrade_C.backgroundColor = .white
        
        buttonGrade_A.setTitleColor(.BlueDeep, for: .normal)
        buttonGrade_B.setTitleColor(.BlueDeep, for: .normal)
        buttonGrade_C.setTitleColor(.BlueDeep, for: .normal)

        //Reset button Customers old and new filter
        buttonSelectNew.backgroundColor = .white
        buttonSelectOld.backgroundColor = .white
        
        buttonSelectNew.setTitleColor(.BlueDeep, for: .normal)
        buttonSelectOld.setTitleColor(.BlueDeep, for: .normal)
        
        PriceRangeSlideReset = true
        ManageDataFilter()
    }
    
    // handle Submi condition filter
     @objc func handleSubmit(){
                
        collectionView?.reloadData()
         
        //close Filter Page
        ShowFilterPage()
     }
    
    //Request Data from Server
    func getCustomerAdmin(token:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminGetCustomer()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.DataCustomer = JSON!["results"] as! [[String : Any]]
                    self.DataCustomerFilter = self.DataCustomer

                    for count in 0..<self.DataCustomer.count{
                        if self.DataCustomer[count]["TotalSales"] as? Double == nil {
                            self.DataCustomer[count]["TotalSales"] = Double(0)
                        }
                    }
                    
                    self.PriceRangeSlideReset = true
                    self.ManageDataFilter()
                    
                    self.collectionView?.reloadData()
                    
                    // Close loader
                    self.Show_Loader()
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func getCustomerSale(token:String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_saleGetCustomer()
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.DataCustomer = JSON!["results"] as! [[String : Any]]
                    self.DataCustomerFilter = self.DataCustomer

                    for count in 0..<self.DataCustomer.count{
                        if self.DataCustomer[count]["TotalSales"] as? Double == nil {
                            self.DataCustomer[count]["TotalSales"] = Double(0)
                        }
                    }
                    
                    self.PriceRangeSlideReset = true
                    self.ManageDataFilter()
                    
                    self.collectionView?.reloadData()
                    
                    // Close loader
                    self.Show_Loader()
                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
        })
    }
    
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func AnimationViewLoadAnchor(){
        
        // ratio
        let ratio = self.view.frame.width / 375.0
        
        // View Loader -----------------------------------------------
        view.addSubview(view_Blur)
        view_Blur.anchor(view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        // view loader -----------------------------------------------
        view_Blur.addSubview(view_loader)
        view_loader.anchorCenter(view_Blur.centerXAnchor, AxisY: view_Blur.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        view_loader.layer.cornerRadius = 20 * ratio
        
        // Loader -----------------------------------------------
        view_loader.addSubview(Loader)
        Loader.anchor(view_loader.topAnchor, left: view_loader.leftAnchor, bottom: view_loader.bottomAnchor, right: view_loader.rightAnchor, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 5 * ratio, rightConstant: 5 * ratio, widthConstant: 90 * ratio, heightConstant: 90 * ratio)
    }
    
    // Func Show Loader
    func Show_Loader() {
        
        if view_Blur.alpha == 0 {
            UIView.animate(withDuration: 0.5) {
                self.view_Blur.alpha = 1
                self.Loader.startAnimating()
            }
        }
        else {
            UIView.animate(withDuration: 0.5) {
                self.view_Blur.alpha = 0
                self.Loader.stopAnimating()
            }
        }
        
    }
    
}

extension CustomerListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataCustomerFilter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! CustomerListViewCell
        
        let DataIndex = DataCustomerFilter[indexPath.row]
        let CompanyName = DataIndex["CustomerCompanyName"] as? String
        let CustomerType = DataIndex["CustomerType"] as? String
        let ContactName = DataIndex["CustomerContactName"] as? String
        let ContactTel = DataIndex["CustomerContactTel"] as? String
        let Grade = DataIndex["CustomerGrade"] as? String
        
        
        cell.labelCompanyName.text = CompanyName
        cell.labelTypeCompany.text = "ประเภท : " + ConvertCustomerType(type: CustomerType!)
        cell.labelContactPersonCompany.text = "ชื่อผู้ติดต่อ : " + ContactName!
        cell.labelPhoneContactPersonCompany.text = "หมายเลขโทรศัพท์ : " + ContactTel!
        
        cell.labelGradeCustomer.text = Grade
        cell.labelGradeCustomer.backgroundColor = ManageCustomerGrades(Grades: Grade!)
        
        if EditStatus{
            cell.IconimageViewEditCustomer.isHidden = false
        }else{
            cell.IconimageViewEditCustomer.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch MoveViewController {
        case "Admin":
            
            if EditStatus{
                let viewController = AddNewCustomerViewController()
                viewController.MoveViewController = MoveViewController
                viewController.DataCustomerDetail = DataCustomerFilter[indexPath.row]
                navigationController?.pushViewController(viewController, animated: true)
                
            }else{
                let viewController = DetailCustomerViewController()
                viewController.DataCustomerDetail = DataCustomerFilter[indexPath.row]
                navigationController?.pushViewController(viewController, animated: true)
            }
            
        case "SetupQuotation":
            
            if EditStatus{
                let viewController = AddNewCustomerViewController()
                viewController.MoveViewController = "SaleEdit"
                viewController.DataCustomerDetail = DataCustomerFilter[indexPath.row]
                navigationController?.pushViewController(viewController, animated: true)
                
            }else{
                //send data to SetupQuotationViewController page and manage data customer
                SetupQuotationViewController.DataCustomerDetail = DataCustomerFilter[indexPath.row]
                NotificationCenter.default.post(name: NSNotification.Name("SetupQuotaDataCustomerUpdate"), object: nil)
                self.navigationController?.popViewController(animated: true)                
            }

        default:
            print("CustomerListViewController collectionView error")
        }
        
        
    }
    
    func ConvertCustomerType(type : String) -> String{
        switch type {
        case "Engineer":
            return "วิศวกร"
        case "Owner":
            return "เจ้าของกิจการ"
        case "Architect":
            return "สถาปนิก"
        case "Contractor":
            return "ผู้รับเหมา"
        case "General":
            return "ลูกค้าทั่วไป"
        default:
            return "Error"
        }
    }
    
    func ManageCustomerGrades(Grades : String) -> UIColor {
        switch Grades {
        case "A":
            return .systemYellow
        case "B":
            return .BlueDeep
        case "C":
            return .systemRed
        default:
            return .black
        }
    }
}

extension CustomerListViewController: UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
          let itemWidth: CGFloat = (UIScreen.main.bounds.width - 20)
          return CGSize(width: itemWidth, height: 150)
       }
      
      func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
          
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
      }
      
      func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          
          return 10
      }
     
}

extension CustomerListViewController: UISearchBarDelegate , UISearchResultsUpdating , UITextFieldDelegate{
        
    func updateSearchResults(for searchController: UISearchController) {
           
        let searchText = searchController.searchBar.text
        
        if searchText!.count > 0{
           
            DataCustomerFilter = DataSortBy.filter{($0["CustomerCompanyName"] as! String).lowercased().prefix(searchText!.lowercased().count) == searchText!.lowercased()}
                            
            searching = true
            collectionView?.reloadData()
        }else{
            searching = false
            DataCustomerFilter = DataSortBy
            collectionView?.reloadData()
        }
        
        if SearchBarButtonClear == true{
            
            //searchController.searchBar.searchTextField.endEditing(true)
            SearchBarButtonClear = false
            
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        SearchBarButtonClear = true
        return true
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

