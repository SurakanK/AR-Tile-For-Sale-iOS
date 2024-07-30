//
//  FilterDatePageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 10/6/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class FilterDatePageController : UIViewController {
    
    // MARK: Parameter
    // ratio
    lazy var ratio = view.frame.width / 375
    // Delegate Tabbar Admin
    var Delegate : TabBarAdminDelegate?
    
    // Parameter of Date
    var MonthData : [String] = []
    var YearData : [String] = []
    
    
    
    // Parameter State of Set Date
    var StateSetDate : Bool = false {
        didSet {
            
            if StateSetDate == true {
                
                UIView.animate(withDuration: 0.5) {
                    self.View_Blur.alpha = 1
                }
            }
            else {
                UIView.animate(withDuration: 0.5) {
                    self.View_Blur.alpha = 0
                }
            }
            
        }
    }
    
    // Parameter State All Duration for Segment Mode Date "All" (index 0)
    var StateAllDuration : Bool = true {
        didSet{
            
            if StateAllDuration {
                
                // Hide Section Set Duration
                Lb_HDuration.alpha = 0
                View_DateStart.alpha = 0
                Lb_HTo.alpha = 0
                View_DateEnd.alpha = 0
                
                let date = Date()
                let formatter = DateFormatter()
                
                formatter.dateFormat = "yyyy"
                formatter.calendar = Calendar(identifier: .gregorian)
                
                // Config Date
                Txt_DateStart.text = "2000" // since year 2000
                Txt_DateEnd.text = formatter.string(from: date) // Current Year
                
                StateSetDate = false
                
            }
            else {
                
                // Show Section Set Duration
                Lb_HDuration.alpha = 1
                View_DateStart.alpha = 1
                Lb_HTo.alpha = 1
                View_DateEnd.alpha = 1
                
            }
            
            
        }
    }
    
    // Parameter String Type of Set Date
    var TypeSetDate : String = "DateStart" // DateStart, DateEnd
    
    
    // MARK: Element Page
    
    // Section Set Mode Date -----
    // Label Header Segment Mode Set Time
    lazy var Lb_HModeDate : UILabel = {
        let label = UILabel()
        label.text = "Set Time Mode"
        label.font = UIFont.MitrMedium(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    // Segment Button Mode Date
    lazy var Seg_ModeDate : UISegmentedControl = {
        let button = UISegmentedControl(items: ["All", "Month", "Year"])
        
        button.selectedSegmentTintColor = .BlueDeep
        button.tintColor = .white
        
        // Attribute Text of Normal State
        button.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.MitrRegular(size: 18 * ratio), NSAttributedString.Key.foregroundColor : UIColor.BlueDeep], for: .normal)
        // Attribute Text of Selected State
        button.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.MitrRegular(size: 18 * ratio), NSAttributedString.Key.foregroundColor : UIColor.whiteAlpha(alpha: 0.9)], for: .selected)
        
        button.backgroundColor = .white
        
        button.selectedSegmentIndex = 0
        // Hide Section Set Duration
        self.StateAllDuration = true

        button.addTarget(self, action: #selector(Seg_BtnModeDateChange(sender:)), for: .valueChanged)
        
        return button

    }()
    // ---------------------------
    
    // Label Header Set Time Duration
    lazy var Lb_HDuration : UILabel = {
        let label = UILabel()
        label.text = "Set Time Duration"
        label.font = UIFont.MitrMedium(size: 18 * ratio)
        label.textColor = .BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Section View Date Start -----
    // View Date Start
    var View_DateStart : UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.BlueDeep.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        
        return view
    }()
    //  Txt Date Start
    lazy var Txt_DateStart : UITextField = {
        let txt = UITextField()
        // Set Attribute PlaceHolder
        txt.attributedPlaceholder = NSAttributedString(string: "Date Start", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 18 * ratio)])
        // Set Attribute Text
        txt.font = UIFont.MitrLight(size: 18 * ratio)
        txt.textColor = UIColor.BlackAlpha(alpha: 0.9)
        txt.textAlignment = .center
        txt.isEnabled = false
        return txt
    }()
    // btn Settime Start
    var Btn_SetStart : UIButton = {
        let button = UIButton()
        button.setImage( #imageLiteral(resourceName: "calendar").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .BlueDeep
        button.backgroundColor = .clear
        
        // add target
        button.addTarget(self, action: #selector(Event_SetDateStart), for: .touchUpInside)
        
        return button
    }()
    
    // -----------------------------
    
    // Label Header To ("To")
    lazy var Lb_HTo : UILabel = {
        let label = UILabel()
        label.text = "To"
        label.font = UIFont.MitrRegular(size: 18 * ratio)
        label.textAlignment = .center
        label.textColor = UIColor.BlackAlpha(alpha: 0.9)
        return label
    }()
    
    // Section View Date End -------
    // View Date End
    var View_DateEnd : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.BlueDeep.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        return view
    }()
    // Txt Date End
    lazy var Txt_DateEnd : UITextField = {
        let txt = UITextField()
        // Set Attribute PlaceHolder
        txt.attributedPlaceholder = NSAttributedString(string: "Date End", attributes: [NSAttributedString.Key.font : UIFont.MitrLight(size: 18 * ratio)])
        // Set Attribute Text
        txt.font = UIFont.MitrLight(size: 18 * ratio)
        txt.textColor = UIColor.BlackAlpha(alpha: 0.9)
        txt.textAlignment = .center
        txt.isEnabled = false
        return txt
    }()
    // btn Settime End
    var Btn_SetEnd : UIButton = {
        let button = UIButton()
        button.setImage( #imageLiteral(resourceName: "calendar").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .BlueDeep
        button.backgroundColor = .clear
        
        //add Target
        button.addTarget(self, action: #selector(Event_SetDateEnd), for: .touchUpInside)
        
        return button
    }()
    
    // -----------------------------
    
    // Button Submit
    lazy var Btn_Submit : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.MitrMedium(size: 18 * ratio)
        
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.5
        
        
        // Add Target
        button.addTarget(self, action: #selector(Event_Submit), for: .touchUpInside)
        
        return button
    }()
    
    // View Blur for Set Date
    var View_Blur : UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.25)
        view.alpha = 0
        return view
    }()
    
    // View Picker Set Date
    var View_SetDate : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    //  Picker Date Set
    var PickerDate : UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    // Button Select Date
    lazy var Btn_SetDate : UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.MitrRegular(size: 18 * ratio)
        button.titleLabel?.textColor = .whiteAlpha(alpha: 0.9)
        button.backgroundColor = .BlueDeep
        button.layer.cornerRadius = 5
        
        // add target
        button.addTarget(self, action: #selector(Event_DoneSetDate), for: .touchUpInside)
        
        return button
    }()
    
    // Button Cancenl Select Date
    lazy var Btn_CancelSetDate : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.MitrRegular(size: 18 * ratio)
        button.titleLabel?.textColor = .whiteAlpha(alpha: 0.9)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 5
        
        //add target
        button.addTarget(self, action: #selector(Event_CancelSetDate), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: Func Layout Page
    func Layout_Page(){
        
        view.backgroundColor = .whiteAlpha(alpha: 1)
        
        // Button Submit
        view.addSubview(Btn_Submit)
        Btn_Submit.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 60 * ratio, bottomConstant: 10 * ratio, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 50 * ratio)
        
        // Section Set Mode Date
        // Label Header Mode Date
        view.addSubview(Lb_HModeDate)
        Lb_HModeDate.anchor(view.safeAreaLayoutGuide.topAnchor, left: Btn_Submit.leftAnchor, bottom: nil, right: Btn_Submit.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        // Segment Button Mode Date
        view.addSubview(Seg_ModeDate)
        Seg_ModeDate.anchor(Lb_HModeDate.bottomAnchor, left: Btn_Submit.leftAnchor, bottom: nil, right: Btn_Submit.rightAnchor, topConstant: 0 * ratio, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 40 * ratio)
        // --------------------------------
        
        // Section Set Time Duration
        // Label Header Set Time Duration
        view.addSubview(Lb_HDuration)
        Lb_HDuration.anchor(Seg_ModeDate.bottomAnchor, left: Lb_HModeDate.leftAnchor, bottom: nil, right: Lb_HModeDate.rightAnchor, topConstant: 15 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
            // Section View Date Start --
            view.addSubview(View_DateStart)
            View_DateStart.anchor(Lb_HDuration.bottomAnchor, left: Seg_ModeDate.leftAnchor, bottom: nil, right: Seg_ModeDate.rightAnchor, topConstant: 10 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
            // Button Date Start
            View_DateStart.addSubview(Btn_SetStart)
            Btn_SetStart.anchorCenter(nil, AxisY: View_DateStart.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
            Btn_SetStart.anchor(nil, left: nil, bottom: nil, right: View_DateStart.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
            // Txt Date Start
            View_DateStart.addSubview(Txt_DateStart)
            Txt_DateStart.anchor(Btn_SetStart.topAnchor, left: View_DateStart.leftAnchor, bottom: Btn_SetStart.bottomAnchor, right: Btn_SetStart.leftAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
            // --------------------------
        
            // Label Header To ("To")
            view.addSubview(Lb_HTo)
            Lb_HTo.anchorCenter(View_DateStart.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
            Lb_HTo.anchor(View_DateStart.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
            // Section View Date End
            view.addSubview(View_DateEnd)
            View_DateEnd.anchor(Lb_HTo.bottomAnchor, left: View_DateStart.leftAnchor, bottom: nil, right: View_DateStart.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40 * ratio)
            // Btn Set Date End
            View_DateEnd.addSubview(Btn_SetEnd)
            Btn_SetEnd.anchorCenter(nil, AxisY: View_DateEnd.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
            Btn_SetEnd.anchor(nil, left: nil, bottom: nil, right: View_DateEnd.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
            // Txt Date End
            View_DateEnd.addSubview(Txt_DateEnd)
            Txt_DateEnd.anchor(Btn_SetEnd.topAnchor, left: View_DateEnd.leftAnchor, bottom: Btn_SetEnd.bottomAnchor, right: Btn_SetEnd.leftAnchor, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        // --------------------------------
        
        // View Blur for Set Date
        view.addSubview(View_Blur)
        View_Blur.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Section View Set Date
        // View Set Date
        View_Blur.addSubview(View_SetDate)
        View_SetDate.anchor(View_DateEnd.bottomAnchor, left: View_DateEnd.leftAnchor, bottom: Btn_Submit.topAnchor, right: View_DateEnd.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 5 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Picker Set Date
        View_SetDate.addSubview(PickerDate)
        PickerDate.anchor(View_SetDate.topAnchor, left: View_SetDate.leftAnchor, bottom: nil, right: View_SetDate.rightAnchor, topConstant: 5 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Btn Select Date
        View_SetDate.addSubview(Btn_SetDate)
        Btn_SetDate.anchor(PickerDate.bottomAnchor, left: PickerDate.leftAnchor, bottom: View_SetDate.bottomAnchor, right: PickerDate.centerXAnchor, topConstant: 5 * ratio, leftConstant: 10 * ratio, bottomConstant: 5 * ratio, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 40 * ratio)
        
        // Btn Cancek Date
        View_SetDate.addSubview(Btn_CancelSetDate)
        Btn_CancelSetDate.anchor(Btn_SetDate.topAnchor, left: PickerDate.centerXAnchor, bottom: Btn_SetDate.bottomAnchor, right: PickerDate.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 40)
        
        // --------------------------------
        
        
    }
    
    // MARK: Func Config Page
    func Config_Page(){
        
        // Config Data Month and Year
        for count in 1...12 {
            var Month = String(count)
            if Month.count == 1 {
                Month = "0" + Month
            }
            MonthData.append(Month)
        }
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yy"
        formatter.calendar = Calendar(identifier: .gregorian)
        let DateTest = formatter.string(from: date)
        
        for count in 0...Int(DateTest)! {
            let CurrentYear = 2000
            YearData.append(String(CurrentYear + count))
        }
        
        // Config PickerView Date
        PickerDate.delegate = self
        PickerDate.dataSource = self
        
    }
    
    // MARK: Func Life Cycle Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element in Page
        Layout_Page()
        // Config Element in Page
        Config_Page()
        
    }
    
    // MARK: Func Btn Page
    // Button Set Duration Date Start
    @objc func Event_SetDateStart(){
        
        // Change State Set Date
        StateSetDate = true
        // Change Type of Set Date
        TypeSetDate = "DateStart"

    }
    // Button Set Duration Date End
    @objc func Event_SetDateEnd(){
        
        // Default Border Color View DateEnd
        View_DateEnd.layer.borderColor = UIColor.BlueDeep.cgColor
        
        // Change State Set Date
        StateSetDate = true
        // Change Type of Set Date
        TypeSetDate = "DateEnd"

    }
    
    // Button Done Set Date
    @objc func Event_DoneSetDate(){
        
        // Check Type of Set Date
        if TypeSetDate == "DateStart" {
            
            // Check Mode of Set Time Duratio
            // Month
            if Seg_ModeDate.selectedSegmentIndex == 1 {
                // Set Value  to Txt DateStart
                let month = MonthData[PickerDate.selectedRow(inComponent: 0)]
                let year = YearData[PickerDate.selectedRow(inComponent: 1)]
                Txt_DateStart.text = month + "-" + year
            }
            // Year
            else if Seg_ModeDate.selectedSegmentIndex == 2 {
                // Set Value  to Txt DateStart
                let year = YearData[PickerDate.selectedRow(inComponent: 0)]
                Txt_DateStart.text = year
            }
       
            
        }
        else if TypeSetDate == "DateEnd" {
            // Check Mode of Set Time Duratio
            // Month
            if Seg_ModeDate.selectedSegmentIndex == 1 {
                // Set Value  to Txt DateStart
                let month = MonthData[PickerDate.selectedRow(inComponent: 0)]
                let year = YearData[PickerDate.selectedRow(inComponent: 1)]
                Txt_DateEnd.text = month + "-" + year
            }
            // Year
            else if Seg_ModeDate.selectedSegmentIndex == 2 {
                // Set Value  to Txt DateStart
                let year = YearData[PickerDate.selectedRow(inComponent: 0)]
                Txt_DateEnd.text = year
            }
        }
        
        // Hide Picker Set Date View
        // Change State Set Date
        StateSetDate = false
        
        
    }
    
    // Button Cancel Set date
    @objc func Event_CancelSetDate(){
        
        // Hide Picker Set Date View
        // Change State Set Date
        StateSetDate = false
        
        
    }
    
    // Button Submit Event
    @objc func Event_Submit(){
        
        // Check Set Date Set != ""
        guard Txt_DateStart.text!.count > 0 else {
            return
        }
        guard Txt_DateEnd.text!.count > 0 else {
            return
        }
        // Check Verify of Set Date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-yyyy"
        // Change formatter Date
        if Seg_ModeDate.selectedSegmentIndex == 0 || Seg_ModeDate.selectedSegmentIndex == 2{
            formatter.dateFormat = "yyyy"
            
        }
        formatter.calendar = Calendar(identifier: .gregorian)
        let DateStart = formatter.date(from: Txt_DateStart.text!)
        let DateEnd = formatter.date(from: Txt_DateEnd.text!)
        
        // Compare Date must DateStart < Date End
        guard DateStart! <= DateEnd! else {
            
            // Alert Error Set Date
            self.View_DateEnd.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        
        // Record Date Mode to Static Variable in TabBarAdminContainer
        if Seg_ModeDate.selectedSegmentIndex == 0 || Seg_ModeDate.selectedSegmentIndex == 2{
            
            TabBarAdminContainer.ModeDate = "Year"
            
        }
        else if Seg_ModeDate.selectedSegmentIndex == 1 {
            
            TabBarAdminContainer.ModeDate = "Month"
            
        }
        
        // Convert Format of Date Set (Start and End)
        let Format_Result = DateFormatter()
        Format_Result.dateFormat = "yyyy-MM"
        Format_Result.calendar = Calendar(identifier: .gregorian)
        
        var DateStart_Result = Format_Result.string(from: DateStart!)
        var DateEnd_Result = Format_Result.string(from: DateEnd!)
        
        // Check Date Mode if "Year" DateStart month = 01 and DateEnd month = 12
        if Seg_ModeDate.selectedSegmentIndex == 0 || Seg_ModeDate.selectedSegmentIndex == 2{
            
            DateEnd_Result = Format_Result.string(from: DateEnd!.endOfMonth(value: 11))
            
        }
        
        
        // Update Date All Data Monitor
        let Date : [String : String] = ["Start" : DateStart_Result, "End" : DateEnd_Result]
        // Record Date Request
        TabBarAdmin.DateMonitor_Request = Date
        
        // Request Data Overall
        Delegate?.Request_Data(Date: Date, Type: "Quotation")
        // Request Data Top Product
        Delegate?.Request_Data(Date: Date, Type: "TopProduct")
        // Request Data Top Sales
        Delegate?.Request_Data(Date: Date, Type: "TopSale")
        
        // Request Data Customer Type
        Delegate?.Request_Data(Date: Date, Type: "CustomerType")
        
        // Request Data Customer Chanel Income
        Delegate?.Request_Data(Date: Date, Type: "CustomerChanel")
        
        // Hide FilterDate Page
        Delegate?.ToggleFilterDate()
        
        // Close BGBlur in Tabbar
        
        
    }
    
    
    
    // MARK: Event Segment Button Mode Date
    @objc func Seg_BtnModeDateChange(sender : UISegmentedControl){
        
        PickerDate.reloadAllComponents()
        
        // Clear Data Set
        Txt_DateStart.text = ""
        Txt_DateEnd.text = ""
        
        // Case All
        if Seg_ModeDate.selectedSegmentIndex == 0 {
            
            StateAllDuration = true
            
        }
        // Case Month
        else if Seg_ModeDate.selectedSegmentIndex == 1 {
            
            StateAllDuration = false
            
        }
        // Case Year
        else if Seg_ModeDate.selectedSegmentIndex == 2 {
            
            StateAllDuration = false
            
        }
        
        
    }
    
    // MARK: Func in Page
    
    
}

// MARK: extension Page
// extension Picker Date
extension FilterDatePageController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if Seg_ModeDate.selectedSegmentIndex == 1 {
            return 2
        }else {
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            // Year
            if Seg_ModeDate.selectedSegmentIndex == 2 {
                return YearData.count
            }
            // Month
            else {
                return MonthData.count
            }
        }
        else{
            return YearData.count
        }
   
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.font = UIFont.MitrRegular(size: 20 * ratio) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        
        if Seg_ModeDate.selectedSegmentIndex == 2 {
            
            let data = YearData
            pickerLabel.text = data[row]
            return pickerLabel
        }
        else {
            if component == 0 {
                let data = MonthData
                pickerLabel.text = data[row]
                return pickerLabel
                
            }
            else {
                let data = YearData
                pickerLabel.text = data[row]
                return pickerLabel
            }
        }
        
        
        
    }
    
  
    
    
    
    
    
}
