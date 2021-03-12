//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Marc Jacques on 3/12/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    
    func toggleHasBeenRead(Cell: BookTableViewCell)
    
}
