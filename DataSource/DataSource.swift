//
//  DataProduct.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 28/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//
import UIKit

struct DataSource {
    
    static func IP() -> String {
        
        let dataIP = "192.168.1.33"
        return dataIP
    }
    
    // MARK : Admin Url
    
    // Login Admin Request (Don't Set Header)
    static func Url_AdminLogin() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/login/admin"
        return Url
    }
    
    // Get Detail Company
    static func Url_GetCompany() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/main/getaccountdetail"
        
        return Url
    }
    
    // Get Summary Admin // no Use
    static func Url_GetSummary() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/main/getsummary"
        return Url
    }
    
    // Get Quotation List Admin
    static func Url_GetQuotationListAdmin() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/main/getquotationlist"
        return Url
        
    }
    
    // Get TopSales Admin
    static func Url_GetTopSalesAdmin() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/main/gettopsales"
        return Url
    }
    
    // Get Top Product Admin
    static func Url_GetTopProductAdmin() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/main/gettopproduct"
        return Url
    }
    
    // Get Type Customer
    static func Url_GetCustomerType() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/main/gettopcustomer"
        return Url
        
    }
    
    // Get Chanel Income Customer
    static func Url_GetCustomerChanel() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/main/gettopcustomerbychannel"
        return Url
        
    }
    
    // Get Detail Quotation
    static func Url_GetDetailQuotation_Admin() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/quotation/getquotation"
        return Url
    }
    
    // Edit Quotation Admin
    static func Url_EditQuotation_Admin() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/quotation/editquotation"
        return Url
        
    }
    
    // Url Export Report to Email
    static func Url_ExportReport_Admin() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/report/byemail"
        return Url
        
    }
    
    // MARK : User Url
    
    // Login User Request (Don,t Set Header)
    static func Url_UserLogin() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/login/sale"
        return Url
    }
    
    // Get Image Server
    static func Url_DownloadImage() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/image/downloadimage"
    
        return Url
        
    }
    
    //Image UploadImage
    static func Url_ImageUploadImage() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/image/uploadimage"
        return Url
    }
    
    //Image DeleteImage
    static func Url_ImageDeleteImage() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/image/deleteimage"
        return Url
    }
    
    // Get Detail Seller
    static func Url_GetDetailSeller() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/main/getaccountdetail"
        return Url
        
    }
    
    // Get Data Catagory
    static func Url_GetCatagory() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/productandcategory/getcategory"
        return Url
        
    }
    
    // Get Quotation of Seller
    static func Url_GetQuoSeller() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/main/getquotationlist"
        return Url
        
    }
    
    // Get List Product
    static func Url_GetListProduct() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/productandcategory/getproductincat"
        return Url
        
    }
    
    // Get List Custom Tile Product
    static func Url_GetListCustomProduct() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/productandcategory/getproductcustom"
        return Url
    }
    
    // Get Detail Product
    static func Url_GetDetailProduct() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/productandcategory/getproductdetail"
        return Url
        
    }
    
    // Get Detail Quotation
    static func Url_GetDetailQuotation() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/quotation/getquotation"
        return Url
        
    }
    
    // Edit Quotation
    static func Url_EditQuotation() -> String {
        
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/quotation/editquotation"
        return Url
    }
    
    // Edit Account Setting
    static func Url_EditAccountSetting() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/account/editaccountsetting"
        return Url
    }
    
    //Get Account Setting
    static func Url_GetAccountSetting() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/account/getaccountsetting"
        return Url
    }
    
    //GetSales
    static func Url_GetSales() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/sales/getsales"
        return Url
    }
    
    //InsertSales
    static func Url_InsertSales() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/sales/insertsales"
        return Url
    }
    
    //EditSales
    static func Url_EditSales() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/sales/editsales"
        return Url
    }

    //Delsales
    static func Url_Delsales() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/sales/delsales"
        return Url
    }
    
    //ResetPasswordSales
    static func Url_ResetPasswordSales() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/sales/resetpasswordsales"
        return Url
    }
    

    //adminGetCategory
    static func Url_adminGetCategory() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/category/getcategory"
        return Url
    }
    
    //adminInsertCategory
    static func Url_adminInsertCategoryy() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/category/insertcategory"
        return Url
    }
    
    //adminEditCategory
    static func Url_adminEditCategory() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/category/editcategory"
        return Url
    }
 
    //adminDelCategory
    static func Url_adminDelCategory() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/category/delcategory"
        return Url
    }
    
    //adminGetProductinCategory
    static func Url_adminGetProductinCategory() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/category/getproductincat"
        return Url
    }
    
    //adminGetProductCustom
    static func Url_adminGetProductCustom() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/category/getproductcustom"
        return Url
    }
    
    //adminInsertProductinCategory
    static func Url_adminInsertProductinCategory() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/category/insertproductincat"
        return Url
    }
    
    //adminDelProductinCategory
    static func Url_adminDelProductinCategory() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/category/delproductincat"
        return Url
    }
    
    //adminGetColor
    static func Url_adminGetColor() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/color/getcolor"
        return Url
    }
    
    //adminInsertColor
    static func Url_adminInsertColor() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/color/insertcolor"
        return Url
    }
    
    //adminDelColor
    static func Url_adminDelColor() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/color/delcolor"
        return Url
    }
    
    //adminGetCustomer
    static func Url_adminGetCustomer() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/customer/getcustomer"
        return Url
    }
    
    //adminEditCustomer
    static func Url_adminEditCustomer() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/customer/editcustomer"
        return Url
    }
    
    //adminGetProduct
    static func Url_adminGetProduct() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/product/getproduct"
        return Url
    }
    
    //adminDelProduct
    static func Url_adminDelProduct() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/product/delproduct"
        return Url
    }
    
    //adminInsertProduct
    static func Url_adminInsertProduct() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/product/insertproduct"
        return Url
    }
    
    //adminEditProduct
    static func Url_adminEditProduct() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/product/editproduct"
        return Url
    }
    
    //saleInsertQuotation
    static func Url_saleInsertQuotation() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/quotation/insertquotation"
        return Url
    }
    
    //saleInsertProductCustom
    static func Url_saleInsertProductCustom() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/productandcategory/insertproductcustom"
        return Url
    }
    
    //saleGetColor
    static func Url_saleGetColor() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/color/getcolor"
        return Url
    }
    
    //saleGetCustomer
    static func Url_saleGetCustomer() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/customer/getcustomer"
        return Url
    }
    
    //adminGetTopQuotationByCustomer
    static func Url_adminGetTopQuotationByCustomer() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/customer/gettopquotationbycustomer"
        return Url
    }
    
    //saleInsertCustomer
    static func Url_saleInsertCustomer() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/customer/insertcustomer"
        return Url
    }
    
    //saleEditCustomer
    static func Url_saleEditCustomer() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/sale/customer/editcustomer"
        return Url
    }
    
    //adminGetAccountQuotation
    static func Url_adminGetAccountQuotation() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/account/getaccountquotation"
        return Url
    }
    
    //adminEditAccountQuotation
    static func Url_adminEditAccountQuotation() -> String {
        let Url = "https://yjnvz6wvc6.execute-api.ap-southeast-1.amazonaws.com/arforsales/admin/account/editaccountquotation"
        return Url
    }
   
    
    
    
    
    
    
    

    
    
    
    


    

    

    

    


    


    
    


    


    

        
        
    


    
}

