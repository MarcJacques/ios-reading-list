//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Marc Jacques on 3/11/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    
    func updateViews() {
        guard let book = book,
              !book.title.isEmpty else { return }
        bookTitleLabel.text = book.title
        
        if book.hasBeenRead == false {
            hasBeenReadButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        } else if book.hasBeenRead == true {
            hasBeenReadButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    @IBAction func hasBeenReadButtonTapped(_ sender: UIButton) {
        let cell = self
        delegate?.toggleHasBeenRead(Cell: cell)
        
        updateViews()
    }

    
}
