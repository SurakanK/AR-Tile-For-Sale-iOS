//
//  TopSaleMonitorPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 16/6/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Charts
import UIDropDown
import Alamofire

private var Id_CollectionCellTopSale : String = "CollectionCell_TopSale"

class TopSaleMonitorPageController : UIViewController, UIScrollViewDelegate {
    
    // MARK: Parameter
    // ratio
    lazy var ratio = view.frame.width / 375
    
    // Delegate Pass Date for Show in TabbarAdmin
    var Delegate_DateShow : DateShowAdminDelegate? // Update Overall Sales
    
    // State Update Data All When View Appear
    var StateUpdate_DataAll : Bool = false
    
    // Parmeter Key Json
    // Top Sale List Key
    let Key_TopSale = Head_TopSale()
    
    // Parameter Overall Sale
    /*var Overall_Sale : Double = 0 {
        didSet {
            // Update Text Lb_Overall
            Lb_Overall.text = String(Overall_Sale).currencyFormatting() + " ฿"
        }
    }*/
    
    // Parameter of Data TopSale
    // Data Top Sale
    var Data_TopSale : [[String : Any]]? = []
    // Data Top Sale Convert Structure
    var Data_Sales : [Data_TopSaleSales] = []
    // State Update Data Top Sale in Page
    var StateUpdate_TopSale : Bool = false {
        didSet {
            
            // Check State Update Data All and State Update Data TopSale
            if StateUpdate_DataAll == true && StateUpdate_TopSale == true {
                
                // Check Nil of Data
                guard Data_TopSale != nil else {return}
                
                // Update Data Top Sale
                self.Update_TopSale()
                //Update_TopSale()
                
                // Change State to Normal
                StateUpdate_TopSale = false
                
            }

        }
    }
    
    // Parameter Num Check Download Image Sale Complete?
    var Num_ImageSaleDownload : Int = 0 {
        didSet{
            
            // Update Data TopSale in Collection View TopSale
            if Num_ImageSaleDownload == Data_TopSale?.count {
                
                DispatchQueue.main.async {
                    let CountSale : CGFloat = CGFloat(self.Data_TopSale!.count)
                    let H_CollectionView : CGFloat = ((160 * self.ratio) * CountSale) + ((10 * self.ratio) * CountSale)
                    self.Collection_TopSale.heightAnchor.constraint(equalToConstant: H_CollectionView).isActive = true
                    self.view.layoutIfNeeded()
                    // Reload CollectionView
                    self.Collection_TopSale.reloadData()
                }
                
                // Reset Num ImageSale Download
                Num_ImageSaleDownload = 0
                
            }
            
        }
    }
    // ---------------------------------
    
