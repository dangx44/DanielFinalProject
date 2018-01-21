//
//  DataManager.swift
//  Vegas2
//
//  Created by hackeru on 14/01/2018.
//  Copyright © 2018 dan. All rights reserved.
//

import Foundation

extension Notification.Name{
    static var scoreUpatedNotification : Notification.Name{
        get{
            return Notification.Name(rawValue: "scoreUpatedNotification")
        }
    }
}

class DataManager{
    
    var score : Int = 100{
        didSet{
            NotificationCenter.default.post(name: .scoreUpatedNotification, object: self)
        }
    }
    
    static let sharedManager = DataManager()
//
//    class var sharedManager: DataManager {
//        struct Static {
//            static let instance = DataManager()
//        }
//        return Static.instance
//    }
}
   /*
    static let manager = DataManager()
    
    private init(){
        
    }*/

