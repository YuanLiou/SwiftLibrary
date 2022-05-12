//
//  ProgressHUD.swift
//  SwiftLibrary
//
//  Created by 劉瑞元 on 2022/5/10.
//

import Foundation
import UIKit

class ProgressHUD: UIVisualEffectView {
    let label: UILabel = UILabel()
    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let vibracyView: UIVisualEffectView
    
    init(text: String) {
        self.text = text
        self.vibracyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    // This require init section is for the interface builder(Storyboard) using
    required init(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibracyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    func setup() {
        contentView.addSubview(vibracyView)
        vibracyView.contentView.addSubview(activityIndicator)
        vibracyView.contentView.addSubview(label)
        
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superView = self.superview {
            let width = superView.frame.size.width / 1.5
            let height: CGFloat = 50.0
            self.frame = CGRect(x: superView.frame.size.width / 2 - width / 2,
                                y: superView.frame.height / 2 - height / 2,
                                width: width,
                                height: height
            )
            vibracyView.frame = self.bounds
            
            let activityIndicatorSize: CGFloat = 40.0
            activityIndicator.frame = CGRect(x: 5, y: height / 2 - activityIndicatorSize / 2, width: activityIndicatorSize, height: activityIndicatorSize)
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: activityIndicatorSize + 5, y: 0, width: width - activityIndicatorSize - 15, height: height)
            label.textColor = UIColor.blue
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
