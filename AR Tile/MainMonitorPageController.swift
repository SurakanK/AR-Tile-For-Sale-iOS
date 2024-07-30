//
//  MainMonitorPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 7/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import TTSegmentedControl
import Charts
import Alamofire
import SkeletonView

private let reuseIdentify = "Tabelcell_TopProduct"

class MainMonitorPageController : UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Parameter of Page
    
    // Data of Date Filter
    var MonthData : [String] = []
    var YearData : [String] = []
    var TypeDate : String = "Month"
    
    // Parameter URl
    var url : String = DataSource.Url_GetSummary() //"http://\(DataSource.IP())/arforsales/getsummary.php"
    
    // Parameter DataCenter
    static var SumSales : Float = 0
    static var SumQuo : Int = 0
    static var DataSetDate : [String] = []
    static var DataSetSales : [Double] = []
    static var DataSetQuo : [Int] = []
    
    var DataTopPro = [[String : Any]]()
    static var DataSeller : [[String : Any]] = []
    static var DataQuo = [[String : Any]]()
    
    // MARK: Element of Page
    // Image BG
    var Im_BG : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "TileBG1")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.alpha = 1
        return image
    }()
    // --------------------------------------------------------
    
    // View Blur
    var BGBlur : UIVisualEffectView = {
        let Blur = UIVisualEffectView(frame: UIScreen.main.bounds)
        let BlurEffect = UIBlurEffect(style: .light)
        Blur.effect = BlurEffect
        Blur.alpha = 0.7
        
        return Blur
    }()
    // --------------------------------------------------------
    
    // UiScrollView
    var ScrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // --------------------------------------------------------
    
    // View Date Filter
    var ViewDateFilter : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    // ------------------------
    // View Blur Date Filter
    var ViewBlur_DateFilter : UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.7)
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // ------------------------
    // Label Header Date Filter
    var Lb_HeaderDateFilter : UILabel = {
        let label = UILabel()
        label.text = "Filter Monitor Duration"
        label.font = UIFont.PoppinsBold(size: 18)
        label.textAlignment = .center
        label.textColor = .BlackAlpha(alpha: 0.8)
        return label
    }()
    // ------------------------
    // Button Close Date Filter
    var Btn_CloseDateFilter : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemRed
        
        button.addTarget(self, action: #selector(Event_CloseDateFilter), for: .touchUpInside)
        return button
    }()
    // ------------------------
    // Button Segment
    var Seg_TimeMonitor : TTSegmentedControl = {
        let button = TTSegmentedControl()
        button.defaultTextFont = UIFont.PoppinsRegular(size: 15)
        button.defaultTextColor = .BlackAlpha(alpha: 0.8)
        
        button.allowChangeThumbWidth = true

        button.selectedTextFont = UIFont.PoppinsMedium(size: 15)
        button.selectedTextColor = .whiteAlpha(alpha: 0.8)
        
        button.thumbGradientColors = [.BlueDeep, .BlueDeep]
        button.itemTitles = ["Month", "Year"]
        button.useShadow = true
        
        return button
    }()
    // ------------------------
    
    // label Header Pick Start
    var Lb_PickStart : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 15)
        label.textColor = .BlackAlpha(alpha: 0.8)
        return label
    }()
    // ------------------------
    // Picker Start
    var Picker_Start : UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    // ------------------------
    // label Header Pick End
    var Lb_PickEnd : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 15)
        label.textColor = .BlackAlpha(alpha: 0.8)
        return label
    }()
    // ------------------------
    // Picker End
    var Picker_End : UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    // ------------------------
    // Button Submit Date Filter
    var Btn_SubmitDate : UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.PoppinsMedium(size: 18)
        button.backgroundColor = UIColor.BlueDeep
        button.layer.cornerRadius = button.frame.height / 2
        
        button.addTarget(self, action: #selector(Event_SubmitFilter), for: .touchUpInside)
        return button
    }()
    
    // ------------------------
    // --------------------------------------------------------
    
    // UIView Monitor 1
    var ViewMonitor_1 : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // ------------------------
    // View Show Date
    var ViewDate : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // ------------------------
    // Icon Date
    var Im_Date : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "schedule")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        
        return image
    }()
    // ------------------------
    // Label Show Date
    var Lb_Date : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .BlackAlpha(alpha: 0.9)
        
        return label
    }()
    
    // ------------------------
    // Button Filer Date
    var Btn_FilterDate : UIButton = {
        let button = UIButton()
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(UIColor.whiteAlpha(alpha: 0.9), for: .normal)
        button.titleLabel?.font = UIFont.PoppinsMedium(size: 15)
        
        button.backgroundColor = .BlueDeep
        /*button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.5*/
        
        button.addTarget(self, action: #selector(Event_FilterClick), for: .touchUpInside)
        
        
        return button
    }()
    
    // --------------------------------------------------------
    
    // UIView Monitor 1
    var ViewMonitor_2 : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    // ------------------------
    
    // Icon Sale
    var Icon_Sales : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "baht")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    // ------------------------
    
    // Label Sales of Time
    var Lb_SalesTime : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 25)
        label.text = "Overall Sales"
        label.textColor = .white
        return label
    }()
    // ------------------------
    
    // Label Money Sales
    var Lb_MoneySales : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsBold(size: 35)
        label.text = "1,000,000฿"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textColor = .white
        return label
    }()
    // ------------------------
    // --------------------------------------------------------
    
    // UIView Monitor 3
    var ViewMonitor_3 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // ------------------------
    // Icon Bar Chart
    var Icon_BarChart : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "sales")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    // ------------------------
    // Label of Bar Chart
    var Lb_HeaderChart : UILabel = {
        let label = UILabel()
        label.text = "Overall Sales Chart"
        label.textColor = .BlackAlpha(alpha: 1)
        label.font = UIFont.PoppinsBold(size: 20)
        return label
    }()
    // ------------------------
    // Bar Chart Show Overall Sales
    var BarChart_Sales : BarChartView = {
        let chart = BarChartView()
        chart.legend.font = UIFont.PoppinsRegular(size: 10)
        chart.legend.textColor = .BlackAlpha(alpha: 0.8)
        chart.rightAxis.enabled = false
        chart.backgroundColor = .clear
        
        // Set X Axis
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelRotationAngle = 80
        chart.xAxis.labelFont = UIFont.PoppinsRegular(size: 7)
        chart.xAxis.gridColor = .clear
        chart.xAxis.xOffset = 10
        
        // Set Y Axis
        chart.leftAxis.gridColor = .clear
        chart.leftAxis.labelFont = UIFont.PoppinsRegular(size: 7)
    
       
        
        chart.animate(xAxisDuration: 2)
        chart.animate(yAxisDuration: 2)
        
        return chart
    }()
    
    // --------------------------------------------------------
    
    // View Monitor 4
    var ViewMonitor_4 : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // ------------------------
    
    // Icon_Quotation
    var Icon_Quotation : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "clipboard")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    // ------------------------
    
    // Label Header Quotation
    var Lb_HeaderQuotation : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 25)
        label.text = "Overall Quotation"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textColor = .white
        return label
    }()
    // ------------------------
    // Label Quantity Quotation
    var Lb_QuantityQuotation : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 35)
        label.text = "100 Report"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    // --------------------------------------------------------
    
    // View Monitor 5
    var ViewMonitor_5 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    // ------------------------
    // Icon Top Product
    var Icon_TopPro : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "new-product")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    // ------------------------
    // Label Header Top Product
    var Lb_HeaderTopPro : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsBold(size: 20)
        label.text = "Top Product"
        label.textColor = .BlackAlpha(alpha: 0.8)
        return label
    }()
    // ------------------------
    // Label Column Name Product
    var View_NamePro : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    var Lb_Co_NamePro : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 15)
        label.text = "Name Product"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // ------------------------
    // Label Column Quantity Product
    var View_QuanPro : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    var Lb_Co_QuanPro : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 15)
        label.text = "QYT"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // ------------------------
    // Label Column Sales Product
    var View_SalesPro : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    var Lb_Co_SalesPro : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 15)
        label.text = "Total"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // ------------------------
    // TableView Top Product
    var TableView_TopPro : UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        //table.separatorStyle = .none
        table.alwaysBounceVertical = false
        return table
    }()
    // --------------------------------------------------------
    
    
    func Layout_Page(){

        let ratio : CGFloat = view.frame.width / 375.0
        let ratio_H : CGFloat = view.frame.height / 812.0
        
        // View
        //view.insertSubview(BGBlur, at: 1)
        view.backgroundColor = .systemGray6
    
        // --------------------------------
        
        // IMage BG
        /*view.insertSubview(Im_BG, at: 0)
        
        Im_BG.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)*/
        // --------------------------------
        
        // Scroll View
        self.view.addSubview(ScrollView)
        ScrollView.contentOffset.x = 0
        
        ScrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // --------------------------------
        // Stack View Monitor
        let StackView_Monitor = UIStackView(arrangedSubviews: [ViewMonitor_1, ViewMonitor_2, ViewMonitor_3, ViewMonitor_4, ViewMonitor_5])
        ScrollView.addSubview(StackView_Monitor)
        
        StackView_Monitor.axis = .vertical
        StackView_Monitor.distribution = .fill
        StackView_Monitor.spacing = 10
        
        StackView_Monitor.anchor(ScrollView.topAnchor, left: ScrollView.leftAnchor, bottom: ScrollView.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: view.bounds.width, heightConstant: 0)
        
        // --------------------------------
        
        // ViewMonitor_1
        // View Date
        ViewMonitor_1.addSubview(ViewDate)
        ViewDate.anchor(ViewMonitor_1.topAnchor, left: ViewMonitor_1.leftAnchor, bottom: ViewMonitor_1.bottomAnchor, right: ViewMonitor_1.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
        
        ViewDate.layer.cornerRadius = (40 * ratio) / 2
        
        // Icon Date
        ViewDate.addSubview(Im_Date)
        
        Im_Date.anchorCenter(nil, AxisY: ViewDate.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Im_Date.anchor(nil, left: ViewDate.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
        
        // Button Filter Date
        ViewDate.addSubview(Btn_FilterDate)
        
        Btn_FilterDate.anchor(ViewDate.topAnchor, left: nil, bottom: ViewDate.bottomAnchor, right: ViewDate.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100 * ratio, heightConstant: 40 * ratio)
        
        Btn_FilterDate.titleLabel?.font = UIFont.PoppinsMedium(size: 18 * ratio)
        Btn_FilterDate.layer.cornerRadius = (40 * ratio) / 2
        
        // Label Date
        ViewDate.addSubview(Lb_Date)
        
        Lb_Date.anchorCenter(nil, AxisY: ViewDate.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Date.anchor(nil, left: Im_Date.rightAnchor, bottom: nil, right: Btn_FilterDate.leftAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_Date.font = UIFont.PoppinsMedium(size: 18 * ratio)
        
        // --------------------------------
        
        // ViewMonitor_2
        ViewMonitor_2.layer.cornerRadius = 10 * ratio
        // Icon Sales
        ViewMonitor_2.addSubview(Icon_Sales)
        
        Icon_Sales.anchor(ViewMonitor_2.topAnchor, left: ViewMonitor_2.leftAnchor, bottom: ViewMonitor_2.bottomAnchor, right: nil, topConstant: 15 * ratio_H, leftConstant: 10 * ratio, bottomConstant: 15 * ratio_H, rightConstant: 0, widthConstant: 90 * ratio, heightConstant: 90 * ratio)
        
        // Label Sales follow Time
        ViewMonitor_2.addSubview(Lb_SalesTime)
        
        Lb_SalesTime.anchor(Icon_Sales.topAnchor, left: Icon_Sales.rightAnchor, bottom: nil, right: ViewMonitor_2.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_SalesTime.font = UIFont.PoppinsBold(size: 25 * ratio)
        
        // Label Money Sales
        ViewMonitor_2.addSubview(Lb_MoneySales)
        
        Lb_MoneySales.anchor(Lb_SalesTime.bottomAnchor, left: Lb_SalesTime.leftAnchor, bottom: Icon_Sales.bottomAnchor, right: Lb_SalesTime.rightAnchor, topConstant: 5 * ratio_H, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_MoneySales.font = UIFont.PoppinsBold(size: 35 * ratio)
        // --------------------------------
        
        // ViewMonitor_3
        ViewMonitor_3.layer.cornerRadius = 10 * ratio
        
        // Icon Header Chart
        ViewMonitor_3.addSubview(Icon_BarChart)
        
        Icon_BarChart.anchor(ViewMonitor_3.topAnchor, left: ViewMonitor_3.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio_H, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
        
        // Label Header Chart
        ViewMonitor_3.addSubview(Lb_HeaderChart)
        
        Lb_HeaderChart.anchor(nil, left: Icon_BarChart.rightAnchor, bottom: Icon_BarChart.bottomAnchor, right: ViewMonitor_3.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 20 * ratio)
        
        Lb_HeaderChart.font = UIFont.PoppinsBold(size: 20 * ratio)
        
        // Chart Overall Sales
        ViewMonitor_3.addSubview(BarChart_Sales)
        
        BarChart_Sales.anchor(Icon_BarChart.bottomAnchor, left: Icon_BarChart.leftAnchor, bottom: ViewMonitor_3.bottomAnchor, right: Lb_HeaderChart.rightAnchor, topConstant: 20 * ratio_H, leftConstant: 0, bottomConstant: 15 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 300 * ratio)
        
        // --------------------------------
        
        // View Monitor 4
        ViewMonitor_4.layer.cornerRadius = 10 * ratio
        // Icon Quotation
        ViewMonitor_4.addSubview(Icon_Quotation)
        
        Icon_Quotation.anchor(ViewMonitor_4.topAnchor, left: ViewMonitor_4.leftAnchor, bottom: ViewMonitor_4.bottomAnchor, right: nil, topConstant: 15 * ratio_H, leftConstant: 10 * ratio, bottomConstant: 15 * ratio_H, rightConstant: 0, widthConstant: 90 * ratio, heightConstant: 90 * ratio)
        
        // Label Header Quotation
        ViewMonitor_4.addSubview(Lb_HeaderQuotation)
        
        Lb_HeaderQuotation.anchor(Icon_Quotation.topAnchor, left: Icon_Quotation.rightAnchor, bottom: nil, right: ViewMonitor_4.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_HeaderQuotation.font = UIFont.PoppinsBold(size: 25 * ratio)
        
        // Label Quantity Quotation
        ViewMonitor_4.addSubview(Lb_QuantityQuotation)
        
        Lb_QuantityQuotation.anchor(Lb_HeaderQuotation.bottomAnchor, left: Lb_HeaderQuotation.leftAnchor, bottom: Icon_Quotation.bottomAnchor, right: Lb_HeaderQuotation.rightAnchor, topConstant: 5 * ratio_H, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_QuantityQuotation.font = UIFont.PoppinsBold(size: 35 * ratio)
        // --------------------------------
        
        // View Monitor 5
        ViewMonitor_5.layer.cornerRadius = 10 * ratio
        // Icon Header Top Product
        ViewMonitor_5.addSubview(Icon_TopPro)
        
        Icon_TopPro.anchor(ViewMonitor_5.topAnchor, left: ViewMonitor_5.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio_H, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
        
        // Label Header Top Product
        ViewMonitor_5.addSubview(Lb_HeaderTopPro)
        
        Lb_HeaderTopPro.anchor(nil, left: Icon_TopPro.rightAnchor, bottom: Icon_TopPro.bottomAnchor, right: ViewMonitor_5.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 20 * ratio)
        
        Lb_HeaderTopPro.font = UIFont.PoppinsBold(size: 20 * ratio)
        
        // Set View Label Column Top Product
        let width_view = (view.frame.width - (40 * ratio)) / 5 // Devide 5 part for (NamePro = 3, QuanPro = 1, SalesPro = 1 )
        // View Column Name Pro
        ViewMonitor_5.addSubview(View_NamePro)
        
        View_NamePro.anchor(Icon_TopPro.bottomAnchor, left: Icon_TopPro.leftAnchor, bottom: nil, right: nil, topConstant: 30 * ratio, leftConstant: 0 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: width_view * 2.5, heightConstant: 40 * ratio)
        
        View_NamePro.addSubview(Lb_Co_NamePro)
        Lb_Co_NamePro.anchorCenter(nil, AxisY: View_NamePro.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_NamePro.anchor(nil, left: View_NamePro.leftAnchor, bottom: nil, right: View_NamePro.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Co_NamePro.font = UIFont.PoppinsMedium(size: 13 * ratio)
        
        // View Quantity Product
        ViewMonitor_5.addSubview(View_QuanPro)
        
        View_QuanPro.anchor(View_NamePro.topAnchor, left: View_NamePro.rightAnchor, bottom: View_NamePro.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width_view, heightConstant: 40 * ratio)
        
        View_QuanPro.addSubview(Lb_Co_QuanPro)
        Lb_Co_QuanPro.anchorCenter(nil, AxisY: View_QuanPro.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_QuanPro.anchor(nil, left: View_QuanPro.leftAnchor, bottom: nil, right: View_QuanPro.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Co_QuanPro.font = UIFont.PoppinsMedium(size: 13 * ratio)
        
        // View Total Sales Product
        ViewMonitor_5.addSubview(View_SalesPro)
        
        View_SalesPro.anchor(View_QuanPro.topAnchor, left: View_QuanPro.rightAnchor, bottom: View_QuanPro.bottomAnchor, right: ViewMonitor_5.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: width_view * 1.5, heightConstant: 40 * ratio)
        
        View_SalesPro.addSubview(Lb_Co_SalesPro)
        Lb_Co_SalesPro.anchorCenter(nil, AxisY: View_SalesPro.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_SalesPro.anchor(nil, left: View_SalesPro.leftAnchor, bottom: nil, right: View_SalesPro.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Co_SalesPro.font = UIFont.PoppinsMedium(size: 13)
        
        // TableView Top Product
        ViewMonitor_5.addSubview(TableView_TopPro)
        
        TableView_TopPro.anchor(View_NamePro.bottomAnchor, left: View_NamePro.leftAnchor, bottom: ViewMonitor_5.bottomAnchor, right: View_SalesPro.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10 * ratio_H, rightConstant: 0, widthConstant: 0, heightConstant: (70 * ratio) * 3)
        
        // --------------------------------
        
        // Overall View Date Filter
        // View Blur Date Filter
        view.addSubview(ViewBlur_DateFilter)
        
        ViewBlur_DateFilter.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        ViewBlur_DateFilter.alpha = 0.0
        
        // View Date Filter
        view.addSubview(ViewDateFilter)
        
        ViewDateFilter.anchorCenter(ViewBlur_DateFilter.centerXAnchor, AxisY: ViewBlur_DateFilter.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 300 * ratio, heightConstant: 0)
        
        ViewDateFilter.alpha = 0.0
        ViewDateFilter.layer.cornerRadius = 10 * ratio
        
        // Button Close Date Filter
        ViewDateFilter.addSubview(Btn_CloseDateFilter)
        
        Btn_CloseDateFilter.anchor(ViewDateFilter.topAnchor, left: nil, bottom: nil, right: ViewDateFilter.rightAnchor, topConstant: 10 * ratio_H, leftConstant: 0, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 20 * ratio, heightConstant: 20 * ratio)
        
        // Label Header Date Filter
        ViewDateFilter.addSubview(Lb_HeaderDateFilter)
        
        Lb_HeaderDateFilter.anchor(Btn_CloseDateFilter.centerYAnchor, left: ViewDateFilter.leftAnchor, bottom: nil, right: ViewDateFilter.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_HeaderDateFilter.font = UIFont.PoppinsMedium(size: 18 * ratio)
        
        // Segment Button Choose Time Monitor
        ViewDateFilter.addSubview(Seg_TimeMonitor)
        
        Seg_TimeMonitor.anchor(Lb_HeaderDateFilter.bottomAnchor, left: Lb_HeaderDateFilter.leftAnchor, bottom: nil, right: Lb_HeaderDateFilter.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30 * ratio)
        
        Seg_TimeMonitor.defaultTextFont = UIFont.PoppinsRegular(size: 15 * ratio)
        Seg_TimeMonitor.selectedTextFont = UIFont.PoppinsMedium(size: 15 * ratio)
        
        // Add Target Segment Control
        Seg_TimeMonitor.didSelectItemWith = { (Index,text) -> () in
            self.Seg_ValueDidChange(index: Index)
            self.TypeDate = text!
            // reload UIPickView
            self.Picker_Start.reloadAllComponents()
            self.Picker_End.reloadAllComponents()
        }
        
        // Label Header Pick Start
        ViewDateFilter.addSubview(Lb_PickStart)
        
        Lb_PickStart.anchor(Seg_TimeMonitor.bottomAnchor, left: Lb_HeaderDateFilter.leftAnchor, bottom: nil, right: nil, topConstant: 20 * ratio_H, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_PickStart.font = UIFont.PoppinsRegular(size: 15 * ratio)
        Lb_PickStart.text = "Start (MM/YYYY) :"
        
        // Picker Start
        ViewDateFilter.addSubview(Picker_Start)
        
        Picker_Start.anchor(Lb_PickStart.bottomAnchor, left: Lb_HeaderDateFilter.leftAnchor, bottom: nil, right: Lb_HeaderDateFilter.rightAnchor, topConstant: 5 * ratio_H, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 70 * ratio_H)
        
        // Label Header Pick Start
        ViewDateFilter.addSubview(Lb_PickEnd)
               
        Lb_PickEnd.anchor(Picker_Start.bottomAnchor, left: Lb_HeaderDateFilter.leftAnchor, bottom: nil, right: nil, topConstant: 5 * ratio_H, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
               
        Lb_PickEnd.font = UIFont.PoppinsRegular(size: 15 * ratio)
        Lb_PickEnd.text = "To (MM/YYYY) :"
               
        // Picker Start
        ViewDateFilter.addSubview(Picker_End)
               
        Picker_End.anchor(Lb_PickEnd.bottomAnchor, left: Lb_HeaderDateFilter.leftAnchor, bottom: nil, right: Lb_HeaderDateFilter.rightAnchor, topConstant: 5 * ratio_H, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 70 * ratio_H)
        
        // Button Submit
        ViewDateFilter.addSubview(Btn_SubmitDate)
        
        Btn_SubmitDate.anchor(Picker_End.bottomAnchor, left: Lb_HeaderDateFilter.leftAnchor, bottom: ViewDateFilter.bottomAnchor, right: Lb_HeaderDateFilter.rightAnchor, topConstant: 10 * ratio_H, leftConstant: 30 * ratio, bottomConstant: 10 * ratio_H, rightConstant: 30 * ratio, widthConstant: 0, heightConstant: 50 * ratio_H)
        
        Btn_SubmitDate.titleLabel?.font = UIFont.PoppinsMedium(size: 18 * ratio)
        Btn_SubmitDate.layer.cornerRadius = (50 * ratio_H) / 2
        
        // --------------------------------
        
        // Config ContentSize of Scroll View
        ScrollView.contentSize = StackView_Monitor.bounds.size
        
    }
    
    // Func Config Element in Page
    func Config_Element(){
        // Config ScrollView
        ScrollView.delegate = self
        
        // Config Data Month and Year
        for count in 1...12 {
            var Month = String(count)
            if Month.count == 1 {
                Month = "0" + Month
            }
            MonthData.append(Month)
        }
        for count in 0...19 {
            let CurrentYear = 2015
            YearData.append(String(CurrentYear + count))
        }
        
        // Request Date Monitor Initial last 3 Month
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM-yyyy"
        formatter.calendar = Calendar(identifier: .gregorian)
        let DateStart = "2019-01"//formatter.string(from: date.endOfMonth(value: -3))
        let DateEnd = "2020-01"//formatter.string(from: date.startOfMonth())
        // Request Data to Server
        RequestData_Server(Url: url, MonitorStart: DateStart, MonitorEnd: DateEnd, MonitorType: "Month", Token: LoginPageController.DataLogin!.Token_Id)
        
        // Config Picker
        Picker_Start.delegate = self
        Picker_Start.dataSource = self
        
        Picker_End.delegate = self
        Picker_End.dataSource = self
        
        // Config TableView Top Product
        TableView_TopPro.delegate = self
        TableView_TopPro.dataSource = self
        
        TableView_TopPro.register(Tablecell_TopProduct.self, forCellReuseIdentifier: reuseIdentify)
        
        
    }
    
    // MARK: Func Scroll View in Page
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Disable Horizontol Scroll
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config Element in Page
        Config_Element()
        
        // Layout UI Page
        Layout_Page()
        
    }
    
    // MARK: Func Update Data in Chart
    func BarChart_Update(xValues: [String], yValuesBarChart: [Double]){
                
        // Set BarChart
        BarChart_Sales.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        BarChart_Sales.xAxis.granularity = 1
        
        BarChart_Sales.xAxis.labelCount = xValues.count
        
        var BarDataEntry : [BarChartDataEntry] = [BarChartDataEntry]()
        
        for count in 0...(xValues.count - 1) {
            
            BarDataEntry.append(BarChartDataEntry(x: Double(count), y: yValuesBarChart[count]))
            
        }
        let barChartSet: BarChartDataSet = BarChartDataSet(entries: BarDataEntry, label: "Sales")
        let data = BarChartData(dataSet: barChartSet)
        
        // Set BarChart
        barChartSet.colors = [UIColor.BlueLight, UIColor.BlueDeep]
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.paddingPosition = .afterPrefix
        formatter.currencySymbol = "฿"
        formatter.maximumFractionDigits = 0
        barChartSet.valueFormatter = ChartValueFormatter(numberFormatter: formatter)
        
        BarChart_Sales.leftAxis.valueFormatter = YAxisValueFormatter()
        
        BarChart_Sales.data = data

        //This must stay at end of function
        BarChart_Sales.notifyDataSetChanged()
        
    }
    
    
    
    // MARK: Event Button Click
    @objc func Event_FilterClick(){
        
        // Chage State of View Date Filter (Open)
        if ViewDateFilter.alpha == 0.0 {
            UIView.animate(withDuration: 0.5) {
                self.ViewBlur_DateFilter.alpha = 0.7
                self.ViewDateFilter.alpha = 1
            }
        }
        
    }
    
    @objc func Event_CloseDateFilter(){
        
        // Chage State of View Date Filter (Close)
        if ViewDateFilter.alpha == 1.0 {
            UIView.animate(withDuration: 0.3) {
                self.ViewBlur_DateFilter.alpha = 0.0
                self.ViewDateFilter.alpha = 0.0
            }
        }
        
    }
    
    @objc func Event_SubmitFilter(){
        // Request Date to Server
        // if Type Month
        if TypeDate == "Month" {
            let DateMStart = MonthData[Picker_Start.selectedRow(inComponent: 0)]
            let DateYStart = YearData[Picker_Start.selectedRow(inComponent: 1)]
            let DateMEnd = MonthData[Picker_End.selectedRow(inComponent: 0)]
            let DateYEnd = YearData[Picker_End.selectedRow(inComponent: 1)]
            let DateStart = "\(DateYStart)-\(DateMStart)"
            let DateEnd = "\(DateYEnd)-\(DateMEnd)"
            print(DateStart, DateEnd)
            RequestData_Server(Url: url, MonitorStart: DateStart, MonitorEnd: DateEnd, MonitorType: TypeDate, Token: LoginPageController.DataLogin!.Token_Id)
        }
        // if Type Year
        else if TypeDate == "Year" {
            let DateYStart = YearData[Picker_Start.selectedRow(inComponent: 0)] + "-01"
            let DateYEnd = YearData[Picker_End.selectedRow(inComponent: 0)] + "-12"
            print(DateYStart, DateYEnd)
            RequestData_Server(Url: url, MonitorStart: DateYStart, MonitorEnd: DateYEnd, MonitorType: TypeDate, Token: LoginPageController.DataLogin!.Token_Id)
        }
        
        // Close View Date Filter
        UIView.animate(withDuration: 0.3) {
            self.ViewBlur_DateFilter.alpha = 0.0
            self.ViewDateFilter.alpha = 0.0
        }
        
        
    }
    
    // MARK: Func Segment Control
    func Seg_ValueDidChange(index : Int) {
        
        if index == 0 {
            Lb_PickStart.text = "Start (MM/YYYY)"
            Lb_PickEnd.text = "To (MM/YYYY)"
        }
        else if index == 1 {
            Lb_PickStart.text = "Start (YYYY)"
            Lb_PickEnd.text = "To (YYYY)"
        }
        
    }
    
    // MARK: Func Sent Data request to Server and Receive Response
    func RequestData_Server(Url: String, MonitorStart : String, MonitorEnd : String, MonitorType : String, Token : String){
        
        // Reset Data Set
        MainMonitorPageController.DataSetDate = []
        MainMonitorPageController.DataSetSales = []
        MainMonitorPageController.DataSetQuo = []
      
        
        // Sent Data to Server
        //let parameter = ["Token" : Token, "Type" : MonitorType, "Start" : MonitorStart, "End" : MonitorEnd]
        let parameter = ["Start" : MonitorStart, "End" : MonitorEnd]
        let Header : HTTPHeaders = [.authorization(bearerToken: Token), .contentType("application/json")]
        
        //let Alamofire = AF
        //Alamofire.session.configuration.timeoutIntervalForRequest = 5
        AF.request(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success(let value) :
                print(value)
                let json = value as? [String : Any]
                
                // Check error Request
                guard json!["results"] != nil else {
                    let errormessage = json!["message"] as! String
                    self.Create_AlertMessage(Title: "Error", Message: errormessage)
                    return
                }
                
                // Manage Data Response
                let data = json!["results"] as? [String : Any]
                print(data)
                self.ManageData_Response(DataResult: data!)
                
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                break
            }
            
            
        })
        
    }
    
    // MARK: Func Manage Date From Server
    func ManageData_Response(DataResult : [String : Any]){
        
        // Convert Data
        let DataQuo = DataResult["Quotation"] as? [[String : Any]]
        
        // Check Data Receive
        guard DataQuo?.count != 0 else {
            Create_AlertMessage(Title: "No Data", Message: "No data for the specified period")
            return
        }
        
        let DataSales = DataResult["TopSales"] as? [[String : Any]]
        let DataTopPro = DataResult["TopProduct"] as? [[String : Any]]
        
        
        // Record to Variable Static for Another Page
        MainMonitorPageController.DataSeller = DataSales!
        MainMonitorPageController.DataQuo = DataQuo!
        
        // DataQuotation
        var SumSales : Double = 0
        var SameDate = ""
        var SumQuoDate = 1
        var StringDate = ""
        var indexData = 0
        // Cal Sum Sales, Sum Quotation and Manage Data for Chart
        for count in 0...(DataQuo!.count - 1) {
            
            let data = DataQuo![count]
            
            let QuoComplete = data["QuotationCompleted"] as! Int
            // Check Quotation Complete
            if QuoComplete == 1 {
                
                // Filter Date for Data Quotation
                let Date = data["Date"] as! String
                let DateArr = Date.components(separatedBy: "-")
                let Year = DateArr[2]
                let Month = DateArr[1]
                // Sort Date for DataSetDate
                // if Type Month
                if TypeDate == "Month" {
                    StringDate = "\(Month)/\(Year)"
                }
                // if Type Month
                else if TypeDate == "Year" {
                    StringDate = "\(Year)"
                }
                
                // Cal Discount and Vat for Sales
                var OverallSales : Double = 0
                if data["TotalSales"]! as? Double != nil {
                    OverallSales = Double(data["TotalSales"]! as! Double)
                }
                let Vat = Double(OverallSales / 100) * Double(data["vat"]! as! Double)
                OverallSales = OverallSales + Vat
                
                SumSales = OverallSales
                // Filter and Record NumDate Same Date
                if SameDate == StringDate {
                    SumQuoDate += 1
                    MainMonitorPageController.DataSetQuo[indexData] = SumQuoDate
                    // Record DataSetSales
                    MainMonitorPageController.DataSetSales[indexData] += SumSales
                    // Reset SumQuo and SumSales
                }
                // Record SumQuoDate
                if SameDate != StringDate {
                    // Record DatasetDate
                    MainMonitorPageController.DataSetDate.append(StringDate)
                    // Record DataSetQuo
                    MainMonitorPageController.DataSetQuo.append(SumQuoDate)
                    // Record DataSetSales
                    MainMonitorPageController.DataSetSales.append(SumSales)
                    // Reset SumQuo and SumSales
                    SumQuoDate = 1
                    SumSales = 0
                    indexData = MainMonitorPageController.DataSetDate.count - 1
                    
                    // Record Date for Compare Next Date Data
                    SameDate = StringDate
                }
                
            }
            
            
        }
        
        // Record Sum Sales and Num Quotation
        MainMonitorPageController.SumSales = Float(MainMonitorPageController.DataSetSales.reduce(0, +))
        MainMonitorPageController.SumQuo = MainMonitorPageController.DataSetQuo.reduce(0, +)
        // Reverse DataSet
        MainMonitorPageController.DataSetDate = MainMonitorPageController.DataSetDate.reversed()
        MainMonitorPageController.DataSetQuo = MainMonitorPageController.DataSetQuo.reversed()
        MainMonitorPageController.DataSetSales = MainMonitorPageController.DataSetSales.reversed()
        
        // Update Element Monitor
        Lb_MoneySales.text = String(MainMonitorPageController.SumSales).currencyFormatting() + " ฿"
        Lb_QuantityQuotation.text = String(MainMonitorPageController.SumQuo) + " Report"
        // Update Date Show
        self.Lb_Date.text = "Date: \(MainMonitorPageController.DataSetDate[0]) ~ \(MainMonitorPageController.DataSetDate.last!)"
        // Update BarChart
        self.BarChart_Update(xValues: MainMonitorPageController.DataSetDate, yValuesBarChart: MainMonitorPageController.DataSetSales)
        
        // ------------------------------------
        
        // Data TopProduct
        self.DataTopPro = DataTopPro!
        TableView_TopPro.reloadData()
        // ------------------------------------
        
    }
    
    // MARK: Func UIPicker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if Seg_TimeMonitor.currentIndex == 0 {
            return 2
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return MonthData.count
        }
        else {
            return YearData.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.font = UIFont.PoppinsRegular(size: 15 ) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        
        if Seg_TimeMonitor.currentIndex == 1 {
            
            let data = YearData
            pickerLabel.text = data[row]
            return pickerLabel
        }
        else {
            if component == 0 {
                let data = MonthData
                pickerLabel.text = data[row]
                return pickerLabel
            }
            else {
                let data = YearData
                pickerLabel.text = data[row]
                return pickerLabel
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

    
}

extension MainMonitorPageController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataTopPro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentify , for: indexPath) as! Tablecell_TopProduct
        
        
        // Layout
        let ratio = cell.frame.height / (tableView.frame.height / 3)
        // Label Order
        cell.Lb_Order.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_Order.anchor(nil, left: Lb_Co_NamePro.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_Order.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Image Pro
        cell.Im_Pro.translatesAutoresizingMaskIntoConstraints = false
        cell.Im_Pro.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        cell.Im_Pro.leftAnchor.constraint(equalTo: cell.Lb_Order.rightAnchor, constant: 20 * ratio).isActive = true
        cell.Im_Pro.heightAnchor.constraint(equalToConstant: 30 * ratio).isActive = true
        cell.Im_Pro.widthAnchor.constraint(equalToConstant: 30 * ratio).isActive = true
        
        // Name Product
        cell.Lb_NamePro.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_NamePro.anchor(nil, left: cell.Im_Pro.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_NamePro.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Label Quantity of Product
        cell.Lb_QuanPro.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_QuanPro.anchor(nil, left: Lb_Co_QuanPro.leftAnchor, bottom: nil, right: Lb_Co_QuanPro.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_QuanPro.font  = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Label Quantity of Product
        cell.Lb_SalesPro.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_SalesPro.anchor(nil, left: Lb_Co_SalesPro.leftAnchor, bottom: nil, right: Lb_Co_SalesPro.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_SalesPro.font  = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Show Data in Cell
        let Data = self.DataTopPro[indexPath.row]
        
        cell.Lb_Order.text = String(indexPath.row + 1) + "."
        cell.Im_Pro.image = #imageLiteral(resourceName: "Icon-Tile")
        cell.Lb_NamePro.text = Data["ProductName"] as? String
        
        // Check Nil Data
        if (Data["Quantity"] as? Double) != nil {
            
            cell.Lb_QuanPro.text = String(Data["Quantity"] as! Double).currencyFormatting()
            cell.Lb_QuanPro.text = String(Data["Quantity"] as! Double).currencyFormatting()
            
            var SalesPro = "0"
            if Data["TotalSales"] as? Int != nil {
                SalesPro = String(Data["TotalSales"] as! Int)
            }
            
            if SalesPro.count > 3 {
                
                let Sales = Int(SalesPro)! / 1000
                cell.Lb_SalesPro.text = "\(String(Sales).currencyFormatting())K฿"
            }
            else {
                cell.Lb_SalesPro.text = SalesPro + " ฿"
            }
            
        }
        else {
            cell.Lb_QuanPro.text = "0"
            cell.Lb_SalesPro.text = "0" + " ฿"
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 * (self.view.frame.width / 375.0)
    }
    
    
    
    
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth(value : Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: value), to: self.startOfMonth())!
    }
}



/*class YAxisValueFormatter: NSObject, IAxisValueFormatter {

    let numFormatter: NumberFormatter

    override init() {
        numFormatter = NumberFormatter()
        numFormatter.numberStyle = .currency
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 0

        // if number is less than 1 add 0 before decimal
        numFormatter.minimumIntegerDigits = 1 // how many digits do want before decimal
        numFormatter.paddingPosition = .afterPrefix
        numFormatter.currencySymbol = "฿"
    }

    /// Called when a value from an axis is formatted before being drawn.
    ///
    /// For performance reasons, avoid excessive calculations and memory allocations inside this method.
    ///
    /// - returns: The customized label that is drawn on the axis.
    /// - parameter value:           the value that is currently being drawn
    /// - parameter axis:            the axis that the value belongs to
    ///

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return numFormatter.string(from: NSNumber(floatLiteral: value))!
    }
}*/
