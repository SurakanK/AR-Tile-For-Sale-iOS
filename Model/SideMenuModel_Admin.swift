//
//  SideMenuModel_Admin.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 18/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//
import UIKit

enum SideMenuAdminOption: Int, CustomStringConvertible {
    case General
    case Account
    case Product
    case Customer
    case Quotation
    case Export
    case Signout
    
    var description: String{
        switch self {
        case .General: return "General Setting"
        case .Account: return "Manage Account User"
        case .Product: return "Manage Your Product"
        case .Customer: return "Manage Customer"
        case .Quotation: return "Manage Quotation"
        case .Export: return "Export Report"
        case .Signout: return "Sign Out"
        }
    }
    
    var image : UIImage {
        switch self {
        case .General: return #imageLiteral(resourceName: "adjust").withRenderingMode(.alwaysTemplate)
        case .Account: return #imageLiteral(resourceName: "relationship").withRenderingMode(.alwaysTemplate) 
        case .Product: return #imageLiteral(resourceName: "order").withRenderingMode(.alwaysTemplate)
        case .Customer: return #imageLiteral(resourceName: "IconAccount").withRenderingMode(.alwaysTemplate)
        case .Quotation: return #imageLiteral(resourceName: "checklist").withRenderingMode(.alwaysTemplate)
        case .Export: return #imageLiteral(resourceName: "export").withRenderingMode(.alwaysTemplate)
        case .Signout: return #imageLiteral(resourceName: "logout2").withRenderingMode(.alwaysTemplate) 
        }
    }
    
}

