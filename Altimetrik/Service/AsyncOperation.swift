//
//  AsyncOperation.swift
//  SingularTest
//
//  Created by Tapasya on 22/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

class AsyncOperation: Operation {
    override var isAsynchronous: Bool {
        return true
    }
    
    var _isFinished: Bool = false
    
    override var isFinished: Bool {
        set {
            willChangeValue(forKey: "isFinished")
            _isFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
        
        get {
            return _isFinished
        }
    }

    var _isExecuting: Bool = false
    
    override var isExecuting: Bool {
        set {
            willChangeValue(forKey: "isExecuting")
            _isExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
        
        get {
            return _isExecuting
        }
    }
    
    func execute() {
    }
    
    override func start() {
        if isCancelled {
            isFinished = true
            return
        }
        isExecuting = true
        execute()
        isExecuting = false
        isFinished = true
    }
}
