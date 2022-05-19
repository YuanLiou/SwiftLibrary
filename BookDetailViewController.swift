//
//  BookDetailViewController.swift
//  SwiftLibrary
//
//  Created by 劉瑞元 on 2022/5/17.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var publishDateLable: UILabel!
    @IBOutlet weak var descriptionLable: UITextView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    var selectedBook: Book? = nil
    
    override func viewDidLoad() {
        guard
            let book = selectedBook
        else {
            fatalError("Couldn't find selected book property.")
        }
        
        if let url = URL(string: book.imageUri!) {
            UIImage.loadFrom(url: url) { image in
                self.thumbnailImage.image = image
            }
        }
        
        titleLable.text = book.title
        authorLable.text = book.author
        publishDateLable.text = book.publishDate
        descriptionLable.text = book.desc
        
        self.navigationItem.title = book.title
    }
    
    @IBAction func onClickCancelButton(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickViewInfoPage(sender: AnyObject) {
    }
}
