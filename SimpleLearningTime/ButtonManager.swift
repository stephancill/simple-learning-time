//
//  ButtonManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/03/18.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//
import Foundation
import SpriteKit

class ButtonFunctions {

    func randomTime() {
    
        let hours = CGFloat(arc4random_uniform(24))
        let minutes = CGFloat(arc4random_uniform(13))
        
        cm.set(hours, minutes)
        dtm.set(cm.time)
    }
    
    func toggleTwentyFourHour() {
        
        if (cm.hourMod == 24) { cm.hourMod = 12 }
        if (cm.hourMod == 12) { cm.hourMod = 24 }
        
        cm.set(cm.calculateTime())
        dtm.set(cm.time)
    }
    
    func toggleDigitalTime() {
    
        dtm.toggleVisibility()
    }
    
}