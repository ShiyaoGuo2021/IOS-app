//
//  Bands.swift
//  MetalBeast
//
//  Created by Leon on 12/5/20.
//  Copyright © 2020 Shiyao Guo. All rights reserved.
//

import Foundation
struct Band:Codable{
    
    let band:String
    let formed:Int
    let origin:String
    
}
struct ResponseData: Decodable {
    var bands: [Band]
}
