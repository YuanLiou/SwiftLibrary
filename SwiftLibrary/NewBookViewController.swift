//
//  NewBookViewController.swift
//  SwiftLibrary
//
//  Created by 劉瑞元 on 2022/4/22.
//

import UIKit
import CoreData

class NewBookViewController: UIViewController {
    
    @IBOutlet weak var textIsbn: UITextField!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var publishDateLable: UILabel!
    @IBOutlet weak var descriptionLable: UITextView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    var processedBook: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickButtonCancel(sender: AnyObject) {
        self.dismiss(animated:true, completion: nil)
    }
    
    @IBAction func onClickButtonSearch(sender: AnyObject) {
        // Read ISBN endpoint from pinfo.list in a dictionary
        guard
            let isbn = textIsbn.text,
            let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let apiUri = dict["Google Books Search ISBN"] as? String
        else {
            fatalError("Couldn't create search URI from ISBN code")
        }
        
        if isbn.isEmpty {
            self.showAlertViewController(message: "ISBN is empty")
            return
        }
        
        // Do the Http request
        // sample: https://www.googleapis.com/books/v1/volumes?q=isbn:<isbn>
        let url = URL(string: apiUri + isbn)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error)  in
            guard
                let jsonString = String(data: data!, encoding: String.Encoding.utf8),
                let dict = Utils.jsonStringToDict(text: jsonString)
            else {
                // Show alert view controller
                self.showAlertViewController(message: "Couldn't find results for code \(url!)")
                return
            }
            
            guard
                let items = dict["items"] as? NSArray,
                let firstItem = items[0] as? NSDictionary,
                let identifier = firstItem["id"] as? String,
                let volumeInfo = firstItem["volumeInfo"] as? NSDictionary
            else {
                fatalError("Couldn't process dict file")
            }
            
            let title = volumeInfo["title"] as? String ?? ""
            let description = volumeInfo["description"] as? String ?? ""
            let publishDate = volumeInfo["publishedDate"] as? String ?? ""
            let infoLink = volumeInfo["infoLink"] as? String ?? ""
            
            var smallThumbnail = ""
            if let imageLinks = volumeInfo["imageLinks"] as? NSDictionary {
                smallThumbnail = imageLinks["smallThumbnail"] as? String ?? ""
            }
            
            var mainAuthor = ""
            if let authors = volumeInfo["authors"] as? NSArray {
                mainAuthor = authors[0] as? String ?? ""
            }
            
            // Add objects to CoreData
            let entity = NSEntityDescription.entity(forEntityName: "Book", in: self.managedObjectContext)
            self.processedBook = Book(entity: entity!, insertInto: self.managedObjectContext)
            self.processedBook!.id = identifier
            self.processedBook!.title = title
            self.processedBook!.author = mainAuthor
            self.processedBook!.publishDate = publishDate
            self.processedBook!.desc = description
            self.processedBook!.descUri = infoLink
            self.processedBook!.imageUri = smallThumbnail
            
            DispatchQueue.main.async {
                self.loadBookDetails(book: self.processedBook!)
            }
        }
        task.resume() // execute the task
    }
    
    private func loadBookDetails(book: Book) {
        if let url = URL(string: book.imageUri!) {
            UIImage.loadFrom(url: url) { image in
                self.thumbnailImage.image = image
            }
        }
        
        titleLable.text = book.title
        authorLable.text = book.author
        publishDateLable.text = book.publishDate
        descriptionLable.text = book.desc
    }
    
}

extension UIImage {
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
