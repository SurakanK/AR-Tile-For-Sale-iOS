//
//  DetailCustomerViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 27/5/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Charts
import UIDropDown
import Alamofire
import NVActivityIndicatorView

class DetailCustomerViewController: UIViewController {
    
    let tokenID = LoginPageController.DataLogin?.Token_Id

    var CellID = "Cell"
    weak var collectionView : UICollectionView?
    
    var DataCustomerDetail = [String : Any]()
    var DataTop5quotabyCustomer = [[String : Any]]()
    var DataQuotationFilter = [[String : Any]]()
    
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

    
    //Element Main
    var ScrollView : UIScrollView = {
        let Scroll = UIScrollView()
        return Scroll
    }()
    
    //Element Detail Customer
    let viewDetailCustomer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlueDeep.withAlphaComponent(0.15)
        return view
    }()
    
    let labelCompanyName: UILabel = {
        let label = UILabel()
        label.text = "บริษัท CP จำกัด มหาชน"
        label.textColor = .BlueLight
        label.font = UIFont.MitrMedium(size: 23)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let labelGradeCustomer: UILabel = {
        let label = UILabel()
        label.text = "B"
        label.textColor = .white
        label.font = UIFont.MitrMedium(size: 25)
        label.textAlignment = .center
        label.backgroundColor = .systemYellow
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    let labelTypeTitle: UILabel = {
        let label = UILabel()
        label.text = "Type      : "
        label.textColor = .BlackAlpha(alpha: 0.7)
        label.font = UIFont.MitrRegular(size: 15)
        label.numberOfLines = 1
        return label
    }()
    
    let labelTypeMessage: UILabel = {
        let label = UILabel()
        label.text = "วิศวกร"
        label.textColor = .BlackAlpha(alpha: 0.7)
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let labelAddressTitle: UILabel = {
        let label = UILabel()
        label.text = "Address  : "
        label.textColor = .BlackAlpha(alpha: 0.7)
        label.font = UIFont.MitrRegular(size: 15)
        label.numberOfLines = 1
        return label
    }()
    
    let labelAddressMessage: UILabel = {
        let label = UILabel()
        label.text = "7 ซอยรามคำแหง 0 เขต บางกระปิ แขวง บางกระปิ กรุงเทพ 10020"
        label.textColor = .BlackAlpha(alpha: 0.7)
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let labelContractTitle: UILabel = {
        let label = UILabel()
        label.text = "Contract : "
        label.textColor = .BlackAlpha(alpha: 0.7)
        label.font = UIFont.MitrRegular(size: 15)
        label.numberOfLines = 1
        return label
    }()
    
    let labelContractMessage: UILabel = {
        let label = UILabel()
        label.text = "นาย ประยุทธ ซันโนบรา \nPhone : 081-856-7890 \nFb : ประยุทธ ซันโนบรา \nLine : -"
        label.textColor = .BlackAlpha(alpha: 0.7)
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let labelChanelIncomeTitle: UILabel = {
        let label = UILabel()
        label.text = "Chanel Income : "
        label.textColor = .BlackAlpha(alpha: 0.7)
        label.font = UIFont.MitrRegular(size: 15)
        label.numberOfLines = 1
        return label
    }()
    
    let labelChanelIncomeMessage: UILabel = {
        let label = UILabel()
        label.text = "FaceBook"
        label.textColor = .BlackAlpha(alpha: 0.7)
        label.font = UIFont.MitrLight(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    //Element Purchase
    let viewPurchase: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlueDeep
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    let imageViewIconBaht: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "baht2")
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 40
        return image
    }()
    
    let labelPurchaseTitle: UILabel = {
        let label = UILabel()
        label.text = "Purchase amount"
        label.textColor = .white
        label.font = UIFont.MitrMedium(size: 25)
        label.numberOfLines = 1
        return label
    }()
    
    let labelPurchaseMessage: UILabel = {
        let label = UILabel()
        label.text = "10,000,000 ฿"
        label.textColor = .white
        label.font = UIFont.MitrMedium(size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    //Element Detail Quotation
    let viewQuotationDetail: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    let labelQuotationTitle: UILabel = {
        let label = UILabel()
        label.text = "Quotation"
        label.textColor = .BlueDeep
        label.font = UIFont.MitrMedium(size: 25)
        label.numberOfLines = 1
        return label
    }()
    
    var PieChart : PieChartView = {
        let chart = PieChartView()
        chart.legend.font = UIFont.PoppinsRegular(size: 10)
        chart.legend.textColor = .BlackAlpha(alpha: 0.8)
        chart.drawEntryLabelsEnabled = false
        chart.highlightPerTapEnabled = false
        chart.rotationEnabled = false
        chart.backgroundColor = .clear
        return chart
    }()
    
    let labelTop5Title: UILabel = {
        let label = UILabel()
        label.text = "Top 5 offering"
        label.textColor = .black
        label.font = UIFont.MitrMedium(size: 18)
        label.numberOfLines = 1
        return label
    }()
    
    let DropDownQuotationFilter: UIDropDown = {
        let DropDownSort = UIDropDown(frame: CGRect(x: 0, y: 0, width: 145, height: 25))
        let DataSort = ["ยอดขายมากสุด","ยอดขายน้อยสุด","เสนอขายล่าสุด"]
        DropDownSort.font = "Mitr-Light"
        DropDownSort.fontSize = 15
        DropDownSort.layer.borderWidth = 0
        DropDownSort.placeholder = "ยอดขายมากสุด"
        DropDownSort.options = DataSort
        DropDownSort.optionsFont = "Mitr-Light"
        DropDownSort.optionsSize = 15
        DropDownSort.hideOptionsWhenSelect = true
        DropDownSort.rowHeight = 50
        DropDownSort.tableHeight = 50 * CGFloat(DataSort.count)
        
        return DropDownSort
    }()
    
    //Element Button View Quotation All
    let buttonViewQuotationAll: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 5
        button.setTitle("View Quotation All", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18)
        button.addTarget(self, action: #selector(ViewQuotationAll), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationSetting()
        ElementSetting()
        DropDownEvent()
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
        
        view.backgroundColor = .systemGray6

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let idCustomer = DataCustomerDetail["idCustomer"] as? Int
        gettopquotationbyCustomer(token: tokenID!, idCustomer: String(idCustomer!))
        
        ManageDataDetail()
    }
    
    
    override func willMove(toParent parent: UIViewController?) {
        
    }
    
    func NavigationSetting(){
        
        navigationItem.title = "Detail Customer"
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
    
    }
    
    func ElementSetting(){

        //CollectionView Setting
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView = collection
        collectionView!.register(CustomerQuotationViewCell.self, forCellWithReuseIdentifier: CellID)
        collectionView!.backgroundColor = .white
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
        //Setting Element Main
        view.addSubview(ScrollView)
        ScrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
               
        ScrollView.contentOffset.x = 0
        
        //Setting Element Detail Customer
        ScrollView.addSubview(viewDetailCustomer)
        viewDetailCustomer.addSubview(labelCompanyName)
        viewDetailCustomer.addSubview(labelGradeCustomer)
        viewDetailCustomer.addSubview(labelTypeTitle)
        viewDetailCustomer.addSubview(labelTypeMessage)
        viewDetailCustomer.addSubview(labelAddressTitle)
        viewDetailCustomer.addSubview(labelAddressMessage)
        viewDetailCustomer.addSubview(labelContractTitle)
        viewDetailCustomer.addSubview(labelContractMessage)
        viewDetailCustomer.addSubview(labelChanelIncomeTitle)
        viewDetailCustomer.addSubview(labelChanelIncomeMessage)

        viewDetailCustomer.anchor(ScrollView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelCompanyName.anchor(viewDetailCustomer.topAnchor, left: viewDetailCustomer.leftAnchor, bottom: nil, right: labelGradeCustomer.leftAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        labelGradeCustomer.anchor(labelCompanyName.topAnchor, left: nil, bottom: nil, right: viewDetailCustomer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 40, heightConstant: 40)
        
        labelTypeTitle.anchor(labelCompanyName.bottomAnchor, left: labelCompanyName.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 0)

        labelTypeMessage.anchor(labelTypeTitle.topAnchor, left: labelTypeTitle.rightAnchor, bottom: nil, right: viewDetailCustomer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelAddressTitle.anchor(labelTypeMessage.bottomAnchor, left: labelCompanyName.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 0)
        
        labelAddressMessage.anchor(labelAddressTitle.topAnchor, left: labelAddressTitle.rightAnchor, bottom: nil, right: viewDetailCustomer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelContractTitle.anchor(labelAddressMessage.bottomAnchor, left: labelCompanyName.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 0)
        
        labelContractMessage.anchor(labelContractTitle.topAnchor, left: labelContractTitle.rightAnchor, bottom: nil, right: viewDetailCustomer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        labelChanelIncomeTitle.anchor(labelContractMessage.bottomAnchor, left: labelCompanyName.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 0)
        
        
        labelChanelIncomeMessage.anchor(labelChanelIncomeTitle.topAnchor, left: labelChanelIncomeTitle.rightAnchor, bottom: viewDetailCustomer.bottomAnchor, right: viewDetailCustomer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)// Buttom anchor viewDetailCustomer
        
        //Setting Element Purchase
        ScrollView.addSubview(viewPurchase)
        viewPurchase.addSubview(imageViewIconBaht)
        viewPurchase.addSubview(labelPurchaseTitle)
        viewPurchase.addSubview(labelPurchaseMessage)

        viewPurchase.anchor(viewDetailCustomer.bottomAnchor, left: viewDetailCustomer.leftAnchor, bottom: nil, right: viewDetailCustomer.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        
        imageViewIconBaht.anchor(viewPurchase.topAnchor, left: viewPurchase.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 80)
        
        labelPurchaseTitle.anchor(imageViewIconBaht.topAnchor, left: imageViewIconBaht.rightAnchor, bottom: nil, right: viewPurchase.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        labelPurchaseMessage.anchor(nil, left: imageViewIconBaht.rightAnchor, bottom: imageViewIconBaht.bottomAnchor, right: viewPurchase.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        //Setting Element Detail Quotation
        ScrollView.addSubview(viewQuotationDetail)
        viewQuotationDetail.addSubview(labelQuotationTitle)
        viewQuotationDetail.addSubview(PieChart)
        viewQuotationDetail.addSubview(labelTop5Title)
        viewQuotationDetail.addSubview(collectionView!)
        viewQuotationDetail.addSubview(buttonViewQuotationAll)
        viewQuotationDetail.addSubview(DropDownQuotationFilter)

        viewQuotationDetail.anchor(viewPurchase.bottomAnchor, left: viewDetailCustomer.leftAnchor, bottom: ScrollView.bottomAnchor, right: viewDetailCustomer.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        labelQuotationTitle.anchor(viewQuotationDetail.topAnchor, left: viewQuotationDetail.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        PieChart.anchor(labelQuotationTitle.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 300, heightConstant: 300)
        PieChart.anchorCenter(viewQuotationDetail.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        labelTop5Title.anchor(PieChart.bottomAnchor, left: viewQuotationDetail.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        DropDownQuotationFilter.anchor(nil, left: nil, bottom: labelTop5Title.bottomAnchor, right: viewQuotationDetail.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 145, heightConstant: 25)
        
        collectionView?.anchor(labelTop5Title.bottomAnchor, left: viewQuotationDetail.leftAnchor, bottom: nil, right: viewQuotationDetail.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        buttonViewQuotationAll.anchor(collectionView?.bottomAnchor, left: collectionView?.leftAnchor, bottom: viewQuotationDetail.bottomAnchor, right: collectionView?.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 45)// Bottom anchor viewQuotationDetail
        
        
        ScrollView.contentSize = viewQuotationDetail.bounds.size

    }

    func DropDownEvent(){
        DropDownQuotationFilter.didSelect { (Text, index) in
            self.DropDownQuotationFilter.placeholder = Text
            
            switch Text {
            case "ยอดขายมากสุด":
                self.DataQuotationFilter = self.DataTop5quotabyCustomer.sorted{($0["TotalSales"] as! Double) >= ($1["TotalSales"] as! Double)}
            case "ยอดขายน้อยสุด":
                self.DataQuotationFilter = self.DataTop5quotabyCustomer.sorted{($0["TotalSales"] as! Double) <= ($1["TotalSales"] as! Double)}
            case "เสนอขายล่าสุด":
                self.DataQuotationFilter = self.DataTop5quotabyCustomer.sorted{($0["TotalSales"] as! Double) >= ($1["TotalSales"] as! Double)}
            default:
                print("DropDownQuotationFilter Error")
            }
            self.collectionView?.reloadData()
        }
                
    }
    
    func ManagePieChartDetail(Inprocess : Int, Completeds : Int, Redjected : Int){
        
        let Value : [Double] = [Double(Completeds),Double(Inprocess),Double(Redjected)]
        let Label = ["Complete", "InProcess", "Reject"]
        let ColorList : [UIColor] = [.systemGreen, .systemYellow, .systemRed]
        var ColorChoose : [UIColor] = []
        
        var PieDataEntry = [PieChartDataEntry]()
        // Apeend DataEntry
        let Sum = Value.reduce(0,+)
        let OnePer : Double = Sum / 100
        for count in 0...2 {
            // Check Data > 0
            if Value[count] > 0 {
                // Cal Sum and Percentage
                let ValuePer : Double = Value[count] / OnePer
                let DataLabel = Label[count] + "(\(String(Int(Value[count])))" + ")"
                let DataEntry = PieChartDataEntry(value: ValuePer, label: DataLabel)
                ColorChoose.append(ColorList[count])
                PieDataEntry.append(DataEntry)
            }
            
        }

        
        let dataSet = PieChartDataSet(entries: PieDataEntry, label: "")
        let data = PieChartData(dataSet: dataSet)
        
        dataSet.colors = ColorChoose//[NSUIColor(cgColor: UIColor.systemGreen.cgColor),NSUIColor(cgColor: UIColor.systemYellow.cgColor),NSUIColor(cgColor: UIColor.systemRed.cgColor)]
        
        // Set Sty of Value
        data.setValueFont(UIFont.PoppinsMedium(size: 13))
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        data.setValueFormatter(ChartValueFormatter(numberFormatter: formatter))
        PieChart.data = data
        
        //This must stay at end of function
        PieChart.notifyDataSetChanged()
    }
    
    func ManageDataDetail(){
        
        
        let CompanyName = DataCustomerDetail["CustomerCompanyName"] as? String
        let CustomerType = DataCustomerDetail["CustomerType"] as? String
        let CompanyAddress = DataCustomerDetail["CustomerCompanyAddress"] as? String
        let ContactName = DataCustomerDetail["CustomerContactName"] as? String
        let ContactTel = DataCustomerDetail["CustomerContactTel"] as? String
        let ContactEmail = DataCustomerDetail["CustomerContactEmail"] as? String
        let ContactLine = DataCustomerDetail["CustomerContactLine"] as? String
        let Recommendedby = DataCustomerDetail["CustomerRecommendedby"] as? String
        let CustomerGrade = DataCustomerDetail["CustomerGrade"] as? String
        let CustomerTotalSales = DataCustomerDetail["TotalSales"] as? Double
        
        let QuotaInprocess = DataCustomerDetail["QuotationInprocess"] as? Int
        let QuotaCompleteds = DataCustomerDetail["QuotationCompleteds"] as? Int
        let QuotaRedjected = DataCustomerDetail["QuotationRedjected"] as? Int
        
        labelCompanyName.text = CompanyName
        labelTypeMessage.text = ConvertCustomerType(type: CustomerType!)
        
        var Address = ""
        let DataAddress = CompanyAddress!.split(separator: "$")
        if DataAddress.count != 0{
              Address = String(DataAddress[0]) + " " +
                        String(DataAddress[1]) + " " +
                        String(DataAddress[2]) + " " +
                        String(DataAddress[3]) + " " +
                        String(DataAddress[4])
        }
        
        labelAddressMessage.text = Address
        
        labelContractMessage.text = ContactName! + " \nPhone : " + ContactTel! + " \nEmail : " + ContactEmail! + " \nLine : " + ContactLine!
        labelChanelIncomeMessage.text = Recommendedby
        
        labelGradeCustomer.text = CustomerGrade
        labelGradeCustomer.backgroundColor = ManageCustomerGrades(Grades: CustomerGrade!)
        
        labelPurchaseMessage.text = String(format: "%.1f" ,CustomerTotalSales!) + " ฿"
        
        ManagePieChartDetail(Inprocess: QuotaInprocess!, Completeds: QuotaCompleteds!, Redjected: QuotaRedjected!)
        
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
    
    //Request Data from Server
    func gettopquotationbyCustomer(token:String , idCustomer: String){
        // Show Loader
        Show_Loader()
        
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_adminGetTopQuotationByCustomer()
        let parameter = ["idCustomer":idCustomer]
        
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                   
                    self.DataTop5quotabyCustomer = JSON!["results"] as! [[String : Any]]
                    self.DataQuotationFilter = self.DataTop5quotabyCustomer
                    
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
    
    // MARK: Btn View All Quotation
    @objc func ViewQuotationAll() {
        
        let QuoPage = ManageQuotationController()
        // Pass Data to Manage Quotation Page
        QuoPage.State_CustomerPage = true
        QuoPage.Name_Customer = self.DataCustomerDetail["CustomerCompanyName"] as? String
        
        if LoginPageController.DataLogin?.AdminUse == true {
            QuoPage.Sale_Use = false
        }
        
        // Next Page
        self.navigationController?.pushViewController(QuoPage, animated: true)
        
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

extension DetailCustomerViewController: UICollectionViewDelegate, UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = DataTop5quotabyCustomer.count
        
        //Layout collectionView height follow Data Top5 quotation byCustomer
        let heightAnchor = 145 * CGFloat(count)
        if heightAnchor > 0 {
            collectionView.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! CustomerQuotationViewCell
        
        let DataIndex = DataQuotationFilter[indexPath.row]
        print(DataIndex)
        let TotalSales = DataIndex["TotalSales"] as? Double
        let RecName = DataIndex["QuotationRecName"] as? String
        let Date = DataIndex["BeginDate"] as? String
        let CompanyName = DataCustomerDetail["CustomerCompanyName"] as? String
        let BySale = DataCustomerDetail["SalesFullname"] as? String
        
        cell.labelPrice.text = String(TotalSales!) + " ฿"
        cell.labelID.text = RecName
        cell.labelDate.text = "Date : " + Date!
        cell.labelCustomer.text = "Customer : " + CompanyName!
        cell.labelBySale.text = "By : " + BySale!
        
        cell.btnTapAction = { () in
            
            // Pass Data And Push to Detail Quotation Page
            let DetailPage = DetailQuotationController()
            DetailPage.Data_Pass = DataIndex
            
            if LoginPageController.DataLogin!.AdminUse {
                DetailPage.Sale_Use = false
            }
            else {
                DetailPage.Sale_Use = true
            }
            
            self.navigationController?.pushViewController(DetailPage, animated: true)
            
        }
        
        return cell
    }
}

extension DetailCustomerViewController: UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
          let itemWidth: CGFloat = (UIScreen.main.bounds.width - 40)
          return CGSize(width: itemWidth, height: 135)
    }
      
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
          
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
      
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          
        return 10
    }
     
}

