//
//  GenreType.swift
//  MetalBeast
//
//  Created by Leon on 12/6/20.
//  Copyright © 2020 Shiyao Guo. All rights reserved.
//

import Foundation
import UIKit
enum GenreType: Int, CaseIterable {
    
    
case a, b, c, d, e, f, g, h ,i,j,k,l

func title() -> String {
    switch self {
    case .a:
        return "Alternative metal"
    case .b:
        return "Black metal"
    case .c:
        return "Christian metal"
        
    
    case .d:
        return "Death metal"
    case .e:
        return "Doom metal"
    case .f:
        return "Gothic metal"
        
    case .g:
    return "Industrial metal"
        
    case .h:
    return "Metalcore"
    
    case .i:
    return "Power metal"
        
    case .j:
    return "Progressive metal"
        
    case .k:
    return "Thrash metal"
        
    case .l:
    return "Heavy metal"
        
    
    }
}
}
