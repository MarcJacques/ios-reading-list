//
//  BookController.swift
//  Reading List
//
//  Created by Marc Jacques on 3/11/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books = [Book]()
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("books.plist")
    }
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    var unreadBooks: [Book] {
        return books.filter {$0.hasBeenRead == false }
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving book data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
              fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(newBook)
        
        saveToPersistentStore()
    }
    
    func deleteBook(Book: Book) {
        guard let index = books.firstIndex(of: Book) else { return }
        
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    func updateReadStatus(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].hasBeenRead.toggle()
        
        saveToPersistentStore()
    }
    
    func updateBookInfo(book: Book, newTitle: String, newReasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index] = Book(title: newTitle, reasonToRead: newReasonToRead)
        
        saveToPersistentStore()
    }
}
