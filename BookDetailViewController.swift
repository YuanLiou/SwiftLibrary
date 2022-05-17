//
//  BookDetailViewController.swift
//  SwiftLibrary
//
//  Created by 劉瑞元 on 2022/5/17.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onClickCancelButton(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
