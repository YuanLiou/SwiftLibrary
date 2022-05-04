//
//  Utils.swift
//  SwiftLibrary
//
//  Created by 劉瑞元 on 2022/4/27.
//

import Foundation
import UIKit
import CoreData

class Utils {
}

extension Utils {
    static func jsonStringToDict(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("jsonStringToDict converting failed")
            }
        }
        return nil
    }
}

extension String {
    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhiteSpace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}

extension UIViewController {
    var managedObjectContext:NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func saveManagedObjectContext() {
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            showAlertViewController(message: "Could not save object")
        }
    }
    
    func showAlertViewController(message: String) {
        let alertController = UIAlertController(title: "SwiftLibrary", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
