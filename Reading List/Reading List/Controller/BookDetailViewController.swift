//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Marc Jacques on 3/11/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit


class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView:
        UITextView!
    
    var book: Book?
    
    var bookController = BookController()
    
    var delegate: AddNewBookDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    private func updateViews() {
        if book == nil {
            self.title = "Add a new book"
        } else {
            guard let book = book else { return }
            self.title = book.title
            bookTitleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
        }
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let title = bookTitleTextField.text,
              let reasonToRead = reasonToReadTextView.text,
              !title.isEmpty,
              !reasonToRead.isEmpty else { return }
        
        if book == nil {
            let newBook = Book(title: title, reasonToRead: reasonToRead)
            delegate?.newBookAdded(book: newBook)
        } else {
            guard let book = book else { return }
            bookController.updateBookInfo(book: book, newTitle: title, newReasonToRead: reasonToRead)
        }
        
        bookTitleTextField.text = ""
        reasonToReadTextView.text = "Reason to Read: "
        
        navigationController?.popViewController(animated: true)
        
    }          
}
