//
//  DataAccount.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 27/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

struct DataAccount {
    
    let ProfileImage: UIImage
    let FirstName: String
    let LastName: String
    let PhoneNumber: String
    let EmployeeID: String
    let AccountID: String
    let AccountPassword: String
    
    init(ProfileImage: UIImage, FirstName : String, LastName : String, PhoneNumber: String, EmployeeID : String, AccountID : String, AccountPassword : String) {
        
        self.ProfileImage = ProfileImage
        self.FirstName = FirstName
        self.LastName = LastName
        self.PhoneNumber = PhoneNumber
        self.EmployeeID = EmployeeID
        self.AccountID = AccountID
        self.AccountPassword = AccountPassword
    }
    
    static func dataAccount() -> [DataAccount] {
        
        var SalesAccount = [DataAccount]()
        
        SalesAccount.append(DataAccount(ProfileImage: #imageLiteral(resourceName: "saleAccount"), FirstName: "ประยุท", LastName: "จันทร์ทรา", PhoneNumber: "0812536778", EmployeeID: "1432", AccountID: "Admin1", AccountPassword: "1508"))
        SalesAccount.append(DataAccount(ProfileImage: #imageLiteral(resourceName: "saleAccount"), FirstName: "ประวัติ", LastName: "วงษ์สุพรรณ", PhoneNumber: "0925547786", EmployeeID: "1508", AccountID: "Admin2", AccountPassword: "1309"))
        SalesAccount.append(DataAccount(ProfileImage: #imageLiteral(resourceName: "saleAccount"), FirstName: "นายสมคริส", LastName: "จาตุพง", PhoneNumber: "0854467889", EmployeeID: "3490", AccountID: "Admin3", AccountPassword: "1508"))
        SalesAccount.append(DataAccount(ProfileImage: #imageLiteral(resourceName: "saleAccount"), FirstName: "นายวิเศษ", LastName: "เครือเงาะ", PhoneNumber: "0824672230", EmployeeID: "1135", AccountID: "Admin4", AccountPassword: "1135"))
        SalesAccount.append(DataAccount(ProfileImage: #imageLiteral(resourceName: "saleAccount"), FirstName: "ปาวีณา", LastName: "ไกรกุ๊ก", PhoneNumber: "0832285734", EmployeeID: "3255", AccountID: "Admin5", AccountPassword: "3255"))
        
        return SalesAccount
    }

}

