//
//  Book.swift
//  Reading List
//
//  Created by Marc Jacques on 3/11/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation


struct Book: Equatable, Codable {
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
    
}
