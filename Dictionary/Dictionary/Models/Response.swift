//
//  Response.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 13/09/2020.
//  Copyright © 2020 Juan Manuel Gentili. All rights reserved.
//

import Foundation

struct Response: Codable {
    let definitions: [Definition]?
    let word: String?
    let pronunciation: String?
}
