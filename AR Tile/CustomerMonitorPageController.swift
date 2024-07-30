//
//  CustomerMonitorPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 20/6/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Charts
import UIDropDown

private var Id_TableType : String = "Tablecell_DataCustomerChart"

class CustomerMonitorPageController : UIViewController {
    
    // MARK: Parameter
    lazy var ratio = view.frame.width / 375
    
    // Parameter Option Of Chart Sty (Type, Income Chanel etc)
    var Option_Chart : [String] = ["Type", "Chanel"]
    
    // State For Update Data When View Appear
    var StateUpdate_DataAll : Bool = false
    
    
    // Key Header Json
    var Key_Type = Head_CustomerType()
    var Key_Chanel = Head_CustomerChanel()
    
    // Parameter DropDown Customer Chart
    var DropDown_Choose : Int = 0 {
        didSet {
            
            // Update Data Chart when DropDown Choose
            // Update TableView Data Chart
            var Count_Data : Int = 0
            if DropDown_Choose == 0 {
                Count_Data = Data_MCustomerType.count
                // Clear State Expended to False
                for count in 0..<Count_Data {
                    Data_MCustomerType[count].State_Expended = false
                }
                
            }
            else if DropDown_Choose == 1 {
                Count_Data = Data_MCustomerChanel.count
                // Clear State Expended to False
                for count in 0..<Count_Data {
                    Data_MCustomerChanel[count].State_Expended = false
                }
            }
            
            
            Height_TableAnchor.constant = (Height_TableCell * CGFloat(Count_Data))
            Table_DataChart.reloadData()
            
            // Update PieChart Customer Type
            Update_PieChartCustomerType()
        }
    }
    
    // Section Parameter Data of Customer Type and State Update
    // Parameter Customer Type Before Manage Data
    var Data_CustomerType : [[String : Any]]? = []
    // Parameter Customer After Manage Data
    var Data_MCustomerType : [Struct_CustomerType] = []
    // Parameter State Update Data
    var StateUpdate_CustomerType : Bool = false {
        didSet{
            
            // Check State Update DataAll and DataCustomerType
            
            if StateUpdate_DataAll == true && StateUpdate_CustomerType == true {
                
                
                self.Update_DataCustomerType()
                // Reset State Update Dta Customer type to Default
                StateUpdate_CustomerType = false
                
                
            }
            
        }
    }
    
    // -------------------------------------
    
