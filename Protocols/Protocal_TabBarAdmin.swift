//
//  Protocal_TabBarAdmin.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 11/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.


import UIKit

//-------------- Admin Protocal --------------------------------------

// Protocol for Open SideMenu Admin Section and Pass Data
protocol TabBarAdminDelegate {
    func ToggleSideMenu(forSideMenuOption SideMenuOption : SideMenuAdminOption?)
    // Func Show FilterDate Page
    func ToggleFilterDate()
    // Func Request Data From Server After Filer Date
    func Request_Data(Date : [String : String], Type : String)
}
// Protocol for Pass Data Date to TabbarAdmin Page (Show)
protocol DateShowAdminDelegate {
    
    func PassDate_Show(DateStart : String, DateEnd : String)
    func UpdateOverallSale_SubPage(TotalSales : Double)
    
    
}

//-------------- User Protocal --------------------------------------
// Protocol for Open SideMenu User Section
protocol TabBarUserDelegate {
    func ToggleSideMenu(Command : String?)
}

// Protocol for User Section about Pass Data and Push Page From TabbarUser
protocol TabbarToolDelegate {
    
    func Update_BadgeValue(Num : Int?)
    
    func Push_PageTo(RootView : UIViewController?)
    
    func Delegate_Page(RootView : UIViewController?)
    
    func Goto_CartPage()
    
    
}










