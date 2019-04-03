//
//  Models.swift
//  Youtube
//
//  Created by win on 3/31/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation

struct Video {
    var title : String
    var number_of_views : CUnsignedLong
    var thumbnail_image_name : String
    var duration : Int
    var channel : [Channel]
    
}
extension Video : Decodable {
    enum VideoCodingKeys : CodingKey{
        case title
        case number_of_views
        case thumbnail_image_name
        case duration
        case channel
    }
    init(from decoder: Decoder) throws {
        let contaner                = try decoder.container(keyedBy: VideoCodingKeys.self)
        title                       = try contaner.decode(String.self, forKey: .title)
        number_of_views             = try contaner.decode(CUnsignedLong.self, forKey: .number_of_views)
        thumbnail_image_name        = try contaner.decode(String.self, forKey: .thumbnail_image_name)
        duration                    = try contaner.decode(Int.self, forKey: .duration)
        channel                     = [try contaner.decode(Channel.self, forKey: .channel)]
    }
}
struct Channel  {
    var name : String
    var profile_image_name : String
    
}
extension Channel : Decodable {
    enum ChannelCodingKeys : CodingKey {
        case name
        case profile_image_name
    }
    init(from decoder : Decoder) throws {
        let contaner              = try decoder.container(keyedBy: ChannelCodingKeys.self)
        name                      = try contaner.decode(String.self, forKey: .name)
        profile_image_name        = try contaner.decode(String.self, forKey: .profile_image_name)
    }
}
