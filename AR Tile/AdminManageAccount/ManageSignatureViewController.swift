//
//  ManageSignatureViewController.swift
//  AR Tile
//
//  Created by Surakan Kasurong on 18/4/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire

class ManageSignatureViewController: UIViewController , UIApplicationDelegate{
   
    let canvas = Canvas()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueLight
        button.setImage(#imageLiteral(resourceName: "bin"), for: .normal)
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.addTarget(self, action: #selector(clearCanvaeButton), for: .touchUpInside)
        return button
    }()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .BlueLight
        button.setImage(#imageLiteral(resourceName: "undo"), for: .normal)
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.addTarget(self, action: #selector(undoCanvaeButton), for: .touchUpInside)
        return button
    }()
    
    let viewmain: UIView = {
        let view = UIView()
        view.backgroundColor = .BlackAlpha(alpha: 0.7)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // ConfigNavigation Bar
        navigationItem.title = "Autograph"
        navigationController?.navigationBar.barTintColor = .BlueLight
        navigationController?.navigationBar.tintColor = UIColor.whiteAlpha(alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.PoppinsMedium(size: 20)]
        

        let ConfirmNavigationButton = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(ConfirmButton))
        navigationItem.rightBarButtonItem = ConfirmNavigationButton
        
        
        view.addSubview(viewmain)
        viewmain.addSubview(canvas)
        viewmain.addSubview(undoButton)
        viewmain.addSubview(clearButton)

        canvas.backgroundColor = .white
        
        
        viewmain.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        canvas.anchorCenter(viewmain.centerXAnchor, AxisY: viewmain.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        canvas.anchor(nil, left: viewmain.leftAnchor, bottom: nil, right: viewmain.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 250)
        
        undoButton.anchor(nil, left: canvas.leftAnchor, bottom: canvas.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        clearButton.anchor(nil, left: undoButton.rightAnchor, bottom: canvas.topAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 5, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
    }
    
    @objc func canRotate() -> Void {}

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        //UIDevice.current.setValue(Int(UIInterfaceOrientation.landscapeRight.rawValue), forKey: "orientation")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        /*if (self.isMovingFromParent) {
          UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }*/

    }
        
    @objc func clearCanvaeButton(){
        canvas.clear()
    }
    
    @objc func undoCanvaeButton(){
        canvas.undo()
    }
    
    @objc func ConfirmButton(){
        ManageAddSaleViewController.imageSignImage = canvas.asImage()
        ManageEditSaleViewController.imageSignImage = canvas.asImage()
        navigationController?.popViewController(animated: false)
    }

    
}


