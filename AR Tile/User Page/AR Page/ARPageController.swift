//
//  ARPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 23/5/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import ARKit
import AVKit
import AVFoundation
import CoreMotion
import Photos

private var Id_CellGrout : String = "UIDesign_CellColorGrout"

class ARPageController : UIViewController {
    
    // MARK: Parameter
    // Ratio
    lazy var ratio = view.frame.width / 375
    
    /// Section Data Cross
    var DataProduct = [String : Any]()
    // parameter audio Shutter
    var Audio_Shutter : AVAudioPlayer!
    
    /// State Process AR --------
    // State Scan FeturePoint
    var StateScanFeature : Bool = false
    // State Marking Area
    var StateMark : Bool = false
    // State Crete Plane Result
    var StateCreatePlane : Bool = false
    // State Done
    var StateDone : Bool = false
    /// ------------------
    
    /// State of Process AR horizontal
    // State Set Direction Simmulate
    var StateDirection : Bool = false
    /// ------------------
    
    /// State of  Process AR Vertical
    // State Set Height for Process Verical
    var StateSetHeight : Bool = false
    /// ------------------
    
    
    // Parameter State of Add Product for Check Product Add to Cart
    var State_AddProduct : Bool = false {
        
        didSet {
            
            if State_AddProduct {
                
                // Change Button Add Product to Remove Product
                Lb_AddProduct.text = "Remove Product"
                Icon_AddProduct.image = #imageLiteral(resourceName: "rubbish-can").withRenderingMode(.alwaysTemplate)
                
            }
            else {
                
                // Change Button remove Product to Add Product
                Lb_AddProduct.text = "Add Product"
                Icon_AddProduct.image = #imageLiteral(resourceName: "buy 25png").withRenderingMode(.alwaysTemplate)
                
            }
            
        }
        
    }
    
    // Parameter Motion Mobile
    var motionManager = CMMotionManager()
    // Parameter Angle Between Device With Floor
    var angle_Floor : Float!
    
    // Plane of Simmulation Tile Pattern
    var Plane_Sim : String!
    
    // angle of Device
    var AngleDevice : Float!
    // Height Plane Vertical
    var Height_Plane : Float = 0.5
    
    // Position Camera
    var PositionCamera : SCNVector3?
    
    // Column Node ARKit
    var columnNode : ColumnNode?
    // Plane Vertical Node
    var PlaneNode_Vertical : SCNNode?
    
    // Image Grid Help
    var Image_Grid_Help : UIImage = #imageLiteral(resourceName: "Grid_begin").imageWithBorder(width: 1, color: UIColor.white)!
    
    
    // Array Name of Column Node
    var NameColumnNode : [String] = []
    // Array All Positon Column Node
    var AllPositionMark : [SCNVector3] = []
    
    // Screen Center
    lazy var ScreenCenter : CGPoint = self.view.center
    
    // Stack Feature Point
    var Stack_FeaturePoint : Int = 0
    var Old_FeaturePoint : Int = 0
    
    // Image Tile Simmulation
    var Image_Tile : UIImage =  #imageLiteral(resourceName: "GA-060_20x20_1950_")
    // Color Grout Select
    var ColorGrout_Selection = UIColor.white
    // Dimension of Tile
    var Dimension : CGSize = CGSize(width: 0.2015, height: 0.2015)
    
    
    // List Grout Color
    var ColorGrout : [String] = ["#f6f1f2", "#d2d1d2", "#a3a19f", "#696164", "#1d191d", "#cab8b5", "#e5dcc9", "#dcd6ce", "#d8c3a6", "#e4ba69", "d3af99", "#bb9a9b", "#d1a5a7", "#c58b94", "#cb8f77", "#906144", "#af674c", "#963a35", "#7a5b53", "#97a99f", "#617261", "#729680", "#7a877b", "#c3d8e7", "#c5e4f7", "#76b1dd", "#3182ba", "#7073ac", "#656684", "#c4a3d9"]
    
    // MARK: Element Page
    // SceneView AR
    lazy var SceneView : ARSCNView = {
        
        let sceneview = ARSCNView()
        // Delegate ARKit
        sceneview.delegate = self

        
        return sceneview
        
    }()
    // Config AR Session
    var configuration = ARWorldTrackingConfiguration()
    
