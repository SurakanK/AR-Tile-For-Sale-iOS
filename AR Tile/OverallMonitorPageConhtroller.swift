//
//  OverallMonitorPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 9/6/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Charts
import Alamofire

private var id_CollectionCellQuo : String = "CollectionCell_StatusQuo"

private var id_CollectionCellTopPro : String = "CollectionCell_TopProductOverall"

class OverallMonitorPageController : UIViewController,UIScrollViewDelegate {
    
    // MARK: Parameter
    // ratio
    lazy var ratio = view.frame.width / 375
    
    // Delegate Pass Date for Show in TabbarAdmin
    var Delegate_DateShow : DateShowAdminDelegate? // For Update Date and Update Overall Sale to TopSalePage and CustomerPage
    
    // State Update Data All when View Appear
    var StateUpdate_DataAll : Bool = false
    
    // Parmeter Key Json
    // Quotation List Key
    let Key_QuoList = Head_QuotationList()
    // Top Product Key
    let Key_TopPro = Head_TopProduct()
    
    
    // Parameter DataSales for BarChart
    var Data_Sales = [DataSales]()
    

    // State Update Data Overall Sale and Data Overall (Quotation)
    var Data_Quotation : [[String : Any]]? = []
    var StateUpdate_Overall : Bool = false {
        didSet {
            
            // Check StateUpdate DataAll and StateUpdate Data Overall
            if StateUpdate_DataAll == true && StateUpdate_Overall == true {
                
                guard Data_Quotation != nil else {return}
                // Update Data
                DispatchQueue.main.async {
                    self.Update_DateOverallSales()
                }
                //Update_DateOverallSales()
                // Change State to Normal
                StateUpdate_Overall = false
                
            }
            
            /*if StateUpdate_Overall == true {
                
                guard Data_Quotation != nil else {return}
                // Update Data
                DispatchQueue.main.async {
                    self.Update_DateOverallSales()
                }
                //Update_DateOverallSales()
                // Change State to Normal
                StateUpdate_Overall = false
                
            }*/
            
            
        }
    }
    
    // Data Status Quotation
    var Status_Quotation : [Int] = [0,0,0,0] // [All,Success,InProcess,Reject]
    
    
    // --------------------------------------------------
    
    
    // State Update Data Top Product and Data Top Product
    var Data_TopProduct : [[String : Any]]? = []
    var StateUpdate_TopProduct : Bool = false {
        didSet {
            
            // Check StateUpdate DataAll and StateUpdateDataTopProduct
            if StateUpdate_DataAll == true && StateUpdate_TopProduct == true {
                
                guard Data_TopProduct != nil else {return}
                // Update Data
                self.Update_DataTopProduct()
                
                // Change State to Normal
                StateUpdate_TopProduct = false
                
            }
            
        }
    }
    
    // Parameter Num Image Product Dowmload For Check Image Download Complete ?
    var Num_ImageProductDownload : Int = 0 {
        didSet {
            
            // For Reload CollectionView Top Product
            if Num_ImageProductDownload == Data_TopProduct?.count {
                // Reload Data in CollectionView Top Product
                Collection_TopPro.reloadData()
                
                // Reset Num_ImageProductDownload
                Num_ImageProductDownload = 0
                
            }
            
        }
    }
    
    // --------------------------------------------------
    
    // MARK: Element in Page
    
