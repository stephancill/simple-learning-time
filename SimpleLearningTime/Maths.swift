//
//  Maths.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/03/02.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//


import SpriteKit
import Foundation

class mf {
    
    /*Constants*/
    var clockMinuteIntervalConst = -0.1047197551    //-360/(180/math.pi)/12/5
    var clockHourIntervalConst = -0.523595          //-360/(180/math.pi)/12
    var pi = 3.1415926535
    
    var currentTouchAngle: Double = 0
    var lastTouchAngle: Double = 0
    var deltaTouchAngle: Double = 0
    var lastDeltaTouchAngle: Double = 0
    
    /*Functions*/
    func angleBetween(P1: CGPoint,  P2: CGPoint, P3: CGPoint) -> Double {
        // P1 = pivot point (center of screen)
        // P2 = left corner
        // P3 = right corner
        
        return Double(atan2(P2.y - P1.y, P2.x - P1.x) - atan2(P3.y - P1.y, P3.x - P1.x))

    }
    
    func updateAngles (touch: UITouch, middle: CGPoint, first: CGPoint) {
        
        currentTouchAngle = angleBetween(middle, P2: first , P3: touch.locationInView(touch.view))
        deltaTouchAngle = currentTouchAngle-lastTouchAngle
        lastTouchAngle = currentTouchAngle
        
        if (abs(deltaTouchAngle-lastDeltaTouchAngle) > 0.9) {deltaTouchAngle = -0.0001 * (deltaTouchAngle/deltaTouchAngle)}     // Prevent jumping
        lastDeltaTouchAngle = deltaTouchAngle
        
    }

}