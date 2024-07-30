//
//  GeneralSetting.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 18/2/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class GeneralSetting: UITableViewController {
    
    private var CellID = "Cell"
    private var HeaderID = "HeaderID"
    private var FooterID = "FooterID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // ConfigNavigation Bar
        navigationItem.title = "General"
        //navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = .BlueLight
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
 
        // ConfigRegister Tableview cell,header,footer
        tableView.register(GeneralTableViewCell.self, forCellReuseIdentifier: CellID)
        tableView.register(GeneralHeaderIDViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderID)
        tableView.register(GeneralFooterViewCell.self, forHeaderFooterViewReuseIdentifier: FooterID)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! GeneralTableViewCell
        
        cell.selectionStyle = .none
        cell.SwitchUI.isHidden = true
        cell.imageNext.isHidden = true
        cell.imageIconViewCell.isHidden = true
        
        if indexPath.section == 0{
    
            if indexPath.row == 0{
                cell.titleTextLabel.text = "Company"
                cell.imageIconViewCell.image = #imageLiteral(resourceName: "pin").withTintColor(UIColor.BlueLight)
                cell.imageIconViewCell.isHidden = false
                cell.imageNext.isHidden = false

            }else if indexPath.row == 1{
                cell.titleTextLabel.text = "Quotation"
                cell.imageIconViewCell.image = #imageLiteral(resourceName: "content").withTintColor(UIColor.BlueLight)
                cell.imageIconViewCell.isHidden = false
                cell.imageNext.isHidden = false
            }

        }else{
            cell.titleTextLabel.text = "AUB"
            cell.SwitchUI.isHidden = false
            cell.SwitchUI.isOn = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            
            if indexPath.row == 0{
                
                let CompanyInfromationSettingController = CompanyInfromationController()
                navigationController?.pushViewController(CompanyInfromationSettingController, animated: true)
                
            }else if indexPath.row == 1{
            
                let QuotationInfromatSettinController = QuotationInfromationController()
                navigationController?.pushViewController(QuotationInfromatSettinController, animated: true)
            }
            
        }else{
            
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 0
        }else{
            return 50
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 50
        }else{
            return 50
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderID) as! GeneralHeaderIDViewCell
        
        if section == 0 {
            header.HeaderTextLabel.text = "General information"
        }else{
            header.HeaderTextLabel.text = "aub"
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let  footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterID) as! GeneralFooterViewCell
        
        if section == 0 {
            footer.FooterTextLabel.text = ""
        }else{
            footer.FooterTextLabel.text = "aub"
        }
        
         return footer
    }
}