    // Scroll View
    // UiScrollView
    var ScrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // Section View Overall Sales -------
    // View
    var View_Overall : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    // Icon Overall
    var Icon_Overall : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "baht").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Header OverallSales
    lazy var Lb_HOverall : UILabel = {
        let label = UILabel()
        label.text = "Purchase amount"
        label.font = UIFont.MitrMedium(size: 25 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    lazy var Lb_Overall : UILabel = {
        let label = UILabel()
        label.text = "0 ฿"
        label.font = UIFont.MitrMedium(size: 25 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    // ----------------------------------
    
    // Section View Chart Sales and Quatation -------
    // View Chart
    var View_Chart : UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 1)
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    // Icon BarChart
    var Icon_BarChart : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "bar-chart").withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Icon pieChart
    var Icon_PieChart : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "analytics").withRenderingMode(.alwaysTemplate)
        image.tintColor = .BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Header BarChart
    lazy var Lb_HBarChart : UILabel = {
        let label = UILabel()
        label.text = "Sales Chart"
        label.font = UIFont.MitrMedium(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // Label Header PieChart
    lazy var Lb_HPieChart : UILabel = {
        let label = UILabel()
        label.text = "Quotation Chart"
        label.font = UIFont.MitrMedium(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // Bar Chart
    lazy var BarChart_Sales : BarChartView = {
        let chart = BarChartView()
        chart.legend.enabled = false
        chart.rightAxis.enabled = false
        chart.backgroundColor = .clear
        
        // Set Font No Data
        chart.noDataFont = UIFont.MitrRegular(size: 10 * ratio)
        
        // Set X Axis
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelRotationAngle = 80
        chart.xAxis.labelFont = UIFont.MitrRegular(size: 7 * ratio)
        chart.xAxis.gridColor = .clear
        chart.xAxis.xOffset = 10
        
        // Set Y Axis
        chart.leftAxis.gridColor = .clear
        chart.leftAxis.labelFont = UIFont.MitrRegular(size: 7 * ratio)
        
        return chart
    }()
    // Pie Chart
    lazy var PieChart_Quotation : PieChartView = {
        let chart = PieChartView()
        //chart.legend.font = UIFont.MitrRegular(size: 10 * ratio)
        //chart.legend.textColor = .BlackAlpha(alpha: 0.8)
        
        // Set Font NoData
        chart.noDataFont = UIFont.MitrRegular(size: 15 * ratio)
        
        // Disable Legend (Under Chart)
        chart.legend.enabled = false
        chart.backgroundColor = .clear
        
        // Setup PieChart
        chart.rotationEnabled = false
        chart.drawEntryLabelsEnabled = false
        //chart.drawHoleEnabled = false
        chart.holeRadiusPercent = 0.3
        chart.transparentCircleRadiusPercent = 0
        
        return chart
    }()
    // Collection List of Status Quotation
    lazy var Collection_Quo : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        view.delegate = self
        view.dataSource = self
        
        view.register(CollectionCell_StatusQuo.self, forCellWithReuseIdentifier: id_CollectionCellQuo)
        
        view.alwaysBounceVertical = true
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        
        
        return view
    }()
    // Color Cell
    var ColorCell_StaQuo : [UIColor] = [.BlueDeepAlpha, .GreenAlpah, .YellowAlpha, .RedAlpha]
    var Title_StaQuo : [String] = ["Total :", "Complete :", "In Process :", "Reject :"]
    
    // ----------------------------------
    
    // Section Top Product
    // View Top Product
    var View_TopPro : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeepAlpha
        view.layer.cornerRadius = 5
        
        /*view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5*/
        return view
    }()
    // Icon Top Product
    var Icon_TopPro : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "badge").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Header TopProduct
    lazy var Lb_HTopPro : UILabel = {
        let label = UILabel()
        label.text = "Top 5 Product"
        label.font = UIFont.MitrMedium(size: 18 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // Collection Top Product
    lazy var  Collection_TopPro : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        view.delegate = self
        view.dataSource = self
        
        view.register(CollectionCell_TopProductOverall.self, forCellWithReuseIdentifier: id_CollectionCellTopPro)
        
        view.alwaysBounceVertical = true
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        
        return  view
    }()
    
    // ----------------------------------
    
    
    
    // MARK: Layout Page
    func LayoutPage(){
        
        // view Background
        view.backgroundColor = .systemGray6
        
        // ScrollView
        view.addSubview(ScrollView)
        ScrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 50 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        view.layoutIfNeeded()
        // -----------
        
        
        
        // StackView of Page
        let StackPage = UIStackView(arrangedSubviews: [View_Overall, View_Chart, View_TopPro])
        StackPage.backgroundColor = .clear
        StackPage.axis = .vertical
        StackPage.distribution = .fill
        StackPage.spacing = 10
        
        ScrollView.addSubview(StackPage)
        let width_StackPage : CGFloat = (ScrollView.frame.width - (20 * ratio))
        StackPage.anchor(ScrollView.topAnchor, left: ScrollView.leftAnchor, bottom: ScrollView.bottomAnchor, right: ScrollView.rightAnchor, topConstant: 10 * ratio, leftConstant:10 * ratio, bottomConstant: 10 * ratio, rightConstant: 10 * ratio, widthConstant: width_StackPage, heightConstant: 0)
        
        // -----------
        
        // Section Overall Sales
        // Icon Overall
        View_Overall.addSubview(Icon_Overall)
        Icon_Overall.anchor(View_Overall.topAnchor, left: View_Overall.leftAnchor, bottom: View_Overall.bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 75 * ratio, heightConstant: 75 * ratio)
        
        // Label Header Overall Sales
        View_Overall.addSubview(Lb_HOverall)
        Lb_HOverall.anchor(nil, left: Icon_Overall.rightAnchor, bottom: Icon_Overall.centerYAnchor, right: View_Overall.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 1 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Label Overall Sales
        View_Overall.addSubview(Lb_Overall)
        Lb_Overall.anchor(Icon_Overall.centerYAnchor, left: Lb_HOverall.leftAnchor, bottom: nil, right: Lb_HOverall.rightAnchor, topConstant: 1 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // -----------
        
        // Section Chart
        // Icon Bar Chart
        View_Chart.addSubview(Icon_BarChart)
        Icon_BarChart.anchor(View_Chart.topAnchor, left: View_Chart.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        // Label Header Bar Chart
        View_Chart.addSubview(Lb_HBarChart)
        Lb_HBarChart.anchorCenter(nil, AxisY: Icon_BarChart.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_HBarChart.anchor(nil, left: Icon_BarChart.rightAnchor, bottom: nil, right: View_Chart.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Bar Chart Sales
        View_Chart.addSubview(BarChart_Sales)
        BarChart_Sales.anchor(Icon_BarChart.bottomAnchor, left: Icon_BarChart.leftAnchor, bottom: nil, right: Lb_HBarChart.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 200 * ratio)
        
        // Icon Pie Chart
        View_Chart.addSubview(Icon_PieChart)
        Icon_PieChart.anchor(BarChart_Sales.bottomAnchor, left: BarChart_Sales.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        // Label; Header Pie Chart
        View_Chart.addSubview(Lb_HPieChart)
        Lb_HPieChart.anchorCenter(nil, AxisY: Icon_PieChart.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_HPieChart.anchor(nil, left: Icon_PieChart.rightAnchor, bottom: nil, right: Lb_HBarChart.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Pie Chart Quotation
        View_Chart.addSubview(PieChart_Quotation)
        PieChart_Quotation.anchor(Icon_PieChart.bottomAnchor, left: Icon_PieChart.leftAnchor, bottom: View_Chart.bottomAnchor, right: View_Chart.centerXAnchor, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        view.layoutIfNeeded()
        PieChart_Quotation.heightAnchor.constraint(equalToConstant: PieChart_Quotation.frame.width).isActive = true
        
        // Collection Quotation Status
        View_Chart.addSubview(Collection_Quo)
        Collection_Quo.anchor(PieChart_Quotation.topAnchor, left: View_Chart.centerXAnchor, bottom: PieChart_Quotation.bottomAnchor, right: Lb_HPieChart.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        // -----------
        
        // Section Top Product
        // Icon Top Product
        View_TopPro.addSubview(Icon_TopPro)
        Icon_TopPro.anchor(View_TopPro.topAnchor, left: View_TopPro.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        // Label Top Product
        View_TopPro.addSubview(Lb_HTopPro)
        Lb_HTopPro.anchorCenter(nil, AxisY: Icon_TopPro.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_HTopPro.anchor(nil, left: Icon_TopPro.rightAnchor, bottom: nil, right: View_TopPro.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Collection Top Product
        View_TopPro.addSubview(Collection_TopPro)
        let Height_CollectionTopPro : CGFloat = ((125 * ratio) * 5) + ((10 * ratio) * 5)
        Collection_TopPro.anchor(Icon_TopPro.bottomAnchor, left: Icon_TopPro.leftAnchor, bottom: View_TopPro.bottomAnchor, right: Lb_HTopPro.rightAnchor, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 15 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: Height_CollectionTopPro)
        // -----------
        
        // Config ContentSize of Scroll View
        ScrollView.contentSize = StackPage.bounds.size
    }
    
    // MARK: Func Scroll View in Page
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Disable Horizontol Scroll
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    // MARK: Config Page
    func ConfigPage(){
        
        // Config Date for Request Initial App
        
        
        
    }
    
    // MARK: Life Cycle of Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element Page
        LayoutPage()
        // Config Element in Page
        ConfigPage()
        
        
    }
    
    // View appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Change State Update Data All
        StateUpdate_DataAll = true
        
        // Updata Data Overall
        if StateUpdate_DataAll == true && StateUpdate_TopProduct == true {
            
            guard Data_TopProduct != nil else {return}
            // Update Data
            DispatchQueue.main.async {
                self.Update_DataTopProduct()
            }
            //Update_DataTopProduct()
            // Change State to Normal
            StateUpdate_TopProduct = false
            
        }
        
        // Update Data Top Product
        if StateUpdate_DataAll == true && StateUpdate_TopProduct == true {
                       
            guard Data_TopProduct != nil else {return}
            // Update Data
            DispatchQueue.main.async {
                self.Update_DataTopProduct()
            }
            // Change State to Normal
            StateUpdate_TopProduct = false
                       
        }
        
    }
    
    // View DisAppear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Change StateUpdate DataAll to Default (false)
        StateUpdate_DataAll = false
        
    }
    
    
    // MARK: Func Chart In Page
    // Func Update PieChart
    func UpdateData_PieChart(){
        // Check Count Data > 0
        guard Status_Quotation[0] != 0 else {
            // Alert No Data
            PieChart_Quotation.noDataText = "No income during this period"
            
            return
        }
        
        // Cal Percent Data Num Status Quotation
        let OnePer : Double = Double(Status_Quotation[0]) / 100
        let Per_Success : Double = Double(Status_Quotation[1]) / OnePer
        let Per_InProcess : Double = Double(Status_Quotation[2]) / OnePer
        let Per_Reject : Double = Double(Status_Quotation[3]) / OnePer
        
        // Set Data to Pie
        var entries : [PieChartDataEntry] = Array()
        let DataEntry : [Double] = [Per_Success, Per_InProcess, Per_Reject]
        var ColorChart : [UIColor] = [.GreenAlpah, .YellowAlpha, .RedAlpha]
        var IndexOffset = 0
        for count in 0...(DataEntry.count - 1) {
            // Check Data > 0
            if DataEntry[count] > 0 {
                entries.append(PieChartDataEntry(value: DataEntry[count]))
            }
            else {
                ColorChart.remove(at: count - IndexOffset)
                IndexOffset += 1
            }
        }
        
        let DataSet = PieChartDataSet(entries: entries, label: "")
        DataSet.colors = ColorChart
        
        DataSet.selectionShift = 10
        
        // Set Format of Value In Piechart
        let data = PieChartData(dataSet: DataSet)
        data.setValueFont(UIFont.MitrLight(size: 15 * ratio))
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        data.setValueFormatter(ChartValueFormatter(numberFormatter: formatter))
        
        PieChart_Quotation.data = data
        
        // animation PieChart
        PieChart_Quotation.animate(yAxisDuration: 1.5)
        
        //This must stay at end of function
        PieChart_Quotation.notifyDataSetChanged()
        
    }
    
    // Func Update Bar Chart
    func Update_BarChart(){
        
        // Check Count Data
        guard Data_Sales.count != 0 else {
            
            // Alert No Data ib Bar Chart
            BarChart_Sales.noDataText = "No income during this period"
            
            return
        }
        
        // Set BarChart
        BarChart_Sales.xAxis.valueFormatter = IndexAxisValueFormatter(values: Data_Sales.map({$0.Date}))
        BarChart_Sales.xAxis.granularity = 1
        // Set DataEntry
        BarChart_Sales.xAxis.labelCount = Data_Sales.count
        var BarDataEntry : [BarChartDataEntry] = Array()
        for count in 0...(Data_Sales.count - 1) {
            BarDataEntry.append(BarChartDataEntry(x: Double(count), y: Data_Sales[count].TotalSales))
        }
        
        // Set DataSet
        let barChartSet: BarChartDataSet = BarChartDataSet(entries: BarDataEntry, label: "")
        let data = BarChartData(dataSet: barChartSet)
        
        // Set format in BarChart
        barChartSet.colors = [UIColor.BlueDeepAlpha, UIColor.BlueDeep]
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.paddingPosition = .afterPrefix
        formatter.currencySymbol = "฿"
        formatter.maximumFractionDigits = 0
        barChartSet.valueFormatter = ChartValueFormatter(numberFormatter: formatter)
        
        BarChart_Sales.leftAxis.valueFormatter = YAxisValueFormatter()
        BarChart_Sales.data = data
        
        // Set Animation Bar Chart
        BarChart_Sales.animate(xAxisDuration: 2)
        BarChart_Sales.animate(yAxisDuration: 2)

        //This must stay at end of function
        BarChart_Sales.notifyDataSetChanged()
    }
    
    
    // MARK: Func Button In Page
    
    // MARK: Func Update OverallSales ------
    // Update
    func Update_DateOverallSales(){
        
        // Check Data > 0
        guard Data_Quotation!.count != 0 else {
            // Alert No Data Monitor
            Create_AlertMessage(Title: "Data not found", Message: "No data found for the specified time period.")
            return
        }
        
        // Manage Data Quotation
        Manage_DataOverallSales()
        
        // Update Data in Collection_Quotation
        Collection_Quo.reloadData()
        
        // Update Overall Sales
        let TotalSales = Data_Sales.map({ $0.TotalSales }).reduce(0,+)
        Lb_Overall.text = String(TotalSales).currencyFormatting() + " ฿"
        Delegate_DateShow?.UpdateOverallSale_SubPage(TotalSales: TotalSales)
        
        // Update Data PieChart Quotation
        UpdateData_PieChart()
        // Update Data BarChart Sales
        Update_BarChart()
        
        
    }
    // Manage
    func Manage_DataOverallSales(){

        // Get Date from Data ----
        let DateS = Data_Quotation![Data_Quotation!.count - 1][Key_QuoList.DateEnd] as! String
        let DateE = Data_Quotation![0][Key_QuoList.DateEnd] as! String
        
        // Update Date Monitor (Show) in TabbarAdminPage
        Delegate_DateShow?.PassDate_Show(DateStart: DateS, DateEnd: DateE)
        //--------------------------
        
        // Section Get Num Status of Quotation List
        let QuoSuccess = Data_Quotation!.filter{($0[Key_QuoList.Quo_Status] as! Int) == 1}
        let QuoInProcess = Data_Quotation!.filter{($0[Key_QuoList.Quo_Status] as! Int) == 0}
        let QuoReject = Data_Quotation!.filter{($0[Key_QuoList.Quo_Status] as! Int) == 2}
        
        // Record to Status Quo
        Status_Quotation = [Data_Quotation?.count as! Int, QuoSuccess.count, QuoInProcess.count, QuoReject.count] // [All,Success,InProcess,Reject]

        //--------------------------
        
        // Section Filter and Manage Data_Quotation for Monitor
        // Clear DataSales Have Update Data_Quotation
        Data_Sales = []
        var Check_Date : String = ""
        for count in 0...(Data_Quotation!.count - 1) {
            
            // Convert Date of Data ---
            let Date_Initial = Data_Quotation![count][Key_QuoList.DateEnd] as! String
            // Formater Date 1
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd-MM-yyyy"
            formatter1.calendar = Calendar(identifier: .gregorian)
            // Formatter Date 2
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "yyyy"
            // ModeDate is "Month"
            if TabBarAdminContainer.ModeDate == "Month" {
                formatter2.dateFormat = "MM/yyyy"
            }
            formatter2.calendar = Calendar(identifier: .gregorian)
            
            let Date_Convert = formatter1.date(from: Date_Initial)
            let Date = formatter2.string(from: Date_Convert!)
            // ------------------------
            
            // Manage Data Quotation for Update Overall Sales and BarChart
            // Check Date Repeat and Status Quotation (Must Be '1' Complete)
            let Status_Quo = Data_Quotation![count][Key_QuoList.Quo_Status] as! Int
            if Date == Check_Date && Status_Quo == 1{
                
                // Find Index of Check Date of Data_Sales
                let index = Data_Sales.firstIndex(where: {$0.Date == Date})
                // Cal Total for Uodate TotalSales to Data_Sales at Date Same (Stack Sales)
                let TotalSales_Old = Data_Sales[index!].TotalSales
                let TotalSales_Ori = Data_Quotation![count][Key_QuoList.Quo_TotalPrice] as! Double
                let Discount = Data_Quotation![count][Key_QuoList.Discount] as! Double
                let vat = Double(Data_Quotation![count][Key_QuoList.Vat] as! String)
                
                let TotalSales_Vat = TotalSales_Ori + (TotalSales_Ori * (vat! / 100))
                let Total_Discount = TotalSales_Vat - Discount
                let TotalSales = TotalSales_Old + Total_Discount
                
                Data_Sales[index!].TotalSales = TotalSales
                
            }
            else if Date != Check_Date && Status_Quo == 1 {
                // Cal Total Sales
                let Total_Ori = Data_Quotation![count][Key_QuoList.Quo_TotalPrice] as! Double
                let vat = Double(Data_Quotation![count][Key_QuoList.Vat] as! String)
                let Discount = Data_Quotation![count][Key_QuoList.Discount] as! Double
                
                let TotalSales = Total_Ori + (Total_Ori * (vat! / 100))
                let Total_Discount = TotalSales - Discount
         
                // Append DataSales
                let Data = DataSales(Date: Date, TotalSales: Total_Discount)
                Data_Sales.append(Data)
                
                // Update Check Date
                Check_Date = Date
                
            }
            
        }
        
        // Reverse Index Data_Sales
        Data_Sales = Data_Sales.reversed()
        // ------------------------
        //--------------------------
    }
    
    // -------------------------------------
    
    // MARK: Func Update Top Product
    // Update to UI
    func Update_DataTopProduct(){
        
        // Check Data > 0
        guard Data_TopProduct!.count != 0 else {
            return
        }
        
        // Check Value in Data Top Sale
        let data = Data_TopProduct![0][Key_TopPro.Quantity] as? Double
        guard data != nil else {
            return
        }
        
        // Manage and Filter Data Top Product ----
        for count in 0...(Data_TopProduct!.count - 1) {
            
            let Key_Image = Data_TopProduct![count][Key_TopPro.Key_Image] as! String
            // Check Key Image Not Empty Download Image
            if Key_Image != "" {
                // Download
                Download_ImageProduct(Url: DataSource.Url_DownloadImage(), Key: Key_Image, Index: count)
                
            }
            else {
                
                // Add Image Default
                Data_TopProduct![count][Key_TopPro.ImageProduct] = #imageLiteral(resourceName: "Icon-Tile")
                
                // Stack Num Image Product
                self.Num_ImageProductDownload += 1
                
            }
            
            
        }
        // ----------------------------------------
        
    }
    
    // -------------------------------------
    
    // MARK: Func Download Image Product
    func Download_ImageProduct(Url : String, Key : String, Index : Int){
        
        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: LoginPageController.DataLogin!.Token_Id), .contentType("application/json")]
        let parameter = ["bucket":"arforsalesimageresize", "path": Key]
        AF.download(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
               
            switch response.result {
            case .success(let value) :
                if let json = value as? [String : Any] {
                       
                    let Body = json["Body"] as? [String : Any]
                       
                    // Convert Data Buffer to UIImage
                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let datos: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
                    let image = UIImage(data: datos as Data)
                       
                    self.Data_TopProduct![Index][self.Key_TopPro.ImageProduct] = image!
                    
                    // Stack Num Image Product
                    self.Num_ImageProductDownload += 1
                    
                }
            case .failure(_):
                   
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Image of Product InComplete")
                   
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
    
  
}

// MARK: Extention In Page
// extension Collection View Page
extension OverallMonitorPageController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == Collection_Quo {
            return 	4
        }
        // if Collection Top Product
        else {
            return 5//Data_TopProduct!.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == Collection_Quo {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id_CollectionCellQuo, for: indexPath) as! CollectionCell_StatusQuo
            
            cell.BGColor = ColorCell_StaQuo[indexPath.row]
            cell.Lb_Header.text = Title_StaQuo[indexPath.row]
            cell.Lb_Value.text = String(Status_Quotation[indexPath.row])
            
            
            return cell
        }
        // if Collection Top Product
        else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id_CollectionCellTopPro, for: indexPath) as! CollectionCell_TopProductOverall
            
            cell.Lb_Order.text = String(indexPath.row + 1)
            
            if Data_TopProduct != nil && Data_TopProduct?.count != 0 {
                
                // Hide Skeleton View
                cell.Im_Pro.hideSkeleton()
                cell.Lb_NamePro.hideSkeleton()
                cell.Lb_QuanPro.hideSkeleton()
                cell.Lb_TotalPro.hideSkeleton()
                
                let Head_TopPro = Head_TopProduct()
                
                // Set ImageProduct
                if Data_TopProduct![indexPath.row][Key_TopPro.ImageProduct] as? UIImage != nil{
                    
                    cell.ImageProduct = Data_TopProduct![indexPath.row][Key_TopPro.ImageProduct] as! UIImage
                    
                }
                else {
                    cell.ImageProduct = #imageLiteral(resourceName: "Icon-Tile")
                }
                
                // Set Name Top Product
                cell.Lb_NamePro.text = String(Data_TopProduct![indexPath.row][Head_TopPro.Name] as! String)
                
                // Set Quantity Top Product
                if Data_TopProduct![indexPath.row][Head_TopPro.Quantity] as? Int == nil {
                    Data_TopProduct![indexPath.row][Head_TopPro.Quantity] = 0
                }
                let Quan_TopPro = "QTY : " + String(Data_TopProduct![indexPath.row][Head_TopPro.Quantity] as! Int).currencyFormatting() + " m²"
                cell.Lb_QuanPro.text = Quan_TopPro
                
                // Set Total Sales Top Product
                if Data_TopProduct![indexPath.row][Head_TopPro.TotalSale] as? Int == nil {
                    Data_TopProduct![indexPath.row][Head_TopPro.TotalSale] = 0
                }
                let Total_TopPro = "Total : " + String(Data_TopProduct![indexPath.row][Head_TopPro.TotalSale] as! Int).currencyFormatting() + " ฿"
                cell.Lb_TotalPro.text = Total_TopPro
                
            }
            // Show Skeleton View
            else {
                cell.Im_Pro.showAnimatedSkeleton()
                cell.Lb_NamePro.showAnimatedSkeleton()
                cell.Lb_QuanPro.showAnimatedSkeleton()
                cell.Lb_TotalPro.showAnimatedSkeleton()
            }
            
            	
            return cell
            
        }
        
    }
    
    
}
extension OverallMonitorPageController : UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == Collection_Quo {
            view.layoutIfNeeded()
            return CGSize(width: collectionView.bounds.width, height: ((PieChart_Quotation.frame.height / 5)))
        }
        // if collection_TopPro
        else {
            
            return CGSize(width: collectionView.bounds.width, height: 125 * ratio)
            
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == Collection_Quo {
            return UIEdgeInsets(top: 10 * ratio, left: 0, bottom: 0, right: 0) //.zero
        }
        else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
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
        if collectionView == Collection_Quo {
            return 5 * ratio
        }
        else {
            return 10 * ratio
        }
        
    }
    
    
}

// MARK: Structure
struct DataSales {
    var Date : String
    var TotalSales : Double
}


// MARK: Class In Page
class YAxisValueFormatter: NSObject, IAxisValueFormatter {

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
}
