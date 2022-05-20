//
//  BookDetailViewController.swift
//  SwiftLibrary
//
//  Created by 劉瑞元 on 2022/5/17.
//

import UIKit
import SafariServices

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var publishDateLable: UILabel!
    @IBOutlet weak var descriptionLable: UITextView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var viewInfoPageButton: UIButton!
    
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
        
        // Check if selected book has descUri
        if book.descUri != nil && book.desc?.isEmpty == false {
            viewInfoPageButton.isEnabled = true
        } else {
            viewInfoPageButton.isEnabled = false
        }
    }
    
    @IBAction func onClickCancelButton(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickViewInfoPage(sender: AnyObject) {
        guard
            let url = URL(string: selectedBook!.descUri!)
        else {
            fatalError("Couldn't parse url to NSURL \(selectedBook!.descUri!)")
        }
        
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
    }
}
