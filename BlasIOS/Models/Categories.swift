//
//  Category.swift
//  BlasIOS
//
//  Created by Andi Gibson on 5/18/20.
//  Copyright © 2020 Andi Gibson. All rights reserved.
//

import Foundation

public struct Categories: Codable{
    var categories: [String]
    
    enum CodingKeys: String, CodingKey {
        case categories
    }
}