    // Section Data Chanel Income Customer
    // Parameter Customer Chanel Income Before Manage Data
    var Data_CustomerChanel : [[String : Any]]? = []
    // Pameter Customer Chanel Income After Manage Data
    var Data_MCustomerChanel : [Struct_DataChanelIncome] = []
    // Parameter State Update Data Customer Chanel Income
    var StateUpdate_CustomerChanel : Bool = false {
        didSet{
            
            // Check State Update DataAll and State Update Data Customer Chanel Income
            if StateUpdate_DataAll == true && StateUpdate_CustomerChanel == true {
                
                // Check Data Customer Chanel Imcome != nil
                guard Data_CustomerChanel != nil else {return}
                
                // Update Data Customer Type
                Update_DataCustomerChanel()
                
                // Chaneg StateUpdate Data Customer Chanel to Default
                StateUpdate_CustomerChanel = false
                
            }
            
        }
    }
    
    
    
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
    var View_NumCustomer : UIView = {
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
    var Icon_NumCustomer : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "customer").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Header OverallSales
    lazy var Lb_HNumCustomer : UILabel = {
        let label = UILabel()
        label.text = "Customer amount"
        label.font = UIFont.MitrMedium(size: 25 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // Label OverallSales (NumTotalSales Company)
    lazy var Lb_NumCustomer : UILabel = {
        let label = UILabel()
        label.text = "0 People"
        label.font = UIFont.MitrMedium(size: 25 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    // ----------------------------------
    
    // Section Customer Chart
    // View Customer Chart
    var View_CustomerChart : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        
        return view
    }()
    // Icon Customer Chart
    var Icon_CustomerChart : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "customer-behavior").withRenderingMode(.alwaysTemplate)
        image.tintColor = .BlueDeep
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Customer Chart
    lazy var Lb_CustomerChart : UILabel = {
        let label = UILabel()
        label.text = "Customer Type"
        label.font = UIFont.MitrMedium(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // ViewDropDown Customer
    var View_DropDownCus : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // PieChart Customer Type
    var PieChart_Type : PieChartView = {
        let chart = PieChartView()
        chart.backgroundColor = .clear
        chart.legend.enabled = false
        
        // Setup PieChart
        chart.rotationEnabled = false
        chart.drawEntryLabelsEnabled = false
        chart.holeRadiusPercent = 0.3
        chart.transparentCircleRadiusPercent = 0
        
        
        return chart
    }()
    // Table View of Data Chart
    lazy var Table_DataChart : UITableView = {
        let table = UITableView()
        // Config Table View
        table.delegate = self
        table.dataSource = self
        table.register(Tablecell_DataCustomerChart.self, forCellReuseIdentifier: Id_TableType)
        
        // Setting Table View
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.isScrollEnabled = false
        // Set Height cell
        table.rowHeight = 235 * ratio
        table.estimatedRowHeight = 45 * ratio
        
        return table
    }()
    // Height Table Cell
    lazy var Height_TableCell = (45 * ratio)
    
    // Height TableView
    lazy var Height_TableAnchor =  self.Table_DataChart.heightAnchor.constraint(equalToConstant: self.Height_TableCell)
    
    // -----------------------------
    
    // MARK: Func Layout
    func Layout_Page(){
        
        // Set Background View
        view.backgroundColor = .systemGray6
        
        // ScrollView
        view.addSubview(ScrollView)
        ScrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 50 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        view.layoutIfNeeded()
        // -----------

        // StackView of Page
        let StackPage = UIStackView(arrangedSubviews: [View_NumCustomer, View_CustomerChart])
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
        View_NumCustomer.addSubview(Icon_NumCustomer)
        Icon_NumCustomer.anchor(View_NumCustomer.topAnchor, left: View_NumCustomer.leftAnchor, bottom: View_NumCustomer.bottomAnchor, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 75 * ratio, heightConstant: 75 * ratio)
        
        // Label Header Overall Sales
        View_NumCustomer.addSubview(Lb_HNumCustomer)
        Lb_HNumCustomer.anchor(nil, left: Icon_NumCustomer.rightAnchor, bottom: Icon_NumCustomer.centerYAnchor, right: View_NumCustomer.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 1 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Label Overall Sales
        View_NumCustomer.addSubview(Lb_NumCustomer)
        Lb_NumCustomer.anchor(Icon_NumCustomer.centerYAnchor, left: Lb_HNumCustomer.leftAnchor, bottom: nil, right: Lb_HNumCustomer.rightAnchor, topConstant: 1 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // -----------
        
        // Section Customer Chart
        // Icon Customer Chart
        View_CustomerChart.addSubview(Icon_CustomerChart)
        Icon_CustomerChart.anchor(View_CustomerChart.topAnchor, left: View_CustomerChart.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        // Label Header Customer Chart
        View_CustomerChart.addSubview(Lb_CustomerChart)
        Lb_CustomerChart.anchorCenter(nil, AxisY: Icon_CustomerChart.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_CustomerChart.anchor(nil, left: Icon_CustomerChart.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // View DropDown Customer Chart
        View_CustomerChart.addSubview(View_DropDownCus)
        View_DropDownCus.anchor(Lb_CustomerChart.topAnchor, left: Lb_CustomerChart.rightAnchor, bottom: Lb_CustomerChart.bottomAnchor, right: View_CustomerChart.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5 * ratio, rightConstant: 10 * ratio, widthConstant: 120 * ratio, heightConstant: 0)
        
        // Drop Down Customer Chart
        // Setting Drop Down Sort By
        view.layoutIfNeeded()
        let DropDownSort = UIDropDown(frame: View_DropDownCus.frame)
        DropDownSort.font = "Mitr-Light"
        DropDownSort.fontSize = (15 * ratio)
        DropDownSort.layer.borderWidth = 0
        DropDownSort.placeholder = Option_Chart[0]
        DropDownSort.options = Option_Chart
        DropDownSort.optionsFont = "Mitr-Light"
        DropDownSort.optionsSize = (15 * ratio)
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = (View_DropDownCus.frame.size.height * ratio)
        DropDownSort.tableHeight = CGFloat((View_DropDownCus.frame.size.height * ratio) * CGFloat(Option_Chart.count))
                  
        // Func DropDown Item Select
        DropDownSort.didSelect { (Text, index) in
            DropDownSort.placeholder = Text
            
            // Update index DropDown For Update Data
            self.DropDown_Choose = index
            
        }
        
        print(DropDown_Choose)
        
        // PieChart_Type
        View_CustomerChart.addSubview(PieChart_Type)
        PieChart_Type.anchor(Icon_CustomerChart.bottomAnchor, left: Icon_CustomerChart.leftAnchor, bottom: nil, right: View_DropDownCus.rightAnchor, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 300 * ratio)
        
        // TableView Data Chart
        View_CustomerChart.addSubview(Table_DataChart)
        Table_DataChart.anchor(PieChart_Type.bottomAnchor, left: PieChart_Type.leftAnchor, bottom: View_CustomerChart.bottomAnchor, right: PieChart_Type.rightAnchor, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Height_TableAnchor.constant = Height_TableCell * CGFloat(Data_MCustomerType.count)
        Height_TableAnchor.isActive = true

        // -----------
        
        // add DropDown Chart Sty
        View_CustomerChart.addSubview(DropDownSort)
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
    
    // MARK: Func Config
    func Config_Page(){
        
    }
    
    // MARK: Life Cycle of Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element In Page
        Layout_Page()
        // Config Element In Page
        Config_Page()
        
    }
    
    // Func View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Change State Update Data All
        StateUpdate_DataAll = true
        // Update Data Customer Type
        if StateUpdate_DataAll == true && StateUpdate_CustomerType == true {
            
            
            self.Update_DataCustomerType()
            // Reset State Update Dta Customer type to Default
            StateUpdate_CustomerType = false
        }
        // Update Data Customer Chanel Income
        if StateUpdate_DataAll == true && StateUpdate_CustomerChanel == true {
            
            // Check Data Customer Chanel Imcome != nil
            guard Data_CustomerChanel != nil else {return}
                           
            // Update Data Customer Type
            Update_DataCustomerChanel()
                           
            // Chaneg StateUpdate Data Customer Chanel to Default
            StateUpdate_CustomerChanel = false
            
        }
        
        
    }
    
    // VIew DisAppear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Change StateUpdate All Data to Default (False) When View Disappear
        StateUpdate_DataAll = false
        
        
    }
    
    // MARK: Func Event Button
    
    // MARK: Func Update CHart in Page
    func Update_PieChartCustomerType(){
        
        
        // Check DropDown Choose (Check Type Chart)
        // Type Chart
        if DropDown_Choose == 0 {
            // Check Data != 0
            guard Data_MCustomerType.count != 0 else {return}
            
            let DataFilter = Data_MCustomerType
            
            // Cal Percent Ratio Sales of Seller Compare Overall Sales of Company in during
            let Sum : Double = Double(DataFilter.map({$0.NumType}).reduce(0, +))
            let OnePer :Double = Double(Sum) / 100

            // Set Data Entry
            var entries : [PieChartDataEntry] = Array()
            var ColorChart : [UIColor] = []
            for count in 0..<DataFilter.count {
                
                let SalesSuccess : Double = Double(DataFilter[count].NumType) / OnePer
                entries.append(PieChartDataEntry(value: SalesSuccess, label: DataFilter[count].TypeName))
                
                // append ColorChart
                ColorChart.append(DataFilter[count].Color_Chart)
                
            }
            
            let DataSet = PieChartDataSet(entries: entries, label: "")
            DataSet.colors = ColorChart
            
            // Set Format of Value In Piechart
            let data = PieChartData(dataSet: DataSet)
            data.setValueFont(UIFont.MitrLight(size: 15 * ratio))
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            formatter.maximumFractionDigits = 1
            formatter.multiplier = 1.0
            data.setValueFormatter(ChartValueFormatter(numberFormatter: formatter))
            
            PieChart_Type.data = data
            
            // animation PieChart
            PieChart_Type.animate(yAxisDuration: 1.5)
            
            //This must stay at end of function
            PieChart_Type.notifyDataSetChanged()
        }
        else if DropDown_Choose == 1 {
            
            // Check Data != 0
            guard Data_MCustomerType.count != 0 else {return}
            
            let DataFilter = Data_MCustomerChanel
            
            // Cal Percent Ratio Sales of Seller Compare Overall Sales of Company in during
            let Sum : Double = Double(DataFilter.map({$0.NumChanel!}).reduce(0, +))
            let OnePer :Double = Double(Sum) / 100

            // Set Data Entry
            var entries : [PieChartDataEntry] = Array()
            var ColorChart : [UIColor] = []
            for count in 0..<DataFilter.count {
                
                let SalesSuccess : Double = Double(DataFilter[count].NumChanel!) / OnePer
                entries.append(PieChartDataEntry(value: SalesSuccess, label: DataFilter[count].NameChanel))
                
                // append ColorChart
                ColorChart.append(DataFilter[count].ColorChart)
                
            }
            
            let DataSet = PieChartDataSet(entries: entries, label: "")
            DataSet.colors = ColorChart
            
            // Set Format of Value In Piechart
            let data = PieChartData(dataSet: DataSet)
            data.setValueFont(UIFont.MitrLight(size: 15 * ratio))
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            formatter.maximumFractionDigits = 1
            formatter.multiplier = 1.0
            data.setValueFormatter(ChartValueFormatter(numberFormatter: formatter))
            
            PieChart_Type.data = data
            
            // animation PieChart
            PieChart_Type.animate(yAxisDuration: 1.5)
            
            //This must stay at end of function
            PieChart_Type.notifyDataSetChanged()
            
            
        }
        
        
    }
    
    // MARK: Func Update and Manage Data Customer Type
    // Update UI Section Data Customer Type
    func Update_DataCustomerType() {
        
        // Check Count of Data != 0
        guard Data_CustomerType!.count > 0 else {
            return
        }
        
        // Manage Data Customer Type
        Data_MCustomerType = [] // Clear Old Data
        Manage_DataCustomerType()
        
        // Check DropDown Choose
        if DropDown_Choose == 0 {
            // Update TableView Data Chart
            Height_TableAnchor.constant = (Height_TableCell * CGFloat(Data_MCustomerType.count))
            Table_DataChart.reloadData()
            
            // Update PieChart Customer Type
            Update_PieChartCustomerType()
        }
        
        // Update Num of All Customer
        let NumAllCustomer = Data_MCustomerType.map({ $0.NumType }).reduce(0,+)
        Lb_NumCustomer.text = String(NumAllCustomer) + " People"
        
    }
    
    // Manage Data Customer type
    func Manage_DataCustomerType() {
        
        // Manage Data Customer Type
        var NameType_Repeat : String = ""
        for count in 0..<Data_CustomerType!.count {
            
            // Name Type
            let NameType = Data_CustomerType![count][Key_Type.CustomerType] as! String
            // ---------------------------------
            
            // Nun Type
            // Check Data Num Type Nil
            if Data_CustomerType![count][Key_Type.NumType] as? Int == nil {
                
                Data_CustomerType![count][Key_Type.NumType] = 0
            }
            let NumType = Data_CustomerType![count][Key_Type.NumType] as! Int
            // ----------------------------------
            
        
            
            // Group Popular Product
            if NameType == NameType_Repeat {
                
                // find Index Name Type Repeat in Data_MCustomerType
                let index = Data_MCustomerType.firstIndex(where: {$0.TypeName == NameType})
                
                // Check Index Nil
                if index != nil {
                    // Manage Data Product Popular
                    let NameProduct = Data_CustomerType![count][Key_Type.ProductName] as! String
                    let NumProduct = (Data_CustomerType![count][Key_Type.NumProduct] as? Double) ?? 0
                    let data_product = Struct_PopularPro(Name_Product: NameProduct, Image_Product: #imageLiteral(resourceName: "Icon-Tile"), Num_Product: NumProduct)
                    
                    // append Data Popular Product
                    Data_MCustomerType[index!].ProductPop.append(data_product)
                }
                
            
            }else {
                
                // Record Data Popular Product
                let NameProduct = Data_CustomerType![count][Key_Type.ProductName] as! String
                let NumProduct = (Data_CustomerType![count][Key_Type.NumProduct] as? Double) ?? 0
                
                let data_Product = Struct_PopularPro(Name_Product: NameProduct, Image_Product: #imageLiteral(resourceName: "Icon-Tile"), Num_Product: NumProduct)
                
                // Record Data Customer Type
                let data = Struct_CustomerType(State_Expended: false, Color_Chart: .random, TypeName: NameType, NumType: NumType, ProductPop: [data_Product])
                
                Data_MCustomerType.append(data)
                
                // Update Name Type Repeat
                NameType_Repeat = NameType
                
            }
            
            
        }
        
        
    }
    
    // MARK: Func Update Ui and Manage Dtaa Customer Chanel Income
    // Update Dtaa Customer Chanel Income
    func Update_DataCustomerChanel() {
        
        // Check Counr of Data Customer Chanel Income
        guard Data_CustomerChanel!.count != 0 else {return}
        
        // Manage Data Customer Chanel Income
        Data_MCustomerChanel = []
        Manage_DataCustomerChanel()
        
        // Check DropDown Choose
        if DropDown_Choose == 1 {
            // Update TableView Data Chart
            Height_TableAnchor.constant = (Height_TableCell * CGFloat(Data_MCustomerChanel.count))
            // Update tableView Data Customer Chart
            Table_DataChart.reloadData()
        }
        
    }
    
    // Manage Data Customer Chanel Income
    func Manage_DataCustomerChanel(){
        
        print(Data_CustomerChanel)
        
        // Manaeg Data Customer Chanel Income
        for count in 0..<Data_CustomerChanel!.count {
            
            // Set Data for Record
            // Name
            let NameChanel = Data_CustomerChanel![count][Key_Chanel.Chanel] as! String
            // NumChanel
            let NumChanel = (Data_CustomerChanel![count][Key_Chanel.NumChanel] as? Int) ?? 0
            // Num Quo All
            let NumQuoAll = (Data_CustomerChanel![count][Key_Chanel.Num_TotalQuo] as? Int) ?? 0
            // Num Quo Success
            let NumQuoSuccess = (Data_CustomerChanel![count][Key_Chanel.Num_QuoSuccess] as? Int) ?? 0
            
            // Sales Total Quo
            let Sales_TotalQuo = (Data_CustomerChanel![count][Key_Chanel.Sales_TotalQuo] as? Double) ?? 0
            
            // Sales Quo Success
            let Sales_SuccessQuo = (Data_CustomerChanel![count][Key_Chanel.Sales_QuoSuccess] as? Double) ?? 0
            
            // Append Data to Data_MCustomer
            let data = Struct_DataChanelIncome(ColorChart: .random, State_Expended: false, NameChanel: NameChanel, NumChanel: NumChanel, NumQuoAll: NumQuoAll, NumQuoSuccess: NumQuoSuccess, SalesQuoSuccess : Sales_SuccessQuo, SalesQuoAll : Sales_TotalQuo)
            print(data)
            
            Data_MCustomerChanel.append(data)
            
            
        }
        
    }
    
    
}
// MARK: Extension
// Table View
extension CustomerMonitorPageController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Check DropDown Choose
        if DropDown_Choose == 0 {
            return Data_MCustomerType.count
        }
        else {
            return Data_MCustomerChanel.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Id_TableType, for: indexPath) as! Tablecell_DataCustomerChart
        
        // Set DropDown for Cell Show Section (Type, Chanel)
        cell.DropDown_Choose = DropDown_Choose
        
        // Type
        if DropDown_Choose == 0 {
            
            // Set Data for cell
            cell.State_Expended = Data_MCustomerType[indexPath.row].State_Expended
            // ColorChart
            cell.Set_ColorChart = Data_MCustomerType[indexPath.row].Color_Chart
            // NameType
            cell.Lb_NameChart.text = Data_MCustomerType[indexPath.row].TypeName
            // Num Type
            cell.Set_NumType = Data_MCustomerType[indexPath.row].NumType
            // DataProduct
            cell.Data_Product = Data_MCustomerType[indexPath.row].ProductPop
        }
        // Chanel
        else if DropDown_Choose == 1 {
            // Set Data for cell
            cell.State_Expended = Data_MCustomerChanel[indexPath.row].State_Expended
            // ColorChart
            cell.Set_ColorChart = Data_MCustomerChanel[indexPath.row].ColorChart
            // NameType
            cell.Lb_NameChart.text = Data_MCustomerChanel[indexPath.row].NameChanel
            // Num Type
            cell.Set_NumType = Data_MCustomerChanel[indexPath.row].NumChanel!
            // Set Quotation Success
            cell.Lb_QuoSuc.text = String(Data_MCustomerChanel[indexPath.row].NumQuoSuccess!)
            // Set label Quotation All
            cell.Lb_QuoAll.text = String(Data_MCustomerChanel[indexPath.row].NumQuoAll!)
            // Set label Sales Quo Success
            cell.Lb_SalesQuoSuc.text = String(Data_MCustomerChanel[indexPath.row].SalesQuoSuccess!).currencyFormatting() + " ฿"
            // Set label Sales Quo All
            cell.Lb_SalesQuoAll.text = String(Data_MCustomerChanel[indexPath.row].SalesQuoAll!).currencyFormatting() + " ฿"
            
            
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Check State Expended
        // Type Expended
        if DropDown_Choose == 0 {
            
            if Data_MCustomerType[indexPath.row].State_Expended {
                return UITableView.automaticDimension
            }
            else {
                return 45 * ratio
            }
            
        }
        // Chanel Expended
        else {
            if Data_MCustomerChanel[indexPath.row].State_Expended {
                return UITableView.automaticDimension
            }
            else {
                return 45 * ratio
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! Tablecell_DataCustomerChart
        
        if cell.State_Expended{
            //cell.State_Expended = false
            // Check DropDowm
            if DropDown_Choose == 0 {
                Data_MCustomerType[indexPath.row].State_Expended = false
            }
            else if DropDown_Choose == 1 {
                Data_MCustomerChanel[indexPath.row].State_Expended = false
            }

            // Update Height Table View
            UIView.animate(withDuration: 0.25) {
                self.Height_TableAnchor.constant -= (190 * self.ratio)
                self.view.layoutIfNeeded()
            }

            
        }
        else {
            //cell.State_Expended = true
            // Check DropDowm
            if DropDown_Choose == 0 {
                Data_MCustomerType[indexPath.row].State_Expended = true
            }
            else if DropDown_Choose == 1 {
                Data_MCustomerChanel[indexPath.row].State_Expended = true
            }

            // Update Height Table View
            UIView.animate(withDuration: 0.25) {
                self.Height_TableAnchor.constant += (190 * self.ratio)
                self.view.layoutIfNeeded()
            }
            
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        
    }
    
    
    
    
}

// Structure Data Customer
struct Struct_CustomerType {
    
    var State_Expended : Bool
    var Color_Chart : UIColor
    
    var TypeName : String
    var NumType : Int
    
    // Struct Popular Product
    var ProductPop : [Struct_PopularPro]
    
}

// Structuer Popular Product
struct Struct_PopularPro {
    
    var Name_Product : String
    var Image_Product : UIImage
    var Num_Product : Double
    
    
}

// Structure Data Customer Chanel Income
struct Struct_DataChanelIncome {
    
    var ColorChart : UIColor
    var State_Expended : Bool
    
    var NameChanel : String
    var NumChanel : Int?
    var NumQuoAll : Int?
    var NumQuoSuccess : Int?
    
    var SalesQuoSuccess : Double?
    var SalesQuoAll : Double?
    
    
}