    // Parameter Option of PieChart
    var Option_Chart : [String] = ["Sales ratio", "Conversion"]
    
    
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
    // Label OverallSales (NumTotalSales Company)
    lazy var Lb_Overall : UILabel = {
        let label = UILabel()
        label.text = "0 ฿"
        label.font = UIFont.MitrMedium(size: 25 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    // ----------------------------------
    
    // Section View Chart Sale ----------
    // View Chart Sale
    var View_ChartSale : UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha(alpha: 1)
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // Icon Chart Sale
    var Icon_ChartSale : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "analytics").withRenderingMode(.alwaysTemplate)
        image.tintColor = .BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Header Sale Chart
    lazy var Lb_HSaleChart : UILabel = {
        let label = UILabel()
        label.text = "Sale Chart"
        label.font = UIFont.MitrMedium(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // View DropDown Sale Chart
    var View_DropChart : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // PieChart Sale
    lazy var PieChart_Sale : PieChartView = {
        let chart = PieChartView()
        chart.legend.font = UIFont.MitrRegular(size: 10 * ratio)
        chart.legend.textColor = .BlackAlpha(alpha: 0.8)
    
        chart.backgroundColor = .clear
        
        // Setup PieChart
        chart.rotationEnabled = false
        chart.drawEntryLabelsEnabled = false
        //chart.drawHoleEnabled = false
        chart.holeRadiusPercent = 0.3
        chart.transparentCircleRadiusPercent = 0
        
        return chart
    }()
    // BarChart Conversion
    lazy var BarChart_Conversion : BarChartView = {
        let chart = BarChartView()
        chart.alpha = 0
        chart.backgroundColor = .clear
        
        //legend
        let legend = chart.legend
        legend.enabled = true
        legend.font = UIFont.MitrRegular(size: 7 * ratio)
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;


        let xaxis = chart.xAxis
        //xaxis.valueFormatter = axisFormatDelegate
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.labelRotationAngle = 45
        xaxis.centerAxisLabelsEnabled = true
        xaxis.labelFont = UIFont.MitrRegular(size: 7 * ratio)
        xaxis.granularity = 1
    
        let yaxis = chart.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.labelFont = UIFont.MitrRegular(size: 7 * ratio)
        yaxis.drawGridLinesEnabled = false

        chart.rightAxis.enabled = false
        chart.leftAxis.valueFormatter = YAxisValueFormatter()
        
        return chart
    }()
    // ----------------------------------
    
    // Section View Top Sale ------------
    // View Top Sale
    var View_TopSale : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeepAlpha
        view.layer.cornerRadius = 5
        return view
    }()
    // Icon Top Sale
    var Icon_TopSale : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "badge").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Header Top Sale
    lazy var Lb_HTopSale : UILabel = {
        let label = UILabel()
        label.text = "Top Sale"
        label.font = UIFont.MitrMedium(size: 18 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // Collection View Top Sale
    lazy var Collection_TopSale : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        // Config CollectionView
        collection.delegate = self
        collection.dataSource = self
        
        // register
        collection.register(CollectionCell_TopSale.self, forCellWithReuseIdentifier: Id_CollectionCellTopSale)
        
        collection.alwaysBounceVertical = true
        collection.backgroundColor = .clear
        collection.isScrollEnabled = false
        
        return collection
    }()
    
    // ----------------------------------
    
    
    // MARK: Func Layout Page
    func Layout_Page(){
        
        // Set Background View
        view.backgroundColor = .systemGray6
        
        // ScrollView
        view.addSubview(ScrollView)
        ScrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 50 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        view.layoutIfNeeded()
        // -----------

        // StackView of Page
        let StackPage = UIStackView(arrangedSubviews: [View_Overall, View_ChartSale, View_TopSale])
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
        
        // Section Sale Chart
        // Icon Chart Sale
        View_ChartSale.addSubview(Icon_ChartSale)
        Icon_ChartSale.anchor(View_ChartSale.topAnchor, left: View_ChartSale.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        // Label Header Chart Sale
        View_ChartSale.addSubview(Lb_HSaleChart)
        Lb_HSaleChart.anchorCenter(nil, AxisY: Icon_ChartSale.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_HSaleChart.anchor(nil, left: Icon_ChartSale.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // View DropDown Chart
        View_ChartSale.addSubview(View_DropChart)
        View_DropChart.anchor(Lb_HSaleChart.topAnchor, left: Lb_HSaleChart.rightAnchor, bottom: Lb_HSaleChart.bottomAnchor, right: View_ChartSale.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 120 * ratio, heightConstant: 0)
        
        // DropDown Chart
        // Setting Drop Down Sort By
        view.layoutIfNeeded()
        let DropDownSort = UIDropDown(frame: View_DropChart.frame)
        DropDownSort.font = "Mitr-Light"
        DropDownSort.fontSize = (15 * ratio)
        DropDownSort.layer.borderWidth = 0
        DropDownSort.placeholder = Option_Chart[0]
        DropDownSort.options = Option_Chart
        DropDownSort.optionsFont = "Mitr-Light"
        DropDownSort.optionsSize = (15 * ratio)
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = (View_DropChart.frame.size.height * ratio)
        DropDownSort.tableHeight = CGFloat((View_DropChart.frame.size.height * ratio) * CGFloat(Option_Chart.count))
           
        // Func DropDown Item Select
        DropDownSort.didSelect { (Text, index) in
            DropDownSort.placeholder = Text
            
            // Show type Chart Follow DropDown Choose
            if Text == self.Option_Chart[0] {
                // Hide BarChart
                self.BarChart_Conversion.alpha = 0
                // Show PieChart
                self.PieChart_Sale.alpha = 1
            }
            else if Text == self.Option_Chart[1] {
                // Hide BarChart
                self.PieChart_Sale.alpha = 0
                // Show PieChart
                self.BarChart_Conversion.alpha = 1
            }
            
            
        }
        
        // PieChart Sale
        View_ChartSale.addSubview(PieChart_Sale)
        PieChart_Sale.anchor(Icon_ChartSale.bottomAnchor, left: Icon_ChartSale.leftAnchor, bottom: View_ChartSale.bottomAnchor, right: View_DropChart.rightAnchor, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 300 * ratio)
        
        // BarChart conversion
        View_ChartSale.addSubview(BarChart_Conversion)
        BarChart_Conversion.anchor(PieChart_Sale.topAnchor, left: PieChart_Sale.leftAnchor, bottom: PieChart_Sale.bottomAnchor, right: PieChart_Sale.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // -----------
        
        // Section Top Sale List
        // Icon Top Sale
        View_TopSale.addSubview(Icon_TopSale)
        Icon_TopSale.anchor(View_TopSale.topAnchor, left: View_TopSale.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        // Label Header Top Sale
        View_TopSale.addSubview(Lb_HTopSale)
        Lb_HTopSale.anchorCenter(nil, AxisY: Icon_TopSale.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_HTopSale.anchor(nil, left: Icon_TopSale.rightAnchor, bottom: nil, right: View_TopSale.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Collection View Top Sale
        View_TopSale.addSubview(Collection_TopSale)
        let H_CollectionView : CGFloat = ((160 * ratio) * 5) + ((10 * ratio) * 5) // Heightcell + Space Cell
        Collection_TopSale.anchor(Icon_TopSale.bottomAnchor, left: Icon_TopSale.leftAnchor, bottom: View_TopSale.bottomAnchor, right: Lb_HTopSale.rightAnchor, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: H_CollectionView)
        
        // -----------
        
        
        
        // Add Drop Down Chart
        View_ChartSale.addSubview(DropDownSort)
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
    
    // MARK: Func Config Page
    func Config_Page(){
        
    }
    
    // MARK: Func Life Cycle of Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element in Page
        Layout_Page()
        // Config Element in Page
        Config_Page()
        
    }
    
    // View Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Change State Update Data All
        StateUpdate_DataAll = true
        // Update Data Top Sale in Page
        if StateUpdate_DataAll == true && StateUpdate_TopSale == true {
            
            // Check Nil of Data
            guard Data_TopSale != nil else {return}
            
            // Update Data Top Sale
            self.Update_TopSale()
            //Update_TopSale()
            
            // Change State to Normal
            StateUpdate_TopSale = false
            
        }
        
    }
    
    // View Disappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Change State Update DataAll to Default (false)
        StateUpdate_DataAll = false
        
    }
    
    
    // MARK: Func Button In Page
    
    // MARK: Func Update Chart
    // Chart Pie Chart (ratio Sale)
    func Update_PieChart(){
        
        // Check Data count != 0
        /*guard Data_Sales.count != 0 else {
            return
        }*/
        
        // Manage Data before Update Chart
        // Filter Data > 0
        let Data_Filter = Data_Sales.filter({$0.Sale_TotalSalesSuccess > 0})
        // Cal Percent Ratio Sales of Seller Compare Overall Sales of Company in during
        let Sum_Sales : Double = Data_Filter.map({$0.Sale_TotalSalesSuccess}).reduce(0, +)
        let OnePer :Double = Double(Sum_Sales) / 100

        // Set Data Entry
        var entries : [PieChartDataEntry] = Array()
        for count in 0..<Data_Filter.count {
            
            let SalesSuccess : Double = Data_Filter[count].Sale_TotalSalesSuccess / OnePer
            entries.append(PieChartDataEntry(value: SalesSuccess, label: Data_Filter[count].Sale_Name))
            
        }
        
        let DataSet = PieChartDataSet(entries: entries, label: "")
        DataSet.colors = ChartColorTemplates.colorful()
        
        // Set Format of Value In Piechart
        let data = PieChartData(dataSet: DataSet)
        data.setValueFont(UIFont.MitrLight(size: 15 * ratio))
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        data.setValueFormatter(ChartValueFormatter(numberFormatter: formatter))
        
        PieChart_Sale.data = data
        
        // animation PieChart
        PieChart_Sale.animate(yAxisDuration: 1.5)
        
        //This must stay at end of function
        PieChart_Sale.notifyDataSetChanged()

    }
    
    // BarChart (Conversion)
    func Update_BarChart(){
        
        // Set Data for Chart
        let Data_Filter = Data_Sales.filter({$0.Sale_TotalSales != 0})
        BarChart_Conversion.xAxis.valueFormatter = IndexAxisValueFormatter(values: Data_Filter.map({$0.Sale_Name}))
        
        // Set DataEntry
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []

        for i in 0..<Data_Filter.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Data_Filter[i].Sale_TotalSales)
            dataEntries.append(dataEntry)

            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Data_Filter[i].Sale_TotalSalesSuccess)
            dataEntries1.append(dataEntry1)
            

        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Total Sales")
        chartDataSet.colors = [.BlueDeep]
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Success Sales")
        chartDataSet1.colors = [.GreenAlpah]
        // Set Format DataSet Chart
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.paddingPosition = .afterPrefix
        formatter.currencySymbol = "฿"
        formatter.maximumFractionDigits = 0
        chartDataSet.valueFormatter = ChartValueFormatter(numberFormatter: formatter)
        chartDataSet1.valueFormatter = ChartValueFormatter(numberFormatter: formatter)

        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        

        let chartData = BarChartData(dataSets: dataSets)


        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"

        let groupCount = Data_Filter.count
        let startYear = 0


        chartData.barWidth = barWidth;
        BarChart_Conversion.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        BarChart_Conversion.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)

        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)

        BarChart_Conversion.data = chartData

        //chart animation
        BarChart_Conversion.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        
        //This must stay at end of function
        BarChart_Conversion.notifyDataSetChanged()
    }
    // ----------------------------
    
    
    
    // MARK: Func Update Top Sale
    func Update_TopSale(){
        
        // Check Count Data != 0
        guard Data_TopSale?.count != 0 else {
            return
        }
        
        // Check Data Have Value ? (!= nil)
        let Data = Data_TopSale![0][Key_TopSale.Sale_QuoCount] as! Int
        
        guard Data != 0 else {return}
        
        // Section Update Chart in Page
        // Convert Data Json to Data Structure
        // Clear Data_Sales
        Data_Sales = []
        for count in 0...(Data_TopSale!.count - 1) {
            
            // Check nil of Data
            if Data_TopSale![count][Key_TopSale.Sale_TotalSales] as? Double == nil {
                Data_TopSale![count][Key_TopSale.Sale_TotalSales] = 0.0
            }
            if Data_TopSale![count][Key_TopSale.Sale_TotalSalesSuccess] as? Double == nil {
                Data_TopSale![count][Key_TopSale.Sale_TotalSalesSuccess] = 0.0
            }
            
            let DataConvert = Data_TopSaleSales(Sale_Name: Data_TopSale![count][Key_TopSale.Sale_Name] as! String, Sale_Id: Data_TopSale![count][Key_TopSale.Sale_Id] as! Int, Sale_TotalSales: Data_TopSale![count][Key_TopSale.Sale_TotalSales] as! Double, Sale_TotalSalesSuccess: Data_TopSale![count][Key_TopSale.Sale_TotalSalesSuccess] as! Double)
            
            Data_Sales.append(DataConvert)
            
        }
        
        // Update PieChart Ratio Sales
        Update_PieChart()
        // Update Bar Chart Conversion
        Update_BarChart()
        
        // Update Overall Sale
        let Overall_Sales = Data_Sales.map({ $0.Sale_TotalSalesSuccess }).reduce(0,+)
        Lb_Overall.text = String(Overall_Sales).currencyFormatting() + " ฿"
        
        // ----------------------------------------------------------
        
        // Section Update Top Sale Collection View
        // Download Image Sale
        for count in 0...(Data_TopSale!.count - 1) {
            let Key_ImageSale = Data_TopSale![count][Key_TopSale.Key_Image] as! String
            
            // Check Key Image Sale Empty?
            if Key_ImageSale != "" {
                
                // Download Image Sale
                Download_ImageSale(Url: DataSource.Url_DownloadImage(), Key: Key_ImageSale, Index: count)
                
            }
            else {
                // add Image Default
                Data_TopSale![count][Key_TopSale.Sale_Image] = #imageLiteral(resourceName: "user")
                // Stack Num Download Image Sale
                Num_ImageSaleDownload += 1
            }
            
            
        }
        
        // ----------------------------------------------------------
        
    }
    
    // MARK: Func Download Image Product
    func Download_ImageSale(Url : String, Key : String, Index : Int){
        
        // Request
        let Header : HTTPHeaders = [.authorization(bearerToken: LoginPageController.DataLogin!.Token_Id), .contentType("application/json")]
        let parameter = ["bucket":"arforsalesfullimage", "path": Key]
        AF.download(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON { (response) in
               
            switch response.result {
            case .success(let value) :
                if let json = value as? [String : Any] {
                       
                    let Body = json["Body"] as? [String : Any]
                       
                    // Convert Data Buffer to UIImage
                    let Buffer_Im = Body!["data"] as! [UInt8]
                    let datos: NSData = NSData(bytes: Buffer_Im, length: Buffer_Im.count)
                    let image = UIImage(data: datos as Data)
                       
                    self.Data_TopSale![Index][self.Key_TopSale.Sale_Image] = image!
                    
                    // Stack Num Image Product
                    self.Num_ImageSaleDownload += 1
                    
                }
            case .failure(_):
                   
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Download Image Sale InComplete")
                   
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
// MARK: Extension in Page
// Extension Collection Top Sale (Delegate and Datasource)
extension TopSaleMonitorPageController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data_TopSale!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Id_CollectionCellTopSale, for: indexPath) as! CollectionCell_TopSale
        
        
        // Update Data ----------
        if Data_TopSale != nil && Data_TopSale?.count != 0 {
            // Order
            cell.Lb_Order.text = String(indexPath.row + 1)
            
            // Image Sale
            if Data_TopSale![indexPath.row][Key_TopSale.Sale_Image] as? UIImage != nil {
                cell.Set_Image = Data_TopSale![indexPath.row][Key_TopSale.Sale_Image] as! UIImage
            }
            else {
                cell.Set_Image = #imageLiteral(resourceName: "user")
            }
            // Name Sale
            cell.Lb_NameSale.text = String(Data_TopSale![indexPath.row][Key_TopSale.Sale_Name] as! String)
            
            // Num Quotation of Sale
            if Data_TopSale![indexPath.row][Key_TopSale.Sale_QuoCount] as? Double == nil {
                
                Data_TopSale?[indexPath.row][Key_TopSale.Sale_QuoCount] = 0
            }
            cell.Set_NumQuo = Data_TopSale?[indexPath.row][Key_TopSale.Sale_QuoCount] as! Double
            
            // Num Total Sales of Seller
            if Data_TopSale![indexPath.row][Key_TopSale.Sale_TotalSales] as? Double == nil {
                
                Data_TopSale?[indexPath.row][Key_TopSale.Sale_TotalSales] = 0.0
            }
            cell.Set_TotalSales = Double(Data_TopSale?[indexPath.row][Key_TopSale.Sale_TotalSales] as! Double)
            
            // Num Quo Success
            cell.Set_NumQuoSuc = Double((Data_TopSale![indexPath.row][Key_TopSale.Sale_QuoCompleteCount] as! Double) ?? 0)
            
            // Num Success Sales
            cell.Set_SuccessSales = Double((Data_TopSale![indexPath.row][Key_TopSale.Sale_TotalSalesSuccess] as? Double) ?? 0)
            
        }
        // ----------------------
        
        return cell

    }
    
    
    
    
}
// Extension Collection View DelegateFlowLayout
extension TopSaleMonitorPageController : UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width , height: 160 * ratio)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
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
        return 10 * ratio
    }
    
}

struct Data_TopSaleSales {
    var Sale_Name : String
    var Sale_Id : Int

    var Sale_TotalSales : Double
    var Sale_TotalSalesSuccess : Double
    
}
