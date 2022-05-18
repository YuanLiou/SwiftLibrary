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
    
    @IBAction func onClickCancelButton(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickViewInfoPage(sender: AnyObject) {
    }
}
