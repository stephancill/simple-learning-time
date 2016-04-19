//
//  GameViewController.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/02/11.
//  Copyright (c) 2016 Stephan Cilliers. All rights reserved.
//

import UIKit
import SpriteKit

var masterScene: SKScene = SKScene()
var deviceType = "iPad"

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = CustomGameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = false
            print(deviceType)
            /* Set the scale mode to scale to fit the window */
            if (deviceType == "iPhone") {
//                scene.scaleMode = .Fill
                scene.size = CGSize( width: skView.bounds.size.height/2, height: skView.bounds.size.width/2)
                scene.inverseScalar = 4
                scene.scaleMode = .AspectFill
            } else {
                scene.scaleMode = .AspectFill
            }
            
            /* Present the scene */
            masterScene = scene
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            deviceType = "iPad"
            return .Landscape
            
        } else {
            deviceType = "iPhone"
            return .Landscape
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
