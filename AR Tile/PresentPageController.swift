//
//  PresentPageController.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 29/1/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class PresentPageController: UIViewController {

    
    var ViewPresent : UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.alpha = 0
        
        return view
        
    }()
    
    var ImageApplication : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Logo_ARTileForSale")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        
        return image
    }()
    
    var LabelNameApplication : UILabel = {
        
        let Label = UILabel()
        
        Label.text = "ar tile".uppercased()
        Label.textColor = UIColor.BlackAlpha(alpha: 0.8)
        Label.font = UIFont.PoppinsExLight(size: 55)
        Label.textAlignment = .center
        
        return Label
    }()
    
    var ImageBG : UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = #imageLiteral(resourceName: "TileBG1")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    var BGBlur : UIVisualEffectView = {
        let Blur = UIVisualEffectView(frame: UIScreen.main.bounds)
        let BlurEffect = UIBlurEffect(style: .light)
        Blur.effect = BlurEffect
        Blur.alpha = 0.9
        
        return Blur
    }()
    
    // MARK: Func Layout Page
    fileprivate func Layout_Section(){
        // Add Element to main View
        view.backgroundColor = UIColor.WhiteLight
        //view.insertSubview(ImageBG, at: 0)
        view.insertSubview(BGBlur, at: 1)
        view.addSubview(ViewPresent)
        
        // Add Element to SubView (View Present)
        ViewPresent.addSubview(ImageApplication)
        //ViewPresent.addSubview(LabelNameApplication)
        
        // MARK: Set Constraint of Element Page
        // Set Constriant ViewPresent
        ViewPresent.translatesAutoresizingMaskIntoConstraints = false
        
        ViewPresent.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        ViewPresent.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        
        ViewPresent.widthAnchor.constraint(equalToConstant: (view.frame.width * 200) / 375.0).isActive = true
        ViewPresent.heightAnchor.constraint(equalToConstant: (view.frame.width * 300) / 375.0).isActive = true
        
        ImageApplication.anchor(ViewPresent.topAnchor, left: ViewPresent.leftAnchor, bottom: ViewPresent.bottomAnchor, right: ViewPresent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: (view.frame.width * 200) / 375.0)
        
        /*LabelNameApplication.anchor(ImageApplication.bottomAnchor, left: ImageApplication.leftAnchor, bottom: ViewPresent.bottomAnchor, right: ImageApplication.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        LabelNameApplication.font = UIFont.PoppinsExLight(size: (view.frame.width * 50) / 375.0)*/
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout
        Layout_Section()
        
        // animation Present
        UIView.animate(withDuration: 1) {
            self.ViewPresent.alpha = 1
        }
        
        UIView.animate(withDuration: 1, delay: 2, options: .curveLinear, animations: {
            self.ViewPresent.alpha = 0
        }) { (Sucess : Bool) in
            if Sucess == true{
                
                // Next To Login Page
                let Next_LoginPage = LoginPageController()
                let navigation = UINavigationController(rootViewController: Next_LoginPage)
                navigation.isNavigationBarHidden = true
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }


}

