//
//  SetupQuotationViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 30/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class SetupQuotationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate{
    
    weak var tableView : UITableView?
    var CellID = "CellIDdd"
    
    static var DataCustomerDetail = [String : Any]()
    
    static var DataProductShopCart = [[String:Any]]()

    var viewCompanyHeight = CGFloat()
    var viewCustomerHeight = CGFloat()
    var viewSaleHeight = CGFloat()
    var viewProductHeight = CGFloat()
    var viewApprovedHeight = CGFloat()
    
    var DropDownButton: [Bool] = [true,true,true,true,true]
    let titleButton = ["Company","Customer","Sale","Product","Approved"]
    
    //Data Customer
    var CustomerID = 0
    var CompanyName = ""
    var CompanyAddress = ""
    var ContactName = ""
    var ContactTel = ""
    var ContactEmail = ""
    var ContactLine = ""
    
    var CustomerRemark = ""
    var SaleRamark = ""
    
    static var ProductDiscount = [Double]()
    static var ProductUnitPriceTotal = [Double]()
    static var ProductRemark = [String]()
    
    static var productpriceTotal = Double()

    var ProductetcDiscount = Double()

    static var ProductPrice = ""
    static var ProductVATPrice = ""
    static var ProducttotalPrice = ""
    static var ProductRemarkAll = ""
    static var ProductDiscountEtc = ""
    
    var ScrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        // ConfigNavigation Bar
        navigationItem.title = "Set Quotation"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // ConfigRegister Tableview cell
        let table =  UITableView(frame: .zero, style: .plain)
        tableView = table
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.tableFooterView = UIView()
        tableView!.backgroundColor = UIColor.systemGray5
        tableView!.separatorStyle = .none
        tableView!.register(SetupQuotationMainViewCell.self, forCellReuseIdentifier: CellID)
               
        
        // set layout ScrollView
        view.addSubview(ScrollView)
        ScrollView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        //set layout viewController
        ScrollView.addSubview(tableView!)
        tableView!.anchor(ScrollView.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        ScrollView.contentSize = tableView!.bounds.size
        
        //function Data Customer Update
        NotificationCenter.default.addObserver(self, selector: #selector(SetupQuotaDataCustomerUpdate(notification:)), name: NSNotification.Name(rawValue: "SetupQuotaDataCustomerUpdate"), object: nil)
        
    }
    
    @objc func Back_CatagoryPage(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 5{
            return 90
        }else{
            
            if DropDownButton[indexPath.row]{
                
                switch indexPath.row {
                case 0:
                    return viewCompanyHeight + 40 + 10
                case 1:
                    return viewCustomerHeight + 40 + 10
                case 2:
                    return viewSaleHeight + 40 + 10
                case 3:
                    return viewProductHeight + 40 + 10 + 10 + 10 + 1.5 + 40 + 150 + 5 + 20 + 100
                default:
                    return viewApprovedHeight + 40 + 10 + 10
                }
                
            }else{
                return 50
            }
            
        }
        
      
    }
    
    override func viewDidLayoutSubviews() {
       tableView?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let DataCustomer = SetupQuotationViewController.DataCustomerDetail
        if DataCustomer.count > 0{
            
            CustomerID = (DataCustomer["idCustomer"] as? Int)!
            CompanyName = (DataCustomer["CustomerCompanyName"] as? String)!
            CompanyAddress = (DataCustomer["CustomerCompanyAddress"] as? String)!
            ContactName = (DataCustomer["CustomerContactName"] as? String)!
            ContactTel = (DataCustomer["CustomerContactTel"] as? String)!
            ContactEmail = (DataCustomer["CustomerContactEmail"] as? String)!
            ContactLine = (DataCustomer["CustomerContactLine"] as? String)!
        }
        
        
        //clear data
        CustomerRemark = ""
        SaleRamark = ""
        
        SetupQuotationViewController.ProductDiscountEtc = ""
        
        // index Data ProductShopCart
        let count = SetupQuotationViewController.DataProductShopCart.count
        
        /*if count != SetupQuotationViewController.ProductDiscount.count{
            //save data begin
            SetupQuotationViewController.ProductDiscount.append(contentsOf: Array(repeating: 0, count: count))
            SetupQuotationViewController.ProductUnitPriceTotal.append(contentsOf: Array(repeating: 0, count: count))
            SetupQuotationViewController.ProductRemark.append(contentsOf: Array(repeating: "-", count: count))

        }*/
        
        // save data begin for ProductUnitPriceTotal
        for index in 0..<count{
            let ProductUnitprice = SetupQuotationViewController.DataProductShopCart[index]["ProductUnitprice"] as! Double
            let ProductQuantity = SetupQuotationViewController.DataProductShopCart[index]["ProductQuantity"] as! Double
            let ProductDiscount = SetupQuotationViewController.ProductDiscount[index]
            
            SetupQuotationViewController.ProductUnitPriceTotal[index] = (ProductUnitprice * ProductQuantity) - ProductDiscount

        }
        
    }
    
    @objc func SetupQuotaDataCustomerUpdate(notification: NSNotification) {
        
        let DataCustomer = SetupQuotationViewController.DataCustomerDetail
        
        CustomerID = (DataCustomer["idCustomer"] as? Int)!
        CompanyName = (DataCustomer["CustomerCompanyName"] as? String)!
        CompanyAddress = (DataCustomer["CustomerCompanyAddress"] as? String)!
        ContactName = (DataCustomer["CustomerContactName"] as? String)!
        ContactTel = (DataCustomer["CustomerContactTel"] as? String)!
        ContactEmail = (DataCustomer["CustomerContactEmail"] as? String)!
        ContactLine = (DataCustomer["CustomerContactLine"] as? String)!
        
        tableView?.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! SetupQuotationMainViewCell
        
        cell.viewCompany.isHidden = true
        cell.viewSale.isHidden = true
        cell.viewCustomer.isHidden = true
        cell.viewCustomerDetail.isHidden = true
        cell.viewProduct.isHidden = true
        cell.viewApproved.isHidden = true
        cell.sideButton.isHidden = true
        cell.CreateQoutationButton.isHidden = true
        
        if indexPath.row == 5{
            cell.CreateQoutationButton.isHidden = false
            cell.CreateQoutationButton.addTarget(self, action: #selector(CreateQoutation), for: .touchUpInside)
            cell.CreateQoutationButton.anchor(cell.topAnchor, left: cell.leftAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 10, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 60)
            
        }else{
            
            cell.sideButton.isHidden = false
            cell.sideButton.addTarget(self, action: #selector(sideBoxButtonHandle), for: .touchUpInside)
            cell.sideButton.setTitle(titleButton[indexPath.row], for: .normal)
            
            cell.sideButton.anchor(cell.topAnchor, left: cell.leftAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 10, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 40)
            
            var mainView = UIView()
            switch indexPath.row {
            case 0://Company
                mainView = cell.viewCompany
                
                cell.viewCompany.anchor(cell.sideButton.bottomAnchor, left: cell.leftAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
                
                //manage data company
                let companydata = TabBarUserController.DataSeller
                
                let companylogo = companydata!.CompanyImage
                let companyName = companydata!.ComponyName
                
                //split companyAddress and assemble Address
                var companyAddress = ""
                let companyAddressArr = companydata!.Company_Adress.split(separator: "$")
                for index in 0..<companyAddressArr.count {
                    companyAddress = companyAddress + companyAddressArr[index]
                }
                                
                let companyEmailandWeb = "Web : " + companydata!.Company_Web
                let companyPhoneandFax = "Phone : " + companydata!.Company_Tel +
                                        " , Fax : " + companydata!.Company_Fax
                //Show Data in cell Company
                cell.imageLogo.image = companylogo
                cell.companyNametile.text = companyName
                cell.companyAddresstitle.text = companyAddress
                cell.companyEmailandWebtitle.text = companyEmailandWeb
                cell.companyPhoneandFaxtitle.text = companyPhoneandFax
                
                cell.layoutIfNeeded()
                viewCompanyHeight = cell.viewCompany.frame.size.height
                
            case 1://Customer
                
                //Check Select Customer
                if SetupQuotationViewController.DataCustomerDetail.count == 0 {
                    //Select customer
                    mainView = cell.viewCustomerDetail
                    
                    cell.buttonSelectCustomer.addTarget(self, action: #selector(SelectCustomerhandle), for: .touchUpInside)
                    
                    cell.viewCustomerDetail.anchor(cell.sideButton.bottomAnchor, left: cell.leftAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
                                                      
                    cell.layoutIfNeeded()
                    viewCustomerHeight = cell.viewCustomerDetail.frame.size.height
                }else{
                    //view customer
                    mainView = cell.viewCustomer
                    cell.viewCustomer.anchor(cell.sideButton.bottomAnchor, left: cell.leftAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
                                   
                    cell.CustomerContactRemarkField.delegate = self
                    cell.CustomerCompanyNametextField.text = CompanyName
                    
                    var Address = ""
                    let DataAddress = CompanyAddress.split(separator: "$")
                    if DataAddress.count != 0{
                          Address = String(DataAddress[0]) + " " +
                                    String(DataAddress[1]) + " " +
                                    String(DataAddress[2]) + " " +
                                    String(DataAddress[3]) + " " +
                                    String(DataAddress[4])
                    }
                    
                    cell.CustomerCompanyAddresstextField.text = Address
                    
                    cell.CustomerContactNameField.text = ContactName
                    cell.CustomerContactPhoneNumberField.text = ContactTel
                    cell.CustomerContactEmailField.text = ContactEmail
                    cell.CustomerContactLineField.text = ContactLine
                    
                    cell.buttonResetCustomer.addTarget(self, action: #selector(ResetCustomehandle), for: .touchUpInside)
                        
                    
                    cell.layoutIfNeeded()
                    viewCustomerHeight = cell.viewCustomer.frame.size.height
                }
               
            case 2://Seller
                mainView = cell.viewSale
                
                cell.viewSale.anchor(cell.sideButton.bottomAnchor, left: cell.leftAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
                
                //manage data sale
                let saledata = TabBarUserController.DataSeller
                
                let saleName = saledata?.NameSeller
                let salePhoneNumber = saledata?.Sale_Tel
                let saleEmail = saledata?.Sale_Email
                
                //Show Data in cell sale
                cell.saleNametitle.text = "Name : " + saleName!
                cell.salePhoneNumberitle.text = "Phone : " + salePhoneNumber!
                cell.saleEmailtitle.text = "Email : " + saleEmail!
                
                cell.saleRemarkField.delegate = self

                cell.layoutIfNeeded()
                viewSaleHeight = cell.viewSale.frame.size.height
                
            case 3:
                mainView = cell.viewProduct
                
                cell.viewProduct.anchor(cell.sideButton.bottomAnchor, left: cell.leftAnchor, bottom: cell.bottomAnchor, right: cell.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
                            
                // buttom price total all product
                let PriceTotal = SetupQuotationViewController.ProductUnitPriceTotal.reduce(0, +)
                //let allDiscount = SetupQuotationViewController.ProductDiscount.reduce(0,+)
                //let PriceTotal = allProductPrice
                
                let vat = TabBarUserController.DataSeller!.QS_vat / 100
                let DiscountEtc = Double(SetupQuotationViewController.ProductDiscountEtc) ?? 0.0

                cell.Price.text = String(format: "%.2f", PriceTotal)
                cell.VATPrice.text = String(format: "%.2f", PriceTotal * vat)
                
                cell.DiscountPriceField.text = String(ProductetcDiscount)
                
                let priceTotal = String(format: "%.2f", (PriceTotal + (PriceTotal * vat)) - DiscountEtc)
                cell.totalPrice.text = priceTotal
                SetupQuotationViewController.productpriceTotal = Double(cell.totalPrice.text!)!
                
                cell.VATPricetitle.text = "VAT " + String(format: "%.0f", vat * 100) + "% :"
                
                cell.productRemarkField.text = TabBarUserController.DataSeller!.QS_MarkBottom
                SetupQuotationViewController.ProductRemarkAll = TabBarUserController.DataSeller!.QS_MarkBottom
                
                SetupQuotationViewController.ProductPrice = cell.Price.text!
                SetupQuotationViewController.ProductVATPrice = cell.VATPrice.text!
                SetupQuotationViewController.ProducttotalPrice = cell.totalPrice.text!
                
                viewProductHeight = CGFloat(Float((cell.tableViewProduct?.numberOfRows(inSection: 0))! * 166))
                
            case 4:
                mainView = cell.viewApproved
                
                cell.viewApproved.anchor(cell.sideButton.bottomAnchor, left: cell.leftAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
                
                //manage data Approved
                let approvedData = TabBarUserController.DataSeller
                
                let SaleName = approvedData?.NameSeller
                let approvedByName = approvedData?.Approve_Name
                let imageSigSale = approvedData?.SignSale
                let imageSigApproved = approvedData?.Approve
                
                //Show Data in cell Approved
                if approvedByName == "" { // Approved by sale
                    cell.CreatedBy.text = "( " + SaleName! + " )"
                    cell.ApprovedBy.text = "( " + SaleName! + " )"
                    cell.signatureCreatedImage.image = imageSigSale
                    cell.signatureApprovedImage.image = imageSigSale
                }else{// Approved by someone 
                    cell.CreatedBy.text = "( " + SaleName! + " )"
                    cell.ApprovedBy.text = "( " + approvedByName! + " )"
                    cell.signatureCreatedImage.image = imageSigSale
                    cell.signatureApprovedImage.image = imageSigApproved
                }
                
                cell.layoutIfNeeded()
                viewApprovedHeight = cell.viewApproved.frame.size.height
            default:break
            }
            
            if DropDownButton[indexPath.row]{
                mainView.isHidden = false
                cell.sideButton.setImage(#imageLiteral(resourceName: "arrowTop"), for: .normal)
            }else{
                mainView.isHidden = true
                cell.sideButton.setImage(#imageLiteral(resourceName: "arrowbottom"), for: .normal)
            }
            
        }
        
        return cell
    }
 
    @objc func sideBoxButtonHandle(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
        
        if DropDownButton[indexPath!.row]{
            DropDownButton[indexPath!.row] = false
        }else{
            DropDownButton[indexPath!.row] = true
        }
        
        tableView?.reloadRows(at: [indexPath!], with: .fade)
    }
    
    @objc func SelectCustomerhandle(){
        
        let ViewController = CustomerListViewController()
        ViewController.MoveViewController = "SetupQuotation"
        navigationController?.pushViewController(ViewController, animated: true)
        
    }
    
    @objc func ResetCustomehandle(){
        SetupQuotationViewController.DataCustomerDetail.removeAll()
        
        tableView?.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
        tableView?.beginUpdates()
        tableView?.endUpdates()

    }
    
    @objc func CreateQoutation(){
        
        if SetupQuotationViewController.DataCustomerDetail.count == 0 {
            
            tableView?.scrollToRow(at: IndexPath(row: 1, section: 0), at: .middle, animated: true)
            Create_AlertMessage(Title: "No customer selected", Message: "please choose your customer. By choosing the button 'select your customer'")
        }else{
            
            let PDFQuotation = PDFQuotationViewController()
            PDFQuotation.DataQuoCompany = StructureDataQuoCompany()
            PDFQuotation.DataQuoCustomer = StructureDataQuoCustomer()
            PDFQuotation.DataQuoSale = StructureDataQuoSale()
            PDFQuotation.DataQuoProduct = StructureDataQuotationProduct()
            PDFQuotation.DataQuoProductPrice = StructureDataQuotationProductPrice()
            PDFQuotation.DataQuoApproved = StructureDataQuoApproved()
            
            navigationController?.pushViewController(PDFQuotation, animated: false)
        }
        
    }
    
    func StructureDataQuoCompany() -> [String:Any]{
        
        //manage data company
        let companydata = TabBarUserController.DataSeller
        
        let companylogo = companydata!.CompanyImage
        let companyShowLogo = companydata!.QS_ShowLogo
        let companyName = companydata!.ComponyName
        let companyTAX = companydata!.QS_TaxId
        let companyVat = companydata!.QS_vat
        
        //split companyAddress and assemble Address
        var companyAddress = ""
        let companyAddressArr = companydata!.Company_Adress.split(separator: "$")
        for index in 0..<companyAddressArr.count {
            companyAddress = companyAddress + companyAddressArr[index]
        }
                        
        let companyEmailandWeb = "Web : " + companydata!.Company_Web
        let companyPhoneandFax = "Phone : " + companydata!.Company_Tel +
                                " , Fax : " + companydata!.Company_Fax
        
        let Data = ["companylogo": companylogo,
                    "companyName": companyName,
                    "companyAddress": companyAddress,
                    "companyEmailandWeb": companyEmailandWeb,
                    "companyPhoneandFax":companyPhoneandFax,
                    "companyTAX":companyTAX,
                    "companyVat":companyVat,
                    "companyShowLogo":companyShowLogo] as [String : Any]
        
        return Data
    }
    
    func StructureDataQuoCustomer() -> [String:String]{
                
        let Data = ["CompanyName":CompanyName,
                    "CompanyAddress":CompanyAddress,
                    "ContactName":ContactName,
                    "ContactTel":ContactTel,
                    "ContactEmail":ContactEmail,
                    "ContactLine":ContactLine,
                    "Remark":CustomerRemark,
                    "CustomerID":String(CustomerID)]
        return Data
    }
    
    
    func StructureDataQuoSale() -> [String:String]{
        
        //manage data sale
        let saledata = TabBarUserController.DataSeller
                       
        let saleName = saledata!.NameSeller
        let salePhoneNumber = saledata!.Sale_Tel
        let saleEmail = saledata!.Sale_Email
        
        let Data = ["saleName": saleName,
                    "salePhoneNumber": salePhoneNumber,
                    "saleEmail": saleEmail,
                    "Remark": SaleRamark]
        
        return Data
    }
    
    func StructureDataQuotationProduct() -> [[String:Any]]{
        // data product shopCart setting
        let ProductShopCart = SetupQuotationViewController.DataProductShopCart
        let ProductDiscount = SetupQuotationViewController.ProductDiscount
        let ProductUnitPriceTotal = SetupQuotationViewController.ProductUnitPriceTotal
        let ProductRemark = SetupQuotationViewController.ProductRemark
        
        // include product settings information
        var DataQuoProduct = [[String:Any]]()
        for index in 0..<ProductShopCart.count{
            
            let Name = ProductShopCart[index]["ProductName"] as! String
            let ProductID = ProductShopCart[index]["idProduct"] as! Int
            let Discription = ProductShopCart[index]["ProductDiscription"] as! String
            let Unitprice = ProductShopCart[index]["ProductUnitprice"] as! Double
            let Quantity = ProductShopCart[index]["ProductQuantity"] as! Double
            let Discount = ProductDiscount[index]
            let PriceTotal = ProductUnitPriceTotal[index]
            let Remark = ProductRemark[index]
            
            let Data = ["idProduct":ProductID,
                        "ProductName":Name,
                        "ProductDiscription":Discription,
                        "ProductUnitprice":Unitprice,
                        "ProductQuantity":Quantity,
                        "ProductDiscount":Discount,
                        "ProductPriceTotal":PriceTotal,
                        "ProductRemark":Remark] as [String : Any]
           
            DataQuoProduct.append(Data)
        }
        return DataQuoProduct
    }
    
    func StructureDataQuotationProductPrice() -> [String:String]{
        // manage data quotation Product Price Discription
        let ProductPrice = SetupQuotationViewController.ProductPrice
        let ProductVATPrice = SetupQuotationViewController.ProductVATPrice
        let ProducttotalPrice = SetupQuotationViewController.ProducttotalPrice
        let ProductRemarkAll = SetupQuotationViewController.ProductRemarkAll
        let ProductDiscountEtc = SetupQuotationViewController.ProductDiscountEtc
        
        let Data = ["ProductPrice":ProductPrice,
                    "ProductVATPrice":ProductVATPrice,
                    "ProducttotalPrice":ProducttotalPrice,
                    "ProductRemarkAll":ProductRemarkAll,
                    "ProductDiscountEtc":ProductDiscountEtc]
        
        return Data
    }
    
    
    func StructureDataQuoApproved() -> [String:Any]{
        //manage data Approved
        let approvedData = TabBarUserController.DataSeller
        
        let saleName = approvedData!.NameSeller
        var approvedByName = ""
        let imageSigSale = approvedData!.SignSale
        var imageSigApproved : UIImage
        
        if approvedData?.Approve_Name == "" {
            approvedByName = approvedData!.NameSeller
            imageSigApproved = approvedData!.SignSale!
        }else{
            approvedByName = approvedData!.Approve_Name
            imageSigApproved = approvedData!.Approve!
        }
        
        let Data = ["saleName":saleName,
                    "approvedByName":approvedByName,
                    "imageSigSale":imageSigSale!,
                    "imageSigApproved":imageSigApproved] as [String : Any]
        return Data
    }
    
  
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .BlueDeep)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SetupQuotationViewController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        
        switch textView.tag {
        case 0:
            CustomerRemark = textView.text
        case 1:
            SaleRamark = textView.text
        default:
            print("")
        }
        
        
    }
    
}
