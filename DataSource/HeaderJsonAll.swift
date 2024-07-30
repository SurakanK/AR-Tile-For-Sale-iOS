//
//  HeaderJsonAll.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 15/6/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

// Structure of Header Json QuotationList
struct Head_QuotationList {
    
    var id : String = "idQuotation"
    var Quo_Name : String = "QuotationRecName"
    var Quo_Status : String = "QuotationCompleted"
    var Quo_ResonReject : String = "QuotationRejectedReason"
    var Quo_Note : String = "QuotationNote"
    var Quo_TotalPrice : String = "TotalSales"
    
    var Cus_Company : String = "CustomerCompanyName"
    var Cus_Adress : String = "CustomerCompanyAddress"
    var Cus_CompanyTel : String = "CustomerCompanyTel"
    var Cus_ContactName : String = "CustomerContactName"
    var Cus_ContactTel : String = "CustomerContactTel"
    
    var Sale_Name : String = "ProjectSalesName"
    var Sale_Id : String = "Sales_idSales"
    
    var DateBegin : String = "BeginDate"
    var DateEnd : String = "EndDate"
    
    var Vat : String = "vat"
    var Discount : String = "discount"
    
}


// Structure of Header Json TopProdduct
struct Head_TopProduct {
    
    var Name : String = "ProductName"
    var Quantity : String = "Quantity"
    var TotalSale : String = "TotalSales"
    var Key_Image : String = "ProductImage" // for Download Image
    var ImageProduct : String = "ImageProduct"
    
}

// Structure Top Sale
struct Head_TopSale {
    
    var Sale_Name : String = "Fullname"
    var Sale_Id : String = "idSales"
    
    var Sale_QuoCount : String = "QuotationCount"
    var Sale_TotalSales : String = "QuotationTotalSales"
    
    var Sale_QuoCompleteCount : String = "QuotationCountSuccess"
    var Sale_TotalSalesSuccess : String = "QuotationTotalSalesSuccess"
    
    var Key_Image : String = "SalesImage"
    var Sale_Image : String = "ImageSale"
    
}

// Structure Customer Type
struct Head_CustomerType {
    
    var CustomerType : String = "CustomerType"
    var NumType : String = "TypeCount"
    
    var ProductName : String = "ProductName"
    var ProductImage : String = "ProductImage"
    var NumProduct : String = "Quantity"
    
    
}

// Structure Chanel Income Customer
struct Head_CustomerChanel {
    
    var Chanel : String = "CustomerRecommendedby"
    var NumChanel : String = "TypeCount"
    
    var Num_TotalQuo : String = "TotalQuotation"
    var Num_QuoSuccess : String = "TotalQuotationSuccess"
    
    var Sales_TotalQuo : String = "QuotationTotalSale"
    var Sales_QuoSuccess : String = "QuotationTotalSaleSuccess"
    
}



