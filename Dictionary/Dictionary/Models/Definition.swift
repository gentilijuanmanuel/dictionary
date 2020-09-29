//
//  Definition.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 13/09/2020.
//  Copyright © 2020 Juan Manuel Gentili. All rights reserved.
//

import Foundation

struct Definition: Codable {
    let type: String?
    let definition: String?
    let example: String?
    let image: String?
    let emoji: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case definition = "definition"
        case example = "example"
        case image = "image_url"
        case emoji = "emoji"
    }
}
