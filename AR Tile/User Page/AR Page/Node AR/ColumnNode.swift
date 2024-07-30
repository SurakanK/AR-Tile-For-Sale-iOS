//
//  ColumnNode.swift
//  AR Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 27/5/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import SceneKit

class ColumnNode : SCNNode {
    
    let size: CGFloat = 0.1
    let segmentWidth: CGFloat = 0.004
    
    private let colorMaterial: SCNMaterial = {
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow
        return material
    }()
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func createSegment(width: CGFloat, height: CGFloat) -> SCNNode {
        let segment = SCNPlane(width: width, height: height)
        segment.materials = [colorMaterial]
        
        return SCNNode(geometry: segment)
    }
    
    private func addHorizontalSegment(dx: Float) {
        let segmentNode = createSegment(width: segmentWidth, height: size)
        segmentNode.position.x += dx
        
        addChildNode(segmentNode)
    }
    
    private func addVerticalSegment(dy: Float) {
        let segmentNode = createSegment(width: size, height: segmentWidth)
        segmentNode.position.y += dy
        
        addChildNode(segmentNode)
    }
    
    private func CreateColumn() {
        let Column_Mark = SCNCapsule(capRadius: 0.01, height: 1)
        let Column_Mark_Node = SCNNode(geometry: Column_Mark)
        Column_Mark_Node.geometry?.materials.first?.diffuse.contents = UIColor(red:0.08, green:0.71, blue:0.84, alpha: 1)
        
        // Create Node Tube Around Column
        // Tube ref 1
        let Tube_ref_1 = SCNTube(innerRadius: 0.08, outerRadius: 0.1, height: 0.001)
        let Tube_ref_1_Node = SCNNode(geometry: Tube_ref_1)
        Tube_ref_1_Node.geometry?.firstMaterial?.diffuse.contents = UIColor.whiteAlpha(alpha: 0.75)
        Tube_ref_1_Node.pivot = SCNMatrix4MakeTranslation(0,0.5, 0)
        Column_Mark_Node.addChildNode(Tube_ref_1_Node)
        // Tube ref 2
        let Tube_ref_2 = SCNTube(innerRadius: 0.13, outerRadius: 0.15, height: 0.001)
        let Tube_ref_2_Node = SCNNode(geometry: Tube_ref_2)
        Tube_ref_2_Node.geometry?.firstMaterial?.diffuse.contents = UIColor.whiteAlpha(alpha: 0.5)
        Tube_ref_2_Node.pivot = SCNMatrix4MakeTranslation(0,0.5, 0)
        Column_Mark_Node.addChildNode(Tube_ref_2_Node)
        
        //Capsule Axis X
        /*let Axis_x = SCNCapsule(capRadius: 0.005, height: 0.5)
        let Axis_x_Node = SCNNode(geometry: Axis_x)
        Axis_x_Node.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        Axis_x_Node.eulerAngles = SCNVector3(-90.degreesToRadians,0,0)
        //Axis_x_Node.pivot = SCNMatrix4MakeTranslation(0, 0.25, 0)
        Column_Mark_Node.addChildNode(Axis_x_Node)
        
        //Capsule Axis Z
        let Axis_z = SCNCapsule(capRadius: 0.005, height: 0.5)
        let Axis_z_Node = SCNNode(geometry: Axis_z)
        Axis_z_Node.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        Axis_z_Node.eulerAngles = SCNVector3(0,0,-90.degreesToRadians)
        //Axis_z_Node.pivot = SCNMatrix4MakeTranslation(0, 0.25, 0)
        Column_Mark_Node.addChildNode(Axis_z_Node)*/
        
        
        
        
        Column_Mark_Node.pivot = SCNMatrix4MakeTranslation(0,-0.5, 0)
        
        addChildNode(Column_Mark_Node)
    }
    
    private func setup() {
        //let dist = Float(size) / 2.0
        //addHorizontalSegment(dx: dist)
        //addHorizontalSegment(dx: -dist)
        //addVerticalSegment(dy: dist)
        //addVerticalSegment(dy: -dist)
        CreateColumn()
        
        
        // Rotate the node so the square is flat against the floor
        //transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
    }
    
}
