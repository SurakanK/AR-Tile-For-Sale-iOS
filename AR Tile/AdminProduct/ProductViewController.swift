//
//  ProductViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 4/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire

class ProductViewController: UITableViewController {
    
    private var CellID = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ConfigNavigation Bar
        navigationItem.title = "Product Setting"
        //navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor.BlueDeep
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
        navigationController?.navigationBar.backgroundColor = .BlueDeep

        // ConfigRegister Tableview
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        tableView.register(ProductViewCell.self, forCellReuseIdentifier: CellID)
        
    }
    
    func Create_AlertMessage(Title : String!, Message : String!){
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.PoppinsBold(size: 18), color: .red)
        alert.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! ProductViewCell
        
        let icon = [#imageLiteral(resourceName: "tile"),#imageLiteral(resourceName: "grid"),#imageLiteral(resourceName: "painting")]
        let texttitle = ["Manage Product","Manage Category","Manage Color list"]
        
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        cell.iconImage.image = icon[indexPath.row].withTintColor(.whiteAlpha(alpha: 0.9))
        cell.titleLable.text = texttitle[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let ProductPhotolibrary = ProductPhotolibraryViewController()
            navigationController?.pushViewController(ProductPhotolibrary, animated: true)
        case 1:
            navigationController?.pushViewController(ProductCategoryViewController(), animated: true)
        default:
            navigationController?.pushViewController(ProductColorlistViewController(), animated: true)
        }
    }
}
