//
//  ActionManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/04/16.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//
// http://stackoverflow.com/questions/28373490/how-to-subclass-nsoperation-in-swift-to-queue-skaction-objects-for-serial-execut
import SpriteKit

class ActionOperation : NSOperation
{
    let _node: SKNode // The sprite node on which an action is to be performed
    let _action: SKAction // The action to perform on the sprite node
    var _finished = false // Our read-write mirror of the super's read-only finished property
    var _executing = false // Our read-write mirror of the super's read-only executing property
    
    /// Override read-only superclass property as read-write.
    override var executing: Bool {
        get { return _executing }
        set {
            willChangeValueForKey("isExecuting")
            _executing = newValue
            didChangeValueForKey("isExecuting")
        }
    }
    
    /// Override read-only superclass property as read-write.
    override var finished: Bool {
        get { return _finished }
        set {
            willChangeValueForKey("isFinished")
            _finished = newValue
            didChangeValueForKey("isFinished")
        }
    }
    
    /// Save off node and associated action for when it's time to run the action via start().
    init(node: SKNode, action: SKAction) {
        
        // This is equiv to ObjC:
        // - (instancetype)initWithNode(SKNode *)node (SKAction *)action
        // See "Exposing Swift Interfaces in Objective-C" at https://developer.apple.com/library/mac/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html#//apple_ref/doc/uid/TP40014216-CH4-XID_35
        
        _node = node
        _action = action
        super.init()
    }
    
    /// Add the node action to the main operation queue.
    override func start()
    {
        if cancelled {
            finished = true
            return
        }
        
        executing = true
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self._node.runAction(self._action) {
                self.executing = false
                self.finished = true
            }
        }
    }
}
