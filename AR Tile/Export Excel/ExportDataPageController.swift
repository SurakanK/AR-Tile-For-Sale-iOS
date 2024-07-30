//
//  ExportDataPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 27/8/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire

private var Id_Cell : String = "CollectionCell_ListReportExport"

class ExportDataPageController : UIViewController {
    
    // MARK: Parameter
    // ratio
    lazy var ratio = view.frame.width / 375
    
    // Email
    var EmailExport : String!
    
    // Parameter Datasource Collection Cell
    var Icon_ListReport : [UIImage] = [#imageLiteral(resourceName: "order_product").withRenderingMode(.alwaysOriginal), #imageLiteral(resourceName: "vendor").withRenderingMode(.alwaysOriginal), #imageLiteral(resourceName: "clipboard").withRenderingMode(.alwaysOriginal)]
    var Name_ListReport : [String] = ["Top product in category", "Top Customer", "In Process Quotation"]
    var Descrip_ListReport : [String] = ["Reports on the most popular products in each product category.", "Reports on customer data, each channel received by the company's customers.", "Reports related to the quote data that are in the sales process during this period."]
    var Report_Number : [String] = ["Report2", "Report6", "Report8"]
    // MARK: Element
    // View Show Duration Monitoring
    lazy var View_Date : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = CGSize(width: 3 * ratio, height: 3 * ratio)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    // Label Date Monitoring
    lazy var Lb_Date : UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = UIColor.BlackAlpha(alpha: 0.9)
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.textAlignment = .center
        return label
    }()
    
    // Collection View List Excel Export
    var Collection_ListExport : UICollectionView!
    
    // View Blur of IMage BG
    var BGBlur : UIVisualEffectView = {
        let Blur = UIVisualEffectView(frame: UIScreen.main.bounds)
        let BlurEffect = UIBlurEffect(style: .dark)
        Blur.effect = BlurEffect
        Blur.alpha = 0
        
        return Blur
    }()
    
