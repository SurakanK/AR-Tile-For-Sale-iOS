//
//  QuotationDetailController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 6/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentify = "Tablecell_ListProductQuotation"

class QuotationDetailController : UIViewController, UIScrollViewDelegate {
    
    //MARK: Parameter of Page
    var DataCross : [String] = [] // [StatusQuo, Name, Date, By]
    
    // Data Center Page
    var Data_Center = [[String : Any]]()
    
    // Count of List Product
    var CountPro : Int = 8
    
    // Parameter Url
    var url : String = "No Data" //DataSource.Url_GetDetailQuo() //"http://\(DataSource.IP())/arforsales/getquotation.php"
    
    
    //MARK: Element of Page
    // Icon Down
    var Icon_Down : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "down-arrow").withRenderingMode(.alwaysTemplate)
        image.tintColor = .BlueDeep
        image.layer.masksToBounds = true
        return image
    }()
    // Scroll View
    var ScrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    // -------------------------------------
    
    // View Detail Header
    var ViewDetail_1 : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // View Check
    var ViewCheck : UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    // Label Check
    var Lb_Check : UILabel = {
        let label = UILabel()
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.font = UIFont.PoppinsBold(size: 15)
        label.textAlignment = .center
        return label
    }()
    
    // Label ID Quotation
    var Lb_IDQuo : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsBold(size: 23)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Label Date
    var Lb_Date : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 13)
        label.textColor = .BlackAlpha(alpha: 0.6)
        return label
    }()
    // Label By Seller
    var Lb_By : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsRegular(size: 15)
        label.textColor = .BlueDeep
        return label
    }()
    
    
    // -------------------------------------
    // View List Product
    var ViewDetail_2 : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // Icon Header Lidt Product
    var Icon_ListPro : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "order_product")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    // Label Header List Product
    var Lb_ListPro : UILabel = {
        let label = UILabel()
        label.text = "Product List"
        label.font = UIFont.PoppinsBold(size: 23)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Header Name Column of List Product
    var ViewCoName : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    var Lb_Co_NamePro : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 13)
        label.text = "Name"
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    
    // Header Quantity Column of List Product
    var ViewCoQuan : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    var Lb_Co_QuanPro : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 13)
        label.text = "QYT"
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    
    // Header Price Column of  List Product
    var ViewCoPrice : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    var Lb_Co_Price : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 13)
        label.text = "Price"
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    
    // Header Total Column of List Product
    var ViewCoTotal : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        return view
    }()
    var Lb_Co_Total : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 13)
        label.text = "Total"
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    
    // Table List Product
    var TableListPro : UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.alwaysBounceVertical = false
        return table
    }()
    
    // Label Header Vat
    var ViewVAT : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    var Lb_Header_Vat : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 10)
        label.text = "VAT"
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    var Lb_Vat : UILabel = {
        let label = UILabel()
        label.text = "7 %"
        label.font = UIFont.PoppinsMedium(size: 10)
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    
    // Label Header Discount
    var ViewDiscount : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BlueLight//UIColor(red: 212/255, green: 20/255, blue: 90/255, alpha: 0.5)
        return view
    }()
    var Lb_Header_Discount : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 10)
        label.textColor = .white
        label.text = "Discount"
        label.textAlignment = .center
        return label
    }()
    var Lb_Discount : UILabel = {
        let label = UILabel()
        label.text = "10 %"
        label.font = UIFont.PoppinsMedium(size: 10)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // Label Header Discount
    var ViewTotal : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    var Lb_Header_Total : UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsMedium(size: 10)
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.text = "TOTAL"
        label.textAlignment = .center
        return label
    }()
    var Lb_Total : UILabel = {
        let label = UILabel()
        label.text = "10,080 ฿"
        label.font = UIFont.PoppinsMedium(size: 10)
        label.textColor = .BlackAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    
    // -------------------------------------

    
    
    //MARK: Layout of Page
    func Layout_Page(){
        
        // ratio of Page
        let ratio : CGFloat = view.frame.width / 375.0
        let ratio_H : CGFloat = view.frame.height / 812.0
        
        // view
        view.backgroundColor = .systemGray6
        
        // Icon Down
        view.addSubview(Icon_Down)
        
        Icon_Down.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Icon_Down.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 5 , leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40 * ratio, heightConstant: 30 * ratio)
        
        // ------------------------------------------
        // ScrollView
        
        view.addSubview(ScrollView)
        
        ScrollView.anchor(Icon_Down.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // ------------------------------------------
        // Stack View
        let StackView = UIStackView(arrangedSubviews: [ViewDetail_1, ViewDetail_2])
        StackView.axis = .vertical
        StackView.distribution = .fill
        StackView.spacing = 40
        ScrollView.addSubview(StackView)
        
        StackView.anchor(ScrollView.topAnchor, left: ScrollView.leftAnchor, bottom: ScrollView.bottomAnchor, right: ScrollView.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 10 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // View_Detail1
        // View Check
        ViewDetail_1.addSubview(ViewCheck)
        ViewCheck.anchor(ViewDetail_1.topAnchor, left: ViewDetail_1.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 110 * ratio, heightConstant: 30 * ratio)
        
        ViewCheck.layer.cornerRadius = (30 * ratio) / 2
        
        // Check State Quotation
        if DataCross[0] == "InProcess" {
            ViewCheck.backgroundColor = .systemYellow
        }
        else if DataCross[0] == "Complete" {
            ViewCheck.backgroundColor = .systemGreen
        }
        else if DataCross[0] == "Reject" {
            ViewCheck.backgroundColor = .systemRed
        }
        
        // Label Check in ViewCheck
        ViewCheck.addSubview(Lb_Check)
        Lb_Check.anchorCenter(ViewCheck.centerXAnchor, AxisY: ViewCheck.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Check.font = UIFont.PoppinsBold(size: 15 * ratio)

        // Label ID Quotation
        ViewDetail_1.addSubview(Lb_IDQuo)
        
        Lb_IDQuo.anchor(ViewCheck.bottomAnchor, left: ViewCheck.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_IDQuo.font = UIFont.PoppinsBold(size: 23 * ratio)

        // Label Date Quotation
        ViewDetail_1.addSubview(Lb_Date)
        
        Lb_Date.anchor(Lb_IDQuo.bottomAnchor, left: Lb_IDQuo.leftAnchor, bottom: nil, right: nil, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Date.font = UIFont.PoppinsRegular(size: 13 * ratio)
        
        // Label By Seller
        ViewDetail_1.addSubview(Lb_By)
        
        Lb_By.anchor(Lb_Date.bottomAnchor, left: Lb_Date.leftAnchor, bottom: ViewDetail_1.bottomAnchor, right: nil, topConstant: 20 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_By.font = UIFont.PoppinsRegular(size: 15 * ratio)
        // -------------------
        
        // ViewDetail_2
        // Icon Header List Product
        ViewDetail_2.addSubview(Icon_ListPro)
        
        Icon_ListPro.anchor(ViewDetail_2.topAnchor, left: ViewDetail_2.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 30 * ratio, heightConstant: 30 * ratio)
        
        // Label Header List Product
        ViewDetail_2.addSubview(Lb_ListPro)
        
        Lb_ListPro.anchorCenter(nil, AxisY: Icon_ListPro.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_ListPro.anchor(nil, left: Icon_ListPro.rightAnchor, bottom: nil, right: ViewDetail_2.rightAnchor, topConstant: 0, leftConstant: 15 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        Lb_ListPro.font = UIFont.PoppinsBold(size: 23 * ratio)
        
        // Column Header of List Product
        let width_CoHeader = (view.frame.width - (40 * ratio)) / 5
        
        // Header Co Name
        ViewDetail_2.addSubview(ViewCoName)
        ViewCoName.anchor(Icon_ListPro.bottomAnchor, left: Icon_ListPro.leftAnchor, bottom: nil, right: nil, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width_CoHeader * 2, heightConstant: 40 * ratio)

        ViewCoName.addSubview(Lb_Co_NamePro)
        Lb_Co_NamePro.anchorCenter(ViewCoName.centerXAnchor, AxisY: ViewCoName.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_NamePro.font = UIFont.PoppinsMedium(size: 13 * ratio)
        
        // Header Co Quantity
        ViewDetail_2.addSubview(ViewCoQuan)
        ViewCoQuan.anchor(ViewCoName.topAnchor, left: ViewCoName.rightAnchor, bottom: ViewCoName.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width_CoHeader * 0.9, heightConstant: 0)
        
        ViewCoQuan.addSubview(Lb_Co_QuanPro)
        Lb_Co_QuanPro.anchorCenter(ViewCoQuan.centerXAnchor, AxisY: ViewCoQuan.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_QuanPro.font = UIFont.PoppinsMedium(size: 13 * ratio)
        
        // Header Co Price
        ViewDetail_2.addSubview(ViewCoPrice)
        ViewCoPrice.anchor(ViewCoQuan.topAnchor, left: ViewCoQuan.rightAnchor, bottom: ViewCoQuan.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width_CoHeader * 0.9, heightConstant: 0)
        
        ViewCoPrice.addSubview(Lb_Co_Price)
        Lb_Co_Price.anchorCenter(ViewCoPrice.centerXAnchor, AxisY: ViewCoPrice.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_Price.font = UIFont.PoppinsMedium(size: 13 * ratio)
        
        // Header Co Total
        ViewDetail_2.addSubview(ViewCoTotal)
        ViewCoTotal.anchor(ViewCoPrice.topAnchor, left: ViewCoPrice.rightAnchor, bottom: ViewCoPrice.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width_CoHeader * 1.2 , heightConstant: 0)
        
        ViewCoTotal.addSubview(Lb_Co_Total)
        Lb_Co_Total.anchorCenter(ViewCoTotal.centerXAnchor, AxisY: ViewCoTotal.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Co_Total.font = UIFont.PoppinsMedium(size: 13 * ratio)
        
        // Table List Product
        ViewDetail_2.addSubview(TableListPro)
        
        TableListPro.anchor(ViewCoName.bottomAnchor, left: ViewCoName.leftAnchor, bottom: nil, right: ViewCoTotal.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: (40 * ratio) * CGFloat(Data_Center.count)) // Height * CountItem
        
        // Result of List Product
        // VAT
        ViewDetail_2.addSubview(ViewVAT)
        
        ViewVAT.anchor(TableListPro.bottomAnchor, left: ViewCoQuan.leftAnchor, bottom: nil, right: ViewCoTotal.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
        
        ViewVAT.addSubview(Lb_Header_Vat)
        
        Lb_Header_Vat.anchorCenter(nil, AxisY: ViewVAT.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Header_Vat.anchor(nil, left: ViewVAT.leftAnchor, bottom: nil, right: ViewCoPrice.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Header_Vat.font = UIFont.PoppinsMedium(size: 10 * ratio)
        
        ViewVAT.addSubview(Lb_Vat)
        
        Lb_Vat.anchorCenter(nil, AxisY: ViewVAT.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Vat.anchor(nil, left: ViewCoTotal.leftAnchor, bottom: nil, right: ViewCoTotal.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Vat.font = UIFont.PoppinsMedium(size: 10 * ratio)
        
        // Discount
        ViewDetail_2.addSubview(ViewDiscount)
        
        ViewDiscount.anchor(ViewVAT.bottomAnchor, left: ViewCoQuan.leftAnchor, bottom: nil, right: ViewCoTotal.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
        
        ViewDiscount.addSubview(Lb_Header_Discount)
        
        Lb_Header_Discount.anchorCenter(nil, AxisY: ViewDiscount.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Header_Discount.anchor(nil, left: ViewDiscount.leftAnchor, bottom: nil, right: ViewCoPrice.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Header_Discount.font = UIFont.PoppinsMedium(size: 10 * ratio)
        
        ViewDiscount.addSubview(Lb_Discount)
        
        Lb_Discount.anchorCenter(nil, AxisY: ViewDiscount.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Discount.anchor(nil, left: ViewCoTotal.leftAnchor, bottom: nil, right: ViewCoTotal.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Discount.font = UIFont.PoppinsMedium(size: 10 * ratio)
        
        // Total
        ViewDetail_2.addSubview(ViewTotal)
        
        ViewTotal.anchor(ViewDiscount.bottomAnchor, left: ViewCoQuan.leftAnchor, bottom: ViewDetail_2.bottomAnchor, right: ViewCoTotal.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
        
        ViewTotal.addSubview(Lb_Header_Total)
        
        Lb_Header_Total.anchorCenter(nil, AxisY: ViewTotal.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Header_Total.anchor(nil, left: ViewTotal.leftAnchor, bottom: nil, right: ViewCoPrice.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Header_Total.font = UIFont.PoppinsMedium(size: 10 * ratio)
        
        ViewTotal.addSubview(Lb_Total)
        
        Lb_Total.anchorCenter(nil, AxisY: ViewTotal.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_Total.anchor(nil, left: ViewCoTotal.leftAnchor, bottom: nil, right: ViewCoTotal.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Lb_Total.font = UIFont.PoppinsMedium(size: 10 * ratio)
        
        // Change BG of Result
        if CountPro % 2 == 1 {
            ViewVAT.backgroundColor = UIColor.BlueLight//UIColor(red: 212/255, green: 20/255, blue: 90/255, alpha: 0.5)
            Lb_Header_Vat.textColor = .white
            Lb_Vat.textColor = .white
            
            ViewDiscount.backgroundColor = .white
            Lb_Header_Discount.textColor = .BlackAlpha(alpha: 0.9)
            Lb_Discount.textColor = .BlackAlpha(alpha: 0.9)
            
            ViewTotal.backgroundColor = UIColor.BlueLight//UIColor(red: 212/255, green: 20/255, blue: 90/255, alpha: 0.5)
            Lb_Header_Total.textColor = .white
            Lb_Total.textColor = .white
        }
        // -------------------
        

    }
    
    // MARK: Func Scroll View in Page
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Disable Horizontol Scroll
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    //MARK: Config of Page
    func Config_Page(){
        
        // Data Quotation Initial
        Lb_Check.text = DataCross[0]
        Lb_IDQuo.text = DataCross[1]
        Lb_Date.text = DataCross[2]
        Lb_By.text = DataCross[3]
        
        // Config Table List Pro
        TableListPro.delegate = self
        TableListPro.dataSource = self
        TableListPro.register(Tablecell_ListProductQuotation.self, forCellReuseIdentifier: reuseIdentify)
        
        // Set Data Initial of Total Quotation Sales
        Lb_Vat.text = DataCross[4].currencyFormatting() + "%"
        Lb_Discount.text = DataCross[5].currencyFormatting() + "%"
        Lb_Total.text = DataCross[6]
        
        
        
        
    }
    
    //MARK: Event Page Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Page
        Layout_Page()
        
        // Config Page
        Config_Page()
        
        print(DataCross[0])
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Request Data From Server
        Request_DataServer(Url: url, Token: LoginPageController.DataLogin!.Token_Id)
        
    }
    
    // MARK: Func Request Data
    func Request_DataServer(Url : String, Token : String){
        
        // Set Parameter for Request
        let Header : HTTPHeaders = [.authorization(bearerToken: Token), .contentType("application/json")]
        let parameter = ["QuotationID" : DataCross[7]] // POST ID Quo
        AF.sessionConfiguration.timeoutIntervalForRequest = 1
        AF.request(Url, method: .post, parameters: parameter,encoding: JSONEncoding.default,headers: Header).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success(let value):
                let json = value as? [String : Any]
                // Record Data to Datacenter Page
                self.Data_Center = (json!["results"] as? [[String : Any]])!
                
                print(self.Data_Center)
                // Reload Table
                self.Layout_Page()
                self.TableListPro.reloadData()
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                break
            }
            
        }
        
    }
    
    //MARK: Func of Page
    
    
    //MARK: Alert Box
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

// MARKL Extention
// TableView Delegate and DataSource
extension QuotationDetailController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data_Center.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentify , for: indexPath) as! Tablecell_ListProductQuotation
        
        // Layout
        // ratio
        let ratio = cell.frame.width / 335
        
        // Label Name Product
        cell.Lb_NamePro.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_NamePro.anchor(nil, left: ViewCoName.leftAnchor, bottom: nil, right: ViewCoName.rightAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cell.Lb_NamePro.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Label Quantity Product
        cell.Lb_QuanPro.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_QuanPro.anchor(nil, left: ViewCoQuan.leftAnchor, bottom: nil, right: ViewCoQuan.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cell.Lb_QuanPro.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Label Price Product
        cell.Lb_PricePro.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_PricePro.anchor(nil, left: ViewCoPrice.leftAnchor, bottom: nil, right: ViewCoPrice.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cell.Lb_PricePro.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Label Total Product
        cell.Lb_TotalPro.anchorCenter(nil, AxisY: cell.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        cell.Lb_TotalPro.anchor(nil, left: ViewCoTotal.leftAnchor, bottom: nil, right: ViewCoTotal.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cell.Lb_TotalPro.font = UIFont.PoppinsRegular(size: 10 * ratio)
        
        // Change BG and Text Color
        if (indexPath.row + 1) % 2 == 0 {
            cell.backgroundColor = UIColor.BlueLight//UIColor(red: 212/255, green: 20/255, blue: 90/255, alpha: 0.5)
            cell.Lb_NamePro.textColor = .white
            cell.Lb_QuanPro.textColor = .white
            cell.Lb_PricePro.textColor = .white
            cell.Lb_TotalPro.textColor = .white
        }
        
        // ---------------------------
        
        // Set Data in Element
        let data = Data_Center[indexPath.row]
        
        cell.Lb_NamePro.text = String(indexPath.row + 1) + ". " + String(data["ProductName"]! as! String)
        cell.Lb_QuanPro.text = String(data["QuoproQuantity"]! as! Int)
        cell.Lb_PricePro.text = String(data["QuoproPrice"]! as! Double).currencyFormatting() + " ฿"
        let TotalPrice = Double(data["QuoproQuantity"]! as! Int) * Double(data["QuoproPrice"]! as! Double)
        cell.Lb_TotalPro.text = String(TotalPrice).currencyFormatting() + " ฿"
        
        /*cell.Lb_NamePro.text = String(indexPath.row + 1) + ". " + " GA-110"
        cell.Lb_QuanPro.text = "2" + " m²"
        cell.Lb_PricePro.text = "560" + " ฿"
        cell.Lb_TotalPro.text = "1,120" + " ฿"*/
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40 * (view.frame.width / 375)
    }
    
    
}
