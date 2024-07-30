//
//  SaleMonitorPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 8/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Charts

private let reuseIdentify = "Tabelcell_TopSeller"

class SaleMonitorPageController : UIViewController, UIScrollViewDelegate {
    
    // Image BG
    var Im_BG : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "robin-worrall-FPt10LXK0cg-unsplash")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        
        return image
    }()
    // --------------------------------------------------------
    
    // View Blur BG
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
    
    // ViewMonitor 1
    var ViewMonitor_1 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // ------------------------
    
    // Icon Header Chart
    var Icon_Chart : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "pie-chart")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        
        return image
    }()
    // ------------------------
    
    // Label Header PieChart
    var Lb_HeaderPieChart : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsBold(size: 20)
        label.textColor = .BlackAlpha(alpha: 0.8)
        label.text = "Seller Ratio Chart"
        
        return label
    }()
    // ------------------------
    
    var PieChart : PieChartView = {
        let chart = PieChartView()
        chart.legend.font = UIFont.PoppinsRegular(size: 10)
        chart.legend.textColor = .BlackAlpha(alpha: 0.8)
    
        chart.backgroundColor = .clear
        
        return chart
    }()
    
    
    
    // --------------------------------------------------------
    
    // ViewMonitor 2
    var ViewMonitor_2 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        return view
    }()
    // ------------------------
    
    // Icon Header To Seller
    var Icon_TopSeller : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "vendor")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        
        return image
    }()
    // ------------------------
    
    // Label Header of Top Seller
    var Lb_HeaderTopSeller : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsBold(size: 20)
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.text = "Top Seller"
        return label
    }()
    // ------------------------
    
    // View Column Table View Top Seller
    var View_Co_NameSeller : UIView = {
        let view = UIView()
        view.backgroundColor = .YellowDeep
        return view
    }()
    
    // Label Column Name
    var Lb_Co_NameSeller : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 13)
        label.textColor = .whiteAlpha(alpha: 0.8)
        label.text = "Name"
        //label.textAlignment = .center
        return label
    }()
    
    // ------------------------
    
    // View Column Table View Top Seller
    var View_Co_ReportSeller : UIView = {
        let view = UIView()
        view.backgroundColor = .YellowDeep
        return view
    }()
    
    // Label Column Report Quotation
    var Lb_Co_ReportSeller : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 13)
        label.textColor = .whiteAlpha(alpha: 0.8)
        label.text = "Estimate"
        label.textAlignment = .center
        return label
    }()
    // ------------------------
    
    // View Column Table View Top Seller
    var View_Co_SalesSeller : UIView = {
        let view = UIView()
        view.backgroundColor = .YellowDeep
        return view
    }()
    
    // Label Column Sales
    var Lb_Co_SalesSeller : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 13)
        label.textColor = .whiteAlpha(alpha: 0.8)
        label.text = "Quotation"
        label.textAlignment = .center
        return label
    }()
    // ------------------------
    
    // TableView Top Seller
    var TableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.alwaysBounceVertical = false
        return table
    }()
    
    // --------------------------------------------------------
    
    
    // MARK: Layout Page
    func Layout_Page(){
        
        let ratio : CGFloat = view.frame.width / 375.0
        let ratio_H : CGFloat = view.frame.height / 812.0
        
        // Set BG View
        view.backgroundColor = .systemGray6
        
        // Image BG
        /*view.insertSubview(Im_BG, at: 0)
        
        Im_BG.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // View Blur
        view.insertSubview(BGBlur, at: 1)
        
        BGBlur.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)*/
        
        // Scroll View
        view.addSubview(ScrollView)
        
        ScrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // StackView
        let StackView_Monitor = UIStackView(arrangedSubviews: [ViewMonitor_1, ViewMonitor_2])
        ScrollView.addSubview(StackView_Monitor)
        
        StackView_Monitor.axis = .vertical
        StackView_Monitor.distribution = .fill
        StackView_Monitor.spacing = 10
        
        StackView_Monitor.anchor(ScrollView.topAnchor, left: ScrollView.leftAnchor, bottom: ScrollView.bottomAnchor, right: view.rightAnchor, topConstant: 10 * ratio_H, leftConstant: 10 * ratio, bottomConstant: 10 * ratio_H, rightConstant: 10 * ratio, widthConstant: view.bounds.width, heightConstant: 0)
        
        // --------------------------------
        
        // ViewMonitor 1
        ViewMonitor_1.layer.cornerRadius = 10 * ratio
        // Icon Header PieChart
        ViewMonitor_1.addSubview(Icon_Chart)
        
        Icon_Chart.anchor(ViewMonitor_1.topAnchor, left: ViewMonitor_1.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
        
        // Label Header PieChart
        ViewMonitor_1.addSubview(Lb_HeaderPieChart)
        
        Lb_HeaderPieChart.anchorCenter(nil, AxisY: Icon_Chart.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_HeaderPieChart.anchor(nil, left: Icon_Chart.rightAnchor, bottom: nil, right: ViewMonitor_1.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_HeaderPieChart.font = UIFont.PoppinsBold(size: 20 * ratio)
        
        // PieChart
        ViewMonitor_1.addSubview(PieChart)
        
        PieChart.anchor(Icon_Chart.bottomAnchor, left: Icon_Chart.leftAnchor, bottom: ViewMonitor_1.bottomAnchor, right: Lb_HeaderPieChart.rightAnchor, topConstant: 30 * ratio_H, leftConstant: 0, bottomConstant: 15 * ratio_H, rightConstant: 0, widthConstant: 0, heightConstant: 300 * ratio_H)
        
        // --------------------------------
        
        // ViewMonitor 2
        ViewMonitor_2.layer.cornerRadius = 10 * ratio
        // Icon Header Top Seller
        ViewMonitor_2.addSubview(Icon_TopSeller)
        
        Icon_TopSeller.anchor(ViewMonitor_2.topAnchor, left: ViewMonitor_2.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio_H, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
        
        // Label Header Top Seller
        ViewMonitor_2.addSubview(Lb_HeaderTopSeller)
        
        Lb_HeaderTopSeller.anchorCenter(nil, AxisY: Icon_TopSeller.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_HeaderTopSeller.anchor(nil, left: Icon_TopSeller.rightAnchor, bottom: nil, right: ViewMonitor_2.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 20 * ratio)
        
        Lb_HeaderTopSeller.font = UIFont.PoppinsBold(size: 20 * ratio)
        
        // Set View Column Top Seller in Stack View
        let width_column = (view.frame.width - (40 * ratio)) / 5
        
        // View Label Column Name Top Seller
        ViewMonitor_2.addSubview(View_Co_NameSeller)
        
        View_Co_NameSeller.anchor(Icon_TopSeller.bottomAnchor, left: Icon_TopSeller.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width_column * 2.25, heightConstant: 40 * ratio)
        
        View_Co_NameSeller.addSubview(Lb_Co_NameSeller)
        
        Lb_Co_NameSeller.anchorCenter(nil, AxisY: View_Co_NameSeller.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_NameSeller.anchor(nil, left: View_Co_NameSeller.leftAnchor, bottom: nil, right: View_Co_NameSeller.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Co_NameSeller.font = UIFont.PoppinsMedium(size: 13 * ratio)
        
        // View Label Column Sales Top Seller
        ViewMonitor_2.addSubview(View_Co_SalesSeller)
        
        View_Co_SalesSeller.anchor(View_Co_NameSeller.topAnchor, left: View_Co_NameSeller.rightAnchor, bottom: View_Co_NameSeller.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width_column * 1.25 , heightConstant: 40 * ratio)
        
        View_Co_SalesSeller.addSubview(Lb_Co_SalesSeller)
        
        Lb_Co_SalesSeller.anchorCenter(nil, AxisY: View_Co_SalesSeller.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_SalesSeller.anchor(nil, left: View_Co_SalesSeller.leftAnchor, bottom: nil, right: View_Co_SalesSeller.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Co_SalesSeller.font = UIFont.PoppinsMedium(size: 13 * ratio)
        
        // View Label Column Quotation Top Seller
        ViewMonitor_2.addSubview(View_Co_ReportSeller)
        
        View_Co_ReportSeller.anchor(View_Co_SalesSeller.topAnchor, left: View_Co_SalesSeller.rightAnchor, bottom: View_Co_SalesSeller.bottomAnchor, right: Lb_HeaderTopSeller.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width_column * 1.5, heightConstant: 40 * ratio)
        
        View_Co_ReportSeller.addSubview(Lb_Co_ReportSeller)
        
        Lb_Co_ReportSeller.anchorCenter(nil, AxisY: View_Co_ReportSeller.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_ReportSeller.anchor(nil, left: View_Co_ReportSeller.leftAnchor, bottom: nil, right: View_Co_ReportSeller.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Co_ReportSeller.font = UIFont.PoppinsMedium(size: 13 * ratio)
        
        // Table View Top Seller
        ViewMonitor_2.addSubview(TableView)
        
        TableView.anchor(View_Co_NameSeller.bottomAnchor, left: View_Co_NameSeller.leftAnchor, bottom: ViewMonitor_2.bottomAnchor, right: View_Co_ReportSeller.rightAnchor, topConstant: 5 * ratio_H, leftConstant: 0, bottomConstant: 15 * ratio_H, rightConstant: 0, widthConstant: 0, heightConstant: CGFloat(50 * (MainMonitorPageController.DataSeller.count)))
        
        // --------------------------------
        
        // Config ContentSize of Scroll View
        ScrollView.contentSize = StackView_Monitor.bounds.size
    }
    
    // MARK: Func Scroll View in Page
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Disable Horizontol Scroll
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    // MARK: Config Element Page
    func Config_Page(){
        
        // Config TableView Top Seller
        TableView.delegate = self
        TableView.dataSource = self
        
        TableView.register(Tablecell_TopSeller.self, forCellReuseIdentifier: reuseIdentify)
    
    }
    
    // MARK: Func Lift Cycle of Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config Element Page
        Config_Page()
        // Layout Page
        Layout_Page()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update Pie Chart
        Update_PieChart(DataSeller: MainMonitorPageController.DataSeller)
        TableView.reloadData()
    }
    

    
    
    
    
    // MARK: Update Data in Chart
    func Update_PieChart(DataSeller : [[String : Any]]){
        
        var PieDataEntry : [PieChartDataEntry] = [PieChartDataEntry]()
        
        // Manage Data For Chart
        for count in 0...(DataSeller.count - 1){
            
            // Find Percent Compare with SumSales
            let OnePer = Double(MainMonitorPageController.SumSales) / 100
            var SalesSeller : Double = 0
            var PerSalesSeller : Double = 0
            var NameSeller : String = ""
            let data = DataSeller[count] as [String : Any]
            
            // Check null
            if (data["QuotationTotalSales"] as? Double) != nil {
                SalesSeller = data["QuotationTotalSales"] as! Double
                PerSalesSeller = SalesSeller / OnePer
                
                // Name Seller
                NameSeller = data["FullName"] as! String
                
                // Record Data to PieDataEntry
                PieDataEntry.append(PieChartDataEntry(value: PerSalesSeller, label: NameSeller))
                
            }
            
        }
        
        let dataSet = PieChartDataSet(entries: PieDataEntry, label: "")
        let data = PieChartData(dataSet: dataSet)
        dataSet.colors = ChartColorTemplates.colorful()
        
        // Set Sty of Value
        dataSet.xValuePosition = PieChartDataSet.ValuePosition.outsideSlice
        dataSet.valueLineWidth = 2
        dataSet.valueLinePart1Length = 0.5
        dataSet.valueLinePart1OffsetPercentage = 1
        dataSet.valueLineColor = .BlackAlpha(alpha: 0.3)
        dataSet.entryLabelFont = UIFont.PoppinsMedium(size: 13)
        dataSet.entryLabelColor = .BlueDeep
        
        data.setValueFont(UIFont.PoppinsMedium(size: 13))
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        data.setValueFormatter(ChartValueFormatter(numberFormatter: formatter))
        
        
        
        PieChart.data = data
    
        
    

        //All other additions to this function will go here

        //This must stay at end of function
        PieChart.notifyDataSetChanged()
    }
    
}

extension SaleMonitorPageController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (MainMonitorPageController.DataSeller.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentify , for: indexPath) as! Tablecell_TopSeller
        
        // Layout
        let ratio = cell.frame.width / 335//cell.frame.height / (tableView.frame.height / 3)
        
        // Label Order
        cell.Lb_Order.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_Order.anchor(nil, left: View_Co_NameSeller.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cell.Lb_Order.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Image Seller
        cell.Im_Seller.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Im_Seller.anchor(nil, left: cell.Lb_Order.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        cell.Im_Seller.layer.cornerRadius = (30 * ratio) / 2
        
        // Label Name Seller
        cell.Lb_NameSeller.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_NameSeller.anchor(nil, left: cell.Im_Seller.rightAnchor, bottom: nil, right: Lb_Co_NameSeller.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cell.Lb_NameSeller.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Label Sales Seller
        cell.Lb_SalesSeller.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_SalesSeller.anchor(nil, left: Lb_Co_ReportSeller.leftAnchor, bottom: nil, right: Lb_Co_ReportSeller.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cell.Lb_SalesSeller.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Label Quotation Seller
        cell.Lb_QuotationSeller.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_QuotationSeller.anchor(nil, left: Lb_Co_SalesSeller.leftAnchor, bottom: nil, right: Lb_Co_SalesSeller.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cell.Lb_QuotationSeller.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Change BG and Text Color
        if (indexPath.row + 1) % 2 == 0 {
            cell.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 103/255, alpha: 0.7)
            cell.Lb_Order.textColor = .white
            cell.Lb_NameSeller.textColor = .white
            cell.Lb_SalesSeller.textColor = .white
            cell.Lb_QuotationSeller.textColor = .white
        }
        
        // ---------------------------
        
        // Set Data of Cell for row
        let data = MainMonitorPageController.DataSeller[indexPath.row] as [String : Any]
        
        // Check Data nil
        if (data["QuotationTotalSales"] as? Double) != nil {
            cell.Lb_Order.text = String(indexPath.row + 1) + "."
            cell.Lb_NameSeller.text = (data["FullName"] as! String)
            cell.Lb_SalesSeller.text = String(data["QuotationTotalSales"] as! Double).currencyFormatting() + " ฿"
            cell.Lb_QuotationSeller.text = String(data["QuotationCount"] as! Int)
        }
        else {
            cell.Lb_Order.text = String(indexPath.row + 1) + "."
            cell.Lb_NameSeller.text = (data["FullName"] as! String)
            cell.Lb_SalesSeller.text = "0" + " ฿"
            cell.Lb_QuotationSeller.text = String(data["QuotationCount"] as! Int)
        }
        
        
        
        /*if let data = MainMonitorPageController.DataSeller[indexPath.row] as? [String : String] {
            cell.Lb_Order.text = String(indexPath.row + 1) + "."
            cell.Lb_NameSeller.text = data["FullName"]
            cell.Lb_SalesSeller.text = String(data["QuotationTotalSales"]!).currencyFormatting() + " ฿"
            cell.Lb_QuotationSeller.text = data["QuotationCount"]
        }
        else {
            let data = MainMonitorPageController.DataSeller[indexPath.row] as? [String : Any]
            
            cell.Lb_Order.text = String(indexPath.row + 1) + "."
            cell.Lb_NameSeller.text = (data!["FullName"] as! String)
            cell.Lb_SalesSeller.text = "0" + " ฿"
            cell.Lb_QuotationSeller.text = String(data?["QuotationCount"] as! Int)
            
        }*/
        
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * (self.view.frame.width / 375)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! Tablecell_TopSeller
        
        // Set Data of Cell for row
        let data = MainMonitorPageController.DataSeller[indexPath.row] as [String : Any]

        let  NextPage = QuotationMonitorPageController()
        let navigation = UINavigationController(rootViewController: NextPage)
        navigation.modalPresentationStyle = .fullScreen
        
        // Filter Data Nil in Data Quotation
        let DataFilter_nil = MainMonitorPageController.DataQuo.filter{($0["Sales_idSales"] as? Double) != nil}
        
        // Send Data to Next Page and Filter Data follow Seller
        NextPage.DataQuo_Center = DataFilter_nil.filter{($0["Sales_idSales"] as! Int) == (data["idSales"] as! Int)}
        // Change State_ViewBefor
        NextPage.State_ViewBefor = true
        
        // Check Data Pass not No Data
        guard NextPage.DataQuo_Center.count > 0 else {
            return
        }
        
        
        self.present(navigation, animated: true, completion: nil)
        
        
    }
    
    
}
