//
//  DeviceConfigurations.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/04/24.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//

import Foundation
import SpriteKit

class DeviceConfigurations {
    // Device-specific constants
    
    // y-values
    
    func classHimAdjust () {
        
        let nodes: [SKSpriteNode : SKSpriteNode] = [
            him.spriteHelp1224Hour : btnm.button1224HourToggle,
            him.spriteHelpCurrentTime : btnm.buttonCurrentDeviceTime,
            him.spriteHelpSelfTest : btnm.buttonSelfTest,
            him.spriteHelpRandomTime : btnm.buttonRandomTime,
            him.spriteHelpDigitalToggle : btnm.buttonToggleDigital
        ]
        
        for node in nodes.keys {
            node.position.y = (nodes[node]?.position.y)!
            node.anchorPoint.y = 0.75
            node.setScale(1.5)
        }
        him.spriteHelp1224Hour.anchorPoint.y = 0.75

        
        
    }

    

}