// DataSource



// Data Login Admin
struct DataUser {
    
    var AdminUse : Bool
    
    var CompanyName : String
    var Logo : UIImage
    var CompanyEmail : String
    
    var SaleQuan : String
    var SaleMax : String
    
    var ProductQuan : String
    var ProductMax : String
    var ProductCustomQuan : String
    var ProductCustomMax : String
    
    var Package : String
    var Token_Id : String
    
}

// Data Login Seller (User)
struct DataDetailSeller {
    
    var ComponyName : String
    var CompanyImage : UIImage
    var Company_Adress : String
    var Company_Tel : String
    var Company_Fax : String
    var Company_Web : String
    
    
    var SignSale : UIImage?
    var Approve : UIImage?
    var Approve_Name : String
    
    var NameSeller : String
    var Seller_Id : String
    var Image_Seller : UIImage
    var Sale_Target : Double?
    var Sale_Tel : String
    var Sale_Email : String
    
    var Quo_InPro : Int
    var Quo_Reject : Int
    var Quo_Complete : Int
    
    var TotalSales : Double
    
    // MARK : State Quotation
    var QS_ShowLogo : Int
    var QS_TaxId : String
    var QS_vat : Double
    var QS_MarkBottom : String
    
    
    var TokenId : String
    
    
}

// Data Product ShopCart
struct DataShopCart {
    
    var NamePro : String
    var Im_Product : UIImage
    
    var Price : Double
    var Area_Fill : Double
    var Area_AR : Double
    var Total_Price : Double
    
    
}