    // Button Back to Page Detail Product Before ARPage
    lazy var Btn_Back : UIButton = {
        
        let button = UIButton()
        // Rotate Image Button
        var image : UIImage = #imageLiteral(resourceName: "next").withRenderingMode(.alwaysTemplate)
        image = image.withTintColor(.whiteAlpha(alpha: 0.9))
        image = image.rotate(radians: 3.14159)
        // Set Image to Button
        button.setImage(image, for: .normal)
        button.tintColor = .whiteAlpha(alpha: 0.9)
        
        // Add Target Button
        button.addTarget(self, action: #selector(Event_BackToDetailPro), for: .touchUpInside)
        
        return button
        
    }()
    
    // Button Help
    var Btn_Help : UIButton = {
        
        let button = UIButton()
        
        // Set IMage to Button
        button.setImage(#imageLiteral(resourceName: "Information").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .whiteAlpha(alpha: 0.9)
        button.alpha = 0
        
        return button
        
    }()
    
    // Section Button Add Product
    // View Button Add Product
    var View_AddProdcut : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.9).cgColor
        view.layer.masksToBounds = true
        return view
    }()
    // Icon add Procuct
    var Icon_AddProduct : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "buy 25png").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        image.contentMode = .scaleAspectFit
        return image
    }()
    // Label Add Product
    lazy var Lb_AddProduct : UILabel = {
        let label = UILabel()
        label.text = "Add Product"
        label.font = UIFont.MitrRegular(size: 15 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        return label
    }()
    // Button Add Product
    var Btn_AddProduct : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        // add Target Button
        button.addTarget(self, action: #selector(Event_AddProduct), for: .touchUpInside)
        
        return button
    }()

    // --------------------------------
    
    // Section Button Clear -----------
    // View Btn Clear
    var View_BtnClear : UIView = {
        
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.9).cgColor
        view.layer.masksToBounds = true
        
        return view
    }()
    // View Icon Btn Clear
    var Icon_Clear : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "brush").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        return image
    }()
    // Label Text Btn Clear
    lazy var Lb_BtnClear : UILabel = {
        let label = UILabel()
        
        label.text = "Clear"
        label.font = UIFont.MitrRegular(size: 15 * ratio)
        label.textColor = UIColor.whiteAlpha(alpha: 0.9)
        
        return label
    }()
    // Button Clear
    var Btn_Clear : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        // add Target Button
        button.addTarget(self, action: #selector(Event_BtnClear), for: .touchUpInside)
        
        return button
    }()
    // --------------------------------
    
    // Animation Alert Process AR Section -------
    // View Animation Alert Process AR
    var View_AnimationAlert : UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.25)
        view.layer.cornerRadius = 5
        
        view.alpha = 0
        
        return view
    }()

    // Image Animation Alert Process
    var Image_GifAlert : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // --------------------------------
    
    // Text Alert Process AR Section -------
    // View Text Alert Process AR
    var View_TxtAlert : UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.25)
        view.layer.cornerRadius = 5
        
        view.alpha = 0
        
        return view
    }()
    // Label Alert Process AR
    lazy var Lb_Alert : UILabel = {
        let label = UILabel()
        label.text = "Alert Process AR"
        label.font = UIFont.MitrRegular(size: 15 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    // --------------------------------
    
    // Section Button Capture -------
    // View Button Undo
    var View_BtnUndo : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.9).cgColor
        view.layer.masksToBounds = true
        
        view.alpha = 0
        
        return view
    }()
    // Icon Btn_Undo
    var Icon_BtnUndo : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "undo").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        return image
    }()
    // Label Btn Undo
    lazy var Lb_BtnUndo : UILabel = {
        let label = UILabel()
        label.text = "Undo"
        label.font = UIFont.MitrRegular(size: 13 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // Btn Undo
    var Btn_Undo : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        // Add Target Button
        button.addTarget(self, action: #selector(Event_BtnUndo(sender:)), for: .touchUpInside)
        return button
    }()
    
    // --------------------------------
    
    // Section Button Capture -------
    // View Btn Capture
    var View_BtnCapture : UIView = {
        let view = UIView()
        
        view.backgroundColor = .BlueDeep
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.9).cgColor
        view.layer.masksToBounds = true
        
        view.alpha = 0
        return view
    }()
    // Icon Button Capture
    var Icon_Capture : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Image").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        return image
    }()
    // Button Capture
    var Btn_Capture : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        // Add Target Button
        //button.addTarget(self, action: #selector(Event_BtnCapture), for: .touchUpInside)
        
        return button
    }()
    // --------------------------------
    
    // Section Button Done
    // View Button Done
    var View_BtnDone : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.9).cgColor
        view.layer.masksToBounds = true
        
        view.alpha = 0
        return view
    }()
    // Icon Btn Done
    var Icon_BtnDone : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "CheckBox").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        return image
    }()

    // Button Done
    var Btn_Done : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        // Add Target Button
        button.addTarget(self, action: #selector(Event_BtnDone), for: .touchUpInside)
        
        return button
    }()
    // --------------------------------
    
    // Button Add Corner Section -------
    // View Btn Add Corner
    var View_BtnAddCorn : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.9).cgColor
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        
        view.alpha = 0
        
        return view
    }()
    // Icon Button Add Corner
    var Icon_BtnAddCorn : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "corner").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        return image
    }()
    // Label Button Add Corner
    lazy var Lb_BtnAddCorn : UILabel = {
        let label = UILabel()
        label.text = "Add Corner"
        label.font = UIFont.MitrRegular(size: 13 * ratio)
        label.textColor = .whiteAlpha(alpha: 0.9)
        label.textAlignment = .center
        return label
    }()
    // Button Add Corner
    var Btn_AddCorn : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        // Add targer button
        button.addTarget(self, action: #selector(Event_BtnAddCorn), for: .touchUpInside)
        
        return button
    }()
    // --------------------------------
    
    // Section Button Grout ------
    // View Btn Grout
    var View_BtnGrout : UIView = {
        let view = UIView()
        view.backgroundColor = .BlueDeep
        view.layer.borderColor = UIColor.whiteAlpha(alpha: 0.9).cgColor
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        
        view.alpha = 0
        return view
    }()
    // Icon Btn Grout
    var Icon_BtnGrout : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "decoration").withRenderingMode(.alwaysTemplate)
        image.tintColor = .whiteAlpha(alpha: 0.9)
        return image
    }()
    // Button Grout
    var Btn_Grout : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        // Add Target Button
        button.addTarget(self, action: #selector(Event_BtnGrout), for: .touchUpInside)
        
        return button
    }()
    
    // Collection Grouct
    lazy var Collection_Grout : UICollectionView = {
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collection.backgroundColor = .whiteAlpha(alpha: 0.5)
        collection.alpha = 0
        collection.isScrollEnabled = true
        collection.showsVerticalScrollIndicator = false
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(UIDesign_CellColorGrout.self, forCellWithReuseIdentifier: Id_CellGrout)
        
        collection.alpha = 0
        return collection
        
    }()
    
    lazy var SizeCollecitonCell : CGSize = CGSize(width: 50 * ratio, height: 50 * ratio)
    lazy var  HeightCollection = self.Collection_Grout.heightAnchor.constraint(equalToConstant: 50 * ratio)
    
    // --------------------------------
    
    // MARK: Layout Page
    func Layout_Page(){
        
        // set Background View
        view.backgroundColor = .white
        
        // Layout AR SceneView
        view.addSubview(SceneView)
        SceneView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Button Back
        view.addSubview(Btn_Back)
        Btn_Back.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 10 * ratio, leftConstant: 10 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
        
        // Button Help
        view.addSubview(Btn_Help)
        Btn_Help.anchor(Btn_Back.topAnchor, left: Btn_Back.rightAnchor, bottom: nil , right: nil, topConstant: 0, leftConstant: 20 * ratio, bottomConstant: 0, rightConstant: 0, widthConstant: 25 * ratio, heightConstant: 25 * ratio)
        
        // Button Undo Section ------
        // View Button Undo
        view.addSubview(View_BtnClear)
        View_BtnClear.anchor(Btn_Help.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Icon Button Undo
        View_BtnClear.addSubview(Icon_Clear)
        Icon_Clear.anchor(View_BtnClear.topAnchor, left: View_BtnClear.leftAnchor, bottom: View_BtnClear.bottomAnchor, right: nil, topConstant: 6 * ratio, leftConstant: 10 * ratio, bottomConstant: 6 * ratio, rightConstant: 0, widthConstant: 18 * ratio, heightConstant: 18 * ratio)
        
        // Label Button Undo
        View_BtnClear.addSubview(Lb_BtnClear)
        Lb_BtnClear.anchor(Icon_Clear.topAnchor, left: Icon_Clear.rightAnchor, bottom: Icon_Clear.bottomAnchor, right: View_BtnClear.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        // Button Undo
        View_BtnClear.addSubview(Btn_Clear)
        Btn_Clear.anchor(View_BtnClear.topAnchor, left: View_BtnClear.leftAnchor, bottom: View_BtnClear.bottomAnchor, right: View_BtnClear.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // --------------------------
        
        // Button Add Product Section ------
        // View Add Product
        view.addSubview(View_AddProdcut)
        View_AddProdcut.anchor(View_BtnClear.topAnchor, left: nil, bottom: View_BtnClear.bottomAnchor, right: View_BtnClear.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Icon Add Product
        View_AddProdcut.addSubview(Icon_AddProduct)
        Icon_AddProduct.anchor(View_AddProdcut.topAnchor, left: View_AddProdcut.leftAnchor, bottom: View_AddProdcut.bottomAnchor, right: nil, topConstant: 6 * ratio, leftConstant: 10 * ratio, bottomConstant: 6 * ratio, rightConstant: 0, widthConstant: 18 * ratio, heightConstant: 18 * ratio)
        
        // Label Add Product
        View_AddProdcut.addSubview(Lb_AddProduct)
        Lb_AddProduct.anchor(Icon_AddProduct.topAnchor, left: Icon_AddProduct.rightAnchor, bottom: Icon_AddProduct.bottomAnchor, right: View_AddProdcut.rightAnchor, topConstant: 0, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 10 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Button Add Product
        View_AddProdcut.addSubview(Btn_AddProduct)
        Btn_AddProduct.anchor(View_AddProdcut.topAnchor, left: View_AddProdcut.leftAnchor, bottom: View_AddProdcut.bottomAnchor, right: View_AddProdcut.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
        // --------------------------
        
        // Animation Alert Process AR Section ------
        // View Animation Alert Process AR
        view.addSubview(View_AnimationAlert)
        View_AnimationAlert.anchorCenter(view.centerXAnchor, AxisY: view.centerYAnchor, ConstantAxisX: -20 * ratio, ConstantAxisY: 0, widthConstant: 250 * ratio , heightConstant: 250 * ratio)
        
        // Video Alert AR Process
        View_AnimationAlert.addSubview(Image_GifAlert)
        Image_GifAlert.anchorCenter(View_AnimationAlert.centerXAnchor, AxisY: View_AnimationAlert.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 210 * ratio, heightConstant: 210 * ratio)
        
        // --------------------------
        
        // Text Alert Process AR Section ------
        // View Text Alert Process AR
        view.addSubview(View_TxtAlert)
        View_TxtAlert.anchor(nil, left: View_AnimationAlert.leftAnchor, bottom: View_AnimationAlert.topAnchor, right: View_AnimationAlert.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Label Alert Process AR
        View_TxtAlert.addSubview(Lb_Alert)
        Lb_Alert.anchor(View_TxtAlert.topAnchor, left: View_TxtAlert.leftAnchor, bottom: View_TxtAlert.bottomAnchor, right: View_TxtAlert.rightAnchor, topConstant: 15 * ratio, leftConstant: 15 * ratio, bottomConstant: 15 * ratio, rightConstant: 15 * ratio, widthConstant: 0, heightConstant: 0)
        // --------------------------
        
        // Button Done Section ------
        // View Button Done
        view.addSubview(View_BtnDone)
        View_BtnDone.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        View_BtnDone.anchor(nil, left: nil, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10 * ratio, rightConstant: 0, widthConstant: 100 * ratio, heightConstant: 60 * ratio)
        // Set Corner radius
        view.layoutIfNeeded()
        View_BtnDone.layer.cornerRadius = View_BtnDone.frame.height / 2
        
        // Icon Btn Done
        View_BtnDone.addSubview(Icon_BtnDone)
        Icon_BtnDone.anchorCenter(View_BtnDone.centerXAnchor, AxisY: View_BtnDone.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 35 * ratio, heightConstant: 35 * ratio)
        
        // Button Done
        View_BtnDone.addSubview(Btn_Done)
        Btn_Done.anchor(View_BtnDone.topAnchor, left: View_BtnDone.leftAnchor, bottom: View_BtnDone.bottomAnchor, right: View_BtnDone.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        // --------------------------
        
        // Button Add Corner Section ------
        // View Btn Add Corner
        view.addSubview(View_BtnAddCorn)
        View_BtnAddCorn.anchor(nil, left: nil, bottom: View_BtnDone.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20 * ratio, rightConstant: 10 * ratio, widthConstant: 100 * ratio, heightConstant: 100 * ratio)
        // Set Corner Radius
        view.layoutIfNeeded()
        View_BtnAddCorn.layer.cornerRadius = View_BtnAddCorn.frame.width / 2
        
        // Icon Btn Add Corner
        View_BtnAddCorn.addSubview(Icon_BtnAddCorn)
        Icon_BtnAddCorn.anchorCenter(View_BtnAddCorn.centerXAnchor, AxisY: View_BtnAddCorn.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: -16.5 * ratio, widthConstant: 40 * ratio, heightConstant: 40 * ratio)
        
        // Label Btn Add Corner
        View_BtnAddCorn.addSubview(Lb_BtnAddCorn)
        Lb_BtnAddCorn.anchor(Icon_BtnAddCorn.bottomAnchor, left: View_BtnAddCorn.leftAnchor, bottom: nil, right: View_BtnAddCorn.rightAnchor, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Button Add Corner
        View_BtnAddCorn.addSubview(Btn_AddCorn)
        Btn_AddCorn.anchor(View_BtnAddCorn.topAnchor, left: View_BtnAddCorn.leftAnchor, bottom: View_BtnAddCorn.bottomAnchor, right: View_BtnAddCorn.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // --------------------------
        
        // Button Add Undo Section ------
        // View Btn Undo
        view.addSubview(View_BtnUndo)
        View_BtnUndo.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: View_BtnDone.topAnchor, right: nil, topConstant: 0, leftConstant: 10 * ratio, bottomConstant: 20 * ratio, rightConstant: 0, widthConstant: 100 * ratio, heightConstant: 100 * ratio)
        // Set Corner Radius
        view.layoutIfNeeded()
        View_BtnUndo.layer.cornerRadius = View_BtnUndo.frame.width / 2
        
        // Icon Btn Undo
        View_BtnUndo.addSubview(Icon_BtnUndo)
        Icon_BtnUndo.anchorCenter(View_BtnUndo.centerXAnchor, AxisY: View_BtnUndo.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: -16.5 * ratio, widthConstant: 40 * ratio, heightConstant: 40 * ratio)
        
        // Label Btn Undo
        View_BtnUndo.addSubview(Lb_BtnUndo)
        Lb_BtnUndo.anchor(Icon_BtnUndo.bottomAnchor, left: View_BtnUndo.leftAnchor, bottom: nil, right: View_BtnUndo.rightAnchor, topConstant: 5 * ratio, leftConstant: 5 * ratio, bottomConstant: 0, rightConstant: 5 * ratio, widthConstant: 0, heightConstant: 0)
        
        // Button Undo
        View_BtnUndo.addSubview(Btn_Undo)
        Btn_Undo.anchor(View_BtnUndo.topAnchor, left: View_BtnUndo.leftAnchor, bottom: View_BtnUndo.bottomAnchor, right: View_BtnUndo.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // --------------------------
        
        // Button Grout Section
        // Collection Grout
        view.addSubview(Collection_Grout)
        Collection_Grout.anchor(Btn_Back.bottomAnchor, left: nil, bottom: nil, right: View_BtnClear.rightAnchor, topConstant: 20 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50 * ratio, heightConstant: 0)
        HeightCollection.isActive = true
        
        // Set Corner Radius
        view.layoutIfNeeded()
        Collection_Grout.layer.cornerRadius = Collection_Grout.frame.width / 2
        
        // View Btn Grout
        view.addSubview(View_BtnGrout)
        View_BtnGrout.anchor(Btn_Back.bottomAnchor, left: nil, bottom: nil, right: View_BtnClear.rightAnchor, topConstant: 20 * ratio, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50 * ratio, heightConstant: 50 * ratio)
        // Set Corner Radius
        view.layoutIfNeeded()
        View_BtnGrout.layer.cornerRadius = View_BtnGrout.frame.width / 2
        
        // Icon Btn Grout
        View_BtnGrout.addSubview(Icon_BtnGrout)
        Icon_BtnGrout.anchorCenter(View_BtnGrout.centerXAnchor, AxisY: View_BtnGrout.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 25 * ratio, heightConstant:  25 * ratio)
        
        // Button Grout
        View_BtnGrout.addSubview(Btn_Grout)
        Btn_Grout.anchor(View_BtnGrout.topAnchor, left: View_BtnGrout.leftAnchor, bottom: View_BtnGrout.bottomAnchor, right: View_BtnGrout.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // --------------------------
        
        
    }
    
    // MARK: Config Page
    func Config_Page(){
        
        // Hide Navigation Bar
        navigationController?.isNavigationBarHidden = true
        
        // Section Prepare Data for Simulation
        // Image
        Image_Tile = DataProduct["Image"] as! UIImage
        
        // Set Dimention Follow Tile Pattern
        // Check Tile Pattern
        let Pattern = DataProduct["TilePattern"] as! Int
        // 1 Sheet
        if Pattern == 0 {
            
            // Set Dimension
            let Dimension = DataProduct["Dimension"] as! String
            let Dimension_Arr = Dimension.components(separatedBy: " x ")
            // Record Dimension
            self.Dimension = CGSize(width: (Double(Dimension_Arr[0]) ?? 0.2000)/100 + 0.0015, height: (Double(Dimension_Arr[1]) ?? 0.2000)/100 + 0.0015) // + Size Grout 1.5mm
            
        }
        // 4 Sheet
        else if Pattern == 1 {
            // Set Dimension
            let Dimension = DataProduct["Dimension"] as! String
            let Dimension_Arr = Dimension.components(separatedBy: " x ")
            let w = (Double(Dimension_Arr[0]) ?? 0.2000)/100 + 0.0015 // + Size Grout 1.5mm
            let h = (Double(Dimension_Arr[1]) ?? 0.2000)/100 + 0.0015 // + Size Grout 1.5mm
            // Record Dimension
            self.Dimension = CGSize(width: w * 2, height: h * 2) // + Size Grout 1.5mm
        }
        
        
        
        
        // Config AR Session
        configuration.worldAlignment = .gravity
        configuration.planeDetection = [.horizontal]
        configuration.isAutoFocusEnabled = true
        
        SceneView.debugOptions = []
        SceneView.session.run(configuration, options: .resetTracking)
        
        // Config Get angle of Mobile
        
        if motionManager.isDeviceMotionAvailable == true {
            
            motionManager.deviceMotionUpdateInterval = 0.001;
            
            let queue = OperationQueue()
            motionManager.startDeviceMotionUpdates(to: queue, withHandler: { [weak self] (motion, error) -> Void in
                
                // Get the attitude of the device
                let y = motion!.gravity.y;
                let z = motion!.gravity.z;
                
                // find angle x
                let angle_x = atan2(y, z) + .pi;           // in radians
                let angle_mobile_x = angle_x * 180 / .pi;
                self?.angle_Floor = Float(angle_mobile_x)
                
            })
        }
        
        
    }
    
    // MARK: Func Life Cycle of Page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element in Page
        Layout_Page()
        // Config Element in Page
        Config_Page()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check State of Product Add to Cart ?
        // Check repeat Id Product Add to Cart
        let Check_Id = TabBarUserController.ProductCart.filter{($0["idProduct"] as! Int) == (DataProduct["idProduct"] as! Int)}
        if Check_Id.count > 0 {
            State_AddProduct = true
        }else {
            State_AddProduct = false
        }
        
        // Alert Select Plane Simmulate
        self.Alert_PlaneSimmulate()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause ARkit
        SceneView.session.pause()
        
    }
    
    // MARK: Func of Button in Page
    // Back Button Event
    @objc func Event_BackToDetailPro(){
        
        // Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // Btn Add Product Event
    @objc func Event_AddProduct(){
        
        // Check State Add Product
        // Remove Product
        if State_AddProduct == false {
            
            // Check repeat Id Product Add to Cart
            let Check_Id = TabBarUserController.ProductCart.filter{($0["idProduct"] as! Int) == (DataProduct["idProduct"] as! Int)}
            
            guard Check_Id.count == 0 else {
                return
            }
            
            // Add Image to Data of Product Cart and Header AR Measure
            var DataAppend = DataProduct
            //DataAppend["Image"] = Im_Product.image
            DataAppend["ARMeasure"] = ProductDetailPageController.ARMeasure
            //DataAppend["Description"] = Lb_Description.text
            
            TabBarUserController.ProductCart.append(DataAppend)
            
            // Change State Add Product to false
            State_AddProduct = true

            
        }
        // Add Product
        else {
            
            // Find Index Product Added From Cart
            let index = TabBarUserController.ProductCart.firstIndex(where : {($0["idProduct"] as! Int) == (DataProduct["idProduct"] as! Int)})
            
            // Remove to Product Cart
            TabBarUserController.ProductCart.remove(at: index!)
            
            // Change State Remove Product
            State_AddProduct = false
            
            
        }
        
    }
    
    // Event Btn Undo
    @objc func Event_BtnUndo(sender : UIButton){
        
        // Animation When Tap
        /*UIView.animate(withDuration: 0.5, animations: {
            self.View_BtnUndo.alpha = 0.5
        }) { (_) in
            self.View_BtnUndo.alpha = 1
        }*/
        if Plane_Sim == "Horizontal" {
            
            if AllPositionMark.count == 0 {
                
                // Delete Node not important in Process Set Direction
                self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if (node.name == "ColumnNode" || node.name == "RecNode"){
                        // Delete Column Node From AR Simmulate
                        node.removeFromParentNode()
                    }

                })
                
                // Hide Button Undo
                View_BtnUndo.alpha = 0
                
                
                // Change State Direction
                self.StateDirection = true
                
            }
            else {
                
                // Hide Button Done if Allposition 2
                if AllPositionMark.count == 2 {
                    
                    // Hide Button Done
                    View_BtnDone.alpha = 0
                    // Show Button Add Corner
                    View_BtnAddCorn.alpha = 1
                    // Add Node Column
                    SceneView.scene.rootNode.addChildNode(columnNode!)
                    
                }
                else if AllPositionMark.count == 1 {
                    
                    self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                        if (node.name == "RecNode"){
                            // Delete Column Node From AR Simmulate
                            node.removeFromParentNode()
                        }

                    })
                    
                    
                }
                
                // Delete Column
                let nameNode = NameColumnNode[NameColumnNode.count - 1]
                self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if (node.name == nameNode){
                        // Delete Column Node From AR Simmulate
                        node.removeFromParentNode()
                        // Remove Name and Position of Column Node From Array Name
                        self.NameColumnNode.removeLast()
                        self.AllPositionMark.removeLast()
                    }

                })
                
            }
            
        }
        else if Plane_Sim == "Vertical" {
            
            if StateSetHeight == false && StateDone == false && AllPositionMark.count != 0 {
                
                // Check Count Name Node
                guard NameColumnNode.count > 0 else {
                    self.Manage_AlertProcessAR(gif: nil, Text: "Unable Undo", Command: true, TimeInterval: 2)
                    return
                }
                
                // Delete Column
                let nameNode = NameColumnNode[NameColumnNode.count - 1]
                self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if (node.name == nameNode){
                        // Delete Column Node From AR Simmulate
                        node.removeFromParentNode()
                        // Remove Name and Position of Column Node From Array Name
                        self.NameColumnNode.removeLast()
                        self.AllPositionMark.removeLast()
                    }
                    if (node.name == "PlaneVer1" && AllPositionMark.count == 0){
                        node.removeFromParentNode()
                    }
                })
                
                
            }
            else if StateSetHeight == true && StateDone == false && StateMark == true {
                
                // Change State Set Height
                StateSetHeight = false
                
                // Chaneg Icon of Button Add Corner
                Icon_BtnAddCorn.image = #imageLiteral(resourceName: "corner").withRenderingMode(.alwaysTemplate)
                Lb_BtnAddCorn.text = "Add Corner"
                
                // Delete Column
                let nameNode = NameColumnNode[NameColumnNode.count - 1]
                self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if (node.name == nameNode){
                        // Delete Column Node From AR Simmulate
                        node.removeFromParentNode()
                        // Remove Name and Position of Column Node From Array Name
                        self.NameColumnNode.removeLast()
                        self.AllPositionMark.removeLast()
                    }
                })
                
            }
            
            else if StateSetHeight == true && StateDone == false && StateMark == false {
                
                // Change State Process Mark
                StateMark = true
                
                // Show Button in Process
                View_BtnAddCorn.alpha = 1
                // Hide Button Done
                View_BtnDone.alpha = 0
                
            }
            
            // Hide Button Undo
            if AllPositionMark.count < 1 {
                
                View_BtnUndo.alpha = 0
                
            }
            
        }
        
        
    }
    
    // Event Btn Capture
    @objc func Event_BtnClear() {
        
        // Animation When Tap
        UIView.animate(withDuration: 0.5, animations: {
            self.View_BtnClear.alpha = 0.5
        }) { (_) in
            self.View_BtnClear.alpha = 1
        }
        
        // Return All Process AR and Element in AR Page to Default
        // Return State
        StateScanFeature = false
        StateMark = false
        StateDone = false
        StateSetHeight = false
        StateCreatePlane = false
        
        // Clear Data Name and Position of Column AR
        AllPositionMark.removeAll()
        NameColumnNode.removeAll()
        
        // Create Stack Feature AR
        Stack_FeaturePoint = 0
        
        // Remove Node All in AR Camera
        PlaneNode_Vertical = nil
        columnNode = nil
        
        self.SceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        
        // Default Element in Page
        // Btn_Undo
        View_BtnUndo.alpha = 0
        // Btn Done
        Icon_BtnDone.image = #imageLiteral(resourceName: "CheckBox").withRenderingMode(.alwaysTemplate)
        View_BtnDone.backgroundColor = .systemGreen
        View_BtnDone.alpha = 0
        // Btn add Coner
        Icon_BtnAddCorn.image = #imageLiteral(resourceName: "corner").withRenderingMode(.alwaysTemplate)
        View_BtnAddCorn.alpha = 0
        // Btn Grout
        View_BtnGrout.alpha = 0
        Collection_Grout.alpha = 0
        
        self.Manage_AlertProcessAR(gif: nil, Text: nil, Command: false, TimeInterval: nil)
        
        // Show Alert Choose Plane Direction
        Alert_PlaneSimmulate()

        
    }
    
    // Event Btn Done
    @objc func Event_BtnDone() {
        
        
        // Check State Done if (true == Btn Capture , false == Done Process AR)
        if StateDone == true {
            
            // Play Sound Shutter
            let Alertshutter = Bundle.main.url(forResource: "Sound/shutter", withExtension: "mp3")
            
            do{
                Audio_Shutter = try AVAudioPlayer(contentsOf: Alertshutter!)
            }
            catch{
                print(error)
            }
            Audio_Shutter.play()

            // Animation Cature
            UIView.animate(withDuration: 0.5, animations: {
                // Alpha view
                self.SceneView.alpha = 0.25
            }) { (_) in
                self.SceneView.alpha = 1
            }
            
            // Get Alabum for Store Image Capture
            getAlbum(title: "AR Tile For Sale") { (_) in}
            
            // Capture Screen AR
            let imageScreen = SceneView.snapshot()
            save(photo: imageScreen, toAlbum: "AR Tile For Sale") { (State, error) in

                // Check State Save Image to Gellery
                DispatchQueue.main.async {
                    if State {
                        self.Manage_AlertProcessAR(gif: nil, Text: "Save Image to Gellery Complete", Command: true, TimeInterval: 2)
                    }else{
                        self.Manage_AlertProcessAR(gif: nil, Text: "Save Image to Gellery InComplete", Command: true, TimeInterval: 2)
                    }
                }
                
                
            }
            
            
            
        }else {
            
            // if Process AR is Vertical
            if Plane_Sim == "Horizontal" {
                
                // Reset State Process All
                StateScanFeature = false
                StateMark = false
                StateDirection = false
                
                // Change State Process AR Create Plane and End Process
                StateDone = true
                StateCreatePlane = true
                
                // Clear Data of Mark Position And Name Column Node
                self.NameColumnNode.removeAll()
                self.AllPositionMark.removeAll()
                
                // Show Button Capture and Color Grout
                View_BtnGrout.alpha = 1
                Collection_Grout.alpha = 1
                
                // Hide Button Undo
                View_BtnUndo.alpha = 0
                
                // Change Icon Button to Capture and Background
                Icon_BtnDone.image = #imageLiteral(resourceName: "Image").withRenderingMode(.alwaysTemplate)
                View_BtnDone.backgroundColor = .BlueDeep
                
                // Delete Node Not Important For Simulate Tile Pattern
                self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if (node.name != "RecNode"){
                        node.removeFromParentNode()
                    }
                })
                
            }
            else if Plane_Sim == "Vertical" {
                
                // Reset State Process All
                StateScanFeature = false
                StateMark = false
                StateSetHeight = false
                // Change State Process AR Create Plane and End Process
                StateDone = true
                StateCreatePlane = true

                
                // Clear Data of Mark Position And Name Column Node
                self.NameColumnNode.removeAll()
                self.AllPositionMark.removeAll()
                
                // Show Button Capture and Color Grout
                View_BtnGrout.alpha = 1
                Collection_Grout.alpha = 1
                
                // Hide Button Undo
                View_BtnUndo.alpha = 0
                
                // Change Icon Button to Capture and Background
                Icon_BtnDone.image = #imageLiteral(resourceName: "Image").withRenderingMode(.alwaysTemplate)
                View_BtnDone.backgroundColor = .BlueDeep
                
                // Delete Node Not Important For Simulate Tile Pattern
                self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if (node.name != "PlaneVer2"){
                        node.removeFromParentNode()
                    }
                })
                self.PlaneNode_Vertical?.enumerateChildNodes({ (node, _) in
                    
                    if (node.name == "LineUnder" || node.name == "LineUpper" || node.name == "LineLeft" || node.name == "LineRight" || node.name == "TextHeight" || node.name == "TextWidth") {
                        
                        node.removeFromParentNode()
                        
                    }
                    
                })
                
                
                
                
            }
        }
        
        
     
        
    }
    
    // Event Btn Add Corner
    @objc func Event_BtnAddCorn(){
        
        if Plane_Sim == "Horizontal" {
            
            // Check State Set Direction
            if StateDirection == true {
                
                // Chaneg Icon of Button Add Corner
                Icon_BtnAddCorn.image = #imageLiteral(resourceName: "corner").withRenderingMode(.alwaysTemplate)
                Lb_BtnAddCorn.text = "Add Corner"
                
                // Change Degree of World Origin
                SceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                    
                    if node.name == "LineAxis" {
                        
                        self.SceneView.session.setWorldOrigin(relativeTransform: node.simdTransform)
                        node.removeFromParentNode()
                    }
                    
                }
                
                // Create a new focal node
                let node = ColumnNode()
                node.name = "ColumnNode"
                // Store the focal node
                self.columnNode = node
                
                // Add Column to AR Process
                self.SceneView.scene.rootNode.addChildNode(columnNode!)
                
                // Show Animation Process
                self.Manage_AlertProcessAR(gif: "Mark-Horizontal", Text: "Mark Area for Tile Simulation", Command: true, TimeInterval: 4)
                
                // Change State of Direction
                StateDirection = false
                // Show Btn Undo
                View_BtnUndo.alpha = 1
                
            }else {
                
                // Make sure we've found the floor
                guard columnNode != nil else { return }
                    
                // Create a copy of the model set its position/rotation
                guard self.PositionCamera != nil else {return}
                let newNode = columnNode!.flattenedClone()
                newNode.position = self.PositionCamera!
                
                // Set Name to Column Node
                newNode.name = "ColumnNode\(String(NameColumnNode.count))"
                
                // Append Record Name and Positon of column Node
                NameColumnNode.append(newNode.name!)
                AllPositionMark.append(newNode.position)
                
                
                // Add the model to the scene
                SceneView.scene.rootNode.addChildNode(newNode)
                
            }
            
            // Show Button Done when Mark Postion 2
            if AllPositionMark.count == 2 {
                
                // Show Button Done
                View_BtnDone.alpha = 1
                // Hide Button Add Corner
                View_BtnAddCorn.alpha = 0
                
                // Delete Column Node
                SceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                    if node.name == "ColumnNode" {

                        node.removeFromParentNode()
                    }
                }
                
                
            }
        
        }
        else if Plane_Sim == "Vertical" {
            
            // Add Column Node State
            if StateSetHeight == false {
                // Make sure we've found the floor
                guard columnNode != nil else { return }
                    
                // Create a copy of the model set its position/rotation
                guard self.PositionCamera != nil else {return}
                let newNode = columnNode!.flattenedClone()
                newNode.position = self.PositionCamera!
                
                // Set Name to Column Node
                newNode.name = "ColumnNode\(String(NameColumnNode.count))"
                
                // Append Record Name and Positon of column Node
                NameColumnNode.append(newNode.name!)
                AllPositionMark.append(newNode.position)
                
                
                // Add the model to the scene
                SceneView.scene.rootNode.addChildNode(newNode)
                
                // Change Icon Button Add Corner to Icon Set Height Plane
                if AllPositionMark.count == 2 {
                    
                    Icon_BtnAddCorn.image = #imageLiteral(resourceName: "height").withRenderingMode(.alwaysTemplate)
                    Lb_BtnAddCorn.text = "Set Height"
                    
                    // Show Animation
                    Manage_AlertProcessAR(gif: "Set-Height", Text: "Set Height of Plane Simmulation", Command: true, TimeInterval: 3)
                    
                    // Change State Set Height
                    StateSetHeight = true
                    
                }
                
            }
            // Show Button Done for End Process and Hide Button Add Corner, Button Undo
            else if StateSetHeight == true {
                
                // Show Button Done
                View_BtnDone.alpha = 1
                // Hide Button Add Corner
                View_BtnAddCorn.alpha = 0
                
                // Change State Mark
                StateMark = false
                
            
                
            }
            
        }
        
        // Show Button Undo
        if AllPositionMark.count > 0 {
            
            View_BtnUndo.alpha = 1
            
        }
        
        
    }
    
    // Event Btn Grout
    @objc func Event_BtnGrout(){
        
        // Animation Expend and Collape Collection Grout
        // Expand
        if Collection_Grout.alpha == 0 {
            
            HeightCollection.constant = (6 * (50 * ratio)) + (12.5 * ratio)
            UIView.animate(withDuration: 0.5) {
                
                self.Collection_Grout.alpha = 1
                self.view.layoutIfNeeded()
                
            }
            
        }
        else if Collection_Grout.alpha == 1 {
            
            HeightCollection.constant = (50 * ratio)
            UIView.animate(withDuration: 0.5) {
                
                self.Collection_Grout.alpha = 0
                self.view.layoutIfNeeded()
                
            }
            
            
        }
        
        
    }
    
    // MARK: Func of Page
    
    // Func Show Alert Choose Plane Simmulate Tile
    func Alert_PlaneSimmulate() {
        
        let dialog_selectionPlane = UIAlertController(title: "", message: "Select Plane For Simmulation", preferredStyle: .alert)
        
        // Choose Horizontal
        dialog_selectionPlane.addAction(UIAlertAction(title: "Floor", style: .default, handler: { action in
            
            self.Plane_Sim = "Horizontal"
            
            // Show Alert
            self.Manage_AlertProcessAR(gif: "Scan-Feature", Text: "Scan the surrounding environment", Command: true, TimeInterval: nil)
            
            // Change Icon of Button Add Corner to Set Direction
            self.Icon_BtnAddCorn.image = #imageLiteral(resourceName: "compass").withRenderingMode(.alwaysTemplate)
            self.Lb_BtnAddCorn.text = "Set Direction"
            
            // Start AR Process
            self.StateScanFeature = true
            
        }))
        // Choose Vertical
        dialog_selectionPlane.addAction(UIAlertAction(title: "Wall", style: .default, handler: { action in
            
            self.Plane_Sim = "Vertical"
            
            // Show Alert
            self.Manage_AlertProcessAR(gif: "Scan-Feature", Text: "Scan the surrounding environment", Command: true, TimeInterval: nil)
            
            // Start AR Process
            self.StateScanFeature = true
            
            
        }))
        
        
        dialog_selectionPlane.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            // Hide Navigation Bar
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        // Set Attribute of Alert Controller
        dialog_selectionPlane.setMessage(font: UIFont.PoppinsMedium(size: 15), color: .BlackAlpha(alpha: 0.9))
        
        self.present(dialog_selectionPlane, animated: true, completion: nil)
        
        
    }
    
    // Func Show and Hide Animation and Text of Alert Process Ar
    func Manage_AlertProcessAR(gif : String?, Text : String?, Command : Bool, TimeInterval : Double?) {
        
        // Gif Alert
        if gif != nil {
            Image_GifAlert.loadGif(name: gif!)
        }
        // Text Alert
        if Text != nil {
            Lb_Alert.text = Text
        }
        
        // Check Command
        if (Command == true && TimeInterval == nil) {
            
            // Open Alert Animation and Text Process AR
            UIView.animate(withDuration: 1) {
                if gif != nil {
                    self.View_AnimationAlert.alpha = 1
                }
                if Text != nil {
                    self.View_TxtAlert.alpha = 1
                }
            }
            
        }
        else if (Command == true && TimeInterval != nil) {
            
            // Open Alert Animation and Text Process AR
            UIView.animate(withDuration: 1) {
                if gif != nil {
                    self.View_AnimationAlert.alpha = 1
                }
                if Text != nil {
                    self.View_TxtAlert.alpha = 1
                }
            }
            // Close Alert Animation and Text Process AR
            UIView.animate(withDuration: 1, delay: TimeInterval! + 1, options: .curveEaseOut, animations: {
                self.View_AnimationAlert.alpha = 0
                self.View_TxtAlert.alpha = 0
            }, completion: nil)
            
            
        }
        else if Command == false {
            
            // Close Alert Animation and Text Process AR
            UIView.animate(withDuration: 1) {
                self.View_AnimationAlert.alpha = 0
                self.View_TxtAlert.alpha = 0
            }
            
        }
        
        
        
    }
    
    // Func Map Value
    func map(minRange:Float, maxRange:Float, minDomain:Float, maxDomain:Float, value:Float) -> Float {
        return minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange)
    }
    
    
    // MARK: Save Image to Album
    func createAlbum(withTitle title: String, completionHandler: @escaping (PHAssetCollection?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            var placeholder: PHObjectPlaceholder?
            
            PHPhotoLibrary.shared().performChanges({
                let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
                placeholder = createAlbumRequest.placeholderForCreatedAssetCollection
            }, completionHandler: { (created, error) in
                var album: PHAssetCollection?
                if created {
                    let collectionFetchResult = placeholder.map { PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [$0.localIdentifier], options: nil) }
                    album = collectionFetchResult?.firstObject
                }
                
                completionHandler(album)
            })
        }
    }
    
    func getAlbum(title: String, completionHandler: @escaping (PHAssetCollection?) -> ()) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", title)
            let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            
            if let album = collections.firstObject {
                completionHandler(album)
            } else {
                self?.createAlbum(withTitle: title, completionHandler: { (album) in
                    completionHandler(album)
                })
            }
        }
    }
    
    func save(photo: UIImage, toAlbum titled: String, completionHandler: @escaping (Bool, Error?) -> ()) {
        getAlbum(title: titled) { (album) in
            DispatchQueue.global(qos: .background).async {
                PHPhotoLibrary.shared().performChanges({
                    let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: photo)
                    let assets = assetRequest.placeholderForCreatedAsset
                        .map { [$0] as NSArray } ?? NSArray()
                    let albumChangeRequest = album.flatMap { PHAssetCollectionChangeRequest(for: $0) }
                    albumChangeRequest?.addAssets(assets)
                }, completionHandler: { (success, error) in
                    completionHandler(success, error)
                })
            }
        }
    }
    
    
}