    // View Alert Process Export
    lazy var View_Alert : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3 * ratio, height: 3 * ratio)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.alpha = 0
        return view
    }()
    
    // Icon StateExport
    var Icon_StateExport : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "CheckBox").withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.tintColor = .whiteAlpha(alpha: 0.9)
        return image
    }()
    
    // Label Alert Export
    lazy var Lb_Alert : UILabel = {
        let label = UILabel()
        label.text = "Report Export Complete"
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Func Layout
    func Layout_Page(){
        
        view.backgroundColor = .systemGray6
        
        // Set Navigation Bar
        navigationItem.title = "Export Report"
        
        // Set View Date
        view.addSubview(View_Date)
        View_Date.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
        // Set Label Date
        view.addSubview(Lb_Date)
        Lb_Date.anchorCenter(View_Date.centerXAnchor, AxisY: View_Date.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        
        // Set Collection List Report
        let Collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(Collection)
        Collection.anchor(View_Date.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Collection.backgroundColor = .clear
        Collection.alwaysBounceVertical = true
        Collection_ListExport = Collection
        
        // Set BG Blur
        view.addSubview(BGBlur)
        BGBlur.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Set View Alert
        view.addSubview(View_Alert)
        View_Alert.anchorCenter(BGBlur.centerXAnchor, AxisY: BGBlur.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        // Icon State Export
        View_Alert.addSubview(Icon_StateExport)
        Icon_StateExport.anchor(View_Alert.topAnchor, left: View_Alert.leftAnchor, bottom: nil, right: View_Alert.rightAnchor, topConstant: 20 * ratio, leftConstant: 40 * ratio, bottomConstant: 0, rightConstant: 40 * ratio, widthConstant: 100 * ratio, heightConstant: 100 * ratio)
        
        // Label Alert
        View_Alert.addSubview(Lb_Alert)
        Lb_Alert.anchor(Icon_StateExport.bottomAnchor, left: View_Alert.leftAnchor, bottom: View_Alert.bottomAnchor, right: View_Alert.rightAnchor, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 20 * ratio, rightConstant: 10 * ratio, widthConstant: 180 * ratio, heightConstant: 0)
        
    }
    
    // MARK: Func Config
    func Config_Page(){
        
        Collection_ListExport.delegate = self
        Collection_ListExport.dataSource = self
        Collection_ListExport.register(CollectionCell_ListReportExport.self, forCellWithReuseIdentifier: Id_Cell)
        
        // Set Data Date to Lb_Date
        Lb_Date.text = TabBarAdmin.TxtDate_Request
        
        
    }
    // MARK: Func Lift Cycle of Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Page
        Layout_Page()
        // config Page
        Config_Page()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    // MARK: Normal Func
    // Func Control Alert State Process Export
    func Control_AlertProcessExport(State : Bool){
        
        var Text_Alert = "Process Export Complete"
        var Icon_Alert = #imageLiteral(resourceName: "correct").withRenderingMode(.alwaysTemplate)
        // Check State
        if State == false {
            Text_Alert = "Process Export InComplete"
            Icon_Alert = #imageLiteral(resourceName: "remove").withRenderingMode(.alwaysTemplate)
        }
        
        // Set Alert Show
        Icon_StateExport.image = Icon_Alert
        Icon_StateExport.contentMode = .scaleAspectFit
        Lb_Alert.text = Text_Alert
        
        // Animation Open View Alert
        /*UIView.animate(withDuration: 1) {
            self.View_Alert.alpha = 1
            self.BGBlur.alpha = 0.5
        }*/
        UIView.animate(withDuration: 1, animations: {
            self.View_Alert.alpha = 1
            self.BGBlur.alpha = 0.5
        }) { (_) in
            // Delay View Alert Show
            UIView.animate(withDuration: 1, delay: 2, options: .curveEaseInOut, animations: {
                self.View_Alert.alpha = 0
                self.BGBlur.alpha = 0
            }, completion: nil)
        }
        
        
    }
    
    // Func Request Export Report
    func Request_ExportReport(Url : String, ReportNumber : String){
        
        let Header : HTTPHeaders = [.authorization(bearerToken: LoginPageController.DataLogin!.Token_Id), .contentType("application/json")]
        
        let parameter = ["Start" : TabBarAdmin.DateMonitor_Request["Start"], "End" : TabBarAdmin.DateMonitor_Request["End"], "Email" : self.EmailExport, "Report" : ReportNumber]
        
        AF.request(Url, method: .post, parameters: parameter as Parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success(let value) :
                
                self.Control_AlertProcessExport(State: true)
                
            case .failure(_):
                self.Control_AlertProcessExport(State: false)
                break
            }
            
            
        })
        
        
    }
    
}
// MARK: Extension
// Extension Collection
extension ExportDataPageController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Id_Cell, for: indexPath) as! CollectionCell_ListReportExport
        
        // Set Image of Cell
        cell.Icon_Report.image = Icon_ListReport[indexPath.row]
        // Set Name Report of Cell
        cell.Lb_NameReport.text = Name_ListReport[indexPath.row]
        // Set Description of Cell
        cell.Lb_DescripReport.text = Descrip_ListReport[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Check Valid Email
        guard LoginPageController.DataLogin?.CompanyEmail != "" else {
            
            let alertError = UIAlertController(title: "Invalid Email", message: "The report could not be exported to this email.", preferredStyle: .alert)
            self.present(alertError, animated: true)
            
            return
        }
        
        let alert = UIAlertController(title: "Export to Email?", message: "Confirm to send Report to email \n \(LoginPageController.DataLogin?.CompanyEmail ?? "")", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Export", style: .default, handler: {(_) in
            self.EmailExport = LoginPageController.DataLogin?.CompanyEmail
            // Request Export
            self.Request_ExportReport(Url: DataSource.Url_ExportReport_Admin(), ReportNumber: self.Report_Number[indexPath.row])
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))

        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 1, height: 1)
        
        self.present(alert, animated: true, completion: nil)
        //self.present(alert, animated: true)
        
    }
    
    
}

extension ExportDataPageController : UICollectionViewDelegateFlowLayout {
    // UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio = view.frame.width / 375
        return CGSize(width: collectionView.bounds.width - (20 * ratio), height: 120 * ratio)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let ratio = view.frame.width / 375
        return UIEdgeInsets(top: 10 * ratio, left: 10 * ratio, bottom: 10 * ratio, right: 10 * ratio) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Space Vertical of cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}


