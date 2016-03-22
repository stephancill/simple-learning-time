//
//  GameScene.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/02/11.
//  Copyright (c) 2016 Stephan Cilliers. All rights reserved.
//
import SpriteKit

let cm: ClockManager = ClockManager()
let bgm: BackgroundManager = BackgroundManager()
let dtm: DigitalTimeManager = DigitalTimeManager()
let btnm: ButtonManager = ButtonManager()
let math: mf = mf()

var allInteractiveElements: [String] = []

class GameScene: SKScene {

    var middle: CGPoint = CGPoint(x: 0, y: 0)
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        self.name = "scene"
        middle = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        cm.initElements(size, scalar: 0.55, scene: self, time: math.currentDeviceTime())
        bgm.initElements(size, scalar: 0.8, scene: self, center: cm.center)
        dtm.initElements(size, scalar: 0.5, scene: self, time: cm.time)
        btnm.initElements(size, scalar: 0.25, scene: self)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        cm.touchesMoved(touches)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let node = getTopNode(touches)
        let nodeName = node.name!
        
        if (cm.interactiveElements.contains(nodeName)) {
            cm.touchesStarted(node, touchLocation: (touches.first?.locationInView(self.view))!)
        }
        
        if (btnm.interactiveElements.contains(nodeName)) {
            btnm.buttonPressed(nodeName)
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let node = getTopNode(touches)
        let nodeName = node.name!
        // Element belongs to clock
        cm.touchesEnded()
        btnm.buttonReleased(nodeName)

    }
    
    func getTopNode (touches: Set<UITouch>) -> SKNode {
        
        let touch = touches.first
        let touchLocation = touch!.locationInView(self.view)
        var node: SKNode = SKNode()
        let nodes = self.nodesAtPoint(convertPointToView(touchLocation))
        //  Set the node to the first interactive node
        for n in nodes {
            if (n.name != nil) {
                if (allInteractiveElements.contains(n.name!)) {
                    node = n
                    break
                }
            }
        }
        
        if (node.name == nil) {node.name = "nil"}
        return node
        
    }
    

}
