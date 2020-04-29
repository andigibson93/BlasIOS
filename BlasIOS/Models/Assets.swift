//
//  Assets.swift
//  BlasIOS
//
//  Created by Andi Gibson on 4/27/20.
//  Copyright © 2020 Andi Gibson. All rights reserved.
//

import Foundation

struct Assets: Codable {
    let assest: [String]
    
    enum CodingKeys: String, CodingKey {
        case assest
    }
    
}
