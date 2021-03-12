//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Marc Jacques on 3/11/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate, AddNewBookDelegate {
    
    
    
    var bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    //    MARK: - Functions
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
        
    }
    
    func toggleHasBeenRead(Cell: BookTableViewCell) {
        guard let book = Cell.book else { return }
        bookController.updateReadStatus(book: book)

        tableView.reloadData()
    }
    
    func newBookAdded(book: Book) {
        bookController.createBook(title: book.title, reasonToRead: book.reasonToRead)
        
        tableView.reloadData()
        
    }
    

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        cell.book = bookFor(indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tableView.deleteRows(at: [indexPath], with: .automatic)
            bookController.deleteBook(Book:bookFor(indexPath: indexPath))
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "AddBookSegue" {
            if let addBookDVC = segue.destination as? BookDetailViewController {
                addBookDVC.bookController = bookController
                addBookDVC.delegate = self
            }
        } else {
            if let bookDVC = segue.destination as? BookDetailViewController {
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                bookDVC.book = bookFor(indexPath: indexPath)
            }
            
        }
        // Pass the selected object to the new view controller.
    }
    
    
}
