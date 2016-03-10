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
    var pi = 3.1415926535
    func angleBetween(P1: CGPoint,  P2: CGPoint, P3: CGPoint) -> Double {
        /*
        If you mean the angle that P1 is the vertex of then this should work:
        
        arcos((P122 + P132 - P232) / (2 * P12 * P13))
        
        where P12 is the length of the segment from P1 to P2, calculated by
        
        sqrt((P1x - P2x)2 + (P1y - P2y)2)
        */
        

//        let seg12 = sqrt(pow((Double(P1.x)-Double(P2.x)), 2) + pow((Double(P1.y)-Double(P2.y)), 2))
//        let seg13 = sqrt(pow((Double(P1.x)-Double(P3.x)), 2) + pow((Double(P1.y)-Double(P3.y)), 2))
//        let seg23 = sqrt(pow((Double(P2.x)-Double(P3.x)), 2) + pow((Double(P2.y)-Double(P3.y)), 2))
//        
//        return pow(cos( (pow(seg12,2) + pow(seg13,2) - pow(seg23,2)) / 2*seg12*seg13), -1)

        
        return Double(atan2(P2.y - P1.y, P2.x - P1.x) - atan2(P3.y - P1.y, P3.x - P1.x))
        

    }

}