// MARK: Extension Page

// Extension AR
extension ARPageController : ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // Add it to the root of our current scene
        if Plane_Sim == "Vertical" {
            
            // Create Node Column
            guard columnNode == nil else { return }
            
            // Create a new focal node
            let node = ColumnNode()
            node.name = "ColumnNode"
            // Store the focal node
            self.columnNode = node
            
            if AllPositionMark.count != 2 {
                SceneView.scene.rootNode.addChildNode(node)
            }
            
        }
        
        
        
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        DispatchQueue.main.async {
            
            // State Scan Feature Point
            if self.StateScanFeature == true {
                
                let Point = self.SceneView.session.currentFrame?.rawFeaturePoints?.points.count
                
                
                // Stack Feature Point From Scan
                guard Point != nil else {
                    return
                }
                
                // Record Old Feature Point Detect count  Feature equel Old Feature Point
                guard self.Old_FeaturePoint != Point else {
                    return
                }
                
                // Stack Feature Point
                self.Stack_FeaturePoint += Point!
                
                // Update Old FeaturePoint
                self.Old_FeaturePoint = Point!
                
                //print(self.Stack_FeaturePoint)
                // Check Stack Feature Point > 20000 ?
                if self.Stack_FeaturePoint > 10000 {
                    
                    // Change State and Change Alert Process
                    self.StateScanFeature = false
                    self.StateMark = true
                    // Reset old Feature Point
                    self.Old_FeaturePoint = 0
                    
                    
                    // Show Btn Add Corner
                    self.View_BtnAddCorn.alpha = 1
                    
                    if self.Plane_Sim == "Horizontal" {
                        self.StateDirection = true
                        
                        // Open Alert Animation Process
                        self.Manage_AlertProcessAR(gif: "Set-Direction", Text: "Set Direction for Tile Simulation", Command: true, TimeInterval: 4)
                        
                    }
                    else if self.Plane_Sim == "Vertical" {
                        
                        // Open Alert Animation Process
                        self.Manage_AlertProcessAR(gif: "Mark-Vertical", Text: "Scan floor for simmulation tile pattern", Command: true, TimeInterval: 4)
                        
                    }
                    
                    
                }
                
                
                
            }
            
            // State Mark Area Simmulate
            if self.StateMark == true {
                
                // Determine if we hit a plane in the scene
                let hit = self.SceneView.hitTest(self.ScreenCenter, types: .existingPlane)
                
                
                // Find Position Floor Lower
                if hit.first != nil {
                    let hit_result = hit.sorted(by: {($0.worldTransform.columns.3.y) < ($1.worldTransform.columns.3.y)})[0]
                    // Find the position of the first plane we hit
                    let positionColumn = hit_result.worldTransform.columns.3 //else { return }
                    self.PositionCamera = SCNVector3(x: positionColumn.x, y: positionColumn.y, z: positionColumn.z)
                }

                // Check nil of PositionCamera
                guard self.PositionCamera != nil else {return}
                
                
                
                // Simulate Horizontal Case
                if self.Plane_Sim == "Horizontal" {
                    
                    if self.StateDirection == true {
                        
                        guard let cameraNode = self.SceneView.pointOfView else { return }

                        //Get camera orientation expressed as a quaternion
                        let q = cameraNode.orientation

                        //Calculate rotation around y-axis (heading) from quaternion and convert angle so that
                        //0 is along -z-axis (forward in SceneKit) and positive angle is clockwise rotation.
                        let alpha = Float.pi - atan2f( (2*q.y*q.w)-(2*q.x*q.z), 1-(2*pow(q.y,2))-(2*pow(q.z,2)) )
                        
                        // Delete Node Line Axis for Update
                        self.SceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                            if (node.name == "LineAxis"){
                                node.removeFromParentNode()
                            }
                        }
                        
                        let LineAxis = self.Create_AxisDirectionPlane(PositionCamera: self.PositionCamera!, Degree: Double(alpha))
                        
                        self.SceneView.scene.rootNode.addChildNode(LineAxis)
                        
                        
                    }
                    else {
                        
                        // Horizontal Process
                        self.HorizontalProcess(PositionCamera: self.PositionCamera!)
                    }
                    
                    
                }
                // Simmulate Vertical Case
                else if self.Plane_Sim == "Vertical" {
                    
                    // Vertical Process
                    self.VerticalProcess(PositionCamera: self.PositionCamera!)
                    
                }
                
                
                
            }
            
            // State Done True (Create Plane Simulation Tile)
            if self.StateCreatePlane == true {
                
                guard self.PlaneNode_Vertical != nil else {return}
                
                // Manage Image Tile
                var image = self.addGroutToimage(ImageTile_Ori: self.Image_Tile, Color_grout: self.ColorGrout_Selection)
                // Check Pattern
                let pattern = self.DataProduct["TilePattern"] as! Int
                // 4 Sheet
                if pattern == 1 {
                    image = self.image_complementTile(image: image)
                }
                
                let min = self.PlaneNode_Vertical!.boundingBox.min
                let max = self.PlaneNode_Vertical!.boundingBox.max
                let w = CGFloat(max.x - min.x)
                let h = CGFloat(max.y - min.y)
                
                // Cal Area of Plane for ARMeasure
                let AreaPlane = w * h
                ProductDetailPageController.ARMeasure = Double(AreaPlane)
                
                let scalex = (Float(w)/Float(self.Dimension.width)).rounded()
                let scaley = (Float(h)/Float(self.Dimension.height)).rounded()
                
                // Set Tile Pattern in object Simulation
                self.PlaneNode_Vertical!.geometry?.firstMaterial?.diffuse.contents = image
                self.PlaneNode_Vertical!.geometry?.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(scalex, scaley, 0)
                self.PlaneNode_Vertical!.geometry?.firstMaterial?.diffuse.mipFilter = .none
                self.PlaneNode_Vertical!.geometry?.firstMaterial?.diffuse.wrapS = .repeat
                self.PlaneNode_Vertical!.geometry?.firstMaterial?.diffuse.wrapT = .repeat
                
                // Change State Done
                self.StateCreatePlane = false
                
                
            }
            
            
        }
    }
    
    // MARK: Func Render Horizontal Case
    func HorizontalProcess(PositionCamera : SCNVector3){
        
        // Update the position of the node
        guard let columnNode = self.columnNode else { return }
        columnNode.position = PositionCamera
        
        
        // Create Grid Area Recgular for Guide Line
        if AllPositionMark.count == 1 {
            
            
            // Delete GriHelp node For update
            self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                // Delete Plane Vertical
                if (node.name == "RecNode"){
                    // Delete Column Node From AR Simmulate
                    node.removeFromParentNode()
                }

            })
            
            let Rec_Node = self.Create_Rec(All_Marking: self.AllPositionMark, PositionCamera: self.PositionCamera!)
            
            Rec_Node.name = "RecNode"
            
            self.SceneView.scene.rootNode.addChildNode(Rec_Node)
            
            
        }
        else if AllPositionMark.count == 2 {
            
            self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                // Delete Plane Vertical
                if (node.name == "RecNode"){
                    // Record to Result Node for Custom and Result
                    self.PlaneNode_Vertical = node
                    
                }

            })
            
            
        }
        

        
        
    }
    
    // MARK: Func Render Vertical Case
    func VerticalProcess(PositionCamera : SCNVector3){
        
        // Update the position of the node
        guard let columnNode = self.columnNode else { return }
        columnNode.position = PositionCamera
        columnNode.name = "ColumnNode"

        
        // Add Guide Line Between Column
        if self.StateSetHeight == false && self.StateDone == false && self.AllPositionMark.count != 0 {
            
            // Delete GriHelp node For update
            self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                if (node.name == "PlaneVer1" || node.name == "PlaneVer2"){
                    // Delete Column Node From AR Simmulate
                    node.removeFromParentNode()
                }
                // Show Column Node
                if (node.name == "ColumnNode") {
                    node.isHidden = false
                }
                
            })
            
            // Add Guild Line
            let Plane_Node = self.Create_PlaneVertical(All_Marking: self.AllPositionMark, PositionCamera: PositionCamera, PlaneHeight: 0.5)
            Plane_Node.name = "PlaneVer1"
            
            self.SceneView.scene.rootNode.addChildNode(Plane_Node)
            
        }
        // Adjust Heigth Plane Vertical
        else if self.StateSetHeight == true && self.StateDone == false {
    
            // Delete GriHelp node For update
            self.SceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                if (node.name == "PlaneVer2" || node.name == "PlaneVer1"){
                    // Delete Column Node From AR Simmulate
                    node.removeFromParentNode()
                }
                // Hide Column Node
                if (node.name == "ColumnNode") {
                    node.isHidden = true
                }
            })
            
            // Map Find Height of Plane
            if self.angle_Floor >= 70 && self.angle_Floor <= 135 {
                self.Height_Plane = self.map(minRange: 70, maxRange: 135, minDomain: 0.5, maxDomain: 3, value: self.angle_Floor)
            }

            
            let Plane_Node = Create_PlaneVertical(All_Marking: AllPositionMark, PositionCamera: AllPositionMark[1], PlaneHeight: CGFloat(Height_Plane))
            Plane_Node.name = "PlaneVer2"
            self.PlaneNode_Vertical = Plane_Node
            self.SceneView.scene.rootNode.addChildNode(Plane_Node)
            
            
        }
        
        
        
    }
    
    // MARK: Func Create Plane Vertical
    func Create_PlaneVertical(All_Marking : [SCNVector3], PositionCamera : SCNVector3, PlaneHeight : CGFloat) -> SCNNode {
        
        var Plane_Node = SCNNode()
        
        
        // Find angle, Distance between pier to pier by func tool_findangle
        let value = tool_findangle_GridHelp(position1: All_Marking[0], currentcamera: PositionCamera)
        
  
      
     
        
        let Plane = SCNPlane(width: CGFloat(value[1]), height: PlaneHeight)
        Plane.firstMaterial?.diffuse.contents = UIColor.whiteAlpha(alpha: 0.5)
        Plane.firstMaterial?.isDoubleSided = true
        
        
        Plane_Node = SCNNode(geometry: Plane)
        
        // Add Under Guide Line
        let Line_Under = SCNCapsule(capRadius: 0.01, height: CGFloat(value[1]))
        Line_Under.firstMaterial?.diffuse.contents = UIColor.whiteAlpha(alpha: 1)
        let LineNode_Under = SCNNode(geometry: Line_Under)
        LineNode_Under.position.y -= Float(PlaneHeight / 2)
        LineNode_Under.pivot = SCNMatrix4MakeRotation(Float(90.degreesToRadians), 0, 0, 1)
        LineNode_Under.name = "LineUnder"
        
        Plane_Node.addChildNode(LineNode_Under)
        
        // Add Under Guide Line
        let Line_Upper = SCNCapsule(capRadius: 0.01, height: CGFloat(value[1]))
        Line_Upper.firstMaterial?.diffuse.contents = UIColor.whiteAlpha(alpha: 1)
        let LineNode_Upper = SCNNode(geometry: Line_Under)
        LineNode_Upper.position.y += Float(PlaneHeight / 2)
        LineNode_Upper.pivot = SCNMatrix4MakeRotation(Float(90.degreesToRadians), 0, 0, 1)
        LineNode_Upper.name = "LineUpper"
        
        Plane_Node.addChildNode(LineNode_Upper)
        
        // Add Left Guild Line
        let Line_Left = SCNCapsule(capRadius: 0.01, height: PlaneHeight)
        Line_Left.firstMaterial?.diffuse.contents = UIColor.BlueDeep
        let LineNode_Left = SCNNode(geometry: Line_Left)
        LineNode_Left.position.x -= Float(value[1] / 2)
        LineNode_Left.name = "LineLeft"
        
        Plane_Node.addChildNode(LineNode_Left)
        
        
        // Add Right Guild Line
        let Line_Right = SCNCapsule(capRadius: 0.01, height: PlaneHeight)
        Line_Right.firstMaterial?.diffuse.contents = UIColor.BlueDeep
        let LineNode_Right = SCNNode(geometry: Line_Right)
        LineNode_Right.position.x += Float(value[1] / 2)
        LineNode_Right.name = "LineRight"
        
        Plane_Node.addChildNode(LineNode_Right)
        
        // Add Text Height Plane
        let Label_Text = String(format: "%.2f", Float(PlaneHeight)) + " m"
        let Text = SCNText(string: Label_Text, extrusionDepth: 0.001)
        Text.font = UIFont.MitrMedium(size: 5)
        Text.firstMaterial?.diffuse.contents = UIColor.white
        let Text_Node = SCNNode(geometry: Text)
        Text_Node.position.y += Float((PlaneHeight / 2) - 0.1)
        
        let min = Text_Node.boundingBox.min
        let max = Text_Node.boundingBox.max
        let w = CGFloat(max.x - min.x)
        Text_Node.position.x -= Float(((w/100) / 2))
        Text_Node.scale = SCNVector3(0.01, 0.01, 0.01)
        Text_Node.name = "TextHeight"
        
        Plane_Node.addChildNode(Text_Node)
        
        // Add Text width Plane
        let LabelW_Text = String(format: "%.2f", Float(value[1])) + " m"
        let Text_W = SCNText(string: LabelW_Text, extrusionDepth: 0.001)
        Text_W.font = UIFont.MitrMedium(size: 5)
        Text_W.firstMaterial?.diffuse.contents = UIColor.white
        let Text_W_Node = SCNNode(geometry: Text_W)
        Text_W_Node.position.y -= Float((PlaneHeight / 2) + 0.1)
        let min_W = Text_W_Node.boundingBox.min
        let max_W = Text_W_Node.boundingBox.max
        let w_W = CGFloat(max_W.x - min_W.x)
        Text_W_Node.position.x -= Float(((w_W/100) / 2))
        Text_W_Node.eulerAngles = SCNVector3(-90.degreesToRadians, 0, 0)
        Text_W_Node.scale = SCNVector3(0.01, 0.01, 0.01)
        Text_W_Node.name = "TextWidth"
        
        Plane_Node.addChildNode(Text_W_Node)
        
        // Find position X, Z of Plane Grid
        let position_X = All_Marking[0].x + (PositionCamera.x - All_Marking[0].x)/2
        let position_Z = (All_Marking[0].z + (PositionCamera.z - All_Marking[0].z)/2)
        
        // Set Plane Node
        Plane_Node.position = SCNVector3(position_X, PositionCamera.y, position_Z)
        Plane_Node.pivot = SCNMatrix4MakeTranslation(0,-Float(PlaneHeight/2), 0)
        Plane_Node.eulerAngles = SCNVector3(0, Double(value[0]), 0) //-90.degreesToRadians
        
        
        
        return Plane_Node
        
    }
    
    // MARK: Func Create Node Plane Rectangle
    func Create_Rec(All_Marking : [SCNVector3], PositionCamera : SCNVector3) -> SCNNode{
        
        var Rec_Node = SCNNode()
        
        // Find angle, Distance between pier to pier by func tool_findangle
        let value = tool_findangle_GridHelp(position1: All_Marking[All_Marking.count - 1], currentcamera: PositionCamera)
        
        // Find Size of Plane
        let W_Plane = abs(All_Marking[0].x - PositionCamera.x)
        let H_Plane = abs(PositionCamera.z - All_Marking[0].z)
        
        let Rec_plane = SCNPlane(width: CGFloat(W_Plane), height: CGFloat(H_Plane))
        
        let scalex = (Float(Rec_plane.width)/0.05).rounded()
        let scaley = (Float(Rec_plane.height)/0.05).rounded()
        
        let surface = SCNMaterial()
        surface.diffuse.contents = Image_Grid_Help
        surface.diffuse.contentsTransform = SCNMatrix4MakeScale(scalex, scaley, 0)
        surface.diffuse.mipFilter = SCNFilterMode.none
        surface.isDoubleSided = false
        surface.diffuse.wrapS = SCNWrapMode.repeat
        surface.diffuse.wrapT = SCNWrapMode.repeat
        
        Rec_plane.materials = [surface]
        
        // Find position X, Z of Plane Grid
        let position_X = All_Marking[All_Marking.count - 1].x + (PositionCamera.x - All_Marking[All_Marking.count - 1].x)/2
        let position_Z = (All_Marking[All_Marking.count - 1].z + (PositionCamera.z - All_Marking[All_Marking.count - 1].z)/2)
        
        // Create Node
        Rec_Node = SCNNode(geometry: Rec_plane)
        Rec_Node.opacity = 1
        //Rec_Node.pivot = SCNMatrix4MakeTranslation(0,value[1]/2, 0)
        Rec_Node.position = SCNVector3(position_X, PositionCamera.y, position_Z)
        Rec_Node.eulerAngles = SCNVector3(-90.degreesToRadians, 0, 0)
        
        
        return Rec_Node
    }
    
    // MARK: Func Create Axis_DirectionPlane
    func Create_AxisDirectionPlane(PositionCamera : SCNVector3 , Degree : Double) -> SCNNode {
        
        var LineNode_Axis = SCNNode()
        
        // Line Axis Y
        let Line_AxisY = SCNCapsule(capRadius: 0.005, height: 0.25)
        Line_AxisY.firstMaterial?.diffuse.contents = UIColor.BlueDeep
        let LineNode_AxisY = SCNNode(geometry: Line_AxisY)
        LineNode_AxisY.eulerAngles = SCNVector3(-90.degreesToRadians, 0, 0)
        
        // Header Arrow Direction Right
        let Arrow_Right = SCNCapsule(capRadius: 0.005, height: 0.05)
        Arrow_Right.firstMaterial?.diffuse.contents = UIColor.BlueDeep
        let ArrowNode_Right = SCNNode(geometry: Arrow_Right)
        ArrowNode_Right.pivot = SCNMatrix4MakeTranslation(0,0.025, 0)
        ArrowNode_Right.eulerAngles = SCNVector3(0, 0, -135.degreesToRadians)
        ArrowNode_Right.position.y -= (0.25 / 2)
        LineNode_AxisY.addChildNode(ArrowNode_Right)
        
        // Header Arrow Direction Right
        let Arrow_Left = SCNCapsule(capRadius: 0.005, height: 0.05)
        Arrow_Left.firstMaterial?.diffuse.contents = UIColor.BlueDeep
        let ArrowNode_Left = SCNNode(geometry: Arrow_Left)
        ArrowNode_Left.pivot = SCNMatrix4MakeTranslation(0,0.025, 0)
        ArrowNode_Left.eulerAngles = SCNVector3(0, 0, 135.degreesToRadians)
        ArrowNode_Left.position.y -= (0.25 / 2)
        LineNode_AxisY.addChildNode(ArrowNode_Left)
        
        // Line Axis X
        let Line_AxisX = SCNCapsule(capRadius: 0.005, height: 0.25)
        Line_AxisX.firstMaterial?.diffuse.contents = UIColor.BlueDeep
        let LineNode_AxisX = SCNNode(geometry: Line_AxisX)
        LineNode_AxisX.eulerAngles = SCNVector3(0, 0, -90.degreesToRadians)
        LineNode_AxisY.addChildNode(LineNode_AxisX)
        
        // Set Node
        LineNode_Axis.addChildNode(LineNode_AxisY)
        LineNode_Axis.position = PositionCamera
        LineNode_Axis.eulerAngles = SCNVector3(0, -Degree, 0)
        LineNode_Axis.name = "LineAxis"
        
        return LineNode_Axis

    }
    
    // MARK: Func Create Node Object
    func create_GridHelp(positioncamera: SCNVector3,All_Marking: [SCNVector3]) -> SCNNode{
        
        var Grid_plane_Node = SCNNode()
        
        if All_Marking.count > 0{
            
            // Find angle, Distance between pier to pier by func tool_findangle
            let value = tool_findangle_GridHelp(position1: All_Marking[All_Marking.count - 1], currentcamera: positioncamera)
            
            let Grid_plane = SCNPlane(width: CGFloat(value[1]), height: CGFloat(value[1]))
            
            let scalex = (Float(Grid_plane.width)/0.05).rounded()
            let scaley = (Float(Grid_plane.height)/0.05).rounded()
            
            let surface = SCNMaterial()
            surface.diffuse.contents = Image_Grid_Help
            surface.diffuse.contentsTransform = SCNMatrix4MakeScale(scalex, scaley, 0)
            surface.diffuse.mipFilter = SCNFilterMode.none
            surface.isDoubleSided = false
            surface.diffuse.wrapS = SCNWrapMode.repeat
            surface.diffuse.wrapT = SCNWrapMode.repeat
            
            Grid_plane.materials = [surface]
            
            // Find position X, Z of Plane Grid
            let position_X = All_Marking[All_Marking.count - 1].x + (positioncamera.x - All_Marking[All_Marking.count - 1].x)/2
            let position_Z = (All_Marking[All_Marking.count - 1].z + (positioncamera.z - All_Marking[All_Marking.count - 1].z)/2)
            let position_Y = (All_Marking[All_Marking.count - 1].y + (positioncamera.y - All_Marking[All_Marking.count - 1].y)/2)

            
            Grid_plane_Node = SCNNode(geometry: Grid_plane)
            Grid_plane_Node.opacity = 1
            Grid_plane_Node.pivot = SCNMatrix4MakeTranslation(0,value[1]/2, 0)
            Grid_plane_Node.position = SCNVector3(position_X, position_Y, position_Z)
            Grid_plane_Node.eulerAngles = SCNVector3(-90.degreesToRadians,Double(value[0]),0)
        }
        
        return Grid_plane_Node
        
    }
    
    
    //MARK: func Dashed lines
    func Create_DashedLine(AllPositionMark : [SCNVector3], CurrentMark: SCNVector3) -> SCNNode {
        
        // Call Function Find Angle and height of line
        let Detail_line = tool_findangle_GridHelp(position1: AllPositionMark[0], currentcamera: CurrentMark) // angle[0], lenth of line[1]
        
        let DashLine = SCNCylinder(radius: 0.005, height: CGFloat(Float(Detail_line[1])))
        
        let Surface = SCNMaterial()
        let count_X = Float(DashLine.radius/0.005).rounded()
        let count_Y = Float(DashLine.height/0.1).rounded()
        
        Surface.diffuse.contents = UIImage(named: "DashLine")
        Surface.diffuse.wrapS = .repeat
        Surface.diffuse.wrapT = .repeat
        Surface.isDoubleSided = true
        
        Surface.diffuse.contentsTransform = SCNMatrix4MakeScale(count_X, count_Y, 0)
        //Surface.multiply.contents = UIColor.green
        
        DashLine.materials = [Surface]
        
        let DashLine_Node = SCNNode(geometry: DashLine)
        DashLine_Node.pivot = SCNMatrix4MakeTranslation(0, -0.5, 0)
        DashLine_Node.pivot = SCNMatrix4MakeRotation(Float(90.degreesToRadians), 0, 0, 1)
        
        // Calculate the position of the line To be between two Column
        let Position_x = AllPositionMark[0].x + (CurrentMark.x - AllPositionMark[0].x)/2
        let Position_z = AllPositionMark[0].z + (CurrentMark.z - AllPositionMark[0].z)/2
        let Position_y = AllPositionMark[0].y + (CurrentMark.y - AllPositionMark[0].y)/2
        
        DashLine_Node.position = SCNVector3(x: Position_x, y: Position_y, z: Position_z)
        DashLine_Node.eulerAngles = SCNVector3(x: 0, y: Float(Detail_line[0]), z: 0)
        
        return DashLine_Node
        
        
    }
    
    // MARK: Func Tool Help for Dev
    func tool_findangle_GridHelp(position1: SCNVector3,currentcamera: SCNVector3) -> [Float]{
        
        // process find Angle
        let phase_A = -(currentcamera.z - position1.z) // Z position of CurrentCamera - Z position of Marking
        let phase_C = -(position1.x - currentcamera.x) // X position of Marking - X position of Current Camera
        
        let angle = atanf(Float(phase_A/phase_C)) // find Angle
        //angle = Float(Double(angle).RadiansTodegrees)
        let length = sqrtf(powf(phase_A, 2) + powf(phase_C, 2))
        
        return [angle,length] // (Angle, length of pier between 1 to 2 pier)
    }
    
    //MARK: Func Custom Image Tile add grout
    func addGroutToimage(ImageTile_Ori : UIImage, Color_grout : UIColor) -> UIImage {
        
        // Create Bg of Image
        let path_grout = UIBezierPath(rect: CGRect(x: 0, y: 0, width: (ImageTile_Ori.size.width * 1.01438), height: (ImageTile_Ori.size.height * 1.01438)))
        
        // Find Position Image Tile for Bg
        let size_im_w = ImageTile_Ori.size.width
        let size_im_h = ImageTile_Ori.size.height
        let Position_Tile_x = (path_grout.bounds.size.width/2) - (size_im_w/2)
        let Position_Tile_y = (path_grout.bounds.size.height/2) - (size_im_h/2)
        
        UIGraphicsBeginImageContextWithOptions(path_grout.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.clear.cgColor)
        context?.setFillColor(Color_grout.cgColor)
        context?.draw(ImageTile_Ori.cgImage!, in: CGRect(x: 0, y: 0, width: ImageTile_Ori.size.width, height: ImageTile_Ori.size.height))
        
        // Add Path Bg to Context
        path_grout.fill()
        
        //Add Image Tileto Context
        ImageTile_Ori.draw(in: CGRectMake( Position_Tile_x, Position_Tile_y, ImageTile_Ori.size.width, ImageTile_Ori.size.height))
        
        // Create Image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    // MARK: Rotate IMage follow degree
    func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height))
        
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (-degrees * CGFloat.pi / 180))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(oldImage.cgImage!, in: CGRect(x: -oldImage.size.width / 2, y: -oldImage.size.height / 2, width: oldImage.size.width, height: oldImage.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // MARK: complementary image Tile Type 4 plane
    func image_complementTile(image: UIImage) -> UIImage {
        
        let size_imagetotal = CGSize(width: (image.size.width * 2), height: (image.size.height * 2))
        // set position complement image Tile
        let position_pull : [[Float]] = [[Float(size_imagetotal.width/2),0], [Float(size_imagetotal.width/2),Float(size_imagetotal.height/2)], [0,Float(size_imagetotal.height/2)], [0,0]]
        let degree_rotate = [90,180,270,360]
        UIGraphicsBeginImageContext(size_imagetotal)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        
        for count in 1...4 {
            let image_rotate = imageRotatedByDegrees(oldImage: image, deg: CGFloat(degree_rotate[count-1]))
            bitmap.draw(image_rotate.cgImage!, in: CGRect(x: CGFloat(position_pull[count - 1][0]), y: CGFloat(position_pull[count - 1][1]), width: CGFloat(image.size.width), height: CGFloat(image.size.height)))
            
        }
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
        
        
    }
    
    // Func CGRectMake
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
}

// Extension CollectionView
extension ARPageController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ColorGrout.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Id_CellGrout, for: indexPath) as! UIDesign_CellColorGrout
        
        print(indexPath.row)
        cell.ratio = ratio
        cell.ColorCell = UIColor(hex: ColorGrout[indexPath.row] + "FF" ) ?? UIColor.white
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! UIDesign_CellColorGrout
        
        // Change Color Grout
        ColorGrout_Selection = cell.ColorCell
        StateCreatePlane = true
        
        
    }
    
    
    
}
extension ARPageController : UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SizeCollecitonCell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 62.5 * ratio, left: 0, bottom: 12.5 * ratio, right: 0) //.zero
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
        return 0
    }
    
    
}


