//
//  SaleShopCartViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 26/3/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class SaleShopCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate , UIScrollViewDelegate{
        
    weak var tableView : UITableView?
    private var CellID = "Cell"
    
    var DelegateTabbarTool : TabbarToolDelegate?
    
    var ProductCart = [[String : Any]]()
    var areaQuantity = [Double]()
    var pricetitleCal = [Double]()
    var StagesPush = false
    
    let titlPriceTotal: UILabel = {
        let label = UILabel()
        label.text = "Total :"
        label.textColor = UIColor.BlackAlpha(alpha: 0.6)
        label.font = UIFont.MitrRegular(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let priceTotal: UILabel = {
        let label = UILabel()
        label.text = "0 Baht"
        label.textColor = UIColor.BlueLight
        label.font = UIFont.MitrRegular(size: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let viewTotal: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 10
        return view
    }()
    
    let getQuotaButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueLight
        button.setImage(#imageLiteral(resourceName: "checklist"), for: .normal)
        button.imageView?.tintColor = .white
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.MitrRegular(size: 20)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 120)
        button.titleEdgeInsets =  UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.addTarget(self, action: #selector(Submit), for: .touchUpInside)
        return button
    }()
    
    // Element no product in shop cart
    let viewNoProduct : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    let labelNoProduct: UILabel = {
        let label = UILabel()
        label.text = "No product in shop cart !"
        label.textAlignment = .center
        label.textColor = .BlueDeep
        label.font = UIFont.MitrMedium(size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let imageNoProduct: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "shopping-cart")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
  
        //NotificationCenter function Clear product in Shop Cart
        NotificationCenter.default.addObserver(self, selector: #selector(ClearShopCart(notification:)), name: NSNotification.Name(rawValue: "ClearShopCart"), object: nil)
        
        // ConfigNavigation Bar
        navigationItem.title = "Shop Cart"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = UIColor.BlueLight
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.BlueDeep, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 25)]
        
        // ConfigRegister Tableview cell,header,footer
        let table =  UITableView(frame: .zero)
        tableView = table
        tableView!.backgroundColor = .systemGray6
        tableView!.rowHeight = UITableView.automaticDimension
        tableView!.separatorStyle = .none
        tableView!.register(SaleShopCartViewCell.self, forCellReuseIdentifier: CellID)
        tableView!.delegate = self
        tableView!.dataSource = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.delegate = self as? UIGestureRecognizerDelegate
        tableView?.addGestureRecognizer(tapRecognizer)
        
        view.addSubview(tableView!)
        view.addSubview(viewTotal)
        view.addSubview(getQuotaButton)
        
        viewTotal.addSubview(titlPriceTotal)
        viewTotal.addSubview(priceTotal)
        
        
        tableView!.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: getQuotaButton.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        getQuotaButton.anchor(nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 15, widthConstant: 180, heightConstant: 60)
        
        viewTotal.anchor(nil, left: view.leftAnchor, bottom: getQuotaButton.bottomAnchor, right: getQuotaButton.leftAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 60)
        
        titlPriceTotal.anchor(viewTotal.topAnchor, left: viewTotal.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        priceTotal.anchor(nil, left: titlPriceTotal.leftAnchor, bottom: viewTotal.bottomAnchor, right: viewTotal.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 3, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        // Setting element no product in shop cart
        view.addSubview(viewNoProduct)
        viewNoProduct.addSubview(labelNoProduct)
        viewNoProduct.addSubview(imageNoProduct)
        
        viewNoProduct.anchorCenter(view.centerXAnchor, AxisY: view.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 350, heightConstant: 350)
        
        imageNoProduct.anchorCenter(viewNoProduct.centerXAnchor, AxisY: viewNoProduct.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 20, widthConstant: 150, heightConstant: 150)
        
        labelNoProduct.anchor(nil, left: viewNoProduct.leftAnchor, bottom: imageNoProduct.topAnchor, right: viewNoProduct.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 40, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if StagesPush == true{
            StagesPush = false
        }else{
            
            ProductCart = TabBarUserController.ProductCart
                        
            if ProductCart.count != 0{
                // insert array according to data
                if areaQuantity.count != ProductCart.count{
                    let count = ProductCart.count - areaQuantity.count
                    let viewContoller = SetupQuotationViewController.self
                    
                    if count > 0{// create when add product in chopcart
                        //create array data
                        areaQuantity.append(contentsOf: Array(repeating: 0, count: count))
                        pricetitleCal.append(contentsOf: Array(repeating: 0, count: count))
                        
                        viewContoller.ProductDiscount.append(contentsOf: Array(repeating: 0, count: count))
                        viewContoller.ProductUnitPriceTotal.append(contentsOf: Array(repeating: 0, count: count))
                        viewContoller.ProductRemark.append(contentsOf: Array(repeating: "-", count: count))
                    
                    }else{// Remove product in chopcart when remove product on detail pag
                        
                        let count = ProductCart.count
                        
                        areaQuantity.removeAll()
                        pricetitleCal.removeAll()
                        
                        viewContoller.ProductDiscount.removeAll()
                        viewContoller.ProductUnitPriceTotal.removeAll()
                        viewContoller.ProductRemark.removeAll()
                        viewContoller.productpriceTotal = 0

                        areaQuantity.append(contentsOf: Array(repeating: 0, count: count))
                        pricetitleCal.append(contentsOf: Array(repeating: 0, count: count))
                        
                        viewContoller.ProductDiscount.append(contentsOf: Array(repeating: 0, count: count))
                        viewContoller.ProductUnitPriceTotal.append(contentsOf: Array(repeating: 0, count: count))
                        viewContoller.ProductRemark.append(contentsOf: Array(repeating: "-", count: count))
                        
                    }
                
                }
                
                // when have product in shop cart
                getQuotaButton.isEnabled = true
                tableView?.isHidden = false
                viewNoProduct.isHidden = true
                
                // price total in cart
                let priceTotalinCart = pricetitleCal.reduce(0, +)
                priceTotal.text = String(format: "%.2f", priceTotalinCart) + " Baht"
                
            }else{
                // when don't product in shop cart
                getQuotaButton.isEnabled = false
                tableView?.isHidden = true
                viewNoProduct.isHidden = false
                
            }

        }
        
        tableView?.reloadData()
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! SaleShopCartViewCell
        
        let image = ProductCart[indexPath.row]["Image"] as? UIImage
        let productName = ProductCart[indexPath.row]["ProductName"] as? String
        let unitPrice = ProductCart[indexPath.row]["ProductPrice"] as? Double
        let areaSection = ProductCart[indexPath.row]["ARMeasure"] as? Double
        let pricetitle = pricetitleCal[indexPath.row]
        
        cell.imageProduct.image = image
        cell.productNametitle.text = productName
        cell.unitPricetitle.text = "Unit Price : " + String(unitPrice!) + " Baht/m2"
        cell.areatitle.text = "ARMeasure : " + String(areaSection!) + " m2"
        cell.pricetitle.text =  String(format: "%.2f",pricetitle) + " Baht"
                
        cell.areaQuantityfield.addTarget(self, action: #selector(TextfieldChange), for: .editingChanged)

        if areaQuantity[indexPath.row] <= 0 {
            cell.areaQuantityfield.text = ""
        }else{
            let area = areaQuantity[indexPath.row]
            cell.areaQuantityfield.text = String(area)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
              
        let delete = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in

            let productName = self.ProductCart[indexPath.row]["ProductName"] as? String
            let alert = UIAlertController(title: "Do You Want to Delete This Product?", message: productName, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (acton) in
                     
                //Remove Rows tableview
                self.tableView!.setEditing(false, animated: true)
                self.ProductCart.remove(at: indexPath.row)
                self.tableView!.deleteRows(at: [indexPath], with: .fade)
                
                //Remove Data Source
                TabBarUserController.ProductCart.remove(at: indexPath.row)
                self.areaQuantity.remove(at: indexPath.row)
                self.pricetitleCal.remove(at: indexPath.row)
                
                SetupQuotationViewController.ProductDiscount.remove(at: indexPath.row)
                SetupQuotationViewController.ProductUnitPriceTotal.remove(at: indexPath.row)
                SetupQuotationViewController.ProductRemark.remove(at: indexPath.row)
                
                self.DelegateTabbarTool?.Update_BadgeValue(Num: self.ProductCart.count)
                
                // price total in cart
                let priceTotalinCart = self.pricetitleCal.reduce(0, +)
                self.priceTotal.text = String(format: "%.2f", priceTotalinCart) + " Baht"
                
                self.viewWillAppear(true)
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            completionHandler(true)
        }
              
        delete.backgroundColor = UIColor.systemGray6
        delete.image = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40)).image { _ in
               #imageLiteral(resourceName: "remove").withTintColor(UIColor.rgb(red: 255, green: 105, blue: 97)).draw(in: CGRect(x: 0, y: 0, width: 40, height: 40))}
                      
        let configuration = UISwipeActionsConfiguration(actions: [delete])
           
        return configuration
              
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
   
    @objc func TextfieldChange(sender: AnyObject){
        let point : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView!.indexPathForRow(at: point)
      
        guard tableView?.cellForRow(at: indexPath!) != nil else {return}
        let cell = tableView?.cellForRow(at: indexPath!) as! SaleShopCartViewCell
        
        // save areaQuantity
        let area = cell.areaQuantityfield.text! as NSString
        
        // areaQuantityfield Don't 0
        if area == "0"{
            cell.areaQuantityfield.text = ""
        }
        
        // alert areaQuantityfield no area
        if cell.areaQuantityfield.text?.count == 0{
            cell.areaQuantityfield.layer.borderColor = UIColor.systemRed.cgColor
        }else{
            cell.areaQuantityfield.layer.borderColor = UIColor.BlueDeep.cgColor
        }
        
        areaQuantity[indexPath!.row] = Double(area.doubleValue)

        // calculate price and save
        let price = ProductCart[indexPath!.row]["ProductPrice"] as? Double
        let priceCal = Double(area.doubleValue) * price!
        pricetitleCal[indexPath!.row] = priceCal
        
        // price total in cart
        let priceTotalinCart = pricetitleCal.reduce(0, +)
        priceTotal.text = String(format: "%.2f", priceTotalinCart) + " Baht"
        
        cell.pricetitle.text =  String(format: "%.2f",priceCal) + " Baht"
    }
    
    @objc func ClearShopCart(notification: NSNotification) {
        
        if ProductCart.count > 0{
            
            //Remove product all in tableview
            ProductCart.removeAll()

            UIView.transition(with: tableView!,
            duration: 0.35,
            options: .transitionCrossDissolve,
            animations: { self.tableView?.reloadData() })
            
            areaQuantity.removeAll()
            pricetitleCal.removeAll()
            
            priceTotal.text = String(format: "%.2f", 0) + " Baht"
            DelegateTabbarTool?.Update_BadgeValue(Num: 0)

            TabBarUserController.ProductCart.removeAll()

            SetupQuotationViewController.ProductDiscount.removeAll()
            SetupQuotationViewController.ProductUnitPriceTotal.removeAll()
            SetupQuotationViewController.ProductRemark.removeAll()
            SetupQuotationViewController.productpriceTotal = 0
            
            getQuotaButton.isEnabled = false
            
            UIView.transition(with: viewNoProduct,
            duration: 0.35,
            options: .transitionCrossDissolve,
            animations: { self.viewNoProduct.isHidden = false })
            
            
        }
    }
    
    @objc func Submit(){
        
        //Check areaQuantityfield = 0
        let indexnil = areaQuantity.firstIndex(of: 0)
        
        if indexnil == nil {
            
            //struct Data from pass data to page SetupQuotationViewController
            var DataProductShopCartPass = [[String:Any]]()
            
            for index in 0..<ProductCart.count{
                
                let ProductID = ProductCart[index]["idProduct"] as? Int
                let ProductName = ProductCart[index]["ProductName"] as? String
                let ProductDiscription = ProductCart[index]["Description"] as? String
                let ProductUnitprice = ProductCart[index]["ProductPrice"] as? Double
                let ProductQuantity = areaQuantity[index]
                
                let data = ["idProduct":ProductID!,
                            "ProductName":ProductName!,
                            "ProductDiscription":ProductDiscription ?? "-",
                            "ProductUnitprice":ProductUnitprice!,
                            "ProductQuantity":ProductQuantity] as [String : Any]
                
                DataProductShopCartPass.append(data)
            }
                        
            // Send DataProductShopCart to page SetupQuotationViewController
            SetupQuotationViewController.DataProductShopCart = DataProductShopCartPass

            // Push to page SetupQuotationViewController
            let SetupQuotation = SetupQuotationViewController()
            SetupQuotation.modalPresentationStyle = .fullScreen
            
            StagesPush = true
            DelegateTabbarTool?.Push_PageTo(RootView: SetupQuotation)
        }else{
            let indexPath = IndexPath(row: indexnil! as Int, section: 0)
            
            // alert areaQuantityfield no area data
            let cell = tableView?.cellForRow(at: indexPath) as! SaleShopCartViewCell
            cell.areaQuantityfield.layer.borderColor = UIColor.systemRed.cgColor
            
            // move to row no area data
            tableView?.scrollToRow(at: indexPath, at: .middle, animated: true)

        }
        
    }
    
}
