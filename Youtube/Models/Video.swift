//
//  Models.swift
//  Youtube
//
//  Created by win on 3/31/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation

class Video: NSObject {
    var thumnailImage : String?
    var title : String?
    var numberOfViews : NSNumber?
    var uploadDate : NSDate?
    
    var channel : Channel?
}
class Channel : NSObject{
    var name : String?
    var profileImageName : String?
}
