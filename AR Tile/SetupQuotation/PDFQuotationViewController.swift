//
//  PDFQuotationViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 9/4/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import MessageUI
import Alamofire
import NVActivityIndicatorView

class PDFQuotationViewController: UIViewController{

    let tokenID = LoginPageController.DataLogin?.Token_Id

    weak var tableView : UITableView?
    var CellID = "CellIDdd"
    
    var DataQuoCompany = [String:Any]()
    var DataQuoCustomer = [String:String]()
    var DataQuoSale = [String:String]()
    var DataQuoProduct = [[String:Any]]()
    var DataQuoProductPrice = [String:String]()
    var DataQuoApproved = [String:Any]()

    var discountTotal : Double = 0

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
    
    let PDFView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //Element Header-------------------------------------------------------------------------------------------------
    let imageLogo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Logo TheThreeTouch")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    let companyNametile: UILabel = {
        let label = UILabel()
        label.text = "บริษัท เดอะตรีทัช เอเชียแปซิฟิค จำกัด"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 8, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let companyAddresstitle: UILabel = {
        let label = UILabel()
        label.text = "56/23 ถ.เสรีไทย แขวงรามอินทรา เขตคันนายาว กรุงเทพ 10240"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let companyEmailandWebtitle: UILabel = {
        let label = UILabel()
        label.text = "Email : threetouch@gmail.com , Web : www.theetouch.com"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let companyPhoneandFaxtitle: UILabel = {
        let label = UILabel()
        label.text = "Phone : 02-379-9065 , Fax : 02-379-9070"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let companyTaxIDtitle: UILabel = {
        let label = UILabel()
        label.text = "เลขประจำตัวผู้เสียภาษี : 0105546037171"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let companyRemarktitle: UILabel = {
        let label = UILabel()
        //label.text = "////////////////////////////////////////////////////////////////////////////////////////////////////////////"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    //Element sub Header------------------------------------------------------------------------------------------------
    let customerCompanyNametitle: UILabel = {
        let label = UILabel()
        label.text = "บริษัท รุ่งเรืองกิจ คอนสตรัคชั่น เอ็นจิเนียริ่ง จำกัด"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let customerCompanyAddresstitle: UILabel = {
        let label = UILabel()
        label.text = "20 ซอยวชิระธรรมสาธิต 55 แขวงบางจาก แขวงพระโขนง กรุงเทพ 092-897-2929"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    let customerContactNametitle: UILabel = {
        let label = UILabel()
        label.text = "ผู้ติดต่อ : ชมด ชดใช้กรรม"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let customerContactPhonetitle: UILabel = {
        let label = UILabel()
        label.text = "เบอร์ : 094-583-4924"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let customerContactRemarktitle: UILabel = {
        let label = UILabel()
        label.text = "Email abbblack@gmail.com  line addblack"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let numberOfQuotationtitle: UILabel = {
        let label = UILabel()
        label.text = "เลขที่ใบเสนอราคา : SO63021021"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let dateOfQuotationtitle: UILabel = {
        let label = UILabel()
        label.text = "วันที่ 20/10/63 เวลา 10:30"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let saleNametitle: UILabel = {
        let label = UILabel()
        label.text = "พนักงานขาย : สุรกานต์ กาสุรงค์"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let salePhonetitle: UILabel = {
        let label = UILabel()
        label.text = "เบอร์ : 0802868363"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let saleEmailtitle: UILabel = {
        let label = UILabel()
        label.text = "Email : surakan@gmail.com"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()

    let saleRemarktitle: UILabel = {
        let label = UILabel()
        label.text = "Line 0802868363"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    //Element product------------------------------------------------------------------------------------------------
    let mainProduct: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let numberkHeader: UILabel = {
        let label = UILabel()
        label.text = "No."
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 6, weight: .medium)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let productNameAndDescripHeader: UILabel = {
        let label = UILabel()
        label.text = "รหัสสินค้า/รายระเอียด"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.numberOfLines = 0
        return label
    }()
        
    let areaHeader: UILabel = {
        let label = UILabel()
        label.text = "จำนวน"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let unitPriceHeader: UILabel = {
        let label = UILabel()
        label.text = "หน่วยละ"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let discounHeader: UILabel = {
        let label = UILabel()
        label.text = "ส่วนลด"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let priceTotalHeader: UILabel = {
        let label = UILabel()
        label.text = "จำนวนเงิน"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    //Element product Footer------------------------------------------------------------------------------------------------
    let viewFooter: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let totalProduct: UILabel = {
        let label = UILabel()
        label.text = "527,476.64"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let Discount: UILabel = {
        let label = UILabel()
        label.text = "0.00"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let totalDiscount: UILabel = {
        let label = UILabel()
        label.text = "527,476.64"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let totalVAT: UILabel = {
        let label = UILabel()
        label.text = "36,923.36"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let totalFull: UILabel = {
        let label = UILabel()
        label.text = "9,074,465.77"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let totalProductitle: UILabel = {
        let label = UILabel()
        label.text = "รวมเป็นเงิน"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let Discounttitle: UILabel = {
        let label = UILabel()
        label.text = "หักส่วนลด"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let totalDiscounttitle: UILabel = {
        let label = UILabel()
        label.text = "จำนวนเงินหลังหักส่วนลด"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let totalVATtitle: UILabel = {
        let label = UILabel()
        label.text = "จำนวนภาษีมูลค่าเพิ่ม : 7%"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let totalFulltitle: UILabel = {
        let label = UILabel()
        label.text = "จำนวนเงินรวมทั้งสิ้น"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let productRemarktile: UILabel = {
        let label = UILabel()
        label.text = "หมายเหตุ : "
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 5
        return label
    }()
    
    let totalFullTexttitle: UILabel = {
        let label = UILabel()
        label.text = "ตัวอักษร : (เก้าล้านเจ็ดหมื่นสี่พันสี่ร้อยหกสิห้าบาทเจ็ดสิบเจ็ดสตางค์ถ้วน)"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    //Element Approved------------------------------------------------------------------------------------------------
    let viewApproved: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let footerCustomertitle: UILabel = {
        let label = UILabel()
        label.text = "ผู้สั่งซื้อสินค้า"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let footerCreatBytitle: UILabel = {
        let label = UILabel()
        label.text = "ผู้จัดทำ"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let footerApprovedtitle: UILabel = {
        let label = UILabel()
        label.text = "ผู้อนุมัติ"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let footviewCustomer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let footerCreatByName: UILabel = {
        let label = UILabel()
        label.text = "(สุรกานต์ กาสุรงค์)"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()

    let footerApprovedName: UILabel = {
        let label = UILabel()
        label.text = "(สุรกานต์ กาสุรงค์)"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 6, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    let imageAutographCreatBy: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "autographTest")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let imageAutographApproved: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "autographTest")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGray6
        
        navigationItem.rightBarButtonItem = editButtonItem
        let edit = UIBarButtonItem(title: "submit", style: .plain, target: self, action: #selector(getTapped))
        navigationItem.rightBarButtonItems = [edit]
        
        // ConfigRegister Tableview cell
        let table =  UITableView(frame: .zero, style: .plain)
        tableView = table
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.tableFooterView = UIView()
        tableView!.backgroundColor = UIColor.systemGray5
        tableView!.separatorStyle = .none
        tableView!.rowHeight = UITableView.automaticDimension
        tableView!.isScrollEnabled = false
        tableView!.register(PDFQuotationViewCell.self, forCellReuseIdentifier: CellID)
        tableView?.backgroundColor = .white
        
        let width : CGFloat = 375 - 20
        view.addSubview(PDFView)
        PDFView.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        PDFView.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width, heightConstant: width * 1.4141)
        
    
        QuoSetlayoutHeader()
        QuoSetlayoutsubHeader()
        QuoSetlayoutProduct()
        QuoSetlayoutApproved()
        
        PDFData()
        
        //Set anchor Animation Load
        AnimationViewLoadAnchor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        discountTotal = 0
    }
    
    func PDFData(){
        
        // data company Header
        if DataQuoCompany["companyShowLogo"] as? Int == 1{
            imageLogo.image = DataQuoCompany["companylogo"] as? UIImage
        }else{
            imageLogo.image = nil
        }
        
        companyNametile.text = DataQuoCompany["companyName"] as? String
        companyAddresstitle.text = DataQuoCompany["companyAddress"] as? String
        companyEmailandWebtitle.text = DataQuoCompany["companyEmailandWeb"] as? String
        companyPhoneandFaxtitle.text = DataQuoCompany["companyPhoneandFax"] as? String
        companyTaxIDtitle.text = "เลขประจำตัวผู้เสียภาษี : " + (DataQuoCompany["companyTAX"] as! String)
        companyRemarktitle.text = " "
        
        // data sub Header customer
        customerCompanyNametitle.text = DataQuoCustomer["CompanyName"]
        
        var Address = ""
        let DataAddress = DataQuoCustomer["CompanyAddress"]!.split(separator: "$")
        if DataAddress.count != 0{
              Address = String(DataAddress[0]) + " " +
                        String(DataAddress[1]) + " " +
                        String(DataAddress[2]) + " " +
                        String(DataAddress[3]) + " " +
                        String(DataAddress[4])
        }
        
        customerCompanyAddresstitle.text = Address
        
        customerContactNametitle.text = "ผู้ติดต่อ : " + DataQuoCustomer["ContactName"]!
        customerContactPhonetitle.text = "เบอร์ : " + DataQuoCustomer["ContactTel"]!
        
        let Remark = "Email:" + DataQuoCustomer["ContactEmail"]! + " , Line:" + DataQuoCustomer["ContactLine"]! +
                    " , Remark:" + DataQuoCustomer["Remark"]!
        customerContactRemarktitle.text = Remark
        
        // data sub Header Quotation date
        let date = Date()
        let formatter = DateFormatter()
        
        // date for qoutation
        formatter.dateFormat = "วันที่ dd/MM/YYY เวลา HH:mm "
        let dateQoutation = formatter.string(from: date)
        dateOfQuotationtitle.text = dateQoutation
        
        // Creat qoutation ID
        formatter.dateFormat = "YYY.MM.dd"
        let dateQoutatioID = formatter.string(from: date)
        let DataSplit = dateQoutatioID.split(separator: ".")
        
        var QoutationID = "QA"
        for index in 0..<DataSplit.count {
            QoutationID = QoutationID + DataSplit[index]
        }
        
        numberOfQuotationtitle.text = "เลขที่ใบเสนอราคา : " + QoutationID
       
        // data sub Header sale
        saleNametitle.text = "พนักงานขาย : " + DataQuoSale["saleName"]!
        salePhonetitle.text = "เบอร์ : " + DataQuoSale["salePhoneNumber"]!
        saleEmailtitle.text = "Email : " + DataQuoSale["saleEmail"]!
        saleRemarktitle.text = "Remark : " + DataQuoSale["Remark"]!
        
        // data sub product price
        var productTotal : Double = 0

        discountTotal = 0
        
        for index in 0..<DataQuoProduct.count {
            let unitPrice = DataQuoProduct[index]["ProductUnitprice"] as! Double
            let Quantity = DataQuoProduct[index]["ProductQuantity"] as! Double
            productTotal = productTotal + (unitPrice * Quantity)
            discountTotal = discountTotal + (DataQuoProduct[index]["ProductDiscount"] as! Double)
        }
        
        //let companyVat = (DataQuoCompany["companyVat"] as! Double) / 100
        //discountTotal = (productTotal + (productTotal * companyVat))  - Double(DataQuoProductPrice["ProducttotalPrice"]!)!
        //discountTotal = discountTotal + Double(DataQuoProductPrice["ProductDiscountEtc"]!)!

        totalProduct.text = String(format: "%.2f", productTotal)
        Discount.text = String(format: "%.2f", discountTotal)
         
        totalDiscount.text = DataQuoProductPrice["ProductPrice"]
        totalVAT.text = DataQuoProductPrice["ProductVATPrice"]
        totalFull.text = DataQuoProductPrice["ProducttotalPrice"]
        totalFullTexttitle.text = PriceToWordString(price: DataQuoProductPrice["ProducttotalPrice"]!)
        
        let vat = String(format: "%.0f",DataQuoCompany["companyVat"] as! Double)
        totalVATtitle.text = "จำนวนภาษีมูลค่าเพิ่ม : " + vat + "%"
        
        productRemarktile.text = "หมายเหตุ :" + DataQuoProductPrice["ProductRemarkAll"]!
        
        // data sub approved
        let saleName = DataQuoApproved["saleName"] as! String
        let approvedByName = DataQuoApproved["approvedByName"] as! String
        let imageSigSale = DataQuoApproved["imageSigSale"] as! UIImage
        let imageSigApproved = DataQuoApproved["imageSigApproved"] as! UIImage
        
        
        footerCreatByName.text = "(" + saleName + ")"
        footerApprovedName.text = "(" + approvedByName + ")"
        imageAutographCreatBy.image = imageSigSale
        imageAutographApproved.image = imageSigApproved
    
    }
    
    func QuoSetlayoutHeader(){
        PDFView.addSubview(imageLogo)
        PDFView.addSubview(companyNametile)
        PDFView.addSubview(companyAddresstitle)
        PDFView.addSubview(companyEmailandWebtitle)
        PDFView.addSubview(companyPhoneandFaxtitle)
        PDFView.addSubview(companyTaxIDtitle)
        PDFView.addSubview(companyRemarktitle)
            
        imageLogo.anchor(PDFView.topAnchor, left: PDFView.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        
        companyNametile.anchor(PDFView.topAnchor, left: imageLogo.rightAnchor, bottom: nil, right: PDFView.rightAnchor, topConstant: 15, leftConstant: 5, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)

        companyAddresstitle.anchor(companyNametile.bottomAnchor, left: companyNametile.leftAnchor, bottom: nil, right: PDFView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        companyEmailandWebtitle.anchor(companyAddresstitle.bottomAnchor, left: companyNametile.leftAnchor, bottom: nil, right: PDFView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        companyPhoneandFaxtitle.anchor(companyEmailandWebtitle.bottomAnchor, left: companyNametile.leftAnchor, bottom: nil, right: PDFView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        companyTaxIDtitle.anchor(companyPhoneandFaxtitle.bottomAnchor, left: companyNametile.leftAnchor, bottom: nil, right: PDFView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        companyRemarktitle.anchor(companyTaxIDtitle.bottomAnchor, left: companyNametile.leftAnchor, bottom: nil, right: PDFView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    func QuoSetlayoutsubHeader(){
        let width : CGFloat = 375 / 2
        
        PDFView.addSubview(customerCompanyNametitle)
        PDFView.addSubview(customerCompanyAddresstitle)
        PDFView.addSubview(customerContactNametitle)
        PDFView.addSubview(customerContactPhonetitle)
        PDFView.addSubview(customerContactRemarktitle)
        PDFView.addSubview(numberOfQuotationtitle)
        
        PDFView.addSubview(dateOfQuotationtitle)
        PDFView.addSubview(saleNametitle)
        PDFView.addSubview(salePhonetitle)
        PDFView.addSubview(saleEmailtitle)
        PDFView.addSubview(saleRemarktitle)
        
        customerCompanyNametitle.anchor(companyRemarktitle.bottomAnchor, left: PDFView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: width - 10, heightConstant: 0)
        
        customerCompanyAddresstitle.anchor(customerCompanyNametitle.bottomAnchor, left: customerCompanyNametitle.leftAnchor, bottom: nil, right: customerCompanyNametitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        customerContactNametitle.anchor(customerCompanyAddresstitle.bottomAnchor, left: customerCompanyNametitle.leftAnchor, bottom: nil, right: customerCompanyNametitle.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        customerContactPhonetitle.anchor(customerContactNametitle.bottomAnchor, left: customerCompanyNametitle.leftAnchor, bottom: nil, right: customerCompanyNametitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        customerContactRemarktitle.anchor(customerContactPhonetitle.bottomAnchor, left: customerCompanyNametitle.leftAnchor, bottom: nil, right: customerCompanyNametitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        numberOfQuotationtitle.anchor(customerCompanyNametitle.topAnchor, left: nil, bottom: nil, right: PDFView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: width - 40, heightConstant: 0)
               
        dateOfQuotationtitle.anchor(numberOfQuotationtitle.bottomAnchor, left: numberOfQuotationtitle.leftAnchor, bottom: nil, right: numberOfQuotationtitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
               
        saleNametitle.anchor(dateOfQuotationtitle.bottomAnchor, left: numberOfQuotationtitle.leftAnchor, bottom: nil, right: numberOfQuotationtitle.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
               
        salePhonetitle.anchor(saleNametitle.bottomAnchor, left: numberOfQuotationtitle.leftAnchor, bottom: nil, right: numberOfQuotationtitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
               
        saleEmailtitle.anchor(salePhonetitle.bottomAnchor, left: numberOfQuotationtitle.leftAnchor, bottom: nil, right: numberOfQuotationtitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
               
        saleRemarktitle.anchor(saleEmailtitle.bottomAnchor, left: numberOfQuotationtitle.leftAnchor, bottom: nil, right: numberOfQuotationtitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func QuoSetlayoutProduct(){
        PDFView.addSubview(mainProduct)
        
        
        mainProduct.addSubview(numberkHeader)
        mainProduct.addSubview(productNameAndDescripHeader)
        mainProduct.addSubview(areaHeader)
        mainProduct.addSubview(unitPriceHeader)
        mainProduct.addSubview(discounHeader)
        mainProduct.addSubview(priceTotalHeader)

        mainProduct.addSubview(tableView!)

        mainProduct.addSubview(totalProduct)
        mainProduct.addSubview(Discount)
        mainProduct.addSubview(totalDiscount)
        mainProduct.addSubview(totalVAT)
        mainProduct.addSubview(totalFull)
        
        mainProduct.addSubview(viewFooter)
        viewFooter.addSubview(totalProductitle)
        viewFooter.addSubview(Discounttitle)
        viewFooter.addSubview(totalDiscounttitle)
        viewFooter.addSubview(totalVATtitle)
        viewFooter.addSubview(totalFulltitle)
        
        viewFooter.addSubview(productRemarktile)
        viewFooter.addSubview(totalFullTexttitle)
        
        mainProduct.anchor(customerContactRemarktitle.bottomAnchor, left: PDFView.leftAnchor, bottom: PDFView.bottomAnchor, right: PDFView.rightAnchor, topConstant: 10, leftConstant: 5, bottomConstant: 20, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        
        numberkHeader.anchor(mainProduct.topAnchor, left: mainProduct.leftAnchor, bottom: nil, right: productNameAndDescripHeader.leftAnchor, topConstant: 0.3, leftConstant: 0.4, bottomConstant: 0, rightConstant: 0.3, widthConstant: 10.2, heightConstant: 14.7)
        
        productNameAndDescripHeader.anchor(numberkHeader.topAnchor, left: numberkHeader.rightAnchor, bottom: numberkHeader.bottomAnchor, right: areaHeader.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0.3, widthConstant: 0, heightConstant: 0)
        
        areaHeader.anchor(numberkHeader.topAnchor, left: nil, bottom: numberkHeader.bottomAnchor, right: unitPriceHeader.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0.3, widthConstant: 41.7, heightConstant: 0)
        
        unitPriceHeader.anchor(numberkHeader.topAnchor, left: nil, bottom: numberkHeader.bottomAnchor, right: discounHeader.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0.3, widthConstant: 41.7, heightConstant: 0)
        
        discounHeader.anchor(numberkHeader.topAnchor, left: nil, bottom: numberkHeader.bottomAnchor, right: priceTotalHeader.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0.3, widthConstant: 21.7, heightConstant: 0)
        
        priceTotalHeader.anchor(numberkHeader.topAnchor, left: nil, bottom: numberkHeader.bottomAnchor, right: mainProduct.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0.3, widthConstant: 53.7, heightConstant: 0)
        
        tableView?.anchor(numberkHeader.bottomAnchor, left: mainProduct.leftAnchor, bottom: totalProduct.topAnchor, right: mainProduct.rightAnchor, topConstant: 0.3, leftConstant: 0.4, bottomConstant: 0.3, rightConstant: 0.3, widthConstant: 0, heightConstant: 0)
        
        totalProduct.anchor(nil, left: totalFull.leftAnchor, bottom: Discount.topAnchor, right: totalFull.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        Discount.anchor(nil, left: totalFull.leftAnchor, bottom: totalDiscount.topAnchor, right: totalFull.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        totalDiscount.anchor(nil, left: totalFull.leftAnchor, bottom: totalVAT.topAnchor, right: totalFull.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        totalVAT.anchor(nil, left: totalFull.leftAnchor, bottom: totalFull.topAnchor, right: totalFull.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        totalFull.anchor(nil, left: nil, bottom: nil, right: mainProduct.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0.3, widthConstant: 53.7, heightConstant: 9.7)
        
        
        viewFooter.anchor(tableView?.bottomAnchor, left: mainProduct.leftAnchor, bottom: totalFull.bottomAnchor, right: totalFull.leftAnchor, topConstant: 0.4, leftConstant: 0.4, bottomConstant: 0, rightConstant: 0.3, widthConstant: 0, heightConstant: 0)
        
        totalProductitle.anchor(nil, left: totalFulltitle.leftAnchor, bottom: Discounttitle.topAnchor, right: totalFulltitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        Discounttitle.anchor(nil, left: totalFulltitle.leftAnchor, bottom: totalDiscounttitle.topAnchor, right: totalFulltitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        totalDiscounttitle.anchor(nil, left: totalFulltitle.leftAnchor, bottom: totalVATtitle.topAnchor, right: totalFulltitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        totalVATtitle.anchor(nil, left: totalFulltitle.leftAnchor, bottom: totalFulltitle.topAnchor, right: totalFulltitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        totalFulltitle.anchor(nil, left: nil, bottom: totalFull.bottomAnchor, right: viewFooter.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 10)
        
        
        productRemarktile.anchor(viewFooter.topAnchor, left: viewFooter.leftAnchor, bottom: nil, right: totalVATtitle.leftAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        totalFullTexttitle.anchor(nil, left: viewFooter.leftAnchor, bottom: viewFooter.bottomAnchor, right: totalVATtitle.leftAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    func QuoSetlayoutApproved(){
        mainProduct.addSubview(viewApproved)
        viewApproved.addSubview(footerCustomertitle)
        viewApproved.addSubview(footerCreatBytitle)
        viewApproved.addSubview(footerApprovedtitle)
        viewApproved.addSubview(footviewCustomer)
        viewApproved.addSubview(footerCreatByName)
        viewApproved.addSubview(footerApprovedName)
        viewApproved.addSubview(imageAutographCreatBy)
        viewApproved.addSubview(imageAutographApproved)

        viewApproved.anchor(totalFull.bottomAnchor, left: mainProduct.leftAnchor, bottom: mainProduct.bottomAnchor, right: mainProduct.rightAnchor, topConstant: 0.5, leftConstant: 0.4, bottomConstant: 0.3, rightConstant: 0.3, widthConstant: 0, heightConstant: 50)
        
        let width : CGFloat = (375 - 20 - 10 - 0.6)/3
        
        footerCustomertitle.anchor(nil, left: viewApproved.leftAnchor, bottom: viewApproved.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: width, heightConstant: 10)
        
        footerApprovedtitle.anchor(nil, left: nil, bottom: viewApproved.bottomAnchor, right: viewApproved.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width, heightConstant: 10)
        
        footerCreatBytitle.anchor(nil, left: footerCustomertitle.rightAnchor, bottom: viewApproved.bottomAnchor, right: footerApprovedtitle.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width, heightConstant: 10)
        
        footviewCustomer.anchor(nil, left: footerCustomertitle.leftAnchor, bottom: footerCustomertitle.topAnchor, right: footerCustomertitle.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 0.5)
        
        footerCreatByName.anchor(nil, left: footerCreatBytitle.leftAnchor, bottom: footerCreatBytitle.topAnchor, right: footerCreatBytitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        footerApprovedName.anchor(nil, left: footerApprovedtitle.leftAnchor, bottom: footerApprovedtitle.topAnchor, right: footerApprovedtitle.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        imageAutographCreatBy.anchor(viewApproved.topAnchor, left: footerCreatBytitle.leftAnchor, bottom: footerCreatByName.topAnchor, right: footerCreatBytitle.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        imageAutographApproved.anchor(viewApproved.topAnchor, left: footerApprovedtitle.leftAnchor, bottom: footerApprovedName.topAnchor, right: footerApprovedtitle.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    @objc func getTapped(){
        
        let alert = UIAlertController(title: "Submit quotation", message: "Would you like to save the quotation and print the quotation ?", preferredStyle: UIAlertController.Style.alert)
        
        alert.setTitlet(font: UIFont.MitrMedium(size: 20), color: .BlueLight)
        alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.5))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
            
            var Product = [[String:Any]]()
            
            let Quotation = ["idCustomer": self.DataQuoCustomer["CustomerID"],
                             "SalesName": self.DataQuoSale["saleName"],
                             "RecordName": "QA",
                             "VAT": self.DataQuoCompany["companyVat"],
                             "discount":self.DataQuoProductPrice["ProductDiscountEtc"]]
            
            for index in 0..<self.DataQuoProduct.count {
                let data = ["id": self.DataQuoProduct[index]["idProduct"],
                            "Name": self.DataQuoProduct[index]["ProductName"],
                            "Price": self.DataQuoProduct[index]["ProductUnitprice"],
                            "Quantity": self.DataQuoProduct[index]["ProductQuantity"],
                            "Discount": self.DataQuoProduct[index]["ProductDiscount"]]
                
                print(data)
                Product.append(data as [String : Any])
            }
            
            self.insertQuotation(token: self.tokenID!, Quotation: Quotation as [String : Any], Product: Product)
                        
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func PriceToWordString(price : String) -> String{ //convert String price to word
        var PriceWord = ""
        
        //sub baht and satang
        let subString = price.components(separatedBy: ".")
        let satang = subString.last
        let baht = subString.first
        let characterssatang = Array(satang!)
        let charactersbaht = Array(baht!)

        var wordbaht = ""
        var wordsatang = ""
        
        if charactersbaht.count <= 7{ // price less Million
            wordbaht = NumToWord(character: charactersbaht)
            wordbaht = wordbaht + "บาท"
        }else{ // price more Million
            
            let subcharactersbah = charactersbaht.count - 6
            let moreMillion = charactersbaht[0..<subcharactersbah]
            let lessMillion = charactersbaht[subcharactersbah..<charactersbaht.count]
            
            var WordmoreMillion = ""
            var WordlessMillion = ""
            
            WordmoreMillion = NumToWord(character: moreMillion.compactMap{$0})
            WordlessMillion = NumToWord(character: lessMillion.compactMap{$0})

            wordbaht = WordmoreMillion + "ล้าน" + WordlessMillion + "บาท"

        }

        if Int(satang!) != 0{// have satang
            wordsatang = NumToWord(character: characterssatang)
            wordsatang = wordsatang + "สตางค์ถ้วน"
        }else{// no satang
            wordsatang = "ถ้วน"
        }

        PriceWord = wordbaht + wordsatang
        print(PriceWord)
        return PriceWord
    }
    
    
    func NumToWord(character : [String.Element]) -> String{
        
        var wordPrice = ""

        for index in 0..<character.count{
           
            let pos = (character.count - 1) - index
            let sub = character[pos]
            
            var Word = ""
            var unit = ""
            
            if pos == (character.count - 1) && sub == "1" {
                Word = "เอ็ด"
            }else if pos == (character.count - 2) && sub == "2"{
                Word = "ยี่"
            }else if pos == (character.count - 2) && sub == "1"{
                Word = ""
            }else{
                switch sub {
                case "1": Word = "หนึ่ง"
                case "2": Word = "สอง"
                case "3": Word = "สาม"
                case "4": Word = "สี่"
                case "5": Word = "ห้า"
                case "6": Word = "หก"
                case "7": Word = "เจ็ด"
                case "8": Word = "แปด"
                case "9": Word = "เก้า"
                default: Word = ""
                }
            }
            
            if sub != "0"{
                switch index {
                case 0: unit = ""
                case 1: unit = "สิบ"
                case 2: unit = "ร้อย"
                case 3: unit = "พัน"
                case 4: unit = "หมื่น"
                case 5: unit = "แสน"
                case 6: unit = "ล้าน"
                default:
                    unit = ""
                }
            }
            wordPrice = Word + unit + wordPrice
        }
        return wordPrice
    }
    
    func insertQuotation(token:String, Quotation: [String:Any], Product: [[String:Any]] ){
                
        let Header : HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
        let Url = DataSource.Url_saleInsertQuotation()
        
        let parameter = ["Quotation":Quotation,"Product":Product] as [String : Any]
        
        // Open loader
        self.Show_Loader()
        
        AF.request(Url, method: .post,parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                //print(value)
                let JSON = value as? [String : Any]
                if JSON!["QuotationRecordName"] != nil{
                    
                    let QoutationID = JSON!["QuotationRecordName"] as! String
                    
                    self.numberOfQuotationtitle.text = "เลขที่ใบเสนอราคา : " + QoutationID
                    
                    // Close loader
                    self.Show_Loader()
                    
                    self.ShowMailComposer()

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
        alert.setTitlet(font: UIFont.MitrMedium(size: 18), color: .red)
        alert.setMessage(font: UIFont.MitrLight(size: 15), color: .BlackAlpha(alpha: 0.9))
        
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

extension PDFQuotationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataQuoProduct.count + 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as!PDFQuotationViewCell
        
        if indexPath.row >= DataQuoProduct.count{
            
            cell.numberktitle.text = " "
            cell.productNameAndDescriptitle.text = " "
            cell.productRemarktitle.text = " "
            cell.areatitle.text = " "
            cell.unitPricetitle.text = " "
            cell.discountitle.text = " "
            cell.priceTotaltitle.text = " "
    
        }else{
            cell.numberktitle.text = String(indexPath.row + 1)
            
            let NameAndDescrip = (DataQuoProduct[indexPath.row]["ProductName"] as! String) + " : " +  (DataQuoProduct[indexPath.row]["ProductDiscription"] as! String)
            let Remark = DataQuoProduct[indexPath.row]["ProductRemark"] as! String
            let area = DataQuoProduct[indexPath.row]["ProductQuantity"] as! Double
            let unitPrice = DataQuoProduct[indexPath.row]["ProductUnitprice"] as! Double
            let discoun = DataQuoProduct[indexPath.row]["ProductDiscount"] as! Double
            let priceTotal = DataQuoProduct[indexPath.row]["ProductPriceTotal"] as! Double
            
            cell.productNameAndDescriptitle.text = NameAndDescrip
            cell.productRemarktitle.text = Remark
            cell.areatitle.text = String(format: "%.2f", area)
            cell.unitPricetitle.text = String(format: "%.2f", unitPrice)
            cell.discountitle.text = String(format: "%.2f", discoun)
            cell.priceTotaltitle.text = String(format: "%.2f", priceTotal)
        }
        
        return cell
    }
    
}

extension PDFQuotationViewController: MFMailComposeViewControllerDelegate {
    
    func ShowMailComposer(){
          
        guard MFMailComposeViewController.canSendMail() else {return}
        
        let CustomerContactEmail = DataQuoCustomer["ContactEmail"]!
        let CompanyName = DataQuoCompany["companyName"] as? String
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([CustomerContactEmail])
          
        //var imageData: [NSData]!
        let fileData = NSData(contentsOfFile: self.PDFView.exportAsPdfFromView())
          
        composer.addAttachmentData(fileData! as Data, mimeType: "application/pdf", fileName: "viewPdf.pdf")
        composer.setSubject(CompanyName!)
        composer.setMessageBody("ใบเสนอราคาสินค้าจากบริษัท \n" + CompanyName!, isHTML: false)
          
        present(composer, animated: true)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            //Show error alert
            controller.dismiss(animated: true)
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Seved")
        case .sent:
            print("Email Sent")
            
            //clear product in shopchart when sent email finish
            NotificationCenter.default.post(name: NSNotification.Name("ClearShopCart"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("MoveTabbarTofirstPage"), object: nil)

            navigationController?.popToRootViewController(animated: true)

        default:
            print("")
        }
        
        controller.dismiss(animated: true)
    }
}

extension UIView {
    
    // Export pdf from Save pdf in drectory and return pdf file path
    func exportAsPdfFromView() -> String {
        
        let pdfPageFrame = self.bounds
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        return self.saveViewPdf(data: pdfData)
        
    }
    
    // Save pdf file in document directory
    func saveViewPdf(data: NSMutableData) -> String {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("viewPdf.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath.path
        } else {
            return ""
        }
    }
}
